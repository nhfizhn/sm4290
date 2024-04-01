# Q2: Which of the technical variables (AA/AG/AP) have the most influence on PE?

# Step 0: Install necessary packages
# install.packages("caret")
# install.packages("rpart.plot")

# Step 1: Load and preprocess the data set
data_q2 <- read.csv("dataset_for_q2.csv")

# Step 2: Define feature and target variables
features_q2 <- c("AA", "AG", "AP")
target_q2 <- "PE"

# Step 3: Build decision tree model
library(rpart)
model_q2 <- rpart(PE ~ ., data = data_q2[, c(features_q2, target_q2)], method = "anova")

# Step 4: Split data set into training and testing sets
library(caret)
set.seed(321)
trainIndex_q2 <- createDataPartition(data_q2$PE, p = 0.7, list = FALSE)
training_q2 <- data_q2[trainIndex_q2, ]
testing_q2 <- data_q2[-trainIndex_q2, ]

# Step 5: Train the decision tree model
model_q2 <- rpart(PE ~ ., data = training_q2[, c(features_q2, target_q2)], method = "anova")

# Step 6: Model assessment
# Calculate predictions on the testing data
predictions_q2 <- predict(model_q2, testing_q2[, features_q2])

# Calculate evaluation metrics (RMSE)
accuracy_q2 <- sqrt(mean((predictions_q2 - testing_q2$PE)^2))
print("Evaluation of Model Performance")
print("RMSE (Accuracy):")
print(accuracy_q2)

# Additional evaluation metrics (R-squared)
rsquared_q2 <- 1 - (sum((testing_q2$PE - predictions_q2)^2) /
                    sum((testing_q2$PE - mean(testing_q2$PE))^2))
print("R-squared:")
print(rsquared_q2)

# Cross-validation
cv_q2 <- trainControl(method = "cv", number = 10)  # 10-fold cross-validation
model_cv_q2 <- train(PE ~ ., data = data_q2[, c(features_q2, target_q2)], 
                     method = "rpart", trControl = cv_q2)
print("Cross-validated RMSE:")
print(sqrt(model_cv_q2$results$RMSE))

# Step 7: Plot the decision tree
library(rpart.plot)
par(mfrow = c(1,1))
rpart.plot(model_q2, digits = 3, roundint = FALSE, fallen.leaves = TRUE, 
           main = "Decision Tree for PE Prediction")

# Step 8: Interpretation (optional)
print("Interpretation")
print("Decision Tree Model:")
print(model_q2)
print("Variable Importance Analysis:")
print(varImp(model_q2))

# Extract actual values from the testing data set
actual_q2 <- testing_q2$PE

# Create a data frame with both predicted and actual values
comparison_q2 <- data.frame(Predicted = predictions_q2, Actual = actual_q2)

# Step 9: Plot predicted vs. actual values
par(mfrow = c(1,2))
plot(comparison_q2$Actual, type = "l", col = "blue",
     ylim = range(c(comparison_q2$Predicted, comparison_q2$Actual)),
     xlab = "Observation", ylab = "PE", main = "Predicted vs. Actual PE")
lines(comparison_q2$Predicted, col = "red")
legend(x = 25, y =  2.2, legend = c("Actual", "Predicted"), col = c("blue", "red"), lty = 1)

# Step 10: Plot residuals
residuals_q2 <- comparison_q2$Actual - comparison_q2$Predicted
plot(residuals_q2, type = "p", col = "blue", 
     xlab = "Observation", ylab = "Residuals", main = "Residuals Plot")
abline(h = 0, col = "red")
grid()