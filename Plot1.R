# Set the work directory
WD <- getwd()
if (!is.null(WD)) setwd(WD)

#Create dir data if it does not exist
if(!file.exists('data')) dir.create('data')

#Download the zip archive if it does not exits and unzip it
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
   download.file(fileUrl, destfile = './data/FNEI_data.zip')
   unzip('./data/FNEI_data.zip', exdir = './data')

#Date of download
datedownloaded <- date()

# load library
library(dplyr)
library(data.table)
library(ggplot2)

#Read files 
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
dir()


##Explore the data for NEI and SCC variables
#str(NEI)
#head(NEI)
#tail(NEI)
#dim(NEI)
#summary(NEI)

# Aggregate the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
Aggrdata <- with(NEI, aggregate(Emissions, by = list(year), sum))
#str(Aggrdata)
#head(Aggrdata)

#Question 1 : making a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
#Open the device
png("./data/plot1.png", width=480, height=480)

#Plot 1 : #Create a plot "the total PM2.5 Emission from all sources with the base plotting system"
plot(Aggrdata, type = "o", main = "Total PM2.5 Emissions From All US Sources", xlab = "Year", ylab = "PM2.5 Emissions(10^6 Tons)", pch = 20, col = "blue", lty = 2)

# Close the device
