################### Importing Data ################### 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


################### Question 1 ################### 
#### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
totalEmissions <- tapply(NEI$Emissions, NEI$year, sum)

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission per year")

dev.copy(png, file="Plot 5.png", height=480, width=480)
dev.off()


################### Question 2 ################### 
#### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
balt <- subset(NEI, fips == "24510")

totalEmissions <- tapply(balt$Emissions, balt$year, sum)

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Total Emission per year in Baltimore")

dev.copy(png, file="Plot 6.png", height=480, width=480)
dev.off()


################### Question 3 ################### 
#### Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

data <- aggregate(Emissions ~ year + type, balt, sum)

g <- ggplot(data, aes(year, Emissions, color = type))
g + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions per type in Baltimore")

dev.copy(png, file="Plot 7.png", height=480, width=480)
dev.off()


################### Question 4 ################### 
#### Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

NEISCC <- merge(NEI, subsetSCC, by="SCC")

totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Total Emission from coal sources")

dev.copy(png, file="Plot 8.png", height=480, width=480)
dev.off()


################### Question 5 ################### 
#### How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

NEISCC <- merge(balt, subsetSCC, by="SCC")

totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from motor sources in Baltimore")

dev.copy(png, file="Plot 9.png", height=480, width=480)
dev.off()


################### Question 6 ################### 
#### Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
los <- subset(NEI, fips == "06037")

vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

dataBalt <- merge(balt, subsetSCC, by="SCC")
dataBalt$city <- "Baltimore City"
dataLos <- merge(los, subsetSCC, by="SCC")
dataLos$city <- "Los Angeles County"
data <- rbind(dataBalt, dataLos)

data <- aggregate(Emissions ~ year + city, data, sum)

g <- ggplot(data, aes(year, Emissions, color = city))
g + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from motor sources in Baltimore and Los Angeles")

dev.copy(png, file="Plot 10.png", height=480, width=480)
dev.off()