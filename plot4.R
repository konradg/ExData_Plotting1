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
  filename  = "plot4.png",
  width     = 480,
  height    = 480,
  units     = "px",
  bg        = "transparent"
)
par(mfrow = c(2, 2), mar=c(4,4,2,1), oma=c(0,0,2,0), cex = 0.75)

plot(
  dat$Global_active_power~dat$Time,
  type ='l',
  xlab = "",
  ylab = "Global Active Power",
)

plot(
  dat$Voltage ~ dat$Time,
  type='l',
  xlab='datetime',
  ylab='Voltage',
)

with(dat, {
  plot(
    Sub_metering_1~Time,
    type ='l',
    xlab = "",
    ylab = "Energy sub metering",
    col="black"
  )
  lines(
    Sub_metering_2~Time,
    col="red"
  )
  lines(
    Sub_metering_3~Time,
    col="blue"
  )
  legend("topright",
         lty=1,
         col=c("black", "red", "blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         bty='n')
})

plot(dat$Global_reactive_power~dat$Time,
     type='l',
     xlab='datetime',
     ylab='Global_reactive_power'
)

dev.off()