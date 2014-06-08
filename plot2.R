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


##Plot2
with(TestData, plot(DateTime,Global_active_power,pch="",
                    xlab="",
                    ylab="Global Active Power (kilowatts)"))
with(TestData,lines(DateTime,Global_active_power))
dev.copy(png,file="plot2.png")
dev.off()

