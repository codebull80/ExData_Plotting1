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





attach(g)

  plot(Sub_metering_1~date_time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

#same graph with ggplot2 No legend here! I couldn't deal the legend problem!!!
#library(ggplot2)


  #ggplot(data = g) +
  #geom_line(mapping= aes(x=date_time, y=Sub_metering_1), color='black')+
  #geom_line(mapping= aes(x=date_time, y=Sub_metering_2), color='red')+
  #geom_line(mapping= aes(x=date_time, y=Sub_metering_3), color='blue')+
  
  #labs(x="", y= "Global Active Power (kilowatts)")
