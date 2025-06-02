# Sample Data (replace with your real data if different)
age <- c(23, 25, 27, 31, 33, 35, 36, 38, 40, 41, 43, 45, 47, 49, 52, 55, 57, 60)
fat <- c(12.3, 13.5, 14.1, 15.6, 16.4, 18.0, 19.2, 20.5, 21.8, 22.1, 23.5, 24.7, 25.8, 26.3, 27.1, 28.4, 29.6, 30.2)

# (a) Calculate Mean, Median, and Standard Deviation
mean_age <- mean(age)
median_age <- median(age)
sd_age <- sd(age)

mean_fat <- mean(fat)
median_fat <- median(fat)
sd_fat <- sd(fat)

cat("=== Descriptive Statistics ===\n")
cat("Mean Age:", mean_age, "\n")
cat("Median Age:", median_age, "\n")
cat("Standard Deviation of Age:", sd_age, "\n\n")

cat("Mean %Fat:", mean_fat, "\n")
cat("Median %Fat:", median_fat, "\n")
cat("Standard Deviation of %Fat:", sd_fat, "\n\n")

# (b) Draw Boxplots for Age and %Fat
par(mfrow = c(1, 2))  # Two plots side-by-side
boxplot(age, main = "Boxplot of Age", col = "skyblue", ylab = "Age")
boxplot(fat, main = "Boxplot of %Fat", col = "lightgreen", ylab = "%Fat")

# (c) Scatter plot and Q-Q plot
par(mfrow = c(1, 2))  # Two plots side-by-side again
plot(age, fat, main = "Scatter Plot: %Fat vs Age", xlab = "Age", ylab = "%Fat", pch = 19, col = "blue")
qqnorm(fat, main = "Q-Q Plot of %Fat")
qqline(fat, col = "red")
