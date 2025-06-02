# Sample age data for 18 adults
age <- c(23, 25, 27, 31, 33, 35, 36, 38, 40, 41, 43, 45, 47, 49, 52, 55, 57, 60)

# Value to normalize
value <- 35

# (i) Min-Max Normalization to range [0, 1]
min_val <- min(age)
max_val <- max(age)
min_max_normalized <- (value - min_val) / (max_val - min_val)

# (ii) Z-score Normalization
mean_val <- mean(age)
std_dev <- 12.94  # Given standard deviation
z_score_normalized <- (value - mean_val) / std_dev

# (iii) Decimal Scaling Normalization
j <- nchar(as.character(max(abs(age))))  # Find j such that 10^j > max(abs(age))
decimal_scaled <- value / (10^j)

# Print Results
cat("=== Normalization Results for Age = 35 ===\n")
cat("1. Min-Max Normalization (0-1):", min_max_normalized, "\n")
cat("2. Z-Score Normalization:", z_score_normalized, "\n")
cat("3. Decimal Scaling Normalization:", decimal_scaled, "\n")
