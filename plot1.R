
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
#plot to png file

png("plot1.png", width = 480, height = 480)
hist(power_data$Global_active_power, col = "red",xlab ="Global Acitve Power (kilowatts)", ylab = "Frequency",main = "Global Active Power")
dev.off()

