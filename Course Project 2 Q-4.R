################### Question 4 ################### 
#### Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

NEISCC <- merge(NEI, subsetSCC, by="SCC")

totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Total Emission from coal sources")

dev.copy(png, file="Plot 8.png", height=480, width=480)
dev.off()
