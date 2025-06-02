# Define the data
x <- c(4, 1, 5, 7, 10, 2, 50, 25, 90, 36)  # Mobile phones sold
y <- c(12, 5, 13, 19, 31, 7, 153, 72, 275, 110)  # Money earned

# Create scatter plot
plot(x, y,
     main = "Scatter Plot: Mobile Phones Sold vs Money Earned",
     xlab = "Mobile Phones Sold",
     ylab = "Money Earned",
     pch = 19,             # Solid circle for points
     col = "blue")         # Point color
