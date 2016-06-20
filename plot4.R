        ## Download file ##
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "household_power_consumption.zip", mode = "wb")
unzip("household_power_consumption.zip", exdir = "household_power_consumption")
library(data.table)
consumption <- fread("household_power_consumption/household_power_consumption.txt", 
                     na.strings = "?")
        ## Subset by Date 2/1/2007-2/2/2007 ##
begin <- as.Date("01/02/2007", "%d/%m/%Y")
end <- as.Date("02/02/2007", "%d/%m/%Y")
consumption <- consumption[as.Date(consumption$Date, "%d/%m/%Y") >= begin & 
                                   as.Date(consumption$Date, "%d/%m/%Y") <= end, ]
library(lubridate)
consumption2 <- within(consumption, 
                       {DateTime = dmy_hms(paste(consumption$Date, consumption$Time))})
        ## Plot the line graph of Sub_metering_1-3 ##
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1), oma = c(1, 1, 0, 0))
with(consumption2, {
        plot(DateTime, Global_active_power, type = "l", 
             xlab = "", ylab = "Global Active Power (kilowatts)")
        plot(DateTime, Voltage, type = "l",
             xlab = "datetime", ylab = "Voltage")
        plot(DateTime, Sub_metering_1, type = "l", 
             xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        legend("topright", lty = "solid", col = c("black", "red", "blue"), bty = "n", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power, type = "l",
             xlab = "datetime", ylab = "Global_reactive_power")
})
dev.copy(png, file = "ExData_Plotting1/plot4.png")
dev.off()