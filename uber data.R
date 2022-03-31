install.packages("ggthemes")
install.packages("DT")

knitr::opts_chunk$set(echo=TRUE)
library(ggplot2) #data visualization library 

library(ggthemes) #add-on to the ggplot library
library(lubridate) #creates ability to add multiple time frames
library(readxl) #reads the excel files

library(dplyr) #used in data manipulation

library(tidyr) #cleans code
library(DT) #uses the Java program datatables
library(scales) #creates scales for mapped data

colors = c(""#d285e6","#85b9e6","#e6d685","#e68885","#8b85e6","#e685e4","#c7f2c2","#f2c2c9")
#sets the colors used in the plots
                
apr_data <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-apr14.csv")
may_data <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-may14.csv")
jun_data <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-jun14.csv")
jul_data <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-jul14.csv")
aug_data <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-aug14.csv")
sep_data <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-sep14.csv")
#gives the data variable names

data_2014 <- rbind(apr_data,may_data,jun_data,jul_data,aug_data,sep_data)

data_2014$Date.Time <- as.POSIXct(data_2014$Date.Time, format = "%m/%d/%Y %H:%M:%S")

data_2014$Time <- format(as.POSIXct(data_2014$Date.Time,format = "%m/%d/%Y %H:%M:%S"), format=%H:%M:%S)

data_2014$Date.Time <- ymd_hms(data_2014$Date.Time)

data_2014$day <- factor(day(data_2014$Date.Time))
data_2014$month <- factor(month(data_2014$Date.Time, label = TRUE))
data_2014$year <- factor(year(data_2014$Date.Time))
data_2014$dayofweek <- factor(wday(data_2014$Date.Time, label = TRUE))

data_2014$hour <- factor(hour(hms(data_2014$Time)))
data_2014$minute <- factor(minute(hms(data_2014$Time)))
data_2014$second <- factor(second(hms(data_2014$TIme)))
#format of the date.time column and creating factors of time

