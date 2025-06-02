# Vector of number of pencils in each box
pencils <- c(25, 23, 12, 11, 6, 7, 8, 9, 10)

# Calculate Mean
mean_pencils <- mean(pencils)

# Calculate Median
median_pencils <- median(pencils)

# Calculate Mode (custom function, since R has no built-in mode for numeric data)
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
mode_pencils <- get_mode(pencils)

# Print results
cat("Mean:", mean_pencils, "\n")
cat("Median:", median_pencils, "\n")
cat("Mode:", mode_pencils, "\n")
