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
