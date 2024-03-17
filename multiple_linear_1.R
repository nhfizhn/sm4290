# Load the dataset
data <- read.csv("pilot dataset - dataset (1).csv")

# Check the structure of the dataset
str(data)

# Fit a multiple linear regression model
# Assuming AVGFPS is the dependent variable and AA, AG, and AP are the independent variables
model <- lm(AVGFPS ~ AA + AG + AP, data = data)

# Summary of the model
summary(model)

# Scatterplot of observed vs predicted AVGFPS
par(mfrow = c(1,2))
plot(data$AVGFPS, fitted(model), xlab = "Observed AVGFPS", ylab = "Predicted AVGFPS")

# Residual plot
plot(residuals(model) ~ fitted(model), xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = "red")  # Add a horizontal line at y = 0 for reference
