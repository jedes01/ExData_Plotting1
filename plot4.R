## This code generates a figure with four charts providing a snapshot of energy used by a single 
## household sampled in one-minute intervals between February 1, 2007 and February 2, 2007.  The 
## original dataset is downloaded from the UCI Machine Learning Repository.

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
subData$Global_reactive_power <- as.numeric(subData$Global_reactive_power)
subData$Voltage <- as.numeric(subData$Voltage)
subData$Sub_metering_1 <- as.numeric(subData$Sub_metering_1)
subData$Sub_metering_2 <- as.numeric(subData$Sub_metering_2)
subData$Sub_metering_2 <- as.numeric(subData$Sub_metering_2)

## Initialize 4-paneled chart.
png("plot4.png", width=480, height=480)
par(mfcol=c(2,2), cex.axis=.9, cex.lab=.9)

## Top left, line graph of total energy used over time.
with(subData, plot(DateTime,Global_active_power,type="n", xlab="",
                   ylab="Global Active Power"))
with(subData, lines(DateTime,Global_active_power, col="gray15"))

## Bottom left, line graph showing energy measured by each of 3 meters over time.
with(subData, plot(DateTime,Sub_metering_1,type="n", xlab="",
                   ylab="Energy sub metering"))
with(subData, lines(DateTime,Sub_metering_1, lwd=.7, col="black"))
with(subData, lines(DateTime,Sub_metering_2, lwd=.7, col="red"))
with(subData, lines(DateTime,Sub_metering_3, lwd=.7, col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"), lty=c(1,1), bty="n", cex=.9)

##Top right, line graph of measured voltage over time.
with(subData, plot(DateTime,Voltage, xlab="datetime", ylab="Voltage", type="n"))
with(subData, lines(DateTime,Voltage, col="gray15"))

##Bottom right, line graph of measured voltage over time.
with(subData, plot(DateTime,Global_reactive_power, xlab="datetime", 
                   ylab="Global_reactive_power", type="n"))
with(subData, lines(DateTime,Global_reactive_power, col="gray15"))

dev.off()