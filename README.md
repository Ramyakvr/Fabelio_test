Problem Statement
Create an application with two pages
Logic - Get data from 4 different sources and identify the case-sensitive common values in given columns.
Then display the common values one by one as any transition with a delay of 3 seconds.
Eg: if the strings "surabaya" and "jakarta" are present in all the sources in the given columns, then display both
of them one after the other with a delay of 3 seconds.
First Page:
Input Form
1) S3 Credentials
a) Bucket
b) Access Key
c) Secret Key
c) CSV File name (checks not necessary)
d) Column Name
2) MySQL Credentials (Build the query to get data from the mentioned column)
a) host
b) port
c) user
d) password
e) Database
f) Table
g) Column Name
3) SCP Credentials (Assume file is in the home folder of user)
a) host
b) user
c) password
d) CSV file name (checks not necessary)
e) Column Name
4) CSV File Upload
a) CSV File Upload option (checks not necessary)
b) Column Name
5) Submit
Second Page :
Display the common words in all sources one by one
PS: Can use any programming language for this app. Assume all the files are in csv format. Checks are not
necessary


Requirements
Ruby 2.3.0
Rails 5
