# Downlaod rawdata
filename <- "data.zip"
if (!file.exists(filename)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", filename, method="curl")
}

if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename)
}

power_consumption <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")

start_date = as.Date("2007-02-01")
end_date = as.Date("2007-02-02")

# The relevant data rows
time_frame_power <- power_consumption[power_consumption$Date >= start_date & power_consumption$Date <= end_date,]

png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(time_frame_power$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()