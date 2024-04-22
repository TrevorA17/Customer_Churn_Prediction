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
# Define the search grid for logistic regression
grid <- expand.grid(
  penalty = c(0.01, 0.1, 1, 10),  # Regularization penalty
  threshold = c(0.3, 0.5, 0.7)     # Decision threshold
)

# Perform random search for hyper-parameter tuning
set.seed(123)  # Set seed for reproducibility
model_random <- train(
  Churn_Label ~ ., 
  data = churn_data_subset, 
  method = "glm", 
  trControl = ctrl, 
  tuneGrid = grid,
  tuneLength = 10  # Number of random parameter sets to evaluate
)

# Print the model results
print(model_random)

# Define the search grid for logistic regression
grid <- expand.grid(
  penalty = c(0.01, 0.1, 1, 10),  # Regularization penalty
  threshold = c(0.3, 0.5, 0.7)     # Decision threshold
)

# Rename columns to 'parameter' as required by train()
colnames(grid) <- c("parameter")

# Perform grid search for hyper-parameter tuning
model_grid <- train(
  Churn_Label ~ ., 
  data = churn_data_subset, 
  method = "glm", 
  trControl = ctrl, 
  tuneGrid = grid,
)

# Print the model results
print(model_grid)




