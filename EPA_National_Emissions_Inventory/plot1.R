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

# 2. Compute the averaged total emissions and create the plot1

totalEmissions <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

png(file = "plot1.png")

with(totalEmissions, 
    plot(year,Emissions,type="o", pch = 10,xaxt = 'n',
    xlab="10 Years' Period", ylab = "Total Emissions from PM2.5",
    col = "red",
    main="Total Emissions from PM2.5 per Year", 
    xlim = c(1999,2008))
)
axis(side = 1, at = totalEmissions$year) 

dev.off()

# Question 1: 
# Have the total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

# Answer:
# From the plot1, PM2.5 emissions decreased from 1999 to 2008 in the United States.

