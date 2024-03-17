# Load the required libraries
library(randomForest)

data <- read.csv("pilot dataset - dataset (1).csv")

# Create a random forest model
rf_avgfps_model <- randomForest(NAVGFPS ~ NAA + NAG + NAP, data = data)
rf_pe_model <- randomForest(NPE ~ NAA + NAG + NAP, data = data)
rf_fpspe_model <- randomForest(NFPSPE ~ NAA + NAG + NAP, data = data)

# Extract feature importance scores from the random forest model
feature_importance_1 <- importance(rf_avgfps_model)
feature_importance_2 <- importance(rf_pe_model)
feature_importance_3 <- importance(rf_fpspe_model)

# Print feature importance scores
print(feature_importance_1)
print(feature_importance_2)
print(feature_importance_3)

# Plot feature importance scores
par(mfrow = c(1,3))
varImpPlot(rf_avgfps_model)
varImpPlot(rf_pe_model)
varImpPlot(rf_fpspe_model)


#-------------------------------------------------------------------------------
library(rpart)

rf_model <- randomForest(NFPSPE ~ NAA + NAG + NAP, data = data)

# Plotting the first tree
plot(rf_model$forest[[1]], main = "Random Forest Tree")

# Feature importance
importance(rf_model)

# Example prediction
new_data <- data.frame(NAA = 0.5, NAG = 1, NAP = 0)
predict(rf_model, new_data)

