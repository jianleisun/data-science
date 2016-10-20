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

# 2. Compute the total emissions in the Baltimore city and create plot2.

BaltimoreTotalEmissions <- subset(NEI, fips == "24510", select = c(year,Emissions)) 

totalEmissions <- aggregate(Emissions ~ year, data = BaltimoreTotalEmissions, FUN = sum)

png(file = "plot2.png")

with(totalEmissions, 
     plot(year,Emissions,type="o", pch = 10, xaxt = 'n',
          xlab="10 Years' Period", ylab = "Baltimore Total Emissions from PM2.5",
          col = "red", main="Total Emissions from PM2.5 in the Baltimore City", 
          xlim = c(1999,2008))
)
axis(side = 1, at = totalEmissions$year) 

dev.off()

# 2) 

# Question 2: 
# Have total emissions from PM2.5 decreased in the Baltimore City, 
#       Maryland (fips == "24510") from 1999 to 2008? 

# Answer:
# From the plot2, the total emissions from PM2.5 in the Baltimore City decresed from 1999 to 2002, 
# increased from 2002 to 2005, and finally decreased from 2005 to 2008.


