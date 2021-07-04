file <- "./household_power_consumption.txt"

if(!file.exists(file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./data.zip")
  unzip("./data.zip")
  
}else{
  
  if(dir.exists("exdata_data_household_power_consumption")){
    
    data <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt",
                       header = TRUE, sep = ";", na.strings = "?")
  }else{
    
    data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
    
    }
}

data$DT <- paste(data$Date, data$Time)
data$DT <- as.POSIXct(data$DT, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")
data <- data[,-c(1,2)]
data <- data[,c(8,c(1:7))]

data <- data[complete.cases(data),]
condition <- data$DT>=as.POSIXct("2007/02/01", format = "%Y/%m/%d", tz = "UTC")&data$DT<=as.POSIXct("2007/02/02", format = "%Y/%m/%d", tz = "UTC")
data <- data[condition,]
rm(condition)

plot(x = data$DT, y = data$Sub_metering_1, type = "l", xaxt = "n", ylab = "Energy sub metering", xlab = "")
lines(x = data$DT, y = data$Sub_metering_2, type = "l", xaxt = "n", col = "red")
lines(x = data$DT, y= data$Sub_metering_3, type = "l", xaxt = "n", col = "blue")
axis(1, at = range(data$DT), labels = c("Thursday", "Friday"))
legend("topright", legend = names(data[6:8]), col = c("black", "red", "blue"), lty = 1)

dev2bitmap("plot3.png", type = "png16m", height = 480, width = 480, units = "px")