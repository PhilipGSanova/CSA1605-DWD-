# Load required packages
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)

# Load the dataset
diabetes <- read.csv("diabetes.csv")

# Preview the data
cat("Summary of Dataset:\n")
summary(diabetes)

# Check if required columns exist
if (!("Age" %in% names(diabetes)) | !("BloodPressure" %in% names(diabetes))) {
  stop("The dataset must contain 'Age' and 'BloodPressure' columns.")
}

# Create Age Groups (modify bins as needed)
diabetes$AgeGroup <- cut(diabetes$Age,
                         breaks = c(20, 30, 40, 50, 60, 70, 100),
                         labels = c("21–30", "31–40", "41–50", "51–60", "61–70", "71+"),
                         right = FALSE)

# (1) Scatter Plot: Blood Pressure vs Age
ggplot(diabetes, aes(x = Age, y = BloodPressure)) +
  geom_point(color = "darkblue", alpha = 0.6) +
  labs(title = "Scatterplot of Blood Pressure vs Age",
       x = "Age",
       y = "Blood Pressure") +
  theme_minimal()

# (2) Bar Chart: Average Blood Pressure per Age Group
library(dplyr)
avg_bp_by_agegroup <- diabetes %>%
  group_by(AgeGroup) %>%
  summarise(AverageBP = mean(BloodPressure, na.rm = TRUE))

ggplot(avg_bp_by_agegroup, aes(x = AgeGroup, y = AverageBP, fill = AgeGroup)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Blood Pressure by Age Group",
       x = "Age Group",
       y = "Average Blood Pressure") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")
