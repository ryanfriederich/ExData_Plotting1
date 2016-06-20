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
with(consumption2, plot(DateTime, Sub_metering_1, type = "l", 
                        xlab = "", ylab = "Energy sub metering"))
with(consumption2, lines(DateTime, Sub_metering_2, col = "red"))
with(consumption2, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = "solid", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "ExData_Plotting1/plot3.png")
dev.off()