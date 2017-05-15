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

#Question 4 : Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#Subset coal combustion related NEI data
SCC.subset <- SCC[grepl("Coal" , SCC$Short.Name), ]
NEI.subset <- NEI[NEI$SCC %in% SCC.subset$SCC, ]

#str(SCC.subset)
#str(NEI.subset)

#Plot 4 : change in emissions from coal combustion-related sources from 1999-2008 by type
#Open the device
png("./data/plot4.png", width=480, height=480)

#Plot 4 : Changes in Coal-Related Emissions: 1999-2008
plot4 <- ggplot(NEI.subset, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) +xlab("year") +ylab("Coal-Related PM2.5 Emissions") + ggtitle("Total Coal-Related PM2.5 Emissions")
print(plot4)

# Close the device
dev.off()

