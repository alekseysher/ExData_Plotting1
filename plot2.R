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

# Plot Global_active_power field of the Dataset as a function of time.
# Graph type is 'l' (Line), axis are labeled according to the reference plot

plot(time,Global_active_power,type="l",ylab="Global active power (kilowatts)",xlab ="")
# copy the plot into a .png file
dev.copy(png,'plot2.png')
dev.off()

