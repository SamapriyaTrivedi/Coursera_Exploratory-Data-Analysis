################### Question 6 ################### 
#### Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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