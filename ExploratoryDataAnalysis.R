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

#Measures of Frequency
# Load dataset (assuming it's already loaded as churn_data)

# Define categorical variables
categorical_vars <- c("Count", "Country", "State", "City", "Zip_Code", 
                      "Gender", "Senior_Citizen", "Partner", "Dependents",
                      "Phone_Service", "Multiple_Lines", "Internet_Service",
                      "Online_Security", "Online_Backup", "Device_Protection",
                      "Tech_Support", "Streaming_TV", "Streaming_Movies",
                      "Contract", "Paperless_Billing", "Payment_Method",
                      "Churn_Label", "Churn_Reason")

# Generate measures of frequency for each categorical variable
for (var in categorical_vars) {
  cat(paste("Frequency table for variable:", var, "\n"))
  print(table(churn_data[[var]]))
  cat("\n")
}

# Measures of central tendency
# Define numerical variables
numerical_vars <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", 
                    "Churn_Value", "Churn_Score", "CLTV")

# Generate measures of central tendency for each numerical variable
for (var in numerical_vars) {
  cat(paste("Measures of central tendency for variable:", var, "\n"))
  print(summary(churn_data[[var]]))
  cat("\n")
}

#Measures of Distribution

# Load required package
library(e1071)

# Define numerical variables
numerical_vars <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", 
                    "Churn_Value", "Churn_Score", "CLTV")

# Generate measures of distribution for each numerical variable
for (var in numerical_vars) {
  cat(paste("Measures of distribution for variable:", var, "\n"))
  cat("Skewness:", skewness(churn_data[[var]]), "\n")
  cat("Kurtosis:", kurtosis(churn_data[[var]]), "\n")
  cat("\n")
}

# Measures of Relationship

# Load required package
library(MASS)  # For the chi-square test

# Define variables
numerical_vars <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", 
                    "Churn_Value", "Churn_Score", "CLTV")

categorical_vars <- c("Count", "Country", "State", "City", "Zip_Code", 
                      "Gender", "Senior_Citizen", "Partner", "Dependents",
                      "Phone_Service", "Multiple_Lines", "Internet_Service",
                      "Online_Security", "Online_Backup", "Device_Protection",
                      "Tech_Support", "Streaming_TV", "Streaming_Movies",
                      "Contract", "Paperless_Billing", "Payment_Method",
                      "Churn_Label", "Churn_Reason")

# Compute measures of relationship for numerical variables (correlation)
cat("Correlation coefficients for numerical variables:\n")
correlation_matrix <- cor(churn_data[, numerical_vars])
print(correlation_matrix)

# Compute measures of relationship for categorical variables (chi-square test)
for (var in categorical_vars) {
  cat(paste("Chi-square test for variable:", var, "\n"))
  cross_tab <- table(churn_data[[var]], churn_data$Churn_Label)
  chi_square_test <- chisq.test(cross_tab)
  print(chi_square_test)
  cat("\n")
}

# ANOVA
# Define the categorical variable (factor)
categorical_var <- "Contract"  

# Define the numerical variable (response)
numerical_var <- "Monthly_Charges"  

# Perform ANOVA
anova_result <- aov(churn_data[[numerical_var]] ~ churn_data[[categorical_var]])

# Summarize ANOVA results
summary(anova_result)

#Univariate Plots

# Load required packages
library(ggplot2)  # For creating plots

# Define numerical and categorical variables
numerical_vars <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", 
                    "Churn_Value", "Churn_Score", "CLTV")

categorical_vars <- c("Count", "Country", "State", "City", "Zip_Code", 
                      "Gender", "Senior_Citizen", "Partner", "Dependents",
                      "Phone_Service", "Multiple_Lines", "Internet_Service",
                      "Online_Security", "Online_Backup", "Device_Protection",
                      "Tech_Support", "Streaming_TV", "Streaming_Movies",
                      "Contract", "Paperless_Billing", "Payment_Method",
                      "Churn_Label", "Churn_Reason")

# Create univariate plots for numerical variables (histograms)
for (var in numerical_vars) {
  ggplot(churn_data, aes(x = !!as.name(var))) +
    geom_histogram(fill = "skyblue", color = "black", bins = 30) +
    labs(title = paste("Histogram of", var),
         x = var, y = "Frequency") +
    theme_minimal()
  ggsave(paste("histogram_", var, ".png", sep = ""), width = 6, height = 4, dpi = 300)
}

# Create univariate plots for categorical variables (bar plots)
for (var in categorical_vars) {
  ggplot(churn_data, aes(x = !!as.name(var))) +
    geom_bar(fill = "skyblue", color = "black") +
    labs(title = paste("Bar plot of", var),
         x = var, y = "Count") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  ggsave(paste("barplot_", var, ".png", sep = ""), width = 6, height = 4, dpi = 300)
}

