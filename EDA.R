data <- read.csv("dataset_for_q2.csv")

# Summary statistics for numeric variables
summary(data[, c("LEVEL", "SCORE", "AVGFPS", "GAMING", "PCP")])

# Frequency table for categorical variables
table(data$AGE)
table(data$SEX)

# Histograms for numeric variables
par(mfrow = c(2,3))
hist(data$LEVEL, main = "Distribution of Levels")
hist(data$SCORE, main = "Distribution of Score")
hist(data$AVGFPS, main = "Distribution of Average FPS")
hist(data$GAMING, main = "Distribution of Gaming Interest")
hist(data$PCP, main = "Distribution of Participant Number")

# Bar plots for categorical variables
par(mfrow = c(1,2))
barplot(table(data$AGE), main = "Frequency of Age Groups")
barplot(table(data$SEX), main = "Frequency of Sex")
