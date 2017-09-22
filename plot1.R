graphrun <- function(){
  
  install.packages(dplyr)
  install.packages(lubridate)
  library(dplyr)
  library(lubridate)
  #download zip file and read in data
  #data is csv2, separated by semicolon
temp <- tempfile()
download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
data <- read.csv2(unz(temp, "household_power_consumption.txt"), header = TRUE)
unlink(temp)


## subset data to dates 2007-02-01 and 2007-02-02
data$Date <-(as.Date(data$Date, format = "%d/%m/%Y"))
x <- filter(data, Date == "2007-02-01"|Date == "2007-02-02")
x$Global_active_power <- as.numeric(as.character(x$Global_active_power))

##create plot
#y <- mutate(x, gapkw = as.numeric(Global_active_power)/1000)
png(filename = "plot1.png",
    width = 480,
    height = 480)
hist(x$Global_active_power, 
     col = "red", 
     freq = TRUE, 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
##dev.copy(png, "myplot.png")
dev.off()
}