library("RCurl")
library("lubridate")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filehandle <- CFILE("household_power_consumption.zip", mode="wb")
curlPerform(url=url, writedata = filehandle@ref, ssl.verifypeer=FALSE)
close(filehandle)

unzip("household_power_consumption.zip")

data <- read.delim("household_power_consumption.txt", sep=";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
data <- subset(data, as.Date(dmy(data$Date)) >= as.Date(ymd("2007-02-01")) & as.Date(dmy(data$Date)) <= as.Date(ymd("2007-02-02")))
data <- mutate(data, Date=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
data$Time <- NULL

png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()