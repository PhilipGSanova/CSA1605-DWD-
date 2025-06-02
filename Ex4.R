# Given data
data <- c(200, 300, 400, 600, 1000)

cat("Original Data:\n")
print(data)

# (a) Min-Max Normalization (scale to [0,1])
min_val <- min(data)
max_val <- max(data)
min_max_norm <- (data - min_val) / (max_val - min_val)

cat("\n(a) Min-Max Normalization (0 to 1):\n")
print(min_max_norm)

# (b) Z-Score Normalization
mean_val <- mean(data)
sd_val <- sd(data)
z_score_norm <- (data - mean_val) / sd_val

cat("\n(b) Z-Score Normalization:\n")
print(z_score_norm)

# (c) Z-Score using Mean Absolute Deviation (MAD)
mad_val <- mean(abs(data - mean_val))
z_score_mad_norm <- (data - mean_val) / mad_val

cat("\n(c) Z-Score using Mean Absolute Deviation:\n")
print(z_score_mad_norm)

# (d) Decimal Scaling Normalization
j <- ceiling(log10(max(abs(data))))
decimal_scaling_norm <- data / (10^j)

cat("\n(d) Decimal Scaling Normalization:\n")
print(decimal_scaling_norm)
