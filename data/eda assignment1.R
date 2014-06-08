##EDA assignment 1
##download read local file, date 1 then date 2 then merge
library(data.table)
testFile<-"~/R/household_power_consumption.txt"
TestData1<-fread(testFile,na.strings="?",
                verbose=TRUE,colClasses=NULL)[Date=="1/2/2007"]
TestData2<-fread(testFile,na.strings="?",
                verbose=TRUE,colClasses=NULL)[Date=="2/2/2007"]
TestData<-rbind(TestData1,TestData2)
##head(TestData)
##TestData
##convert date and time to date time format
##merge with testdata and tidy
as.Date(TestData$Date,"%d/%m/%Y")
dateTimeC<-paste(TestData$Date,TestData$Time)
dateTimeD<-data.frame(strptime(dateTimeC,"%d/%m/%Y %H:%M:%S"))
##dateTimeD
names(dateTimeD)<-"DateTime"
names(dateTimeD)
TestData<-cbind(dateTimeD,TestData)
TestData<-TestData[,c(1,4:10)]
for(i in 2:8){
    storage.mode(TestData[,i])<-"numeric"    
} 

##make plots and send to png file
library(datasets)

##Plot1
hist(TestData$Global_active_power,col="orangered",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.copy(png,file="plot1.png")
dev.off()

##Plot2
with(TestData, plot(DateTime,Global_active_power,pch="",
                    xlab="",
                    ylab="Global Active Power (kilowatts)"))
with(TestData,lines(DateTime,Global_active_power))
dev.copy(png,file="plot2.png")
dev.off()

##Plot3
par(mar=c(2,4,2,2))
with(TestData, plot(DateTime,Sub_metering_1,pch="",                    
                    xlab="",
                    ylab="Energy sub metering"))
with(TestData,lines(DateTime,Sub_metering_1))
with(TestData,lines(DateTime,Sub_metering_2,col="orangered"))
with(TestData,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright", pch = "_______", col=c("black","orangered","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2",
        "Sub_metering_3"))
dev.copy(png,file="plot3.png")
dev.off()

##Plot4
par(mfrow=c(2,2),mar=c(2,4,1,2),oma=c(1,1,1,1))
with(TestData,{
    ##plotLT
    with(TestData, plot(DateTime,Global_active_power,pch="",
                        xlab="",
                        ylab="Global Active Power"))
    with(TestData,lines(DateTime,Global_active_power))
    
    ##plotRT    
    with(TestData, plot(DateTime,Voltage,pch="",                        
                        xlab="datetime",
                        ylab="Voltage"))
    with(TestData,lines(DateTime,Voltage))
      
    ##plotLB    
    with(TestData, plot(DateTime,Sub_metering_1,pch="",                   
                        xlab="",
                        ylab="Energy sub metering"))
    with(TestData,lines(DateTime,Sub_metering_1))
    with(TestData,lines(DateTime,Sub_metering_2,col="orangered"))
    with(TestData,lines(DateTime,Sub_metering_3,col="blue"))
    legend("topright", pch = "_______", col=c("black","orangered","blue"),
           legend=c("Sub_metering_1", "Sub_metering_2",
                    "Sub_metering_3")) 
    ##plotBR
    with(TestData, plot(DateTime,Global_reactive_power,pch="",
                        xlab="datetime",
                        ylab="Global_reactive_power"))
    with(TestData,lines(DateTime,Global_reactive_power))

})
dev.copy(png,file="plot4.png")
dev.off()
