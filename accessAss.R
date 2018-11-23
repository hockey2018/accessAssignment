#aoife sullivan software engineering assignment
#15323016
#this r code should allow the user to access git hub 
#in order to implement this code, please install the following packages
# when you run it at the end and if it does not work you must type 0 into
# the console and rerun the code, you then should be brought to a git hub 
# authorisation site and you know that your code has worked


#install.packages("jsonlite")
library(jsonlite)
#install.packages("httpuv")
library(httpuv)
#install.packages("httr")
library(httr)



# this can be any application but here we will use github
oauth_endpoints("github")

# this refers to the oauth that I personally generated
myapp <- oauth_app(appname = "aoifesAccessAssignment",
                   key = "a18829be5dfb86ca6f94",
                   secret = "c1a561fa6b32bbd3b8dbb77a8f45df83f906021e")

# this will get the oath creditdentials from github
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# this will use api
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

#Dataframe to be used in assignment 
allDataDF = data.frame( Username = integer(), Following = integer(), Followers = integer(), Repositories = integer(), DateCreated = integer(), Location = integer())
allData = c()

# This will stop the http error
stop_for_status(req)

# this will get the content from the required request
json1 = content(req)

# this line will convert the data to a data frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# this will make a subset data frame 
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

#PART 1: Interrogate the GitHub API to retrieve and display data regarding the logged in developer.
#Logged in developer: phadej

# Access Users profile. 
data1 = GET("https://api.github.com/users/zhchyu999", gtoken)
c = content(data1)
