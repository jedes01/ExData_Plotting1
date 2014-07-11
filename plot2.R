## This code generates a line graph of the "Global Active Power" used by a single household
## sampled in one-minute intervals between February 1, 2007 and February 2, 2007.  The original
## dataset is downloaded from the UCI Machine Learning Repository.

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

## Generate plot, store in "plot2.png" in the working directory.
png("plot2.png", width=480, height=480)
with(subData, plot(DateTime,Global_active_power,type="n", xlab="",
                  ylab="Global Active Power (kilowatts)"))
with(subData, lines(DateTime,Global_active_power, col="gray15"))
dev.off()