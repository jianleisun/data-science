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

# 2. 

SCC_selected <- SCC$SCC[grepl("[m|M]obile",SCC$EI.Sector)]

SCC_data <- subset(NEI, SCC %in% SCC_selected & fips == "24510", select = c(year,Emissions))

emissionsBaltimoreMotorVehicle <- aggregate(Emissions ~ year, data = SCC_data, FUN = sum)

png(file = "plot5.png")

with(emissionsBaltimoreMotorVehicle, 
     plot(year, Emissions, type="o", pch = 10, xaxt = 'n',
          xlab="10 Years' Period", ylab = "Motor Vehicle Emissions",
          col = "red", main="Motor Vehicle Emissions in Baltimore City", 
          xlim = c(1999,2008))
)
axis(side = 1, at = emissionsBaltimoreMotorVehicle$year) 

dev.off()

# Question 5: 
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Answer:
# The emissions from motor vehicle sources decreased from 1999 to 2002,  
# and then increased from 2002 to 2008.


