## Code for plot 3

## Read the RDS datasets they don't already exist
setwd("EDA")
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset dataset NEI for Baltimore,MD(fips=24510)
sub_NEI  <- NEI[NEI$fips=="24510", ]


# Aggregate Totals by Year AND Type
aggregatedYearType <- aggregate(Emissions ~ year + type, sub_NEI, sum)

# Plot graph for the data using ggplot2
library(ggplot2)
png("plot3.png", width=640, height=640)
g <- ggplot(aggregatedYearType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(g)
dev.off()
