library(tibble)
temp <- tempfile() ## create a temporal file

## Download de file from the url and save it to temp
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

## Unzip and read the.txt file with the ";" separator, including the Headers and specifing the missing values
data <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",header = TRUE, na.strings = "?", 
                   stringsAsFactors = FALSE)

## Unlinking the temporary file
unlink(temp)

## subsetting the data with just the info of the 2 days that we need
my_data <- subset(data,Date=="2/2/2007" | Date=="1/2/2007")

## Concatenate a column with the Date and Time info
Date_Time <- paste(my_data$Date,my_data$Time)

## Add the new column to de data frame and format the info as Date and Time variable
my_data2 <- add_column(my_data,Date_Time,.after=2)
my_data2$Date_Time <- strptime(my_data2$Date_Time,"%d/%m/%Y %H:%M:%S")

## Set the y label
y_lab <- c("Energy sub metering")

## create a type line plot of Global Act pw for the period of time 
with(my_data2,plot(Date_Time,Sub_metering_1,type="n",ylab=y_lab,xlab=n))
with(my_data2,lines(Date_Time,Sub_metering_1,type="l"))
with(my_data2,lines(Date_Time,Sub_metering_2,type="l",col="red"))
with(my_data2,lines(Date_Time,Sub_metering_3,type="l",col="blue"))
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

## Copy the plot created on the screen device to a png device with specific dimensions
dev.copy(png,width=480,height=480,filename="plot3.png")

## Always dissconect the device!!!
dev.off()
