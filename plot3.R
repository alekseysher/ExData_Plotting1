
# reading in the Data file
# ! IMPOTANT !  Here assumption is made that the data file is in the current 
# directory. This choice was made due to ambiguity in file's location on
# a particular system
#############################################################################

mydata <- read.table("household_power_consumption.txt",header=TRUE,sep=";")


# converting Date field of the dataset, which is a factor into Data format

mydata$Date<-as.Date(mydata$Date,"%d/%m/%Y")

# Selecting variable of interest in the predefined time interval

Global_active_power<-mydata$Global_active_power[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]

# Converting Global_active_power field of the dataset, which is a factor into
# a plottable numeric type in two easy steps

Global_active_power<-as.character(Global_active_power)
Global_active_power<-as.numeric(Global_active_power)

# Construction of the time variable is done through the strptime() function
# Preselect Time and Date in the interval of interest

Time<-mydata$Time[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]
Date<-mydata$Date[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]

# Combine Date and Time into one variable DateTimeCombined
DateTimeCombined<-paste(Date,Time)

# Construct new variable time, which represents time for the plot
time<-strptime(as.character(DateTimeCombined),"%Y-%m-%d %H:%M:%S")

# Select variables of interest in the predefined interval of interest
 
sm1<-mydata$Sub_metering_1[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]
sm2<-mydata$Sub_metering_2[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]
sm3<-mydata$Sub_metering_3[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]

# Plot Sub_metering_1 variable (sm1) against time as the black line 
# and label axis according to the reference plot

plot(time,as.numeric(as.character(sm1)),type="l",col="black",xlab="",ylab="Energy sub metering")

# add Sub_metering_2 variable (sm2) against time as the red line

lines(time,as.numeric(as.character(sm2)),type="l",col="red")

# add Sub_metering_3 variable (sm3) against time as the blue line

lines(time,as.numeric(as.character(sm3)),type="l",col="blue")

# add the legend accoring to color coding of the lines, line type
# and reference plot naming scheme

legend("topright",c("Sub_metering_1","Sub_metering_1","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))



# copy resulting plot into a .png file
dev.copy(png,'plot3.png')
dev.off()

