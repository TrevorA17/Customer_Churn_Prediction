# Load dataset
YourDataset <- read.csv("data/dataset.csv", colClasses = c(
  CustomerID = "character",
  Count = "numeric",
  Country = "character",
  State = "character",
  City = "character",
  `Zip Code` = "character",
  `Lat Long` = "character",
  Latitude = "numeric",
  Longitude = "numeric",
  Gender = "factor",
  `Senior Citizen` = "factor",
  Partner = "factor",
  Dependents = "factor",
  `Tenure Months` = "numeric",
  `Phone Service` = "factor",
  `Multiple Lines` = "factor",
  `Internet Service` = "factor",
  `Online Security` = "factor",
  `Online Backup` = "factor",
  `Device Protection` = "factor",
  `Tech Support` = "factor",
  `Streaming TV` = "factor",
  `Streaming Movies` = "factor",
  Contract = "factor",
  `Paperless Billing` = "factor",
  `Payment Method` = "factor",
  `Monthly Charges` = "numeric",
  `Total Charges` = "numeric",
  `Churn Label` = "factor",
  `Churn Value` = "numeric",
  `Churn Score` = "numeric",
  CLTV = "numeric",
  `Churn Reason` = "factor"
))

# Define levels for categorical columns if needed
# For example, if Gender has levels "Female" and "Male", you can define as follows:
gender_levels <- c("Female", "Male")
YourDataset$Gender <- factor(YourDataset$Gender, levels = gender_levels)

# Display the dataset
View(YourDataset)
