# finding the weight of each of AR, GR, PR, ER, CR, OR to determine 
# the formulation of PE.

# Step 1: Load the data set
data_PE <- read.csv("dataset_for_PE.csv")

# Step 2: Define feature and target variables
features_PE <- c("AR", "GR", "PR", "ER", "CR", "OR")
target_PE <- "SCORE" 

# Step 3: Build decision tree model
library(rpart)
model_PE <- rpart(SCORE ~ ., data = data_PE[, c(features_PE, target_PE)], method = "anova")

# Step 4: Split data set into training and testing sets
library(caret)
set.seed(321)
trainIndex_PE <- createDataPartition(data_PE$SCORE, p = 0.7, list = FALSE)
training_PE <- data_PE[trainIndex_PE, ]
testing_PE <- data_PE[-trainIndex_PE, ]

# Step 5: Train the decision tree model
model_PE <- rpart(SCORE ~ ., data = training_PE[, c(features_PE, target_PE)], method = "anova")


# Model assessment
# Calculate predictions on the testing data
predictions_PE <- predict(model_PE, testing_PE[, features_PE])

# Calculate evaluation metrics (RMSE)
accuracy_PE <- sqrt(mean((predictions_PE - testing_PE$SCORE)^2))
print("Evaluation of Model Performance")
print("RMSE (Accuracy):")
print(accuracy_PE)

# Additional evaluation metrics (R-squared)
rsquared_PE <- 1 - (sum((testing_PE$SCORE - predictions_PE)^2) / 
                      sum((testing_PE$SCORE - mean(testing_PE$SCORE))^2))
print("R-squared:")
print(rsquared_PE)

# Cross-validation
cv_PE <- trainControl(method = "cv", number = 10)  # 10-fold cross-validation
model_cv_PE <- train(SCORE ~ ., data = data_PE[, c(features_PE, target_PE)], 
                     method = "rpart", trControl = cv_PE)
print("Cross-validated RMSE:")
print(sqrt(model_cv_PE$results$RMSE))

# Step 6: Interpretation
print("Variable Importance Analysis:")
var_imp <- varImp(model_PE)
print(var_imp)

# Step 7: Add 'weight' column to var_imp data set
weights <- var_imp$Overall / sum(var_imp$Overall)
data_PE_weights <- data.frame(VarImp = var_imp$Overall, Weights = weights)
rownames(data_PE_weights) <- c("AR", "CR", "ER", "GR", "OR", "PR")

# Step 8: Display the new data set
print(data_PE_weights)