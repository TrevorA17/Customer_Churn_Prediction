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