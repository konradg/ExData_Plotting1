# Download and unzip file if necessary
if (!exists("dat") || length(dat[,1]) != 2880) {
  if (!file.exists("household_power_consumption.txt")) {
    if (!file.exists("power_consumption.zip")) {
      download.file(destfile="power_consumption.zip", url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
    }
    unzip("power_consumption.zip")
  }
  dat <- read.csv2("household_power_consumption.txt", na.strings="?", stringsAsFactors=FALSE)
  dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
  dat <- dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",]
  dat$Global_active_power <- as.numeric(dat$Global_active_power)
}

# Plotting
png(
  filename  = "plot1.png",
  width     = 480,
  height    = 480,
  units     = "px",
  bg        = "transparent"
)
hist(dat$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()