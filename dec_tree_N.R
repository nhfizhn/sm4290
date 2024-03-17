# Step 1: Load and preprocess the dataset
data <- read.csv("pilot dataset - dataset (1).csv")

# Step 2: Define feature and target variables (using normalized values)
features <- c("NAA", "NAG", "NAP")
target <- "NAVGFPS"

# Step 3: Build decision tree model
library(rpart)
model <- rpart(NAVGFPS ~ ., data = data[, c(features, target)], method = "anova")

# Step 4: Split dataset into training and testing sets
library(caret)
set.seed(123) # for reproducibility
trainIndex <- createDataPartition(data$NAVGFPS, p = 0.7, list = FALSE)
training <- data[trainIndex, ]
testing <- data[-trainIndex, ]

# Step 5: Train the decision tree model
model <- rpart(NAVGFPS ~ ., data = training[, c(features, target)], method = "anova")

# Step 6: Plot the decision tree
library(rpart.plot)
par(mfrow = c(1,2))
rpart.plot(model)

# Step 7: Evaluate model performance (optional)
predictions <- predict(model, testing[, features])
accuracy <- sqrt(mean((predictions - testing$NAVGFPS)^2))
print("Evaluation of Model Performance")
print("Predictions:")
print(predictions)
print("Accuracy:")
print(accuracy)

# Step 8: Interpretation (optional)
print("Interpretation")
print("Decision Tree Model:")
print(model)
print("Variable Importance Analysis:")
print(varImp(model))

# Extract actual values from the testing dataset
actual <- testing$NAVGFPS

# Create a dataframe with both predicted and actual values
comparison <- data.frame(Predicted = predictions, Actual = actual)

# Step 9: Plot predicted vs. actual values
plot(comparison$Actual, type = "l", col = "blue", ylim = range(c(comparison$Predicted, comparison$Actual)),
     xlab = "Observation", ylab = "NAVGFPS", main = "Predicted vs. Actual NAVGFPS")
lines(comparison$Predicted, col = "red")
legend("topright", legend = c("Actual", "Predicted"), col = c("blue", "red"), lty = 1)
grid()