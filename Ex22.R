# Player scores
points <- c(15, 18, 20, 22, 25, 27, 30, 35, 38, 40, 45, 85)

# Create boxplot
boxplot(points,
        main = "Boxplot of Points Scored by Tennis Players",
        ylab = "Points Scored",
        col = "lightblue",
        border = "darkblue",
        notch = TRUE)

# Add grid lines
grid()
