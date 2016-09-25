firstrow <- read.table("household_power_consumption.txt", sep=";", 
                       header=T, nrows=1, na.strings="?")

pc <- read.table("household_power_consumption.txt", sep=";", 
                 header=F, skip=66000, nrows=4000, 
                 na.strings="?",
                 col.names=names(firstrow))

tday = strptime(pc$Date, "%d/%m/%Y")
ttime = strptime(pc$Time, "%H:%M:%S")
ttime = ttime - strptime("00:00:00", "%H:%M:%S")
fulldate = tday + ttime

t1 <- strptime("1/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
t2 <- strptime("3/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")

mask <- t1 <= fulldate & fulldate <= t2
pcss <- pc[mask,]
fulldatess = fulldate[mask]

par(mfrow=c(1,1))
png("plot2.png")
plot(fulldatess, pcss$Global_active_power, type='n',
     xlab="Date and Time", ylab="Global Active Power (kW)")
lines(fulldatess, pcss$Global_active_power)
dev.off()
