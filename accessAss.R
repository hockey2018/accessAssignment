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


# The code above was sourced from Michael Galarnyk's blog, found at:
# https://towardsdatascience.com/accessing-data-from-github-api-using-r-3633fb62cb08


#PART 1: Interrogate the GitHub API to retrieve and display data regarding the logged in developer.
#Logged in developer: phadej

# Access Users profile. 
data1 = GET("https://api.github.com/users/zhchyu999", gtoken)
c = content(data1)

#Save users' data in a dataframe
data1 = jsonlite::fromJSON(jsonlite::toJSON(c))

#Retrieve information on 'phadej' and save in a vector
login = data1$login
following = data1$following
followers = data1$followers
name = data1$name
id = data1$id
public_repos = data1$public_repos
created_at = data1$created_at
updated_at = data1$updated_at
location = data1$location

#This vector will contain all information on phadej
phadej = c(login, following, followers, name, id, public_repos, created_at, updated_at, location)

write.csv(phadej, 'PhadeJ.csv')

#Part 2: The second part of the assignment is to interrogate the github API to build some sort of data 
#visualisation that highlights some aspect of the software engineering process.
#I will do the visualisation through plotly.

#this is the data frame that will be used in this assignment 
allDataDF = data.frame( Username = integer(), Following = integer(), Followers = integer(), Repositories = integer(), DateCreated = integer(), Location = integer())
allData = c()

#Get the information on the followers of phadej and then store this information in a data fram 
data2 = GET("https://api.github.com/users/phadej/followers", gtoken)
content2 = content(data2)
DF2 = jsonlite::fromJSON(jsonlite::toJSON(content2))

#Get the usernames of phadeji followers and store them in a vector
login = DF2$login
id = c(login)
id

#will create a loop to go through the users to find the users and add them to the list
for (i in 1:length(id))
{
  #create a list that will track individual followers
  u = id[i]
  url = paste("https://api.github.com/users/", id[i], "/followers", sep = "")
  followers = GET(url, gtoken)
  followersContent = content(followers)
  length(followersContent)
 
   #this will skip if there are no followers present
  if (length(followersContent) == 0)
  {
    next
  }
  
  #this will add the followers to the data frame
  DF3 = jsonlite::fromJSON(jsonlite::toJSON(followersContent))
  
  #this will get the user names of the followers
  followersLogin = DF3$login
  
  #this secon loop will loop through the followers followers to make sure there are no duplicates
 
  for (j in 1:length(followersLogin))
  {
    #this will make sure the user isnt in the group already
    if (is.element(followersLogin[j], allData) == FALSE)
    {
      length(allData)
      #this will add the users to the list
      allData[length(allData) + 1] = followersLogin[j]
      
      #this will get data about each user
      url2 = paste("https://api.github.com/users/", followersLogin[j], sep = "")
      f = GET(url2, gtoken)
      followers2 = content(f)
      DF4 = jsonlite::fromJSON(jsonlite::toJSON(followers2))
      
      #get user ID
      id = DF4$id
      
      #get those following
      following = DF4$following
      
      #get followers
      followers = DF4$followers
      
      #get those public repositories
      repos = DF4$public_repos
      
      #get those who joined Github
      created = substr(DF4$created_at, start = 1, stop = 10)
      
      #get there location
      location = DF4$location
      if(length(location)==0)
      {
        location = 'NULL'
      }
      
      #get last time it was updated
      updated_At = DF4$updated_at
      
      #put the users data in a new data fram
      allDataDF[nrow(allDataDF)+1, ] = c(followersLogin[j], following, followers, repos, created,location )
    }
    
    #put in a limit to speed up the run time, i chose 600
    #This can also be extended to an infinite amount of users
    if(length(allData) >600)
    {
      break 
    }
    next
  }
  if(length(allData) >500)
  {
    break
  }
  next
}

#Create temporary vector 
totalusers = c()
allcommits = c()
allcommits
for( i in 1:length(totalusers)){
  currentuser = totalusers[i]
  currentuser
  url = paste("https://api.github.com/users/", currentuser, "/commits", sep="")
  commits = fromJSON(url)
  next
}