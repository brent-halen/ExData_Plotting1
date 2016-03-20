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


# Build the plot
with(subread, plot(Date, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
# Add the first line
with(subread, lines(subread$Date, subread$Sub_metering_1, col = "black"))
# Add the second line
with(subread, lines(subread$Date, subread$Sub_metering_2, col = "red"))
# Add the third line
with(subread, lines(subread$Date, subread$Sub_metering_3, col = "blue"))
# Add the legend using the 'lty' parameter to make the symbols into lines. 
legend("topright",lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Write to png file.
dev.copy(png, file = "plot3.png")
# Deactivate png visual device
dev.off()