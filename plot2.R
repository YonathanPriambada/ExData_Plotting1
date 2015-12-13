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

##plot2
png("plot2.png",width=480, height=480)
plot(datafin$DateTime, as.numeric(as.character(datafin$Global_active_power)),
     type='l',ylab="Global Active Power (Kilowatts)", xlab="")
dev.off()