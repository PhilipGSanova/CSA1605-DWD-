# Class A and Class B scores
classA <- c(76, 35, 47, 64, 95, 66, 89, 36, 84)
classB <- c(51, 56, 84, 60, 59, 70, 63, 66, 50)

# (i) Mean, Median, Range
mean_A <- mean(classA)
median_A <- median(classA)
range_A <- range(classA)
range_A_val <- diff(range_A)

mean_B <- mean(classB)
median_B <- median(classB)
range_B <- range(classB)
range_B_val <- diff(range_B)

# Print results
cat("Class A:\n")
cat("Mean:", mean_A, "\n")
cat("Median:", median_A, "\n")
cat("Range:", range_A_val, "\n\n")

cat("Class B:\n")
cat("Mean:", mean_B, "\n")
cat("Median:", median_B, "\n")
cat("Range:", range_B_val, "\n\n")

# (ii) Boxplot
boxplot(classA, classB,
        names = c("Class A", "Class B"),
        col = c("lightblue", "lightgreen"),
        main = "Boxplot of Exam Scores: Class A vs Class B",
        ylab = "Score")

# Inference
if (mean_A > mean_B) cat("Class A has higher mean.\n") else cat("Class B has higher mean.\n")
if (median_A > median_B) cat("Class A has higher median.\n") else cat("Class B has higher median.\n")
if (range_A_val > range_B_val) cat("Class A has a wider range of scores.\n") else cat("Class B has a wider range of scores.\n")
