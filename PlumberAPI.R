# Load the saved neural network model
loaded_neural_model <- readRDS("./models/saved_neural_model.rds")

#* @apiTitle Churn Prediction Model API
#* @apiDescription Used to predict customer churn.

#* @param Tenure_Months Number of months the customer has stayed with the company
#* @param Monthly_Charges Monthly charges for the customer
#* @param Total_Charges Total charges for the customer
#* @param Contract Type of contract (e.g., "Month-to-month", "One year", "Two year")
#* @param Paperless_Billing Whether the customer has opted for paperless billing (Yes/No)
#* @param Payment_Method Payment method used by the customer
#* @param Senior_Citizen Whether the customer is a senior citizen (Yes/No)
#* @param Dependents Whether the customer has dependents (Yes/No)
#* @param Partner Whether the customer has a partner (Yes/No)
#* @param Gender Gender of the customer (Male/Female)
#* @param Internet_Service Type of internet service subscribed by the customer
#* @param Online_Security Whether the customer has online security service (Yes/No)
#* @param Tech_Support Whether the customer has tech support service (Yes/No)
#* @param Churn_Label Actual churn status (Yes/No)

#* @get /churn_prediction

predict_churn <- function(Tenure_Months, Monthly_Charges, Total_Charges, Contract,
                          Paperless_Billing, Payment_Method, Senior_Citizen,
                          Dependents, Partner, Gender, Internet_Service,
                          Online_Security, Tech_Support, Churn_Label) {
  
  # Create a data frame using the arguments
  to_be_predicted <- data.frame(
    Tenure_Months = as.numeric(Tenure_Months),
    Monthly_Charges = as.numeric(Monthly_Charges),
    Total_Charges = as.numeric(Total_Charges),
    Contract = as.character(Contract),
    Paperless_Billing = as.character(Paperless_Billing),
    Payment_Method = as.character(Payment_Method),
    Senior_Citizen = as.character(Senior_Citizen),
    Dependents = as.character(Dependents),
    Partner = as.character(Partner),
    Gender = as.character(Gender),
    Internet_Service = as.character(Internet_Service),
    Online_Security = as.character(Online_Security),
    Tech_Support = as.character(Tech_Support)
  )
  
  # Use the loaded model to make predictions
  prediction <- predict(loaded_neural_model, newdata = to_be_predicted)
  
  # Return the prediction
  return(prediction)
}

