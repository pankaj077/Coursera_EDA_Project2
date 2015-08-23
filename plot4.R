## Code for plot 4

# Read the RDS datasets they don't already exist
setwd("EDA")
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Merge the two data sets so as to fetch all NEIxSCC records with Short.Name (SCC) Coal
NEISCC <- merge(NEI, SCC, by="SCC")

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

# Aggregate the subsetted Total by Year
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)


# Generate Plot 4, for the aggregateddata
library(ggplot2)

png("plot4.png", width=640, height=640)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()
