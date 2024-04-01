# Q3: What is the optimal combination of the technical variables (`AA`/`AG`/`AP`) 
# to achieve optimal `NFPSPE`?

# Step 0: Install necessary packages
# install.packages("caret")
# install.packages("rpart.plot")

# Step 1: Load and preprocess the dataset
data_q3 <- read.csv("final_dataset.csv")

# Step 2: Define feature and target variables
features_q3 <- c("NAA", "NAG", "NAP")
target_q3 <- "NAVGFPSPE"

# Step 3: Build decision tree model
model_q3 <- rpart(NAVGFPSPE ~ ., data = data_q3[, c(features_q3, target_q3)], method = "anova")

# Step 4: Split data set into training and testing sets
set.seed(123)  # For reproducibility
trainIndex_q3 <- createDataPartition(data_q3$NAVGFPSPE, p = 0.7, list = FALSE)
training_q3 <- data_q3[trainIndex_q3, ]
testing_q3 <- data_q3[-trainIndex_q3, ]

# Step 5: Train the decision tree model
model_q3 <- rpart(NAVGFPSPE ~ ., data = training_q3[, c(features_q3, target_q3)], method = "anova")

# Step 6: Model assessment
predictions_q3 <- predict(model_q3, testing_q3[, features_q3])

# Calculate evaluation metrics (RMSE)
accuracy_q3 <- sqrt(mean((predictions_q3 - testing_q3$NAVGFPSPE)^2))
print("Evaluation of Model Performance")
print("RMSE (Accuracy):")
print(accuracy_q3)

# Additional evaluation metrics (R-squared)
rsquared_q3 <- 1 - (sum((testing_q3$NAVGFPSPE - predictions_q3)^2) 
                    / sum((testing_q3$NAVGFPSPE - mean(testing_q3$NAVGFPSPE))^2))
print("R-squared:")
print(rsquared_q3)

# Cross-validation
cv_q3 <- trainControl(method = "cv", number = 10)  # 10-fold cross-validation
model_cv_q3 <- train(NAVGFPSPE ~ ., data = data_q3[, c(features_q3, target_q3)], 
                     method = "rpart", trControl = cv_q3)
print("Cross-validated RMSE:")
print(sqrt(model_cv_q3$results$RMSE))

# Step 7: Plot the decision tree
par(mfrow=c(1,1))
library(rpart.plot)
rpart.plot(model_q3, main = "Decision Tree for NAVGFPSPE Prediction")

# Step 8: Interpretation (optional)
print("Interpretation")
print("Decision Tree Model:")
print(model_q3)
print("Variable Importance Analysis:")
print(varImp(model_q3))

# Step 9: Plot predicted vs. actual values
par(mfrow = c(1,2))
actual_q3 <- testing_q3$NAVGFPSPE
comparison_q3 <- data.frame(Predicted = predictions_q3, Actual = actual_q3)
plot(comparison_q3$Actual, type = "l", col = "blue",
     ylim = range(c(comparison_q3$Predicted, comparison_q3$Actual)),
     xlab = "Observation", ylab = "NAVGFPSPE", main = "Predicted vs. Actual NAVGFPSPE")
lines(comparison_q3$Predicted, col = "red")
legend(x = 80, y = 0.2, legend = c("Actual", "Predicted"), col = c("blue", "red"), lty = 1)

# Step 10: Plot residuals
residuals_q3 <- comparison_q3$Actual - comparison_q3$Predicted
plot(residuals_q3, type = "p", col = "blue", 
     xlab = "Observation", ylab = "Residuals", main = "Residuals Plot")
abline(h = 0, col = "red")
grid()
