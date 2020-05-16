# Download and unzip the dataset:
filezip <- "household_power_consumption.zip"
filename <- "household_power_consumption.txt"

if (!file.exists (filezip)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file (fileURL, filezip, method="curl")
}  

if (!file.exists (filename)) { 
    unzip (filezip) 
}


powerData <- read.table (filename, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
powerData$Date = as.Date (powerData$Date, format = "%d/%m/%Y") 

startDate = as.Date ("2007-02-01")
endDate = as.Date ("2007-02-02")
selectedData <- powerData [powerData$Date >= startDate & powerData$Date <= endDate, ]
selectedData$combine <- with(selectedData, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

png ("plot3.png")
with (selectedData, plot (Sub_metering_1 ~ combine, type = "l", 
                          ylab = "Energy sub metering",
                          xlab = ""))
with (selectedData, lines (combine, Sub_metering_2, col = "red"))
with (selectedData, lines (combine, Sub_metering_3, col = "blue"))
legend ("topright", lwd=1, lty=c(1, 1, 1), col = c("black", "red", "blue"), 
        legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))


dev.off ()
