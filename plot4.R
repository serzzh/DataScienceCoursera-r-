
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
## Reading data from RDS files.
## This first line will likely take a few seconds. Be patient!

if(!exists('NEI')) NEI<-readRDS("summarySCC_PM25.rds") ## Avoing of double reading and saving our time.
if(!exists('SCC')) SCC<-readRDS("Source_Classification_Code.rds")

## Extracting SCC for motor vehicle 
SCC_V <- SCC[grepl('Coal',SCC$EI.Sector),]

##Merging data
Coal <- merge(NEI, SCC_V)

## Summarizing the data

Coal$year <- factor(Coal$year)
em_sum <- tapply(Coal$Emissions, Coal$year, sum)

##Making plot and writing it to PNG device
par(mfrow=c(1,1))
par(cex=0.8)
barplot(em_sum/1000, ylab="Emissions PM2.5, kilotons", xlab='Year', col='magenta', main='Coal combustion emissions, USA')
dev.copy(png, file = "Plot_4.png") 
dev.off()