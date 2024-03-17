install.packages("caret")
library(caret)

# Set the number of folds (e.g., 5-fold or 10-fold)
num_folds <- 5

# Define the train control with k-fold cross-validation
train_control <- trainControl(method = "cv", number = num_folds)

data <- read.csv("pilot dataset - dataset.csv")

# Define your modeling technique and parameters (e.g., decision tree)
model <- train(AVGFPS ~ ., data = data, method = "rpart", trControl = train_control)

# View the cross-validation results
print(model)
