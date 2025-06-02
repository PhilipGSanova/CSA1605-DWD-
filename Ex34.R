# Sample dataset creation
set.seed(123)  # For reproducibility
data <- data.frame(
  age = sample(seq(1, 80, by = 5), 100, replace = TRUE),  # ages grouped in 5-year intervals
  tumor_size = sample(seq(1, 50, by = 1), 100, replace = TRUE),  # in mm
  inv_nodes = sample(0:30, 100, replace = TRUE)  # number of involved lymph nodes
)

# View first few rows
head(data)

# Load required library
library(ggplot2)

# 1. Histogram
hist(data$age, breaks = 10, col = "skyblue", main = "Histogram of Age", xlab = "Age Groups")
hist(data$tumor_size, breaks = 10, col = "lightgreen", main = "Histogram of Tumor Size", xlab = "Tumor Size (mm)")
hist(data$inv_nodes, breaks = 10, col = "salmon", main = "Histogram of Involved Nodes", xlab = "Involved Nodes")

# 2. Scatter plot (Age vs Tumor Size)
plot(data$age, data$tumor_size, main = "Age vs Tumor Size", 
     xlab = "Age", ylab = "Tumor Size (mm)", col = "purple", pch = 19)

# 3. Box plots
boxplot(data$tumor_size, main = "Boxplot of Tumor Size", col = "lightblue")
boxplot(data$inv_nodes, main = "Boxplot of Involved Nodes", col = "lightpink")
