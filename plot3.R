# Include dplyr for 'mutate'
library(dplyr)

# Read in data from csv file, ensuring we skip unneeded rows, set
# the correct separator, and set the na string to '?'
# I extracted the column names first so I could add them explicitly
# to the main data set.
filename <- "household_power_consumption.txt"
epc_head <- read.csv(filename, sep=";", header=FALSE, nrows=1)
epc <- read.csv(filename,
                sep=";",
                skip=66637,
                nrows=2880,
                na.strings=c("?"),
                header=FALSE,
                col.names=unlist(epc_head[1,]))

# Convert the 'Date' and 'Time' columns to the R types 'Date' and
# 'POSIXct' respectively.
epc <- mutate(epc, Date=as.Date(Date,"%d/%m/%Y"),
              Time=as.POSIXct(paste(as.character(Date), Time),
                              format="%Y-%m-%d %H:%M:%S"))

# Create an empty png file
png(filename="plot3.png")

# Data used for plots
x <- epc[,"Time"]
y1 <- epc[,"Sub_metering_1"]
y2 <- epc[,"Sub_metering_2"]
y3 <- epc[,"Sub_metering_3"]

# Create empty plot and add data on as lines, including legend
plot(x, y1, type="n", ylab="Energy sub metering", xlab="")
lines(x, y1, col="black")
lines(x, y2, col="red")
lines(x, y3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       lty=c(1,1,1),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the png file handle
dev.off()
