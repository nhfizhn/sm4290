# Exploratory Data Analysis

# Load the dataset
data <- read.csv("pilot dataset - dataset (1).csv")

# Summary statistics
summary(data)

# Histograms
par(mfrow=c(2, 3)) # Set up a 2x3 grid of plots
hist(data$AA, main="Actual Audio")
hist(data$AG, main="Actual Graphics")
hist(data$AP, main="Actual Physics")
hist(data$AVGFPS, main="AVGFPS")
hist(data$PE, main="PE")

# Jittered scatter plots
plot(jitter(data$AA), data$AVGFPS, xlab="AA", ylab="AVGFPS", main="Scatter Plot with Jitter: AA vs AVGFPS")
plot(jitter(data$AG), data$AVGFPS, xlab="AG", ylab="AVGFPS", main="Scatter Plot with Jitter: AG vs AVGFPS")
plot(jitter(data$AP), data$AVGFPS, xlab="AP", ylab="AVGFPS", main="Scatter Plot with Jitter: AP vs AVGFPS")
plot(jitter(data$AA), data$PE, xlab="AA", ylab="PE", main="Scatter Plot with Jitter: AA vs PE")
plot(jitter(data$AG), data$PE, xlab="AG", ylab="PE", main="Scatter Plot with Jitter: AG vs PE")
plot(jitter(data$AP), data$PE, xlab="AP", ylab="PE", main="Scatter Plot with Jitter: AP vs PE")

# Correlation matrix
par(mfrow=c(1, 1)) # Reset to default plot layout
correlation_matrix <- cor(data[, c("AA", "AG", "AP", "AVGFPS", "PE")])
print(correlation_matrix)
heatmap(correlation_matrix, symm=TRUE)

# Boxplots for outliers
par(mfrow=c(1, 2)) # Set up a 1x2 grid of plots
boxplot(data$AVGFPS, main="AVGFPS Boxplot")
boxplot(data$PE, main="PE Boxplot")
par(mfrow=c(1, 1)) # Reset to default plot layout

# Check for missing values
missing_values <- sum(is.na(data))
print(paste("Number of missing values:", missing_values))
