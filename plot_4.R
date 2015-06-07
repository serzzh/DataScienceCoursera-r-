library(data.table)
library(datasets)
file <- './household_power_consumption.txt'
names <-  c('Date','Time','Global_active_power','Global_reactive_power','Voltage', 'Global_intensity', 'Sub_metering_1','Sub_metering_2','Sub_metering_3')
dateFrom <- '2007-02-01'
dateTo <- '2007-02-02'
## Counting number of lines for defined time inter (every observation correpponds a minute)
nobs <- difftime(as.Date(dateTo)+1,as.Date(dateFrom), units = 'mins')
## Formating starting date to fit the datafile
dateFrom <- gsub("^0", "", format(as.Date(dateFrom),"%d/%m/%Y"))
dateFrom <- gsub("/0", "/", dateFrom)
## Reading relevant data
data <- fread(file, skip = dateFrom, nrows = nobs)
data <- setNames(data,names)
## Converting Date/Time and adding as a new column to dataset
Datetime <- as.POSIXct(strptime(paste(data[, Date],data[, Time]), '%d/%m/%Y %H:%M:%S'))
data <- cbind(Datetime,data)
## Plot4
par(mfrow=c(2,2))
par(mar=c(4,4,1,1))
par(cex=0.5)
## Plot4.1
plot(Datetime, data$Global_active_power, ylab="Global Active Power", xlab='', type='l')
## Plot4.2
plot(Datetime, data$Voltage, ylab="Voltage", type='l')
## Plot4.3
plot(Datetime, data$Sub_metering_1, ylab="Energy submetering", xlab='', type='l')
lines(Datetime, data$Sub_metering_2, col='red')
lines(Datetime, data$Sub_metering_3, col='blue')
legend('topright', names(data)[8:10], col = c(1, 'red', 'blue'), lty = c(1, 1, 1), bty='n', xjust=1, x.intersp=0, yjust=1)
## Plot4.4
plot(Datetime, data$Global_reactive_power, ylab="Global Reactive Power", type='l')
## Copy plot to PNG
dev.copy(png, file = "Plot_4.png") 
dev.off()
