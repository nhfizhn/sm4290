# Load the rpart package
library(rpart)

# loads the data set into R
data <- read.csv("pilot dataset - dataset.csv")

# Build decision tree model
tree_model <- rpart(AVGFPS ~ AA + AG + AP, data = data)

# Plot decision tree
plot(tree_model, margin = 0.2)
text(tree_model, use.n = TRUE, cex = 0.8)

# Based on the description you provided, it seems you have built a decision tree 
# with a binary split on the Actual Graphics (AG) variable. The split criterion 
# is that AG is greater than or equal to 1.5.

# Left Node (AG >= 1.5): This node represents the subset of data where the Actual 
# Graphics (AG) variable is greater than or equal to 1.5. In this subset, the average 
# (frame rate) is approximately 43.66, and the sample size (n) is 90. This means 
# that among the observations where AG is greater than or equal to 1.5, the average 
# FPS is around 43.66, calculated from a sample of 90 observations.

# Right Node (AG < 1.5): This node represents the subset of data where the Actual 
# Graphics (AG) variable is less than 1.5. In this subset, the average FPS is 
# approximately 51.69, and the sample size (n) is 45. This means that among the 
# observations where AG is less than 1.5, the average FPS is around 51.69, 
# calculated from a sample of 45 observations.

# In summary, the decision tree is splitting the data based on the Actual Graphics 
# variable, with the threshold of 1.5. The resulting nodes represent different 
# subsets of data characterized by different levels of Actual Graphics, with 
# corresponding average FPS values and sample sizes. This information helps to 
# how the Actual Graphics setting influences the average FPS in your Unity environment.