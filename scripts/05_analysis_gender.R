# ---- Gender-specific resistance analysis -----------------------------------

# Boxplots: resistance by gender and bacteria --------------------------------

title_gender <- grid::textGrob(
  label = "% resistance by gender and bacteria",
  gp = grid::gpar(fontsize = 15, fontface = "bold")
)

y_min <- 0
y_max <- 100

plots_bacteria_gender <- lapply(bacteria_list, function(bac) {
  ggplot(df_gender_ES[df_gender_ES$Bacteria == bac, ],
         aes(x = Category, y = Resistance)) +
    geom_boxplot(
      fill = "#65b32e",
      colour = "#0c4828",
      alpha = 0.5,
      outlier.shape = NA
    ) +
    coord_cartesian(ylim = c(y_min, y_max)) +
    ggtitle(bac) +
    labs(x = "Gender", y = "% resistance")
})

grid.arrange(
  grobs = plots_bacteria_gender,
  ncol = 4,
  top = title_gender
)

# ---- Multifactor ANOVA: gender model ---------------------------------------

anova_gender <- aov(
  Resistance ~ Category * Bacteria * Antibiotic * Year,
  data = df_gender_ES
)

anova_gender_summary <- summary(anova_gender)

p_value_gender <- anova_gender_summary[[1]]$"Pr(>F)"[1]
p_value_gender_formatted <- format(p_value_gender, digits = 3, scientific = TRUE)
p_value_gender_formatted
anova_gender_summary

# ---- Median resistance by gender and bacteria ------------------------------

res_gender_table <- dcast(
  df_gender_ES,
  Bacteria ~ Category,
  value.var = "Resistance",
  fun.aggregate = median
)

df_res_gender <- as.data.frame(res_gender_table)

df_res_gender[, 2:3] <- round(df_res_gender[, 2:3], 2)

formattable(
  df_res_gender,
  align = c("l", rep("c", NCOL(df_res_gender) - 1)),
  list(
    "Bacteria" = formatter(
      "span",
      style = ~ style(color = "#7cbdc4", font.weight = "bold")
    ),
    area(col = 2:3) ~ color_tile("#c2dae8", "#1a6b85")
  )
)

# ---- Correlation between male and female resistance ------------------------

cor_gender <- cor(df_res_gender[, c("Male", "Female")], method = "pearson")
cor_gender

# ---- Difference in resistance between males and females --------------------

df_res_gender$diff_male_female <- df_res_gender$Male - df_res_gender$Female

ggplot(
  df_res_gender,
  aes(x = Bacteria, y = diff_male_female, fill = diff_male_female > 0)
) +
  geom_bar(stat = "identity") +
  scale_fill_manual(
    values = c("#7cbdc4", "#65b32e"),
    labels = c("Higher in females", "Higher in males")
  ) +
  labs(y = "% males - % females") +
  ggtitle("Difference in resistance by gender and bacteria") +
  geom_text(
    aes(label = round(diff_male_female, 2)),
    vjust = -0.5,
    size = 3
  ) +
  theme_classic() +
  theme(
    axis.text.x = element_text(
      angle = 90,
      hjust = 1,
      vjust = 0.5
    )
  )
