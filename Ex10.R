# Load the 'water' dataset from the 'carData' package
if (!require("carData")) install.packages("carData", dependencies = TRUE)
library(carData)

# Load the dataset
data("water")

# View structure and summary
str(water)
summary(water)

# Plot: Check linear relationship between 'hardness' and 'mortality'
plot(water$hardness, water$mortality,
     main = "Scatterplot of Mortality vs Hardness",
     xlab = "Hardness",
     ylab = "Mortality",
     pch = 19, col = "blue")

# Fit a linear regression model
model <- lm(mortality ~ hardness, data = water)
abline(model, col = "red", lwd = 2)  # Add regression line to plot

# View model summary
summary(model)

# Predict mortality for hardness = 88
new_data <- data.frame(hardness = 88)
predicted_mortality <- predict(model, newdata = new_data)

# Output the predicted value
cat("Predicted Mortality for Hardness = 88:", predicted_mortality, "\n")
