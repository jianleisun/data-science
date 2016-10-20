# By Jianlei(John) Sun Wed Oct 19 15:30:24 2016

# 1. Prepre the dataset

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fileName <- "dataset.zip"

if (!file.exists(fileName)) {
    download.file(URL, fileName,"curl")             
    file <- unzip(fileName)   
}

NEI <- readRDS("summarySCC_PM25.rds")               
SCC <- readRDS("Source_Classification_Code.rds") 

# 2. Compute all codes of the coal combustion-related sources and create plot4

SCC_selected <- SCC$SCC[grepl("[C|c]oal",SCC$EI.Sector)]

SCC_data <- subset(NEI, SCC %in% SCC_selected, select = c(year,Emissions))

totalEmissionsCoal <- aggregate(Emissions ~ year, data = SCC_data, FUN = sum)

png(file = "plot4.png")

with(totalEmissionsCoal, 
     plot(year, Emissions, type="o", pch = 10, xaxt = 'n',
          xlab="10 Years' Period", ylab = "Coal combustion-related Emissions",
          col = "red", main="Coal combustion-related Emissions across the United States", 
          xlim = c(1999,2008))
)
axis(side = 1, at = totalEmissionsCoal$year) 

dev.off()

# Question 4: 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Answer:
# From the plot4, the emissions from coal combustion-related sources decreased from 1999-2008.

