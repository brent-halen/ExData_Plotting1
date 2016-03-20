#Load Data.table library
library("data.table")


#set file to filename variable.
filename <- "./household_power_consumption.txt"
# Read data into variable "read" with read.table function.
read <- read.table(filename, sep = ";", na = "?", header = TRUE)
# convert to data.table and set to dtread format.
# subset to subdtread format using subset.data.frame function. Character class was used rather than converting to date
# to finish job with fewer lines of code. 
subread <- subset.data.frame(read, ((read$Date == "1/2/2007"))  |  (read$Date == "2/2/2007") )
# Convert Date/Time columns to Date class. 
subread$Date <- strptime(paste(subread$Date,subread$Time), "%d/%m/%Y %H:%M:%S")


# Set up 2 rows & 2 columns for the charts
par(mfrow = c(2, 2))
# Set all of the charts to be created with the next block of code.
with(subread, {
    # Create plot 1
    plot(subread$Date, subread$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    # Create plot 2
    plot(subread$Date, subread$Voltage, type="l", xlab="datetime", ylab="Voltage")
    # Create plot 3's base
    plot(subread$Date, subread$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    # Add line 1 to plot 3
    lines(subread$Date, subread$Sub_metering_1, col = "black")
    # Add line 2 to plot 3
    lines(subread$Date, subread$Sub_metering_2, col = "red")
    # Add line 3 to plot 3
    lines(subread$Date, subread$Sub_metering_3, col = "blue")
    # Add a legend to plot 3
    legend("topright",lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
    # Add plot 4
    plot(subread$Date, subread$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

# Write to png file.
dev.copy(png, file = "plot4.png")
# Deactivate png visual device
dev.off()