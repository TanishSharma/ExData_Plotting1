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
data$DT <- as.Date(data$DT, format = "%d/%m/%Y %H:%M:%S")
data <- data[,-c(1,2)]
data <- data[,c(8,c(1:7))]

data <- data[complete.cases(data),]
condition <- data$DT>as.Date("2007-01-31", format = "%Y-%m-%d")&data$DT<as.Date("2007-02-03", format = "%Y-%m-%d")
data <- data[condition,]
rm(condition)

histogram <- hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev2bitmap("plot1.png", type = "png16m", width = 480, height = 480, units = "px")