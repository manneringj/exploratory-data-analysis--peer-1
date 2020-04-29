#Script to load and subset the data
EPC<-read.csv("household_power_consumption.txt",sep=";")

#Process Dates and Times
EPC$Date<-strptime(EPC$Date,format="%d/%m/%Y")
EPC$Time<-strptime(EPC$Time,format="%H:%M:%S")
EPC<-subset(EPC,Global_active_power!="?")
EPC<-subset(EPC,Date==as.POSIXct("2007-02-01 00:00:00")| Date==as.POSIXct("2007-02-02 00:00:00"))
EPC$DateTime<-as.POSIXct(paste(format(EPC$Date,format="%Y-%m-%d"),format(EPC$Time,format="%H:%M:%S"),sep=" "))

#Resolve columns to correct data type        
EPC$Global_active_power<-as.numeric(gsub(",", "", EPC$Global_active_power))
EPC$Global_reactive_power<-as.numeric(gsub(",", "", EPC$Global_reactive_power))

EPC$Voltage<-as.numeric(levels(EPC$Voltage))[EPC$Voltage]
EPC$Sub_metering_2<-as.numeric(levels(EPC$Sub_metering_2))[EPC$Sub_metering_2]
EPC$Sub_metering_1<-as.numeric(levels(EPC$Sub_metering_1))[EPC$Sub_metering_1]

#Chart 3- Energy sub metering
par(mfrow=c(1,1))
with(EPC,plot(DateTime,Sub_metering_1, type= "l",xlab=NA ,ylab="Energy Sub Metering"))
points(EPC$DateTime,EPC$Sub_metering_2,type="l",col="red")
points(EPC$DateTime,EPC$Sub_metering_3,type="l",col="blue")

legend("topright",inset = 0.1,text.width =50000,lty=1,col=c("black","red","blue"),legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Copy Output to png
dev.copy(png,file="plot3.png")
dev.off()