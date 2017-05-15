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


#Subset data with the condition fips == "24510"
library(ggplot2)
subsetdata <- subset(NEI, fips == "24510")
baltisources <- aggregate(subsetdata[c("Emissions")], list(type = subsetdata$type, year = subsetdata$year), sum)

#Question 3 : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
#Open the device
png("./data/plot3.png", width=480, height=480)

#Plot 3: #Create a plot "the total PM2.5 Emission from all sources with the base plotting system"
plot3 <- ggplot(data = baltisources, aes(factor(year), Emissions, fill = type)) +
        geom_bar(stat = "identity") +
        facet_grid(facets = .~type,scales = "free",space = "free") +
        labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))
print(plot3)

# Close the device
dev.off()
