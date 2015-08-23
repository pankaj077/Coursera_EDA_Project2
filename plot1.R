## Code for Plot 1

## Read the RDS datasets they don't already exist
setwd("EDA")
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Summarize the totals by year using the aggregate command
aggregatedYearlyTotal <- aggregate(Emissions ~ year, NEI, sum)

# Plot the yearly totals using the base plotting system
png('plot1.png')
barplot(height=aggregatedYearlyTotal$Emissions, names.arg=aggregatedYearlyTotal$year, xlab="Years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()