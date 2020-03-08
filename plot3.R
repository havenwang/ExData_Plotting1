# Downlaod rawdata
filename <- "data.zip"
if (!file.exists(filename)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", filename, method="curl")
}

if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename)
}

power_consumption <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")

start_date = as.Date("2007-02-01")
end_date = as.Date("2007-02-02")

# The relevant data rows
time_frame_power <- power_consumption[power_consumption$Date >= start_date & power_consumption$Date <= end_date,]
global_active_power_kilowatt <- as.numeric(time_frame_power$Global_active_power) / 1000

# Create a column for date and time together
time_frame_power$datetime <- as.POSIXct(paste(time_frame_power$Date, time_frame_power$Time), format="%Y-%m-%d %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480)
plot(time_frame_power$datetime, time_frame_power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(time_frame_power$datetime, time_frame_power$Sub_metering_2, type="l", col="red")
lines(time_frame_power$datetime, time_frame_power$Sub_metering_3, type="l", col="blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), seg.len = 2, lwd = 2)
dev.off()