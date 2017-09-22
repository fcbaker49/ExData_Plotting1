graphrun <- function(){
  
  install.packages(dplyr)
  install.packages(lubridate)
  install.packages(chron)
  library(dplyr)
  library(lubridate)
  library(chron)
  #download zip file and read in data
  #data is csv2, separated by semicolon
temp <- tempfile()
download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
data <- read.csv2(unz(temp, "household_power_consumption.txt"), header = TRUE)
unlink(temp)


## subset data to dates 2007-02-01 and 2007-02-02
dt <- paste(as.character(data$Date), 
            as.character(data$Time))
data$dt <- with(data, as.POSIXct(dt, format="%d/%m/%Y %H:%M:%S"))

data$Date <-(as.Date(data$Date, format = "%d/%m/%Y", tz = ""))
filt <- filter(data, Date == "2007-02-01"|Date == "2007-02-02")
filt$Global_active_power <- as.numeric(as.character(filt$Global_active_power))
filt$Sub_metering_1 <- as.numeric(as.character(filt$Sub_metering_1))
filt$Sub_metering_2 <- as.numeric(as.character(filt$Sub_metering_2))
filt$Sub_metering_3 <- as.numeric(as.character(filt$Sub_metering_3))
filt$Voltage <- as.numeric(as.character(filt$Voltage))
filt$Global_reactive_power <- as.numeric(as.character(filt$Global_reactive_power))
##create plot

par(mfrow = c(2,2))

#png(filename = "plot4.png",
#    width = 480,
#   height = 480)

## Plot 1
plot(filt$dt, 
     filt$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab= "Global Active Power")

## Plot 2
plot(filt$dt, 
     filt$Voltage, 
     type = "l", 
     xlab = "", 
     ylab= "Voltage")

## Plot 3
plot(filt$dt, 
     filt$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab= "Energy sub metering")

lines(filt$dt, 
     filt$Sub_metering_2, 
     type = "l", 
     col = "red")

lines(filt$dt, 
     filt$Sub_metering_3, 
     type = "l", 
     col = "blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lty=1, cex=0.8, box.lty=0)

#Plot 4
plot(filt$dt, 
     filt$Global_reactive_power, 
     type = "l", 
     xlab = "", 
     ylab= "Global Reactive Power")

dev.copy(png,'plot4.png')
dev.off()

}