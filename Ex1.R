# Given data
sales <- c(5, 10, 11, 13, 15, 35, 50, 55, 72, 92, 204, 215)
sales_sorted <- sort(sales)

cat("Sorted Sales Data:\n")
print(sales_sorted)

# (a) Equal-Frequency (Equi-depth) Partitioning
n <- length(sales_sorted)
bin_size <- n / 3  # 3 bins

# Split into 3 equal-frequency bins
bins_equal_freq <- split(sales_sorted, ceiling(seq_along(sales_sorted) / bin_size))
names(bins_equal_freq) <- paste("Bin", 1:3)

cat("\n(a) Equal-Frequency Binning:\n")
print(bins_equal_freq)

# (b) Equal-Width Partitioning
min_val <- min(sales)
max_val <- max(sales)
bin_width <- (max_val - min_val) / 3

# Cut into 3 equal-width bins
bins_equal_width <- cut(sales_sorted, 
                        breaks = seq(min_val, max_val, by = bin_width), 
                        include.lowest = TRUE, 
                        right = FALSE)

# Group data by bins
bins_equal_width_result <- split(sales_sorted, bins_equal_width)

cat("\n(b) Equal-Width Binning:\n")
print(bins_equal_width_result)

# (c) Clustering (using k-means)
set.seed(1)  # For reproducibility
sales_matrix <- matrix(sales_sorted, ncol = 1)
km <- kmeans(sales_matrix, centers = 3)

# Group data by cluster
bins_clustering <- split(sales_sorted, km$cluster)
names(bins_clustering) <- paste("Cluster", names(bins_clustering))

cat("\n(c) Clustering (K
