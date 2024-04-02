# Load the required libraries
library(rpart.plot)

data <- read.csv("final_dataset.csv")

# Fit a decision tree model to predict NAVGFPSPE
N_model <- rpart(NAVGFPSPE ~ COMB, data = data)


# Visualize the decision trees
library(rpart.plot)
par(mfrow = c(1,1), mar = c(2,0,3,0))

N_model <- rpart(NAVGFPSPE ~ LEVEL, data = data)

rpart.plot(N_model, roundint = FALSE, fallen.leaves = TRUE, 
           main = "Decision Tree for COMB Prediction")
mtext(expression(bold("Figure 7")~ "Predictive Model for Optimal Combination"), side = 1, line = 1)
