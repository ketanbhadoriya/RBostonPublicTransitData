#Start of the R script for cleaning data of Boston Public Transit Ridership Data
library(readxl)

# Importing mbta.xlsx and skip first row: mbta
mbta <- read_excel("mbta.xlsx",skip=1) #skipping the first row

#structure of mbta
str(mbta)

#11 rows of mbta
head(mbta,n=11)

#summary of mbta
summary(mbta)

# Removing rows 1, 7, and 11 of mbta: mbta2
mbta2 <- mbta[-c(1, 7, 11), ]

# Removing the first column of mbta2: mbta3
mbta3 <- mbta2[, -1]

#Tidying Data
# Load tidyr
library(tidyr)

# Gather columns of mbta3: mbta4
mbta4 <- gather(mbta3, month, thou_riders, -mode)

# View the head of mbta4
head(mbta4)

# Coercing thou_riders to numeric
mbta4$thou_riders <- as.numeric(mbta4$thou_riders)
head(mbta4)

# Spreading the contents of mbta4: mbta5
mbta5 <- spread(mbta4, mode, thou_riders)

# View the head of mbta5
head(mbta5)
head(mbta5$month)

# Splitting month column into month and year: mbta6
mbta6 <- separate(mbta5,month,c("year","month"),sep="-")

# View the head of mbta6
head(mbta6)

#Spotting Outliers
# View a summary of mbta6
summary(mbta6)


# Generate a histogram of Boat column
hist(mbta6$Boat)

#Removing The Outlier
# the row number of the incorrect value: i
i <- which(mbta6$Boat > 30)

# Replace the incorrect value with 4
mbta6$Boat[i] <- 4

# Generate a histogram of Boat column
hist(mbta6$Boat)
