## Code for plot 6

# Read the RDS datasets they don't already exist
setwd("EDA")
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

# Subset NEI for Baltimore and Los Angeles
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

# Aggregate by Year and City
aggregatedTotalByYearCity <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearCity$fips[aggregatedTotalByYearCity$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearCity$fips[aggregatedTotalByYearCity$fips=="06037"] <- "Los Angeles, CA"

# Generate Plot 6 to compare the cities side by side
library(ggplot2)
png("plot6.png", width=960, height=480)
g <- ggplot(aggregatedTotalByYearCity, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicles in Baltimore City, MD vs Los Angeles, CA ( 1999-2008) ')
print(g)
dev.off()