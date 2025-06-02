# Original price data (sorted)
prices <- c(1, 1, 5, 5, 5, 5, 5, 8, 8, 10, 10, 10, 10, 12, 14, 14, 14, 15, 15, 15,
            15, 15, 15, 18, 18, 18, 18, 18, 18, 18, 18, 20, 20, 20, 20, 20, 20, 20,
            21, 21, 21, 21, 25, 25, 25, 25, 25, 28, 28, 30, 30, 30)

# (i) Equal-frequency partitioning into 3 bins
n <- length(prices)
bin_size <- n / 3
bins <- split(prices, ceiling(seq_along(prices) / bin_size))

# Print the bins
cat("Equal-Frequency Bins:\n")
print(bins)

# (ii) Data smoothing

# Smoothing by bin means
bin_means <- lapply(bins, function(bin) rep(mean(bin), length(bin)))

# Smoothing by bin boundaries
bin_boundaries <- lapply(bins, function(bin) {
  min_val <- min(bin)
  max_val <- max(bin)
  sapply(bin, function(x) {
    if (abs(x - min_val) < abs(x - max_val)) min_val else max_val
  })
})

# Combine results
smoothed_means <- unlist(bin_means)
smoothed_boundaries <- unlist(bin_boundaries)

# Display smoothing results
cat("\nSmoothed using Bin Means:\n")
print(smoothed_means)

cat("\nSmoothed using Bin Boundaries:\n")
print(smoothed_boundaries)

# (iii) Plot Histogram for frequency division
hist(prices,
     breaks = 3,
     col = "lightblue",
     main = "Histogram of Prices (3 Equal-Frequency Bins)",
     xlab = "Price",
     ylab = "Frequency",
     border = "black")
