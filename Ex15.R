# Load necessary libraries
library(ggplot2)
library(caret)

# Load the dataset (simulate or replace with actual file)
# Replace with your actual path
data <- read.csv("ad_clicks.csv")

# View the structure of the dataset
str(data)

# Convert 'Clicked' to factor for classification
data$Clicked <- as.factor(data$Clicked)

# Split data into training and testing
set.seed(123)
trainIndex <- createDataPartition(data$Clicked, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

# Train a logistic regression model
model <- glm(Clicked ~ User_Age + Ad_Position + Time_Spent, data = trainData, family = binomial)

# Summary of the model
summary(model)

# Predict on test set
pred_probs <- predict(model, testData, type = "response")
pred_class <- ifelse(pred_probs > 0.5, "1", "0")
pred_class <- as.factor(pred_class)

# Confusion matrix
confusionMatrix(pred_class, testData$Clicked)

# Plotting ROC Curve
library(pROC)
roc_obj <- roc(testData$Clicked, as.numeric(pred_probs))
plot(roc_obj, col = "blue", main = "ROC Curve")
auc(roc_obj)
