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

#Chart 4 - 2 x 2 window
par(mfrow=c(2,2))

#Top Right
with(EPC,plot(DateTime, Global_active_power,type = "l",xlab=NA ,ylab="Global Active Power (kilowatts)"))

#Top Left
with(EPC,plot(DateTime,Voltage,type = "l",xlab="datetime",ylab="Voltage"))

#Bottom left
with(EPC,plot(DateTime,Sub_metering_1, type= "l",xlab=NA ,ylab="Energy Sub Metering"))
points(EPC$DateTime,EPC$Sub_metering_2,type="l",col="red")
points(EPC$DateTime,EPC$Sub_metering_3,type="l",col="blue")
par(cex=0.5)
legend("topright",text.width =50000,lty=1,col=c("black","red","blue"),legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Bottom right
par(cex=0.8)
with(EPC,plot(DateTime,Global_reactive_power,type = "l",xlab="datetime",ylim=c(0,0.5)))

# Copy Output to png
dev.copy(png,file="plot4.png")
dev.off()