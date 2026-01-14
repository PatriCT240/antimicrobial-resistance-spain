# ---- Classification tree: antibiotic decision support ----------------------

# Build classification tree
tree_model <- rpart(
  Antibiotic ~ .,
  data = df_ES
)

predicted_ab <- predict(tree_model, df_ES, type = "class")

# Visual tree
fancyRpartPlot(tree_model)

# Accuracy
accuracy <- mean(predicted_ab == df_ES$Antibiotic)
accuracy

# Confusion matrix
conf_matrix <- table(
  Observed = df_ES$Antibiotic,
  Predicted = predicted_ab
)

# yardstick expects a tibble; we adapt manually for plotting
df_cm <- data.frame( truth = df_ES$Antibiotic, estimate = predicted_ab ) 

# Convert to factors (REQUIRED by yardstick) 
df_cm$truth <- as.factor(df_cm$truth) 
df_cm$estimate <- as.factor(df_cm$estimate)

conf_mat_obj <- yardstick::conf_mat( 
  df_cm, 
  truth = truth, 
  estimate = estimate 
  ) 
autoplot(conf_mat_obj, type = "heatmap") + 
  scale_fill_gradient(low = "#C2DAE8", high = "#003C50")