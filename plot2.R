## Code for Plot 2

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

# Plot the yearly Emissions using the base pltting system
aggregatedYearlyTotal <- aggregate(Emissions ~ year, sub_NEI, sum)
png('plot2.png')
barplot(height=aggregatedYearlyTotal$Emissions, names.arg=aggregatedYearlyTotal$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions in Baltimore City, MD across years'))
dev.off()