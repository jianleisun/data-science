plot2 <- function()
{       
    library(sqldf)     
    
    # 1. select two days from the input file
    
    data <- read.csv2.sql("household_power_consumption.txt", 
        sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'", na.strings = "?") 
    
    # 2. prepare the data/time object
    
    data$Date <- as.Date(data$Date, format = "%d/%m/%Y")        
    
    data$DateTime <- paste(data$Date, data$Time)
    
    data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S") # Appropriate time format
    
    # 3. plot the data
    
    png(file = "plot2.png")

    plot(data$DateTime, data$Global_active_power, type = "l", 
       xlab = "", ylab = "Global Active Power (kilowatts)")
    
    dev.off()

}

