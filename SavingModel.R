# Saving the neural network model
saveRDS(model_neural, "./models/saved_neural_model.rds")

# Load the saved model
loaded_neural_model <- readRDS("./models/saved_neural_model.rds")

# Prepare new data for prediction (using churn dataset variables)
new_data <- data.frame(
  Tenure_Months = 10,
  Monthly_Charges = 50,
  Total_Charges = 500,
  Contract = "Month-to-month",
  Paperless_Billing = "Yes",
  Payment_Method = "Electronic check",
  Senior_Citizen = "No",
  Dependents = "Yes",
  Partner = "Yes",
  Gender = "Female",
  Internet_Service = "Fiber optic",
  Online_Security = "Yes",
  Tech_Support = "Yes"
)

# Use the loaded model to make predictions
predictions_loaded_model <- predict(loaded_neural_model, newdata = new_data)

# Print predictions
print(predictions_loaded_model)

