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

png ("plot2.png")
with (selectedData, plot (Global_active_power ~ combine, type = "l", 
                          ylab = "Global Active Power (kilowatts)",
                          xlab = ""))

dev.off ()
