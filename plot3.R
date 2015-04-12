# Download and unzip file if necessary
if (!exists("dat") || length(dat[,1]) != 2880) {
  print("Recreating data...")
  if (!file.exists("household_power_consumption.txt")) {
    print("No unzipped file")
    if (!file.exists("power_consumption.zip")) {
      print("No zip file, downloading")
      download.file(destfile="power_consumption.zip", url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
    }
    unzip("power_consumption.zip")
  }
  dat <- read.csv2("household_power_consumption.txt", na.strings="?", stringsAsFactors=FALSE)
  dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
  dat <- dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",]
  dat$Global_active_power <- as.numeric(dat$Global_active_power)
  dat$Time <- as.POSIXct(paste(dat[,1], dat[,2]), format="%Y-%m-%d %H:%M:%S")
}

# Plotting
png(
  filename  = "plot3.png",
  width     = 480,
  height    = 480,
  units     = "px",
  bg        = "transparent"
)

plot(
  dat$Sub_metering_1~dat$Time,
  type ='l',
  xlab = "",
  ylab = "Energy sub metering",
  col="black"
)
lines(
  dat$Sub_metering_2~dat$Time,
  col="red"
)
lines(
  dat$Sub_metering_3~dat$Time,
  col="blue"
)
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.off()