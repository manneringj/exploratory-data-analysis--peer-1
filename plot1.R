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


#Chart 1 - Histogram of Global Active Power

# Plot to Windows device
        par(mfrow=c(1,1))
        hist(EPC$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main = "Global Active Power")
# Copy Output to png
        dev.copy(png,file="plot1.png")
        dev.off()
