# performing regression analysis to answer the research question about which variables (Audio, Graphics, or Physics) 
# most influential on frame rates in Unity

# loads the data set into R
data <- read.csv("pilot dataset - dataset.csv")

# View the structure of the dataset
str(data)

# Check for missing values
summary(data)

# Fit a regression model
model <- lm(AVGFPS ~ AA + AG + AP, data = data)

# View summary of the model
summary(model)


# checking LINE assumptions ----------------------------------------------------

# linear relationships = no linearity :(
par(mfrow = c(1,3))
plot(data$AA, data$AVGFPS)
plot(data$AG, data$AVGFPS)
plot(data$AP, data$AVGFPS)

# Homoscedasticity = idk what this is tbh
plot(model$fitted.values, residuals(model))

# Normality of Residuals = tbf they look fine
hist(residuals(model))
qqnorm(residuals(model))
qqline(residuals(model))

# If the p-value from the Shapiro-Wilk test is greater than 0.05, 
# it suggests that the residuals are normally distributed
shapiro.test(residuals(model)) # but i got p-value = 4.907e-7 :(

# in conclusion, i cannot use regression. i'll try decision tree
