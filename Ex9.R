# Define the age data
age <- c(13, 15, 16, 16, 19, 20, 20, 21, 22, 22,
         25, 25, 25, 25, 30, 33, 33, 35, 35, 35,
         35, 36, 40, 45, 46, 52, 70)

# Sort the data just to verify (optional)
age <- sort(age)

# Print the data
cat("Sorted Age Data:\n")
print(age)

# Calculate Q1 and Q3
Q1 <- quantile(age, 0.25)
Q3 <- quantile(age, 0.75)

# Display the results
cat("\nFirst Quartile (Q1):", Q1, "\n")
cat("Third Quartile (Q3):", Q3, "\n")
