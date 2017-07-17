
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question. 

## Reading data from RDS files.
## This first line will likely take a few seconds. Be patient!

if(!exists('NEI')) NEI<-readRDS("summarySCC_PM25.rds") ## Avoing of double reading and saving our time.
if(!exists('SCC')) SCC<-readRDS("Source_Classification_Code.rds")

## Extracting data for Baltimore
NEI_Balt <- NEI[which(NEI$fips == "24510"),]

## Summarizing the data
NEI_Balt$year <- factor(NEI_Balt$year)
em_sum <- tapply(NEI_Balt$Emissions, NEI_Balt$year, sum)

##Making plot and writing it to PNG device
par(mfrow=c(1,1))
par(cex=0.8)
barplot(em_sum/1000, ylab="Emissions PM2.5, kilotons", xlab='Year', col='blue', main='Total emissions PM2.5, Baltimore City')
dev.copy(png, file = "Plot_2.png") 
dev.off()
