# Load required packages
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
library(ggplot2)
library(dplyr)

# Load the dataset
diabetes <- read.csv("diabetes.csv")

# View structure and summary
str(diabetes)
summary(diabetes)

# Ensure Outcome is a factor for classification analysis (optional)
diabetes$Outcome <- as.factor(diabetes$Outcome)

# -----------------------------
# 1. Simple Linear Regression
# -----------------------------
# We'll convert Outcome to numeric for regression interpretation (1 = diabetic)
diabetes$OutcomeNum <- as.numeric(as.character(diabetes$Outcome))

model1 <- lm(OutcomeNum ~ Age, data = diabetes)
summary(model1)

# Plot with regression line
ggplot(diabetes, aes(x = Age, y = OutcomeNum)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Simple Linear Regression: Diabetes vs Age",
       x = "Age",
       y = "Diabetes Outcome (0=No, 1=Yes)") +
  theme_minimal()

# -----------------------------
# 2. Multiple Linear Regression
# -----------------------------
model2 <- lm(OutcomeNum ~ Age + BMI + BloodPressure + Glucose + Insulin +
               SkinThickness + Pregnancies, data = diabetes)

summary(model2)

# -----------------------------
# Optional: Compare predictions
# -----------------------------
# Predict using model2
diabetes$PredictedOutcome <- predict(model2, newdata = diabetes)

# View predictions for first 10 rows
head(diabetes[, c("Age", "OutcomeNum", "PredictedOutcome")], 10)
