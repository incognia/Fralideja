#!/usr/bin/Rscript
#   format-data.R - Twitter Data Mining App
#
#   Copyright © 2018, Rodrigo Ernesto Alvarez Aguilera <incognia@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Version 0.1 - April 4, 2018
#   Author: Rodrigo Ernesto Alvarez Aguilera
#   Author: Bas Hofstra
#
#   Tested under Ubuntu 16.04.4 LTS using R version 3.4.4
#

setwd("~/twitter/") # Let us set the working directory again
library(foreign) # Load a package for reading files
dataframe <- read.csv("~/fralideja/[search-pattern]_data.csv")

source <- as.character(dataframe$screenName)
Id <- as.data.frame(dataframe$screenName)
tweets <- dataframe$text
target <- gsub(".*?@(.*?):.*", "\\1", tweets)
target <- gsub("\\??", "", target)
net <- as.data.frame(cbind(source, target))
net <- net[- grep(" ", net$target),]

client <- dataframe$statusSource
client <- gsub(".*?>(.*?)</a>.*", "\\1", client)
client <- gsub("Twitter for iPhone", "ios", client)
client <- gsub("Twitter for Android", "android", client)
client <- gsub("Twitter Web Client", "web", client)
client <- gsub("Twitter for iPad", "ios", client)
client <- gsub("TweetDeck", "communitymanager", client)
#client <- gsub("twitterfeed", "nonapple", client)
#client <- gsub("RSScockpit", "nonapple", client)
#client <- gsub("iOS", "apple", client)
#client <- gsub("Tweetbot for i<U+039F>S", "nonapple", client)
client <- gsub("Facebook", "facebook", client)
client <- gsub("Hootsuite", "communitymanager", client)
client <- gsub("Twitter for Windows Phone", "windowsphone", client)
#client <- gsub("Engagor", "nonapple", client)
#client <- gsub("Echofon", "nonapple", client)
client <- gsub("Twitter for BlackBerry", "blackberry", client)
#client <- gsub("Marokko.nl", "nonapple", client)
#client <- gsub("vk.nl Mobile on iOS", "apple", client)
#client <- gsub("vk.nl Mobile on apple", "apple", client)
#client <- gsub("OBI4wan", "nonapple", client)
#client <- gsub("Tweetbot for i<U+039F>S", "nonapple", client)
client <- gsub("Twitter for Mac", "mac", client)
client <- gsub("Twitter for Windows", "windows", client)
client <- gsub("IFTTT", "bot", client)
#client <- gsub("Twitter for Windows Phone", "nonapple", client)
#client <- gsub("Mobile Web (M5)", "nonapple", client)
#client <- gsub("Twitter for Nokia S40", "nonapple", client)
#client <- gsub("Plume???for???Android", "nonapple", client)
#client <- gsub("Buffer", "nonapple", client)
client <- gsub("dlvr.it", "bot", client)
#client <- gsub("Twitter for BlackBerry???", "nonapple", client)
#client <- gsub("Tweetbot for Mac", "apple", client)
client <- gsub("RoundTeam", "bot", client)
client <- gsub("TweetCaster for Android", "communitymanager", client)
#client <- gsub("Plume???for???Android", "nonapple", client)
#client <- gsub("Google", "nonapple", client)
#client <- gsub("Plume???for???Android", "nonapple", client)
client <- gsub("WordPress.com", "wordpress", client)
#client <- gsub("Mobile Web (M5)", "nonapple", client)
client <- gsub("null", "nonapple", client)
client <- gsub("nonapple???", "nonapple", client)
client <- gsub("???", "", client)
client <- gsub("???", "", client)
client <- gsub("\\(|\\)", "", client)
client <- gsub("\\<|\\>", "", client)
client <- gsub("\\+|", "", client)
client <- gsub(" ", "", client)
#client <- gsub("MobileWebM5", "nonapple", client)
#client <- gsub("TweetbotforiU039FS", "nonapple", client)
client <- gsub("null", "nonapple", client)

client <- as.data.frame(client)

actors <- cbind(Id, client)
colnames(actors) <- c("Id", "client")
actors <- unique(actors) # For removing duplicates

write.table(actors, "[search-pattern]_actors.csv",row.names = FALSE)
write.table(net, "[search-pattern]_ties.csv",row.names = FALSE)
