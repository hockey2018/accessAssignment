#this r code should allow the user to access git hub 
#in order to implement this code, please install the following packages
#
#

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
