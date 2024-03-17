# Load the required libraries
library(randomForest)

training_data <- read.csv("pilot dataset - dataset.csv")

# Create a random forest model
rf_model <- randomForest(AVGFPS ~ AA + AG + AP, data = training_data)

predictions <- predict(rf_model, newdata = training_data)

var_importance <- importance(rf_model)
print(var_importance)

# Example of predicting average FPS and player experience for a combination of technical variables
combination <- data.frame(AA = 1, AG = 3, AP = 1)  # Example combination
predicted_fps <- predict(rf_model, newdata = combination)
