# By Jianlei(John) Sun Wed Oct 19 15:30:24 2016

library(ggplot2)

# 1. Prepre the dataset

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fileName <- "dataset.zip"

if (!file.exists(fileName)) {
    download.file(URL, fileName,"curl")             
    file <- unzip(fileName)   
}

NEI <- readRDS("summarySCC_PM25.rds")               
SCC <- readRDS("Source_Classification_Code.rds")     

SCC_selected <- SCC$SCC[grepl("[m|M]obile",SCC$EI.Sector)]

SCC_data <- subset(NEI, SCC %in% SCC_selected & (fips == "24510" | fips == "06037")
                 , select = c(year,Emissions,fips))

emissionsBaltimoreAndLosAngeles <- aggregate(Emissions ~ year + fips, data = SCC_data, FUN = sum)

names(emissionsBaltimoreAndLosAngeles) <- c("Year", "County", "Emissions")

emissionsBaltimoreAndLosAngeles$County<-rep(c("Los Angeles","Baltimore"),each=4)

png(file = "plot6.png")

qplot(Year, Emissions, data=emissionsBaltimoreAndLosAngeles, color=County) + geom_line() + labs(y="Motor Vehicle Emissions") + labs(title = "Baltimore Vs. Los Angeles Motor Vehicle Emissions")

dev.off()

# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Answer:
# Logs Angeles shows greater changes over time than Baltimore City.
# Specifically speaking, the motor vehicle sources in Baltimore City decreased from 1999 to 2002,
# and then slightly increased from 2002 to 2008; 
# Los Angeles increased from 1999 to 2005, and then decreased from 2005 to 2008.

