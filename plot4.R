
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

# select additional variables of interest (Voltage and Global_reactive_power)
# and convert them into numeric type

Voltage<-mydata$Voltage[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]
Voltage<-as.numeric(as.character(Voltage))

# !!!! for Global_reactive_power a variable is named grp for simplicity

grp<-mydata$Global_reactive_power[mydata$Date=="2007-02-01" | mydata$Date=="2007-02-02"]
grp<-as.numeric(as.character(grp))


# divide the plot into 2 rows and 2 columns

par(mfrow=c(2,2))

#par(mar=c(5.1,4.1,2.1,2.1)) # 5.1,4.1,4.1,2.1
# above I was experimenting with margins, but in the end decided to leave them
# at default values, thus this part is commented out


# First plot Global_active_power as a function of time (plot2)
plot(time,Global_active_power,type="l",ylab="Global active power",xlab ="")

# Now plot Voltage as a function of time
plot(time,Voltage,type="l",ylab="Voltage",xlab ="datetime")

# Now plot Sub metering versus time, with different colors and a legend
# !!!! note that this time there is no box around the legend, so an extra
# option is invoked  bty="n"

plot(time,as.numeric(as.character(sm1)),type="l",col="black",xlab="",ylab="Energy sub metering")
lines(time,as.numeric(as.character(sm2)),type="l",col="red")
lines(time,as.numeric(as.character(sm3)),type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_1","Sub_metering_3"),bty="n",lty=c(1,1,1),col=c("black","red","blue"))


# Plot Global_reactive_power as a function of time
plot(time,grp,type="l",ylab="Global_reactive_power",xlab ="datetime")


# save the resulting plot into a .png file

dev.copy(png,'plot4.png')
dev.off()

