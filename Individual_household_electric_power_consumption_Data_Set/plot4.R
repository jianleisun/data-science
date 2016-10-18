plot4 <- function()
{      
    library(sqldf)     
    
    # 1. select two days from the input file
    
    data <- read.csv2.sql("household_power_consumption.txt", 
            sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'", na.strings = "?") 
        
    # 2. prepare the data/time object
    
    data$Date <- as.Date(data$Date, format = "%d/%m/%Y")        
    
    data$DateTime <- paste(data$Date, data$Time)
    
    data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S") # Appropriate time format
        
    # 3. plot the sub graphs 
    
    png(file = "plot4.png")
    
    par(mfrow = c(2,2))
    
    # sub figure 1
    plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power") 
    
    # sub figure 2 
    plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    
    # sub figure 3
    plot  (data$DateTime, data$Sub_metering_1, type = "l", xlab = "", 
           ylab = "Energy sub metering", col = "Black")
    points(data$DateTime, data$Sub_metering_2, type = "l", xlab = "", 
           ylab = "Energy sub metering", col = "Red")
    points(data$DateTime, data$Sub_metering_3, type = "l", xlab = "", 
           ylab = "Energy sub metering", col = "Blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
          legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
    
    # sub figure 4
    plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
        
    dev.off()

}
