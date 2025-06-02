# Load required package
install.packages("caret")     # Run only once
library(caret)

# Actual and Predicted values
actual <- factor(c("No Wolf", "No Wolf", "Wolf"), levels = c("Wolf", "No Wolf"))
predicted <- factor(c("Wolf", "Wolf", "Wolf"), levels = c("Wolf", "No Wolf"))

# Create the confusion matrix
conf_matrix <- confusionMatrix(predicted, actual, positive = "Wolf")

# Print confusion matrix
print(conf_matrix)
