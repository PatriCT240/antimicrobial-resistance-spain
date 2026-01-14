# ---- Time trends in resistance ---------------------------------------------

# Mean resistance by antibiotic and year
resistance_mean <- df_ES %>%
  group_by(Antibiotic, Year) %>%
  summarise(
    mean_resistance = mean(Resistance),
    .groups = "drop"
  )

palette_time <- c(
  "#0B490A", "#65b32e", "#C7C7C7", "#70E6B8", "#C0D236",
  "#3E5B84", "#008C75", "#82428D", "#F1D676", "#E8683F",
  "#DC9635", "#B81A5D", "#7C170F", "#717171", "#003C50"
)

ggplot(
  resistance_mean,
  aes(x = Year, y = mean_resistance, color = Antibiotic)
) +
  geom_line() +
  scale_color_manual(values = palette_time) +
  labs(
    title = "Evolution of antibiotic resistance in Spain",
    x = "Year",
    y = "% resistance (mean)",
    color = "Antibiotic group"
  ) +
  theme_minimal()

# ---- Split antibiotics: beta-lactam related vs non beta-lactam -------------

df_ES <- df_ES %>%
  mutate(
    Group = case_when(
      Antibiotic %in% c("AMP", "CAZ", "PIP/TAZ", "C3G", "CAR", "HGA", "PEN") ~ "Beta_lactam_related",
      Antibiotic %in% c("TRIPLE", "XDR", "AG", "FQ", "C3G/FQ/AG", "MAC", "VAN", "MRSA") ~ "Non_beta_lactam"
    )
  )

# ---- Beta-lactam related antibiotics ---------------------------------------

df_beta <- subset(df_ES, Group == "Beta_lactam_related")

resistance_mean_beta <- df_beta %>%
  group_by(Antibiotic, Year) %>%
  summarise(
    mean_resistance = mean(Resistance),
    .groups = "drop"
  )

ggplot(
  resistance_mean_beta,
  aes(x = Year, y = mean_resistance, color = Antibiotic)
) +
  geom_line() +
  scale_color_manual(values = palette_time) +
  labs(
    title = "Resistance trends of beta-lactam–related antibiotics in Spain",
    x = "Year",
    y = "% resistance (mean)",
    color = "Antibiotic group"
  ) +
  theme_minimal()

# ---- Non beta-lactam antibiotics -------------------------------------------

df_nonbeta <- subset(df_ES, Group == "Non_beta_lactam")

resistance_mean_nonbeta <- df_nonbeta %>%
  group_by(Antibiotic, Year) %>%
  summarise(
    mean_resistance = mean(Resistance),
    .groups = "drop"
  )

ggplot(
  resistance_mean_nonbeta,
  aes(x = Year, y = mean_resistance, color = Antibiotic)
) +
  geom_line() +
  scale_color_manual(values = palette_time) +
  labs(
    title = "Resistance trends of non beta-lactam antibiotics in Spain",
    x = "Year",
    y = "% resistance (mean)",
    color = "Antibiotic group"
  ) +
  theme_minimal()

# ---- Time series + ARIMA forecasting (overall resistance) ------------------

# Order by Year
df_ordered <- arrange(df_ES, Year)

df_ordered$Year_char <- as.character(df_ordered$Year)

ts_series <- ts(
  df_ordered$Resistance,
  frequency = 6,
  start = c(lubridate::year(df_ordered$Year[1]),
            lubridate::month(df_ordered$Year[1]))
)

ts_series <- window(ts_series, start = c(2000, 1), end = c(2018, 12))
ts_series <- aggregate(ts_series, FUN = mean)
ts_series <- na.fill(ts_series, "extend")
ts_series <- ts(
  ts_series,
  frequency = 6,
  start = c(2000, 1),
  end = c(2018, 12)
)

plot(
  ts_series,
  xlab = "Year",
  ylab = "% resistance",
  xlim = c(2000, 2018),
  main = "Time series of antimicrobial resistance in Spain"
)

# ARIMA model
arima_auto <- auto.arima(df_ES$Resistance)
summary(arima_auto)

arima_model <- arima(ts_series, order = c(5, 1, 3))
arima_model

forecast_res <- forecast(arima_model, h = 10)

plot(
  forecast_res,
  xlab = "Year",
  main = "Forecast of antimicrobial resistance in Spain",
  sub = "Forecast using ARIMA(5,1,3)"
)
