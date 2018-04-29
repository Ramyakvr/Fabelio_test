class HomeController < ApplicationController
  include CommonWordHelper
  
  def index
  end

  def get_common_words
    @words = get_common_words_for_all_sources(params['data'])
    @words = [@words] unless @words.is_a? Array
    render 'display_common_words'
  end

end
