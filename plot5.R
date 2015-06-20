
##  How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?  

## Reading data from RDS files.
## This first line will likely take a few seconds. Be patient!

if(!exists('NEI')) NEI<-readRDS("summarySCC_PM25.rds") ## Avoing of double reading and saving our time.
if(!exists('SCC')) SCC<-readRDS("Source_Classification_Code.rds")

## Extracting SCC for motor vehicle 

SCC_V <- SCC[grepl('Vehicle',SCC$SCC.Level.Two),]

## Extracting data for Baltimore
NEI_Balt <- NEI[which(NEI$fips == "24510"),]
NEI_Balt$year <- factor(NEI_Balt$year)

##Merging data
Balt_v <- merge(NEI_Balt, SCC_V)

## Summarizing the data

em_sum <- tapply(Balt_v$Emissions, Balt_v$year, sum)

##Making plot and writing it to PNG device
par(mfrow=c(1,1))
par(cex=0.8)
barplot(em_sum, ylab="Emissions PM2.5, tons", xlab='Year', main="Vehicle Emissions in Baltimore, PM2.5", col='blue')
dev.copy(png, file = "Plot_5.png") 
dev.off()
