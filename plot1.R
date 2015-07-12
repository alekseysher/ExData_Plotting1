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

# plotting a histogram of the Global_active_power

hist((Global_active_power), breaks=24, col="red",main="Global active power",xlab="Global active power (kilowatts)")

# copying the plot into a file

dev.copy(png,'plot1.png')
dev.off()

