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
as.Date(data$Date,"%d/%m/%Y")  ## format the Dates

## Plot a red Histogram of Global active pw, with a main title an a x label
with(my_data,hist(Global_active_power,col="red",main="Global Active Power",
                  xlab="Global Active Power (kilowatts)"))

## Copy the plot created on the screen device to a png device with specific dimensions
dev.copy(png,width=480,height=480,filename="plot1.png")

## Always dissconect the device!!!
dev.off()