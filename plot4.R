# This program creates plot1.png from the dataset.
# It is presumed the dataset exists in "../data/household_power_consumption.txt"

plot4 <- function( datafile = "../data/household_power_consumption.txt"){
    # See comments in plot1.R and plot2.R for the same lines of code as below
    library(rJava)
    library(data.table)
  
    options( warn=-1)
    tTab <- fread(datafile, sep=";", header=TRUE)
    options(warn = 0)
    tTab$Date <- as.Date(tTab$Date, format = "%d/%m/%Y")
    s3 <-tTab[ tTab$Date == as.Date("2007-2-1") | tTab$Date == as.Date("2007-2-2"),]
    s3$Sub_metering_1 <- as(s3$Sub_metering_1, "numeric")
    s3$Sub_metering_2 <- as(s3$Sub_metering_2, "numeric")
    s3$Sub_metering_3 <- as(s3$Sub_metering_3, "numeric")
    
    png(filename = "plot4.png", width=480, height=480)
    
    # create the 2x2 image matrix 
    par(mfrow=c(2,2), mar=c(4,4,3,3))
    
    # 1st plot
    plot( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=s3$Global_active_power, type="l", xlab="", ylab="Global Active Power", yaxt='n')
    axis(2,seq(0,6,2), label=TRUE)
    # 2nd plot
    plot( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=s3$Voltage, type="l", xlab="datetime", ylab="Voltage",  yaxt='n')
    axis(2,seq(234,246,4), label=TRUE)
    
    # 3rd plot
    plot( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=s3$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", yaxt='n')
    lines( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=as(s3$Sub_metering_2, "numeric"), type="l", xlab="", ylab="Energy sub metering", col="red")
    lines( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=as(s3$Sub_metering_3, "numeric"), type="l", xlab="", ylab="Energy sub metering", col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=3, col=c("black", "red", "blue"), bty="n")
    axis(2,seq(0,30,10), label=TRUE)
    
    # 4th plot and device close
    plot( x= strptime(paste(s3$Date, s3$Time), format="%Y-%m-%d %H:%M:%S"), y=s3$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power",  yaxt='n')
    axis(2,seq(0.0,0.5,0.1), label=TRUE)
    
    
    dev.off()
}

plot4()