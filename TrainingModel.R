# Load dataset
churn_data <- read.csv("data/Telco_customer_churn.csv", colClasses = c(
  CustomerID = "character",
  Count = "factor",
  Country = "factor",
  State = "factor",
  City = "factor",
  Zip_Code = "factor",
  Lat_Long = "character",
  Latitude = "numeric",
  Longitude = "numeric",
  Gender = "factor",
  Senior_Citizen = "factor",
  Partner = "factor",
  Dependents = "factor",
  Tenure_Months = "numeric",
  Phone_Service = "factor",
  Multiple_Lines = "factor",
  Internet_Service = "factor",
  Online_Security = "factor",
  Online_Backup = "factor",
  Device_Protection = "factor",
  Tech_Support = "factor",
  Streaming_TV = "factor",
  Streaming_Movies = "factor",
  Contract = "factor",
  Paperless_Billing = "factor",
  Payment_Method = "factor",
  Monthly_Charges = "numeric",
  Total_Charges = "numeric",
  Churn_Label = "factor",
  Churn_Value = "numeric",
  Churn_Score = "numeric",
  CLTV = "numeric",
  Churn_Reason = "factor"
))

# Display the structure of the dataset
str(churn_data)

# View the first few rows of the dataset
head(churn_data)

View(churn_data)

# Load required package
library(caret)  # For data splitting

# Set seed for reproducibility
set.seed(123)

# Specify the proportion of data for training (e.g., 80%)
train_proportion <- 0.8

# Split the dataset into training and testing sets
train_indices <- createDataPartition(churn_data$Churn_Label, p = train_proportion, list = FALSE)
train_data <- churn_data[train_indices, ]
test_data <- churn_data[-train_indices, ]

# Display the dimensions of the training and testing sets
cat("Training set size:", nrow(train_data), "\n")
cat("Testing set size:", nrow(test_data), "\n")

# Load required package
library(boot)  # For bootstrapping

# Define your statistic of interest (mean)
mean_function <- function(data, indices) {
  sample <- data[indices, "Tenure_Months"]
  return(mean(sample))
}

# Set the number of bootstrap iterations
num_iterations <- 1000

# Perform bootstrapping
bootstrap_results <- boot(data = churn_data, statistic = mean_function, R = num_iterations)

# Summarize bootstrap results
print(bootstrap_results)

#Cross- Validation

# Select subset of columns (adjust as needed)
selected_columns <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", "Gender", "Senior_Citizen", "Churn_Label")

# Subset the dataset based on selected columns
churn_data_subset <- churn_data[, selected_columns]

#Basic Cross-Validation
# Load required package
library(caret)

# Define control parameters for cross-validation
ctrl <- trainControl(method = "cv", number = 5)

# Specify the method as "svmRadial" for SVM
model <- train(Churn_Label ~ ., data = churn_data_subset, method = "svmRadial", trControl = ctrl)

# Print the model results
print(model)


#Repeated Cross-Validation
# Set the number of folds and repetitions
num_folds <- 5  
num_repeats <- 3  

# Define the control parameters for repeated cross-validation
ctrl_repeated <- trainControl(method = "repeatedcv", number = num_folds, repeats = num_repeats)

# Train the model using repeated k-fold cross-validation
model_repeated <- train(Churn_Label ~ ., data = churn_data_subset, method = "svmRadial", trControl = ctrl_repeated)

# Print the model results
print(model_repeated)

#LOOCV
# Define the control parameters for LOOCV
ctrl_loocv <- trainControl(method = "LOOCV")

# Train the model using LOOCV
model_loocv <- train(Churn_Label ~ ., data = churn_data_subset, method = "svmRadial", trControl = ctrl_loocv)

# Print the model results
print(model_loocv)

# Define control parameters for cross-validation
ctrl <- trainControl(method = "cv", number = 5)

# Train the logistic regression model
model_logistic <- train(Churn_Label ~ ., data = churn_data_subset, method = "glm", trControl = ctrl, family = "binomial")

# Print the model results
print(model_logistic)


