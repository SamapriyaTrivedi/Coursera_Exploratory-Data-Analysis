################### Question 5 ################### 
#### How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

NEISCC <- merge(balt, subsetSCC, by="SCC")

totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from motor sources in Baltimore")

dev.copy(png, file="Plot 9.png", height=480, width=480)
dev.off()