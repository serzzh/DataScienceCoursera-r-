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
## Plot3
par(mfrow=c(1,1))
par(mar=c(3,4,1,1))
par(cex=0.75)
plot(Datetime, data$Sub_metering_1, ylab="Energy submetering", xlab='', type='l')
lines(Datetime, data$Sub_metering_2, col='red')
lines(Datetime, data$Sub_metering_3, col='blue')
legend('topright', names(data)[8:10], col = c(1, 'red', 'blue'), lty = c(1, 1, 1), xjust=1, yjust=1)
dev.copy(png, file = "Plot_3.png") 
dev.off()
