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
