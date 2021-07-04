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

plot(data$DT, data$Global_active_power, type = "l", xaxt = "n", xlab = "Days", ylab = "Global Active Power (kilowatts)")
axis(1,at =range(data$DT) ,labels = c("Thursday", "Friday"))

dev2bitmap("plot2.png", type = "png16m", width = 480, height = 480, units = "px")