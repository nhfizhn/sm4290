# Q1: Which of the technical variables (AA/AG/AP) have the most influence on AVGFPS?

# Step 0: Install necessary packages
# install.packages("caret")
# install.packages("rpart.plot")

# Step 1: Load and preprocess the data set
data_q1 <- read.csv("dataset_for_PE.csv")

# Step 2: Define feature and target variables
features_q1 <- c("AA", "AG", "AP")
target_q1 <- "AVGFPS" 

# Step 3: Build decision tree model
library(rpart)
model_q1 <- rpart(AVGFPS ~ ., data = data_q1[, c(features_q1, target_q1)], method = "anova")

# Step 4: Split data set into training and testing sets
library(caret)
set.seed(321)
trainIndex_q1 <- createDataPartition(data_q1$AVGFPS, p = 0.7, list = FALSE)
training_q1 <- data_q1[trainIndex_q1, ]
testing_q1 <- data_q1[-trainIndex_q1, ]

# Step 5: Train the decision tree model
model_q1 <- rpart(AVGFPS ~ ., data = training_q1[, c(features_q1, target_q1)], method = "anova")

# Step 6: Model assessment
# Calculate predictions on the testing data
predictions_q1 <- predict(model_q1, testing_q1[, features_q1])

# Calculate evaluation metrics (RMSE)
accuracy_q1 <- sqrt(mean((predictions_q1 - testing_q1$AVGFPS)^2))
print("Evaluation of Model Performance")
print("RMSE (Accuracy):")
print(accuracy_q1)

# Additional evaluation metrics (R-squared)
rsquared_q1 <- 1 - (sum((testing_q1$AVGFPS - predictions_q1)^2) / 
                    sum((testing_q1$AVGFPS - mean(testing_q1$AVGFPS))^2))
print("R-squared:")
print(rsquared_q1)

# Cross-validation
cv_q1 <- trainControl(method = "cv", number = 10)  # 10-fold cross-validation
model_cv_q1 <- train(AVGFPS ~ ., data = data_q1[, c(features_q1, target_q1)], 
                     method = "rpart", trControl = cv_q1)
print("Cross-validated RMSE:")
print(sqrt(model_cv_q1$results$RMSE))

# Step 7: Plot the decision tree
library(rpart.plot)
par(mfrow = c(1,1))
rpart.plot(model_q1, roundint = FALSE, fallen.leaves = TRUE, 
           main = "Decision Tree for AVGFPS Prediction")

# Step 8: Interpretation (optional)
print("Interpretation")
print("Decision Tree Model:")
print(model_q1)
print("Variable Importance Analysis:")
print(varImp(model_q1))

# Extract actual values from the testing data set
actual_q1 <- testing_q1$AVGFPS

# Create a data frame with both predicted and actual values
comparison_q1 <- data.frame(Predicted = predictions_q1, Actual = actual_q1)

# Step 9: Plot predicted vs. actual values
par(mfrow = c(1,2))
plot(comparison_q1$Actual, type = "l", col = "blue",
     ylim = range(c(comparison_q1$Predicted, comparison_q1$Actual)),
     xlab = "Observation", ylab = "AVGFPS", main = "Predicted vs. Actual AVGFPS")
lines(comparison_q1$Predicted, col = "red")
legend(x = 120, y = 36, legend = c("Actual", "Predicted"), col = c("blue", "red"), lty = 1)

# Step 10: Plot residuals
residuals_q1 <- comparison_q1$Actual - comparison_q1$Predicted
plot(residuals_q1, type = "p", col = "blue", 
     xlab = "Observation", ylab = "Residuals", main = "Residuals Plot")
abline(h = 0, col = "red")
grid()
