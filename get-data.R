#!/usr/bin/Rscript
#   get-data.R - Twitter Data Mining App
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

# Choose your working directory
setwd("~/twitter/[search-pattern]/")

# Load libraries
library(twitteR)
library(foreign)
library(devtools)

# The Consumer Key (API Key), Consumer Secret (API Secret),
# Access Token and Access Token Secret needed to access the Twitter-API
con <- "[Consumer Key]"
cons <-"[Consumer Secret]"
api <- "[Access Token]"
apis <- "[Access Token Secret]"

setup_twitter_oauth(con, cons, api, apis)

# Format date and time (YYMMDD-hhmmss)
date <- format(Sys.time(), "%y%m%d-%H%M%S")

# So we want to download information surrounding "[search-pattern]"
dataframe <- searchTwitter('[search-pattern]', n = 10000, retryOnRateLimit = 10000)
dataframe <- do.call("rbind", lapply(dataframe, as.data.frame))
dataframe$text <- gsub("\n", " ", dataframe$text) # Here some lines to delete linebreaks
dataframe$text <- gsub("\r", " ", dataframe$text) # so that statistical software reads it
dataframe$location <- gsub("\n", " ", dataframe$location) # nicely.
dataframe$location <- gsub("\r", " ", dataframe$location)
write.table(dataframe, paste0(date, "-[search-pattern]_data.txt"), sep = "\t", row.names = FALSE)
