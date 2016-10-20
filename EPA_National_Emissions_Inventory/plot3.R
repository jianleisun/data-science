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

# 2. Compute the total emissions based on the "year" and "type", 
#           and create "plot3" using the ggplot plotting system.

BaltimoreTotalEmissions <- subset(NEI, fips == "24510", select = c(year, Emissions, type)) 

totalEmissions <- aggregate(Emissions ~ year + type, data = BaltimoreTotalEmissions, FUN = sum)

names(totalEmissions) <- c("Year","Type", "Emissions")

png(file = "plot3.png")

ggplot(totalEmissions, aes(Year, Emissions, color = Type)) + geom_line() + labs(y="PM2.5 Emissions") + labs(title="PM2.5 Emissions in Baltimore City per Type/Year")

dev.off()

# Question 3: 
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 

# Answer:
# From plot3, the "point" source emission first increased from 1999 to 2005, and then decreaed from 2005 to 2008; 
# The remaing sources such as "non-road","nonpoint" and "on-raod" decreased from 1999 to 2008.

