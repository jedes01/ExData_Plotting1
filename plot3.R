## This code generates a line graph comparing energy (in watt-hours) used by (1) the kitchen, (2)
## the laundry room, and (3) an electric water heater and air conditioner in a single room sampled
## in one-minute intervals between February 1, 2007 and February 2, 2007.  The original dataset
## is downloaded from the UCI Machine Learning Repository.

library(data.table)

## Download data from UCI Machine Learning Respository, store as object called 'data'.
fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL, temp)
data <- fread(unzip(temp, "household_power_consumption.txt"), sep=";", na.strings="?", header="T")
unlink(temp)

## Subset data, assign variables to appropriate classes.
subData <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007"]
subData$DateTime <- paste(subData$Date, subData$Time, sep = " ")
subData$DateTime <- as.POSIXct(subData$DateTime, format="%d/%m/%Y %H:%M:%S")
subData$Global_active_power <- as.numeric(subData$Global_active_power)
subData$Sub_metering_1 <- as.numeric(subData$Sub_metering_1)
subData$Sub_metering_2 <- as.numeric(subData$Sub_metering_2)
subData$Sub_metering_2 <- as.numeric(subData$Sub_metering_2)

## Generate plot, store in "plot3.png" in the working directory.
par(cex=.8)
png("plot3.png", width=480, height=480)
with(subData, plot(DateTime,Sub_metering_1,type="n", xlab="",
                   ylab="Energy sub metering"))
with(subData, lines(DateTime,Sub_metering_1, lwd=.7, col="black"))
with(subData, lines(DateTime,Sub_metering_2, lwd=.7, col="red"))
with(subData, lines(DateTime,Sub_metering_3, lwd=.7, col="blue"))

legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"), lty=c(1,1))
dev.off()
