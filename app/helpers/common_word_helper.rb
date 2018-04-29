module CommonWordHelper
	SOURCES = ['s3','mysql','remote','local']

	def get_common_words_for_all_sources(data)
		common_words = []
		SOURCES.each{|source|
			begin
				words = send('get_values_from_'+source, data[source])
			rescue => e
				words = e.message
			end
			return (words+"\nError in "+source) unless words.is_a? Array
			common_words &= words
			return 'No Common Words are found' if common_words.empty?
		}
	end

	def get_values_from_s3(data)
		s3 = AWS::S3.new(:access_key_id => data['access_key'], :secret_access_key => data['secret_key'])
		object = s3.buckets[data['bucket']].objects[data['file_name']]
		file_url = object.url_for(:get, { :expires => 20.minutes.from_now, :secure => true }).to_s.gsub('https://s3.amazonaws.com/','http://')
		parse_file(file_url, data['column_name'])
	end

	def get_values_from_mysql(data)
		ActiveRecord::Base.establish_connection(
			:adapter  => "mysql2",
			:database => data['database'],
			:host     => data['host'],
			:port     => data['port'],
			:username => data['user'],
			:password => data['password']
		)
		result = ActiveRecord::Base.connection.execute("select #{data['column_name']} from #{data['table']}")
		result.to_a.flatten
	end

	def get_values_from_remote(data)
		Net::SCP.download!(data['host'], data['user'], data['file_name'] , "tmp/", :password => data['password'])
		parse_file("tmp/"+data['file_name'], data['column_name'])
	end

	def get_values_from_local(data)
		parse_file(data['file_name'].path, data['column_name'])
	end

	def parse_file(file,column_name)
		column_no = nil
		values = []
		Roo::CSV.new(file).each_with_index{|row, i|
			if i == 0
				row.each_with_index { |column, j| 
					column_no = j if column == column_name
				}
				return 'Column with given name is not found' if column_no.nil?
			elsif i>= 1 && row[column_no].present?
				values << row[column_no]
			end
		}
		values
	end
end