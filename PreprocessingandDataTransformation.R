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

# Missing Values

# Check for missing values in the dataset
missing_values <- colSums(is.na(churn_data))

# Display columns with missing values
cols_with_missing <- names(missing_values[missing_values > 0])
print(cols_with_missing)

# Summarize the count of missing values for each column
print(missing_values)

# Perform mean imputation for each column with missing values
for (col in cols_with_missing) {
  mean_value <- mean(churn_data[[col]], na.rm = TRUE)  # Compute mean of the column
  churn_data[[col]][is.na(churn_data[[col]])] <- mean_value  # Replace missing values with mean
}

# Verify that missing values have been imputed
missing_values_after_imputation <- colSums(is.na(churn_data))
print(missing_values_after_imputation)
