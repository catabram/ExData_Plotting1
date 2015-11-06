## Set working directory

setwd("C:/Users/catab_000/Desktop/intr")

## Get data 

## assign file url
fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## download file
download.file(fileURL, destfile = "power_consumption.zip")
## unzip file
temp <- unzip("power_consumption.zip")

## Read and transform file

## read file
power_consumption <- read.table(temp, header=TRUE, sep=";")
## delete temp file
rm(temp)
## format dates
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
## extract needed dates data (making subset)
power_data <- power_consumption[(power_consumption$Date=="2007-02-01") | (power_consumption$Date=="2007-02-02"),]
## remove unnesesary data
rm(power_consumption)

## format numbers (Global_active_power, Global_reactive_power, Voltage, Sub_meterings)
power_data$Global_active_power <- as.numeric(as.character(power_data$Global_active_power))
power_data$Global_reactive_power <- as.numeric(as.character(power_data$Global_reactive_power))
power_data$Voltage <- as.numeric(as.character(power_data$Voltage))
power_data$Sub_metering_1 <- as.numeric(as.character(power_data$Sub_metering_1))
power_data$Sub_metering_2 <- as.numeric(as.character(power_data$Sub_metering_2))
power_data$Sub_metering_3 <- as.numeric(as.character(power_data$Sub_metering_3))
## format dates
power_data <- transform(power_data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## Plot 1 function, histogram
plot_1 <- function() {
  hist(power_data$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowats)")
  dev.copy(png, file="plot1.png", width=1000, height=800)
  dev.off()
}
plot_1()