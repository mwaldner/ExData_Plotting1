# Start by seeing if a directory fo the data exist and if not create one called "data"

if(!file.exists("base_plot_data")){
  dir.create("base_plot_data")
}

#download the external data and unzip

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./base_plot_data/RawData.zip" ,mode = "wb")
data <- unzip( zipfile = "./base_plot_data/RawData.zip", exdir = "/base_plot_data")

#get column names

colNames <- names(read.table(data, nrow=1, header=TRUE, sep=";"))

#filter specific rows by the dates we are interested in

power_data <- read.table(data,
                         na.strings = "?",
                         sep = ";",
                         header = FALSE,
                         col.names = colNames,
                         skip = grep("^[1,2]/2/2007", readLines(data))[1]-1,
                         nrow = 2879
)


datetime <- strptime(paste(power_data$Date, power_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

png("plot4.png", width=480, height=480)

# set the parameters to be 4 plots ordered 2 per column and 2 per row

par(mfcol= c(2,2))

# plot 1
globalActivePower <- as.numeric(power_data$Global_active_power)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")


# plot 2
sub_metering_1 <- as.numeric(power_data$Sub_metering_1)
sub_metering_2 <- as.numeric(power_data$Sub_metering_2)
sub_metering_3 <- as.numeric(power_data$Sub_metering_3)

plot(datetime,sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, sub_metering_2, type = "l", col ="red")
lines(datetime, sub_metering_3, type = "l", col = "blue")
legend("topright",bty = "n", lty = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_Metering_3"), col =c("black","red","blue"))


# plot 3

voltage <- as.numeric(power_data$Voltage)
plot(datetime, voltage, type = "l", xlab = "datetime", y_lab = "Voltage")

# plot 4
 
global_reactive_power <- as.numeric(power_data$Global_reactive_power)
plot(datetime, global_reactive_power, type = "l", xlab= "datetime", ylab="Global_reactive_power")


dev.off()