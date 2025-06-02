# List of persons
persons <- c("Gopu", "Babu", "Baby", "Gopal", "Krishna", "Jai", "Dev", "Malini", "Hema", "Anu")

# Corresponding vegetarian status (yes/no)
veg_status <- c("yes", "yes", "yes", "no", "yes", "no", "no", "yes", "yes", "yes")

# Convert to factor
veg_factor <- factor(veg_status, levels = c("yes", "no"))

# Count vegetarians and non-vegetarians
veg_count <- table(veg_factor)

# Display the counts
print(veg_count)

# Find which type is greater
if (veg_count["yes"] > veg_count["no"]) {
  cat("More people are vegetarian.\n")
} else if (veg_count["yes"] < veg_count["no"]) {
  cat("More people are non-vegetarian.\n")
} else {
  cat("Equal number of vegetarian and non-vegetarian people.\n")
}
