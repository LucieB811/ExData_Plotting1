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

png ("plot4.png")

par(mfrow = c(2, 2))

# top left
with (selectedData, plot (Global_active_power ~ combine, type = "l", 
                          ylab = "Global Active Power",
                          xlab = ""))


#top right
with (selectedData, plot (Voltage ~ combine, type = "l", xlab = "datetime"))

# bottom left
with (selectedData, plot (Sub_metering_1 ~ combine, type = "l", 
                          ylab = "Energy sub metering",
                          xlab = ""))
with (selectedData, lines (combine, Sub_metering_2, col = "red"))
with (selectedData, lines (combine, Sub_metering_3, col = "blue"))
legend ("topright", lwd=1, lty=c(1, 1, 1), col = c("black", "red", "blue"), 
        legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),
        bty = "n")

#bottom right
with (selectedData, plot (Global_reactive_power ~ combine, type = "l", xlab = "datetime"))

dev.off ()
