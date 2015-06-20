
## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?  

library(plyr)


## Reading data from RDS files.
## This first line will likely take a few seconds. Be patient!

if(!exists('NEI')) NEI<-readRDS("summarySCC_PM25.rds") ## Avoing of double reading and saving our time.
if(!exists('SCC')) SCC<-readRDS("Source_Classification_Code.rds")

## Extracting SCC for motor vehicle 

SCC_V <- SCC[grepl('Vehicle',SCC$SCC.Level.Two),]

## Extracting data for Baltimore
NEI_Balt <- NEI[which(NEI$fips == "24510"),]
NEI_Balt$year <- factor(NEI_Balt$year)

## Extracting data for LA county
NEI_LA <- NEI[which(NEI$fips == "06037"),]
NEI_LA$year <- factor(NEI_LA$year)

##Merging data
Balt_v <- merge(NEI_Balt, SCC_V)
LA_v <- merge(NEI_LA, SCC_V)

## Summarizing the data

Balt_v$year <- factor(Balt_v$year)
Balt_sum <- tapply(Balt_v$Emissions, Balt_v$year, sum)

LA_v$year <- factor(LA_v$year)
LA_sum <- tapply(LA_v$Emissions, LA_v$year, sum)

##Making plot and writing it to PNG device
par(mfrow=c(1,2))
par(mar=c(4,4,6,1))
par(cex=0.8)
barplot(Balt_sum/1000, ylab="Emissions PM2.5, kilotons", xlab='Year', main = 'Baltimore', col='blue')
barplot(LA_sum/1000, ylab="Emissions PM2.5, kilotons", xlab='Year', main = 'Los Angeles', col='red')
mtext("Motor Vehicle Emissions, PM2.5", side = 3, line = -1.5, outer = TRUE, cex=1, font=2)
dev.copy(png, file = "Plot_6.png") 
dev.off()
