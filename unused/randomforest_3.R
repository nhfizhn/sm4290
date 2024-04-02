# Load required libraries
library(randomForest)

# Load your dataset
# Assuming your dataset is stored in 'df'

# Feature engineering
df$Player_Experience <- rowMeans(df[, c("Audio_Rating", "Graphics_Rating", "Physics_Rating", "Enjoyment_Rating", "Comfort_Rating", "Overall_Satisfaction_Rating")])

# Split the data into training and testing sets
set.seed(123)  # for reproducibility
train_indices <- sample(1:nrow(df), 0.8 * nrow(df))
train_data <- df[train_indices, ]
test_data <- df[-train_indices, ]

# Train the Random Forest model
rf_model <- randomForest(Average_FPS + Player_Experience ~ Audio + Graphics + Physics, data = train_data)

# Make predictions
predictions <- predict(rf_model, newdata = test_data)

# Evaluate model performance (e.g., mean squared error)
mse <- mean((predictions - test_data$Average_FPS)^2)

# Plot individual trees
for (i in 1:ntree(rf_model)) {
  tree <- getTree(rf_model, i, labelVar = TRUE)
  plot(tree)
}
