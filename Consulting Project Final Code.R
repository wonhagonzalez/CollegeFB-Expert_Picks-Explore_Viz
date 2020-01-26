library(stringr)
library(DBI)
library(plotly)

#read in data
Project_set <- read.csv('~/Downloads/STAT 6366/Consulting Project/SMU.Project.csv')
bet_lines2007 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2007-08.csv")
bet_lines2008 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2008-09.csv")
bet_lines2009 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2009-10.csv")
bet_lines2010 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2010-11.csv")
bet_lines2011 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2011-12.csv")
bet_lines2012 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2012-13.csv")
bet_lines2013 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2013-14(1).csv")
bet_lines2014 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2014-15(1).csv")
bet_lines2015 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2015-16(1).csv")
bet_lines2016 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2016-17(1).csv")
bet_lines2017 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2017-18(1).csv")
bet_lines2018 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2018-19.csv")
bet_lines2019 <- read.csv("~/Downloads/STAT 6366/Consulting Project/ncaa football 2019-20.csv")

#make new money line data set for 2019
money_lines2019 <- bet_lines2019[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2019[seq(from = 1, to = nrow(money_lines2019), by = 2),]
Home.Teams.ML.set <- money_lines2019[seq(from = 2, to = nrow(money_lines2019), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2019 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2019 <- ML_2019[c(1,2,4,3,5)]

#Change the dates to match project data set
ML_2019$Date <- as.character(ML_2019$Date)
str(ML_2019$Date)
ML_2019$Date <- paste("2019", ML_2019$Date, sep="")
ML_2019$Date <- as.numeric(ML_2019$Date)

ML_2019$Date <- as.character(ML_2019$Date)
ML_2019$Date[1:528] <- str_replace(ML_2019$Date[1:528], "2019", "20190")
##Season not completed yet, so don't have to use following line
#ML_2019$Date[528:1176] <- str_replace(ML_2019$Date[528:1176], "2019", "20200")

ML_2019$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2019$Date, perl = TRUE)

ML_2019$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2019$Date, perl = TRUE)

ML_2019$Date <- gsub("-", "/", ML_2019$Date)


#make new money line data set for 2018
money_lines2018 <- bet_lines2018[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2018[seq(from = 1, to = nrow(money_lines2018), by = 2),]
Home.Teams.ML.set <- money_lines2018[seq(from = 2, to = nrow(money_lines2018), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2018 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2018 <- ML_2018[c(1,2,4,3,5)]

#Change the dates to match project data set
ML_2018$Date <- as.character(ML_2018$Date)
str(ML_2018$Date)
ML_2018$Date <- paste("2018", ML_2018$Date, sep="")
ML_2018$Date <- as.numeric(ML_2018$Date)
ML_2018[896:901,]
ML_2018$Date <- as.character(ML_2018$Date)
ML_2018$Date[1:352] <- str_replace(ML_2018$Date[1:352], "2018", "20180")
ML_2018$Date[896:901] <- str_replace(ML_2018$Date[896:901], "2018", "20190")

ML_2018$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2018$Date, perl = TRUE)

ML_2018$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2018$Date, perl = TRUE)

ML_2018$Date <- gsub("-", "/", ML_2018$Date)


#2017
#view(bet_lines2017)
#make new money line data set for 2017
money_lines2017 <- bet_lines2017[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2017[seq(from = 1, to = nrow(money_lines2017), by = 2),]
Home.Teams.ML.set <- money_lines2017[seq(from = 2, to = nrow(money_lines2017), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2017 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2017 <- ML_2017[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2017$Date <- as.character(ML_2017$Date)
str(ML_2017$Date)
ML_2017$Date <- paste("2017", ML_2017$Date, sep="")
ML_2017$Date <- as.numeric(ML_2017$Date)
#view(ML_2017)
ML_2017[878:883,]
ML_2017$Date <- as.character(ML_2017$Date)
ML_2017$Date[1:340] <- str_replace(ML_2017$Date[1:340], "2017", "20170")
ML_2017$Date[878:883] <- str_replace(ML_2017$Date[878:883], "2017", "20180")

ML_2017$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2017$Date, perl = TRUE)

ML_2017$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2017$Date, perl = TRUE)

ML_2017$Date <- gsub("-", "/", ML_2017$Date)


#2016
#view(bet_lines2016)
#make new money line data set for 2016
money_lines2016 <- bet_lines2016[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2016[seq(from = 1, to = nrow(money_lines2016), by = 2),]
Home.Teams.ML.set <- money_lines2016[seq(from = 2, to = nrow(money_lines2016), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2016 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2016 <- ML_2016[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2016$Date <- as.character(ML_2016$Date)
str(ML_2016$Date)
ML_2016$Date <- paste("2016", ML_2016$Date, sep="")
ML_2016$Date <- as.numeric(ML_2016$Date)
#view(ML_2016)
ML_2016[872:876,]
ML_2016$Date <- as.character(ML_2016$Date)
ML_2016$Date[1:288] <- str_replace(ML_2016$Date[1:288], "2016", "20160")
ML_2016$Date[872:876] <- str_replace(ML_2016$Date[872:876], "2016", "20170")

ML_2016$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2016$Date, perl = TRUE)

ML_2016$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2016$Date, perl = TRUE)

ML_2016$Date <- gsub("-", "/", ML_2016$Date)


#2015
#view(bet_lines2015)
#make new money line data set for 2015
money_lines2015 <- bet_lines2015[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2015[seq(from = 1, to = nrow(money_lines2015), by = 2),]
Home.Teams.ML.set <- money_lines2015[seq(from = 2, to = nrow(money_lines2015), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2015 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2015 <- ML_2015[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2015$Date <- as.character(ML_2015$Date)
str(ML_2015$Date)
ML_2015$Date <- paste("2015", ML_2015$Date, sep="")
ML_2015$Date <- as.numeric(ML_2015$Date)
#view(ML_2015)
ML_2015[857:866,]
ML_2015$Date <- as.character(ML_2015$Date)
ML_2015$Date[1:286] <- str_replace(ML_2015$Date[1:286], "2015", "20150")
ML_2015$Date[857:866] <- str_replace(ML_2015$Date[857:866], "2015", "20160")

ML_2015$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2015$Date, perl = TRUE)

ML_2015$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2015$Date, perl = TRUE)

ML_2015$Date <- gsub("-", "/", ML_2015$Date)


#2014
#view(bet_lines2014)
#make new money line data set for 2014
money_lines2014 <- bet_lines2014[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2014[seq(from = 1, to = nrow(money_lines2014), by = 2),]
Home.Teams.ML.set <- money_lines2014[seq(from = 2, to = nrow(money_lines2014), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2014 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2014 <- ML_2014[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2014$Date <- as.character(ML_2014$Date)
str(ML_2014$Date)
ML_2014$Date <- paste("2014", ML_2014$Date, sep="")
ML_2014$Date <- as.numeric(ML_2014$Date)
#view(ML_2014)
ML_2014[865:876,]
ML_2014$Date <- as.character(ML_2014$Date)
ML_2014$Date[1:327] <- str_replace(ML_2014$Date[1:327], "2014", "20140")
ML_2014$Date[865:876] <- str_replace(ML_2014$Date[865:876], "2014", "20150")

ML_2014$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2014$Date, perl = TRUE)

ML_2014$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2014$Date, perl = TRUE)

ML_2014$Date <- gsub("-", "/", ML_2014$Date)


#2013
#view(bet_lines2013)
#make new money line data set for 2013
money_lines2013 <- bet_lines2013[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2013[seq(from = 1, to = nrow(money_lines2013), by = 2),]
Home.Teams.ML.set <- money_lines2013[seq(from = 2, to = nrow(money_lines2013), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2013 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2013 <- ML_2013[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2013$Date <- as.character(ML_2013$Date)
str(ML_2013$Date)
ML_2013$Date <- paste("2013", ML_2013$Date, sep="")
ML_2013$Date <- as.numeric(ML_2013$Date)
#view(ML_2013)
ML_2013[835:846,]
ML_2013$Date <- as.character(ML_2013$Date)
ML_2013$Date[1:316] <- str_replace(ML_2013$Date[1:316], "2013", "20130")
ML_2013$Date[835:846] <- str_replace(ML_2013$Date[835:846], "2013", "20140")

ML_2013$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2013$Date, perl = TRUE)

ML_2013$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2013$Date, perl = TRUE)

ML_2013$Date <- gsub("-", "/", ML_2013$Date)


#2012
#view(bet_lines2012)
#make new money line data set for 2012
money_lines2012 <- bet_lines2012[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2012[seq(from = 1, to = nrow(money_lines2012), by = 2),]
Home.Teams.ML.set <- money_lines2012[seq(from = 2, to = nrow(money_lines2012), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2012 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2012 <- ML_2012[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2012$Date <- as.character(ML_2012$Date)
str(ML_2012$Date)
ML_2012$Date <- paste("2012", ML_2012$Date, sep="")
ML_2012$Date <- as.numeric(ML_2012$Date)
#view(ML_2012)
ML_2012[826:837,]
ML_2012$Date <- as.character(ML_2012$Date)
ML_2012$Date[1:328] <- str_replace(ML_2012$Date[1:328], "2012", "20120")
ML_2012$Date[826:837] <- str_replace(ML_2012$Date[826:837], "2012", "20130")

ML_2012$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2012$Date, perl = TRUE)

ML_2012$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2012$Date, perl = TRUE)

ML_2012$Date <- gsub("-", "/", ML_2012$Date)


#2011
#view(bet_lines2011)
#make new money line data set for 2011
money_lines2011 <- bet_lines2011[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2011[seq(from = 1, to = nrow(money_lines2011), by = 2),]
Home.Teams.ML.set <- money_lines2011[seq(from = 2, to = nrow(money_lines2011), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2011 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2011 <- ML_2011[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2011$Date <- as.character(ML_2011$Date)
str(ML_2011$Date)
ML_2011$Date <- paste("2011", ML_2011$Date, sep="")
ML_2011$Date <- as.numeric(ML_2011$Date)
#view(ML_2011)
ML_2011[801:812,]
ML_2011$Date <- as.character(ML_2011$Date)
ML_2011$Date[1:270] <- str_replace(ML_2011$Date[1:270], "2011", "20110")
ML_2011$Date[801:812] <- str_replace(ML_2011$Date[801:812], "2011", "20120")

ML_2011$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2011$Date, perl = TRUE)

ML_2011$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2011$Date, perl = TRUE)

ML_2011$Date <- gsub("-", "/", ML_2011$Date)


#2011
#view(bet_lines2011)
#make new money line data set for 2011
money_lines2011 <- bet_lines2011[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2011[seq(from = 1, to = nrow(money_lines2011), by = 2),]
Home.Teams.ML.set <- money_lines2011[seq(from = 2, to = nrow(money_lines2011), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2011 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2011 <- ML_2011[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2011$Date <- as.character(ML_2011$Date)
str(ML_2011$Date)
ML_2011$Date <- paste("2011", ML_2011$Date, sep="")
ML_2011$Date <- as.numeric(ML_2011$Date)
#view(ML_2011)
ML_2011[801:812,]
ML_2011$Date <- as.character(ML_2011$Date)
ML_2011$Date[1:270] <- str_replace(ML_2011$Date[1:270], "2011", "20110")
ML_2011$Date[801:812] <- str_replace(ML_2011$Date[801:812], "2011", "20120")

ML_2011$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2011$Date, perl = TRUE)

ML_2011$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2011$Date, perl = TRUE)

ML_2011$Date <- gsub("-", "/", ML_2011$Date)


#2010
#view(bet_lines2010)
#make new money line data set for 2010
money_lines2010 <- bet_lines2010[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2010[seq(from = 1, to = nrow(money_lines2010), by = 2),]
Home.Teams.ML.set <- money_lines2010[seq(from = 2, to = nrow(money_lines2010), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2010 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2010 <- ML_2010[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2010$Date <- as.character(ML_2010$Date)
str(ML_2010$Date)
ML_2010$Date <- paste("2010", ML_2010$Date, sep="")
ML_2010$Date <- as.numeric(ML_2010$Date)
#view(ML_2010)
ML_2010[796:808,]
ML_2010$Date <- as.character(ML_2010$Date)
ML_2010$Date[1:265] <- str_replace(ML_2010$Date[1:265], "2010", "20100")
ML_2010$Date[796:808] <- str_replace(ML_2010$Date[796:808], "2010", "20110")

ML_2010$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2010$Date, perl = TRUE)

ML_2010$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2010$Date, perl = TRUE)

ML_2010$Date <- gsub("-", "/", ML_2010$Date)


#2009
#view(bet_lines2009)
#make new money line data set for 2009
money_lines2009 <- bet_lines2009[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2009[seq(from = 1, to = nrow(money_lines2009), by = 2),]
Home.Teams.ML.set <- money_lines2009[seq(from = 2, to = nrow(money_lines2009), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2009 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2009 <- ML_2009[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2009$Date <- as.character(ML_2009$Date)
str(ML_2009$Date)
ML_2009$Date <- paste("2009", ML_2009$Date, sep="")
ML_2009$Date <- as.numeric(ML_2009$Date)
#view(ML_2009)
ML_2009[757:770,]
ML_2009$Date <- as.character(ML_2009$Date)
ML_2009$Date[1:228] <- str_replace(ML_2009$Date[1:228], "2009", "20090")
ML_2009$Date[757:770] <- str_replace(ML_2009$Date[757:770], "2009", "20100")

ML_2009$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2009$Date, perl = TRUE)

ML_2009$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2009$Date, perl = TRUE)

ML_2009$Date <- gsub("-", "/", ML_2009$Date)


#2008
#view(bet_lines2008)
#make new money line data set for 2008
money_lines2008 <- bet_lines2008[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2008[seq(from = 1, to = nrow(money_lines2008), by = 2),]
Home.Teams.ML.set <- money_lines2008[seq(from = 2, to = nrow(money_lines2008), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2008 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2008 <- ML_2008[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2008$Date <- as.character(ML_2008$Date)
str(ML_2008$Date)
ML_2008$Date <- paste("2008", ML_2008$Date, sep="")
ML_2008$Date <- as.numeric(ML_2008$Date)
#view(ML_2008)
ML_2008[707:718,]
ML_2008$Date <- as.character(ML_2008$Date)
ML_2008$Date[1:222] <- str_replace(ML_2008$Date[1:222], "2008", "20080")
ML_2008$Date[707:718] <- str_replace(ML_2008$Date[707:718], "2008", "20090")

ML_2008$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2008$Date, perl = TRUE)

ML_2008$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2008$Date, perl = TRUE)

ML_2008$Date <- gsub("-", "/", ML_2008$Date)


#2007
#view(bet_lines2007)
#make new money line data set for 2007
money_lines2007 <- bet_lines2007[c(1,3,4,12)]

#Making separate sets for home and away teams, using every other observations
Away.Teams.ML.set <- money_lines2007[seq(from = 1, to = nrow(money_lines2007), by = 2),]
Home.Teams.ML.set <- money_lines2007[seq(from = 2, to = nrow(money_lines2007), by = 2),]

#Renaming date, Team, and Money Lines Variables
colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ï..Date"] <- "Date"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ï..Date"] <- "Date"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="Team"] <- "Away.Team"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="Team"] <- "Home.Team"

colnames(Away.Teams.ML.set)[colnames(Away.Teams.ML.set)=="ML"] <- "Away.ML"
colnames(Home.Teams.ML.set)[colnames(Home.Teams.ML.set)=="ML"] <- "Home.ML"

#Deleting the VH variable in the home and away set
Away.Teams.ML.set <- Away.Teams.ML.set[-2]
Home.Teams.ML.set <- Home.Teams.ML.set[-2]

#using cbind to merge home and away sets
ML_2007 <- cbind(Home.Teams.ML.set, Away.Teams.ML.set[-1])
#check against the original bet_lines set

#Reorder variables to have teams and money lines next to each other
ML_2007 <- ML_2007[c(1,2,4,3,5)]

#Now we have to make the dates look like the project data set (experts)

#Change the dates to match project data set
ML_2007$Date <- as.character(ML_2007$Date)
str(ML_2007$Date)
ML_2007$Date <- paste("2007", ML_2007$Date, sep="")
ML_2007$Date <- as.numeric(ML_2007$Date)
#view(ML_2007)
ML_2007[702:712,]
ML_2007$Date <- as.character(ML_2007$Date)
ML_2007$Date[1:248] <- str_replace(ML_2007$Date[1:248], "2007", "20070")
ML_2007$Date[702:712] <- str_replace(ML_2007$Date[702:712], "2007", "20080")

ML_2007$Date <- gsub("(\\d{6})(ï=\\d{2})", "\\1-", ML_2007$Date, perl = TRUE)

ML_2007$Date <- gsub("(\\d{4})(ï=\\d{2})", "\\1-", ML_2007$Date, perl = TRUE)

ML_2007$Date <- gsub("-", "/", ML_2007$Date)


###Ready to merge ML sets
ML_set <- rbind(ML_2019, ML_2018, ML_2017, ML_2016, ML_2015, ML_2014, ML_2013,
                ML_2012, ML_2011, ML_2010, ML_2009, ML_2008, ML_2007)

#Look at team names
ml_teams <- as.character(sort(unique(ML_set$Home.Team)))
ml_teams

project_teams <- as.character(sort(unique(Project_set$Home.Team)))
project_teams

#Trying to see if there are mismatches in the way teams are named.
team_names <- cbind(project_teams, ml_teams)
#Looks like ML team names need to add spaces before upper cases.

#Add Space before each upper case letter in ML_set
ML_set$Home.Team <- gsub("([[:lower:]])([[:upper:]])", "\\1 \\2", ML_set$Home.Team, perl = TRUE)
ML_set$Away.Team <- gsub("([[:lower:]])([[:upper:]])", "\\1 \\2", ML_set$Away.Team, perl = TRUE)
ML_set$Home.Team <- gsub("([[:upper:]])([[:upper:]])([[:lower:]])", "\\1 \\2\\3", ML_set$Home.Team, perl = TRUE)
ML_set$Away.Team <- gsub("([[:upper:]])([[:upper:]])([[:lower:]])", "\\1 \\2\\3", ML_set$Away.Team, perl = TRUE)

#Look at team names again
ml_teams <- as.character(sort(unique(ML_set$Home.Team)))
ml_teams
team_names <- cbind(project_teams, ml_teams)

# write csv file with names to see the difference
write.xlsx(team_names, file="C:/Users/wonha/Desktop/SMU Class Material/6366 Statistical Consulting/Consulting Project/team_names.csv")
#write_excel_csv(Country_compare, path = "C:/Users/wonha/Desktop/SMU Class Material/6395 Intro to Bayesian Statistical Learning/FInal Project/Compare_countries.csv")

#Change ML team names
ML_set[ML_set=="Alabama AM"] <- 'Alabama A&M'
ML_set[ML_set=="Alcorn St"] <- 'Alcorn State'
ML_set[ML_set=="Appalachian St"] <- 'Appalachian State'
ML_set[ML_set=="Arizona U"] <- 'Arizona'
ML_set[ML_set=="BOISEST"] <- 'Boise State'
ML_set[ML_set=="Brown"] <- 'Brown University'
ML_set[ML_set=="Buffalo U"] <- 'Buffalo'
ML_set[ML_set=="Central Florida"] <- 'UCF'
ML_set[ML_set=="Charleston Sou"] <- 'Charleston Southern'
ML_set[ML_set=="Cincinnati U"] <- 'Cincinnati'
ML_set[ML_set=="Davidson"] <- 'Davidson College'
ML_set[ML_set=="East Tennessee St"] <- 'East Tennessee State'
ML_set[ML_set=="East Washington"] <- 'Eastern Washington'
ML_set[ML_set=="Florida AM"] <- 'Florida A&M'
ML_set[ML_set=="Florida International"] <- 'FIU'
ML_set[ML_set=="Florida Intl"] <- 'FIU'
ML_set[ML_set=="Houston U"] <- 'Houston'
ML_set[ML_set=="Idaho St"] <- 'Idaho State'
ML_set[ML_set=="Illinois St"] <- 'Illinois State'
ML_set[ML_set=="Indiana St"] <- 'Indiana State'
ML_set[ML_set=="Jacksonville"] <- 'Jacksonville University'
ML_set[ML_set=="Jacksonville St"] <- 'Jacksonville State'
ML_set[ML_set=="Kennesaw St"] <- 'Kennesaw State'
ML_set[ML_set=="Kent"] <- 'Kent State'
ML_set[ML_set=="Mc Neese St"] <- 'McNeese'
ML_set[ML_set=="Miami Florida"] <- 'Miami (FL)'
ML_set[ML_set=="Miami Ohio"] <- 'Miami (OH)'
ML_set[ML_set=="Minnesota U"] <- 'Minnesota'
ML_set[ML_set=="Mississippi"] <- 'Ole Miss'
ML_set[ML_set=="Mississippi St"] <- 'Mississippi State'
ML_set[ML_set=="Miss.Valley St"] <- 'Mississippi Valley State'
ML_set[ML_set=="Montana St"] <- 'Montana State'
ML_set[ML_set=="Mid Tennessee State"] <- 'MTSU'
ML_set[ML_set=="Middle Tenn St"] <- 'MTSU'
ML_set[ML_set=="Middle Tennessee State"] <- 'MTSU'
ML_set[ML_set=="Nicholls St"] <- 'Nicholls State'
ML_set[ML_set=="N.Carolina A&T"] <- 'North Carolina A&T'
ML_set[ML_set=="NC Central"] <- 'North Carolina Central'
ML_set[ML_set=="No Dakota State"] <- 'North Dakota State'
ML_set[ML_set=="NO.Colorado"] <- 'Northern Colorado'
ML_set[ML_set=="No Illinois"] <- 'Northern Illinois'
ML_set[ML_set=="Pittsburgh U"] <- 'Pittsburgh'
ML_set[ML_set=="Portland St"] <- 'Portland State'
ML_set[ML_set=="Sam Houston St"] <- 'Sam Houston State'
ML_set[ML_set=="So Carolina St"] <- 'South Carolina State'
ML_set[ML_set=="So Illinois"] <- 'Southern Illinois'
ML_set[ML_set=="So Mississippi"] <- 'Southern Miss'
ML_set[ML_set=="South Dakota St"] <- 'South Dakota State'
ML_set[ML_set=="Stephen F.Austin"] <- 'Stephen F Austin'
ML_set[ML_set=="Tennessee U"] <- 'Tennessee'
ML_set[ML_set=="Tenn Chat"] <- 'Chattanooga'
ML_set[ML_set=="Tex San Antonio"] <- 'UTSA'
ML_set[ML_set=="UL-Monroe"] <- 'Louisiana Monroe'
ML_set[ML_set=="UL Monroe"] <- 'Louisiana Monroe'
ML_set[ML_set=="UL Lafayette"] <- 'Lafayette'
ML_set[ML_set=="USC"] <- 'Southern Cal'
ML_set[ML_set=="Washington U"] <- 'Washington'
ML_set[ML_set=="Weber St"] <- 'Weber State'
ML_set[ML_set=="William Mary"] <- 'William&Mary'
ML_set[ML_set=="Youngstown St"] <- 'Youngstown State'

##Check team names again
ml_teams <- as.character(sort(unique(ML_set$Home.Team)))
ml_teams
team_names <- cbind(project_teams, ml_teams)

# write csv file with names to see the difference
#write.xlsx(team_names, file="C:/Users/wonha/Desktop/SMU Class Material/6366 Statistical Consulting/Consulting Project/team_names.csv")

#merge all sets now
#Analysis_set <- merge(x = Project_set, y = ML_set, by = c("Date", "Home.Team", "Away.Team"), all.x = TRUE)
ML_set$Home.ML <-as.numeric(as.character(ML_set$Home.ML))
ML_set$Away.ML <-as.numeric(as.character(ML_set$Away.ML))
ML_set$Total.ML <- abs(ML_set$Home.ML - ML_set$Away.ML)
Analysis_set <- merge(Project_set, ML_set, by=c("Date", "Home.Team", "Away.Team"))

#Make column for the positive(underdog) and negative(favored) money lines
Analysis_set$Underdog.ML <- pmax(Analysis_set$Home.ML, Analysis_set$Away.ML)
Analysis_set$Favorite.ML <- pmin(Analysis_set$Home.ML, Analysis_set$Away.ML)
Analysis_set[1000:1010, c(2,3, 126:130)]
#Add columns for team probability to win
Analysis_set$Fave.Win.Prob <- round(abs(Analysis_set$Favorite.ML)/(abs(Analysis_set$Favorite.ML)+100), digits = 1)
Analysis_set$UnDog.Win.Prob <- round(100/(Analysis_set$Underdog.ML+100), digits = 1)
Analysis_set[1000:1010, c(2,3, 129:132)]
#Adjust win probability of "underdog" if money line is even
Analysis_set$UnDog.Win.Prob <- ifelse(Analysis_set$Home.ML ==Analysis_set$Away.ML, 0.5, Analysis_set$UnDog.Win.Prob)

Analysis_set$Home.Team <- as.character(Analysis_set$Home.Team)
Analysis_set$Away.Team <- as.character(Analysis_set$Away.Team)
Analysis_set$Winner <- as.character(Analysis_set$Winner)
Analysis_set$Loser <- as.character(Analysis_set$Loser)

#Create variable for who was the favorite to win
Analysis_set$Fave.to.Win <- ifelse(Analysis_set$Home.ML < 0, Analysis_set$Home.Team, Analysis_set$Away.Team)

#Create potential points reward for guessing correctly
Analysis_set$Pot.Award <- ifelse(Analysis_set$Fave.to.Win == Analysis_set$Winner, (1 - Analysis_set$Fave.Win.Prob), (1 - Analysis_set$UnDog.Win.Prob))
Analysis_set[1000:1010, c(2,3, 129:134)]


#Create list of analyst names to use in loop to complete guess and points awarded variables
Analyst.Names <- names(Analysis_set[, 13:125])
names.length <- length(Analyst.Names)
An.Var.Names.RW <- paste(Analyst.Names[1:names.length], ".RW", sep = "")
An.Var.Names.Pts <- paste(Analyst.Names[1:names.length], ".Pts", sep = "")


for (i in 1: names.length){
  #Create variable for if analyst got the game correct
  Analysis_set[[An.Var.Names.RW[i]]] <- ifelse(Analysis_set[[Analyst.Names[i]]] == Analysis_set$Winner, "Correct", "Incorrect")
  #Create column for how many points to award analyst
  #Analysis_set[[An.Var.Names.Pts[i]]] <- ifelse(Analysis_set[[An.Var.Names.RW[i]]] == "Correct", Analysis_set$Pot.Award, 0)
}

Analysis_set1 <- subset(Analysis_set, Total.ML<=500)
Analysis_set2 <- subset(Analysis_set, Total.ML<=1000)
Analysis_set3 <- subset(Analysis_set, Total.ML<=1500)


#Count <- lapply(Analysis_set1[, 129:241], table)
#Count1 <- as.data.frame.complex(Count)

#Now to find average of each analyst
Pick.PCT1 <- round(colMeans(Analysis_set1[,seq(from = 135, to = ncol(Analysis_set1))] == "Correct", na.rm = TRUE), digits = 2)
Num.Pick1 <- colSums(!is.na(Analysis_set1[,135:247]))
ML500 <- as.data.frame(cbind(Num.Pick1, Pick.PCT1))
ML500 <- sqlRownamesToColumn(ML500)

Pick.PCT2 <- round(colMeans(Analysis_set2[,seq(from = 135, to = ncol(Analysis_set2))] == "Correct", na.rm = TRUE), digits = 2)
Num.Pick2 <- colSums(!is.na(Analysis_set2[,135:247]))
ML1000 <- as.data.frame(cbind(Num.Pick2, Pick.PCT2))
ML1000 <- sqlRownamesToColumn(ML1000)

Pick.PCT3 <- round(colMeans(Analysis_set3[,seq(from = 135, to = ncol(Analysis_set3))] == "Correct", na.rm = TRUE), digits = 2)
Num.Pick3 <- colSums(!is.na(Analysis_set3[,135:247]))
ML1500 <- as.data.frame(cbind(Num.Pick3, Pick.PCT3))
ML1500 <- sqlRownamesToColumn(ML1500)

#Scatterplot of money line subsets, showing number of picks and correct percentage
p1 <- plot_ly(
  ML500, x = ~Num.Pick1, y = ~Pick.PCT1,
  # Hover text:
  text = ~paste("Expert Name: ", row_names, "<br>Number of Picks: ", Num.Pick1, '<br>Correct Percentage:', Pick.PCT1),
  color = ~Pick.PCT1, size = ~Pick.PCT1
) %>% layout(xaxis = list(title="Number of Picks"), yaxis = list(title="Correct Pick Percentage"), title="Money Line 500")
p1
p2 <- plot_ly(
  ML1000, x = ~Num.Pick2, y = ~Pick.PCT2,
  # Hover text:
  text = ~paste("Expert Name: ", row_names, "<br>Number of Picks: ", Num.Pick2, '<br>Correct Percentage:', Pick.PCT2),
  color = ~Pick.PCT2, size = ~Pick.PCT2
) %>% layout(xaxis = list(title="Number of Picks"), yaxis = list(title="Correct Pick Percentage"), title="Money Line 1000")
p2
p3 <- plot_ly(
  ML1500, x = ~Num.Pick3, y = ~Pick.PCT3,
  # Hover text:
  text = ~paste("Expert Name: ", row_names, "<br>Number of Picks: ", Num.Pick3, '<br>Correct Percentage:', Pick.PCT3),
  color = ~Pick.PCT3, size = ~Pick.PCT3
) %>% layout(xaxis = list(title="Number of Picks"), yaxis = list(title="Correct Pick Percentage"), title="Money Line 1500")
p3

#Boxplot to compare the summary of different money line subsets
g1<-ggplot(ML500) +
  aes(x = "", y = Pick.PCT1) +
  geom_boxplot(fill = "#a6cee3") +
  labs(x = "ML500", y = "Correct Percentage", title = "Boxplot ML500") +
  theme_minimal()
g2<-ggplot(ML1000) +
  aes(x = "", y = Pick.PCT2) +
  geom_boxplot(fill = "#a6cee3") +
  labs(x = "ML 1000", y = "Correct Percentage", title = "Boxplot ML1000") +
  theme_minimal()
g3<-ggplot(ML1500) +
  aes(x = "", y = Pick.PCT3) +
  geom_boxplot(fill = "#a6cee3") +
  labs(x = "ML 1500", y = "Correct Percentage", title = "Boxplot ML1500") +
  theme_minimal()

Pick.PCT <- round(colMeans(Analysis_set[,seq(from = 135, to = ncol(Analysis_set))] == "Correct", na.rm = TRUE), digits = 2)
Num.Pick <- colSums(!is.na(Analysis_set[,135:247]))
ML.all <- as.data.frame(cbind(Num.Pick, Pick.PCT))
ML.all <- sqlRownamesToColumn(ML.all)
g4<-ggplot(ML.all) +
  aes(x = "", y = Pick.PCT) +
  geom_boxplot(fill = "#a6cee3") +
  labs(x = "ML All", y = "Correct Percentage", title = "Boxplot for Different Money Line Subsets") +
  theme_minimal()
subplot(g1,g2,g3,g4, shareX = T , shareY = T)

#write.csv(ML500, file = "~/Desktop/ML500.csv")
#write.csv(ML1000, file = "~/Desktop/ML1000.csv")
#write.csv(ML1500, file = "~/Desktop/ML1500.csv")
#write.csv(ML.all, file = "~/Desktop/MLall.csv")

for (i in 1: names.length){
  #Create variable for if analyst got the game correct
  #Analysis_set[[An.Var.Names.RW[i]]] <- ifelse(Analysis_set[[Analyst.Names[i]]] == Analysis_set$Winner, "Correct", "Incorrect")
  #Create column for how many points to award analyst
  Analysis_set[[An.Var.Names.Pts[i]]] <- ifelse(Analysis_set[[An.Var.Names.RW[i]]] == "Correct", Analysis_set$Pot.Award, 0)
}

#Now I need to create a data set just with the number of points on average the analyst gets
Points.Earned <- Analysis_set[,seq(from = 248, to = ncol(Analysis_set))]
#Check dimensions
dim(Points.Earned) #10089 rows (games) and 113 columns (analysts) matches master set

#Now to find average of each analyst
#Pick.PCT <- colMeans(Analysis_set[,seq(from = 135, to = ncol(Analysis_set), by = 2)] == "Correct", na.rm = TRUE)
Avg.Score <- colMeans(Points.Earned, na.rm = TRUE)
#Number of perdictions made by each analyst
N.Preds <- colSums(!is.na(Points.Earned)) #Phil Steel has most, 6318

#Create new data frame with just these two variables
How.Good <- cbind(N.Preds, Pick.PCT, Avg.Score)
How.Good <- as.data.frame(How.Good)
How.Good <- sqlRownamesToColumn(How.Good)
# Rename analyst column
colnames(How.Good)[colnames(How.Good)=="row_names"] <- "Analyst"

#Histogram of number of predictions
ggplot(How.Good) +
  aes(x = N.Preds) +
  geom_histogram(bins = 20L, fill = "#0c4c8a") +
  labs(x = "Predictions", y = "Count", title = "Histogram of Predictions Made") +
  theme_gray()

#Scatterplot of pick pct. vs average pts earned
ggplot(How.Good) +
  aes(x = Pick.PCT, y = Avg.Score, size = N.Preds) +
  geom_point(colour = "#0c4c8a") +
  labs(x = "Pick Percentage", y = "Average Points Earned", title = "Compare Pick Accuracy to Weighted Values", size = "Number of Predictions") +
  theme_gray()
