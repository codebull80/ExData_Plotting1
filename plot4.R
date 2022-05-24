library(lubridate)
library(tidyverse)

g <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.string= "?", colClasses= c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# join date and time


g<-  mutate(g, date_time= paste(Date, Time))

#Drop Date and Time columns

g<- select(g, Global_active_power:date_time)

# Parse data and time with lubridate

g$date_time <- dmy_hms(g$date_time)


#filter for date (also remove incomplete observations)

g <- filter (g, date_time>dmy_hms("1/2/2007 00:00:00") & date_time<=dmy_hms("2/2/2007 23:59:59"))





par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
attach(g)

  plot(Global_active_power~date_time, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~date_time, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~date_time, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~date_time, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")

  
  ## Saving to file
  dev.copy(png, file="plot4.png", height=480, width=480)
  dev.off()
  
 # Same with ggplot2 and gridExtra!
 # library(ggplot2)
  #library(gridExtra)
  
 # plot1<- ggplot(data=g)+
          
          #geom_line(mapping= aes(x=date_time, y=Global_active_power ))+
    
         # labs(x="", y= "Global Active Power (kilowatts)")
  
  #plot2<- ggplot(data=g)+
  
          #geom_line(mapping= aes(x=date_time, y=Voltage ))+
    
          #labs(x="", y= "Voltage(Volt)")
 
  #plot3<- ggplot(data=g)+
    
  
          #geom_line(mapping= aes(x=date_time, y=Sub_metering_1), color='black')+
          #geom_line(mapping= aes(x=date_time, y=Sub_metering_2), color='red')+
          #geom_line(mapping= aes(x=date_time, y=Sub_metering_3), color='blue')+
    
    #labs(x="", y= "Global Active Power (kilowatts)")
  
  #plot4<- ggplot(data=g)+
    
          #geom_line(mapping= aes(x=date_time, y=Global_reactive_power ))+
    
          #labs(x="", y= "Global Rective Power (kilowatts)")
    
  #grid.arrange(plot1, plot2, plot3, plot4, ncol=2)
 
  