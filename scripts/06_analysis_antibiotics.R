# ---- Resistance by bacteria and antibiotic groups --------------------------

res_bac_ab_table <- dcast(
  df_ES,
  Bacteria ~ Antibiotic,
  value.var = "Resistance",
  fun.aggregate = median
)

# Replace NAs with empty strings for display
res_bac_ab_table[is.na(res_bac_ab_table)] <- ""

df_res_bac_ab <- as.data.frame(res_bac_ab_table)

# Convert numeric columns
df_res_bac_ab[, 2:ncol(df_res_bac_ab)] <-
  apply(df_res_bac_ab[, 2:ncol(df_res_bac_ab)], 2, as.numeric)

df_res_bac_ab[, 2:ncol(df_res_bac_ab)] <-
  round(df_res_bac_ab[, 2:ncol(df_res_bac_ab)], 2)

df_res_bac_ab[is.na(df_res_bac_ab)] <- ""

formattable(
  df_res_bac_ab,
  align = c("l", rep("c", NCOL(df_res_bac_ab) - 1)),
  list(
    "Bacteria" = formatter(
      "span",
      style = ~ style(color = "#27408B", font.weight = "bold")
    )
  )
)

# ---- Visualisation: resistance > 10% ---------------------------------------

df_long_ab <- gather(
  df_res_bac_ab,
  key = "Antibiotic",
  value = "Resistance",
  -Bacteria
)

df_long_ab$Resistance <- round(as.numeric(df_long_ab$Resistance), 1)

palette_ab <- c(
  "#0B490A", "#65b32e", "#70E6B8", "#C0D236", "#3E5B84",
  "#008C75", "#82428D", "#E8683F", "#B81A5D", "#7C170F"
)

df_filtered_ab <- df_long_ab %>%
  filter(Resistance > 10.0)

ggplot(
  df_filtered_ab,
  aes(x = Resistance, y = Bacteria, fill = Antibiotic)
) +
  geom_col() +
  scale_fill_manual(values = palette_ab) +
  labs(
    x = "% resistance",
    y = "Bacteria",
    fill = "Antibiotic group"
  ) +
  scale_y_discrete(labels = df_long_ab$Bacteria) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  )
