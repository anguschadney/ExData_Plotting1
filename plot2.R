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
# 'POSIXct' respectively.s
epc <- mutate(epc, Date=as.Date(Date,"%d/%m/%Y"),
                   Time=as.POSIXct(paste(as.character(Date), Time),
                                   format="%Y-%m-%d %H:%M:%S"))

# Create an empty png file
png(filename="plot2.png")

# Data used for plot
x <- epc[,"Time"]
y <- epc[,"Global_active_power"]

# Create empty plot and add data on as a line
plot(x, y, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(x, y)

# Close the png file handle
dev.off()
