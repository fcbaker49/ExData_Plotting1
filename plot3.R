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

##create plot

png(filename = "plot3.png",
    width = 480,
   height = 480)

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
       col=c("black","red", "blue"), lty=1, cex=0.8)

dev.off()

}