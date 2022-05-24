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





hist(g$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")


## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

#Using ggplot2 :


#library(ggplot2)

 #ggplot(data = g, mapping = aes(x= Global_active_power))+
 #geom_histogram(binwidth = 0.5, fill="red", linetype= 1, color="black")+
#labs(x= "Global Active Power (kilowatts)", title= "Global Active Power")
