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


# The necessary data should be subset to the subdtread variable. 
# Build the plot (well, in this case it's a histogram) to specifications. 
hist(subread$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# Save histogram as a .png file. 
dev.copy(png, file = "plot1.png")
# Close the visual device at the end of the program. 
dev.off()