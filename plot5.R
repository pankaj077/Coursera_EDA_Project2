## Code for plot 5

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

library(ggplot2)

# Subset for motor vehicle sources in Baltimore City
# Assume motor vehicles implies is 'ON-ROAD' type 
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedYearlyTotal <- aggregate(Emissions ~ year, subsetNEI, sum)



png("plot5.png", width=800, height=640)
g <- ggplot(aggregatedYearlyTotal, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle type ON-ROAD in Baltimore City, Maryland from 1999 to 2008')
print(g)
dev.off()
