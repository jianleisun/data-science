plot3 <- function()
{  
    library(sqldf)     
    
    # 1. select two days from the input file
    
    data <- read.csv2.sql("household_power_consumption.txt", 
        sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'", na.strings = "?") 
 
    # 2. prepare the data/time object
    
    data$Date <- as.Date(data$Date, format = "%d/%m/%Y")        
    
    data$DateTime <- paste(data$Date, data$Time)
    
    data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S") # Appropriate time format
    
        
    # 3. plot the energy sub metering data
    
    png(file = "plot3.png")
    
    plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", 
           ylab = "Energy sub metering", col = "Black")

    points(data$DateTime, data$Sub_metering_2, type = "l", xlab = "", 
           ylab = "Energy sub metering", col = "Red")
    
    points(data$DateTime, data$Sub_metering_3, type = "l", xlab = "", 
           ylab = "Energy sub metering", col = "Blue")
    
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
    dev.off()
}
