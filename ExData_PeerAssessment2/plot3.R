
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.  

library(ggplot2)
library(plyr)

## Reading data from RDS files.
## This first line will likely take a few seconds. Be patient!

if(!exists('NEI')) NEI<-readRDS("summarySCC_PM25.rds") ## Avoing of double reading and saving our time.
if(!exists('SCC')) SCC<-readRDS("Source_Classification_Code.rds")

## Extracting data for Baltimore
NEI_Balt <- NEI[which(NEI$fips == "24510"),]

## Summarizing the data
## NEI_Balt$year <- factor(NEI_Balt$year)
NEI_Balt$type <- factor(NEI_Balt$type)
em_sum <- ddply(NEI_Balt,.(year, type), summarize, total_P2.5=sum(Emissions))

##Making plot and writing it to PNG device
p1 <- qplot(year, total_P2.5, data=em_sum, facets = .~type, geom="bar", stat="identity")
print(p1)
dev.copy(png, file = "Plot_3.png") 
dev.off()
