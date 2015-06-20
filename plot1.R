
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

## Reading data from RDS files.
## This first line will likely take a few seconds. Be patient!

if(!exists('NEI')) NEI<-readRDS("summarySCC_PM25.rds") ## Avoing of double reading and saving our time.
if(!exists('SCC')) SCC<-readRDS("Source_Classification_Code.rds")

## Summarizing the data
NEI$year <- factor(NEI$year)
em_sum <- tapply(NEI$Emissions, NEI$year, mean)

##Making plot and writing it to PNG device
barplot(em_sum, ylab="Emissions, PM2.5", xlab='Year')
dev.copy(png, file = "Plot_1.png") 
dev.off()