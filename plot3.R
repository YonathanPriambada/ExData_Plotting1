if(!file.exists('irvine.zip')){
    url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
    
    download.file(url,destfile = "irvine.zip")##downloading the data file
}
unzip("irvine.zip")

data<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

data$DateTime<-paste(data$Date, data$Time)## concatenation of date and time variables
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

##Below we create the subset for data from 1st to 2nd Feb 07, as required
start<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
end<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
datafin<-data[start:end,]

##plot3
png("plot3.png",width=480, height=480)
plot(datafin$DateTime, as.numeric(as.character(datafin$Sub_metering_1)),type='l', 
     ylab ="Energy sub metering", xlab="")
lines(datafin$DateTime, as.numeric(as.character(datafin$Sub_metering_2)),type='l', col='red')
lines(datafin$DateTime, datafin$Sub_metering_3,type='l', col="blue")

legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1)
       ,col=c("black","red","blue"))
dev.off()
