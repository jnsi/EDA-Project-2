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

## Filter SCC dataset for Vehicle Entries

vehicles <- grepl(pattern = "vehicle",x = SCC$SCC.Level.Two,ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

baltimorevehicles <- (vehiclesNEI[vehiclesNEI$fips == "24510",])

## Create a BarPlot and Export as PNG file

#Question 5 : How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#Open the device
png("./data/plot5.png", width=480, height=480,units = "px")

#Plot 5: Motor Vehicle-Related Emissions in Baltimore County: 1999-2008
plot5<-ggplot(data = baltimorevehicles, aes(factor(year), Emissions)) +
        geom_bar(stat = "identity",fill = "orange", width = 0.75) +
        theme_grey(base_size = 14,base_family = "") +
        labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Vehicle Source Emissions, Baltimore City"))
print(plot5)

# Close the device
dev.off()
