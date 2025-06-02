# Min-Max Normalization for value 80,000
min_val <- 50000
max_val <- 100000
v <- 80000

min_max_norm <- (v - min_val) / (max_val - min_val)
cat("Min-Max Normalized value of 80000:", min_max_norm, "\n")
# Data vector
data <- c(200, 300, 400, 600, 1000)

# Min-Max Normalization
min_data <- min(data)
max_data <- max(data)

min_max_normalized <- (data - min_data) / (max_data - min_data)
cat("Min-Max Normalized data:\n")
print(min_max_normalized)
# Z-Score Normalization
mean_data <- mean(data)
sd_data <- sd(data)

z_score_normalized <- (data - mean_data) / sd_data
cat("Z-Score Normalized data:\n")
print(z_score_normalized)
