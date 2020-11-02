################### Question 2 ################### 
#### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

balt <- subset(NEI, fips == "24510")

totalEmissions <- tapply(balt$Emissions, balt$year, sum)

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Total Emission per year in Baltimore")

dev.copy(png, file="Plot 6.png", height=480, width=480)
dev.off()