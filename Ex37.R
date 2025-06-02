# Diabetes dataset - Age values
age <- c(30, 57, 68, 96, 39, 40, 20, 19, 42, 12, 25, 25, 65, 35, 30, 23, 23, 35, 45, 85)

# Calculate Mean
mean_age <- mean(age)

# Display Mean
cat("Mean Age:", mean_age, "\n")
# Speed data
speed <- c(78.3, 81.8, 82, 74.2, 83.4, 84.5, 82.9, 77.5, 80.9, 70.6)

# Calculate Interquartile Range (IQR)
iqr_speed <- IQR(speed)

# Calculate Standard Deviation
sd_speed <- sd(speed)

# Display Results
cat("Interquartile Range of Speed:", iqr_speed, "\n")
cat("Standard Deviation of Speed:", sd_speed, "\n")
# Boxplot
boxplot(speed, main = "Boxplot of Speeds", ylab = "Speed (kph)", col = "lightblue")

# Histogram
hist(speed, main = "Histogram of Speeds", xlab = "Speed (kph)", col = "lightgreen", breaks = 5)
