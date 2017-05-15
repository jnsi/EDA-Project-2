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

# Question 6 :Compare emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"),
## Filter SCC dataset for Vehicle Entries
library(ggplot2)
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

## Create Barplot and Export as PNG file
#Open the device
png("./data/plot6.png",width = 480, height = 480,units = "px",)

#Create the plot
plot6 <- ggplot(bothNEI, aes(x=year, y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

#Close the device
print(plot6)
dev.off()
