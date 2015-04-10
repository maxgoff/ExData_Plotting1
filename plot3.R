# This program creates plot1.png from the dataset.
# It is presumed the dataset exists in "../data/household_power_consumption.txt"

plot3 <- function( datafile = "../data/household_power_consumption.txt"){
    # rJava is a package that is presumed to be installed.  Proper configuration can be tricky.
    # See the README for configuration consideratins.
    
    library(rJava)
    
    # data.table is reuired for fread
    # turn of warnings for fread which will throw copious warnings otherwise
    options( warn=-1)
    library(data.table)
 
    tTab <- fread(datafile, sep=";", header=TRUE)
    options(warn = 0)
    
    # coerce the Date field in the table to into a Date object
    tTab$Date <- as.Date(tTab$Date, format = "%d/%m/%Y")
    
    # select the specific dates we want from the data, per the assignment
    s3 <-tTab[ tTab$Date == as.Date("2007-2-1") | tTab$Date == as.Date("2007-2-2"),]
    
    # a little more coersion 
    s3$Sub_metering_1 <- as(s3$Sub_metering_1, "numeric")
    s3$Sub_metering_2 <- as(s3$Sub_metering_2, "numeric")
    s3$Sub_metering_3 <- as(s3$Sub_metering_3, "numeric")
    
    # initialize the png device image dimensions specified
    png(filename = "plot3.png", width=480, height=480)
    
    # create the plot per the specification and all the lines and legend to match, closing the device when finished
    plot( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=s3$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", yaxt='n')
    lines( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=as(s3$Sub_metering_2, "numeric"), type="l", xlab="", ylab="Energy sub metering", col="red")
    lines( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=as(s3$Sub_metering_3, "numeric"), type="l", xlab="", ylab="Energy sub metering", col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=3, col=c("black", "red", "blue"))
    axis(2,seq(0,30,10), label=TRUE)
    
    dev.off()
}

plot3()