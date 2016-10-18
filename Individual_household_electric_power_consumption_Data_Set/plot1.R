plot1 <- function()
{   
    library(sqldf)     
    
    # 1. select two days from the input file
        
    data <- read.csv2.sql("household_power_consumption.txt", 
        sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'", na.strings = "?") 
        
    # 2. compute the histogram for "Global Active Power"
    
    png(file = "plot1.png")
    
    hist(data$Global_active_power, col = "Red", main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)")
    
    dev.off()
}
