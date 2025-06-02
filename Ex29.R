# Original marks
marks <- c(55, 60, 71, 63, 55, 65, 50, 55, 58, 59, 61, 63, 65, 67, 71, 72, 75)

# Sort marks
sorted_marks <- sort(marks)

### (a) Equal-Frequency Partitioning (3 bins)
n <- length(sorted_marks)
bin_size <- ceiling(n / 3)
equal_freq_bins <- split(sorted_marks, ceiling(seq_along(sorted_marks)/bin_size))
cat("Equal-Frequency Bins:\n")
print(equal_freq_bins)

### (b) Equal-Width Partitioning (3 bins)
min_val <- min(sorted_marks)
max_val <- max(sorted_marks)
width <- (max_val - min_val) / 3
breaks <- seq(min_val, max_val, by = width)
# Add max to include upper bound
breaks[length(breaks)] <- max_val + 1 
equal_width_bins <- cut(sorted_marks, breaks = breaks, include.lowest = TRUE)
cat("Equal-Width Bins:\n")
print(table(equal_width_bins))

### (c) Clustering using K-means (3 clusters)
set.seed(123)
kmeans_result <- kmeans(matrix(sorted_marks), centers = 3)
cat("Cluster assignments:\n")
print(data.frame(Mark = sorted_marks, Cluster = kmeans_result$cluster))

### Histogram Plot
par(mfrow = c(1, 3))  # Plot 3 charts side by side

# Histogram for Equal-Frequency
hist(sorted_marks,
     breaks = c(-Inf, tail(unlist(lapply(equal_freq_bins, max)), -1), Inf),
     main = "Equal-Frequency",
     xlab = "Marks",
     col = "skyblue",
     border = "white")

# Histogram for Equal-Width
hist(sorted_marks,
     breaks = breaks,
     main = "Equal-Width",
     xlab = "Marks",
     col = "lightgreen",
     border = "white")

# Histogram for Clustering
hist(sorted_marks,
     col = kmeans_result$cluster,
     main = "K-Means Clustering",
     xlab = "Marks",
     border = "white")
