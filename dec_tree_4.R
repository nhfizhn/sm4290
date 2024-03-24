# Q4: Which technical variables (`AA`/`AG`/`AP`) settings do most participants prefer?

# Step 1: Load and preprocess the dataset
data_q4 <- read.csv("dataset - 17Mar24.csv")

# Step 2: Define feature and target variables
features_q4 <- c("AA", "AG", "AP")
target_q4 <- "OptimalPerformance"  # New target variable representing combined optimization

# Create the new target variable by summing AVGFPS and PE
data_q4$OptimalPerformance <- data_q4$NFPSPE

# Step 3: Build decision tree model
model_q4 <- rpart(OptimalPerformance ~ ., data = data_q4[, c(features_q4, target_q4)], method = "anova")

# Step 4: Split data set into training and testing sets
set.seed(123)
trainIndex_q4 <- createDataPartition(data_q4$OptimalPerformance, p = 0.7, list = FALSE)
training_q4 <- data_q4[trainIndex_q4, ]
testing_q4 <- data_q4[-trainIndex_q4, ]

# Step 5: Train the decision tree model
model_q4 <- rpart(OptimalPerformance ~ ., data = training_q4[, c(features_q4, target_q4)], method = "anova")

# Step 6: Model assessment
predictions_q4 <- predict(model_q4, testing_q4[, features_q4])

# Calculate evaluation metrics (e.g., RMSE)
accuracy_q4 <- sqrt(mean((predictions_q4 - testing_q4$OptimalPerformance)^2))
print("Evaluation of Model Performance")
print("RMSE (Accuracy):")
print(accuracy_q4)

# Additional evaluation metrics (e.g., R-squared)
rsquared_q4 <- 1 - (sum((testing_q4$OptimalPerformance - predictions_q4)^2) 
                    / sum((testing_q4$OptimalPerformance - mean(testing_q4$OptimalPerformance))^2))
print("R-squared:")
print(rsquared_q4)

# Step 7: Variable Importance Analysis
print("Variable Importance Analysis:")
print(varImp(model_q4))

# Step 8: Interpretation (optional)
print("Interpretation")
print("Decision Tree Model:")
print(model_q4)

# Step 9: Plot the decision tree
library(rpart.plot)
par(mfrow = c(1,1))
rpart.plot(model_q4, fallen.leaves = FALSE, main = "Decision Tree for Optimal Performance Prediction")

# Step 10: Extract actual values from the testing dataset
actual_q4 <- testing_q4$OptimalPerformance

# Create a dataframe with both predicted and actual values
comparison_q4 <- data.frame(Predicted = predictions_q4, Actual = actual_q4)

# Step 11: Plot predicted vs. actual values
par(mfrow = c(1,2))
plot(comparison_q4$Actual, type = "l", col = "blue",
     ylim = range(c(comparison_q4$Predicted, comparison_q4$Actual)),
     xlab = "Observation", ylab = "Optimal Performance", main = "Predicted vs. Actual Optimal Performance")
lines(comparison_q4$Predicted, col = "red")
legend("bottom", legend = c("Actual", "Predicted"), col = c("blue", "red"), lty = 1)
grid()

# Step 12: Plot residuals
residuals_q4 <- comparison_q4$Actual - comparison_q4$Predicted
plot(residuals_q4, type = "p", col = "green", 
     xlab = "Observation", ylab = "Residuals", main = "Residuals Plot")
abline(h = 0, col = "red")
grid()
