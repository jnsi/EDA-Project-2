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

#Question 2 : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question
#Subset data on the condition when fips == "24510" 
subsetdata <- subset(NEI, fips == "24510")
baltimore <- tapply(subsetdata$Emissions, subsetdata$year, sum)
#str(subsetdata)
#str(baltimore)

#Plot 2 : use the base plotting system to make a plot of this data
#Open the device
png("./data/plot2.png", width=480, height=480)

#Plot 1 : #Create a plot "the total PM2.5 Emission from all sources with the base plotting system"
plot(baltimore, type = "o", main = "Emissions of Baltimore City from 1999 to 2008 by Source Type", xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tons)", pch = 19, col = "darkblue", lty = 6)

# Close the device
dev.off()
