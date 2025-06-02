# Given strike rates
strike_rates <- c(100, 70, 60, 90, 90)

### (a) Min-Max Normalization (range: 0 to 1)
min_val <- min(strike_rates)
max_val <- max(strike_rates)
min_max_normalized <- (strike_rates - min_val) / (max_val - min_val)
cat("Min-Max Normalization:\n")
print(min_max_normalized)

### (b) Z-Score Normalization
mean_val <- mean(strike_rates)
std_dev <- sd(strike_rates)
z_score_normalized <- (strike_rates - mean_val) / std_dev
cat("Z-Score Normalization:\n")
print(z_score_normalized)

### (c) Z-Score Normalization using Mean Absolute Deviation (MAD)
mad_val <- mean(abs(strike_rates - mean_val))
z_score_mad_normalized <- (strike_rates - mean_val) / mad_val
cat("Z-Score using MAD:\n")
print(z_score_mad_normalized)

### (d) Decimal Scaling Normalization
j <- ceiling(log10(max(abs(strike_rates))))
decimal_scaled <- strike_rates / (10^j)
cat("Decimal Scaling Normalization:\n")
print(decimal_scaled)
