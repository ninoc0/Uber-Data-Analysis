install.packages("ggthemes")
install.packages("DT")
install.packages("tinyverse")

knitr::opts_chunk$set(echo=TRUE)
library(ggplot2) #data visualization library 

library(ggthemes) #add-on to the ggplot library
library(lubridate) #creates ability to add multiple time frames
library(readxl) #reads the excel files

library(dplyr) #used in data manipulation

library(tidyr) #cleans code
library(tinyverse)
library(DT) #uses the Java program datatables
library(scales) #creates scales for mapped data

colors = c("#d285e6","#85b9e6","#e6d685","#e68885","#8b85e6","#e685e4","#c7f2c2","#f2c2c9"")
#sets the colors used in the plots

apr <- read.csv ("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-apr14.csv")
may <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-may14.csv")
jun <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-jun14.csv")
jul <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-jul14.csv")
aug <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-aug14.csv")
sep <- read.csv("C:\\Users\\nicoo\\OneDrive\\Desktop\\uber-raw-data-sep14.csv")
#gives the data variable names

data <- rbind(apr,may,jun,jul,aug,sep)
cat(dim(data))
#combines the data into one set and checks the dimensions

data$Date.Time <- as.POSIXct(data$Date.Time, format = "%m/%d/%Y %H:%M:%S")

data$Time <- format(as.POSIXct(data$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S")

data$Date.Time <- ymd_hms(data$Date.Time)

data$day <- factor(day(data$Date.Time))
data$month <- factor(month(data$Date.Time, label = TRUE))
data$year <- factor(year(data$Date.Time))
data$dayofweek <- factor(wday(data$Date.Time, label = TRUE))

data$hour <- factor(hour(hms(data$Time)))
data$minute <- factor(minute(hms(data$Time)))
data$second <- factor(second(hms(data$TIme)))
#format of the date.time column and creating factors of time

head(data)
#check the data is correct

hour_data <- data %>%
  group_by(hour) %>%
    dplyr::summarise(Total = n())
datatable(hour_data)

ggplot(hour_data, aes(hour, Total)) +
geom_bar(stat="identity",
           fill="#d285e6",
           color="#85b9e6") +
ggtitle("Trips Every Hour", subtitle = "aggregated today") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_test(hjust = 0.5)) +
scale_y_continuous(labels=comma)
