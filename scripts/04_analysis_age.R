# ---- Age-specific resistance analysis ----

# Boxplots: resistance by age group and bacteria -----------------------------

title_age <- grid::textGrob(
  label = "% resistance by age group and bacteria",
  gp = grid::gpar(fontsize = 15, fontface = "bold")
)

bacteria_list <- as.list(unique(df_ES$Bacteria))

y_min <- 0
y_max <- 100

plots_bacteria_age <- lapply(bacteria_list, function(bac) {
  ggplot(df_age_ES[df_age_ES$Bacteria == bac, ],
         aes(x = Category, y = Resistance)) +
    geom_boxplot(
      fill = "#65b32e",
      colour = "#0c4828",
      alpha = 0.5,
      outlier.shape = NA
    ) +
    coord_cartesian(ylim = c(y_min, y_max)) +
    ggtitle(bac) +
    labs(x = "Age group", y = "% resistance")
})

grid.arrange(
  arrangeGrob(grobs = plots_bacteria_age, ncol = 4),
  top = title_age
)

# ---- Multifactor ANOVA: age model ------------------------------------------

anova_age <- aov(
  Resistance ~ Category * Bacteria * Antibiotic * Year,
  data = df_age_ES
)

anova_age_summary <- summary(anova_age)

# Extract p-value of the first term (for reporting)
p_value_age <- anova_age_summary[[1]]$"Pr(>F)"[1]
p_value_age_formatted <- format(p_value_age, digits = 3, scientific = TRUE)
p_value_age_formatted
anova_age_summary

# ---- Median resistance table by age group and bacteria ---------------------

res_age_table <- dcast(
  df_age_ES,
  Bacteria ~ Category,
  value.var = "Resistance",
  fun.aggregate = median
)

colnames(res_age_table) <- c("Bacteria", "G1_0_4", "G2_5_18", "G3_19_64", "G4_65plus")

df_res_age <- as.data.frame(res_age_table)

df_res_age[, 2:5] <- round(df_res_age[, 2:5], 2)

formattable(
  df_res_age,
  align = c("l", rep("c", NCOL(df_res_age) - 1)),
  list(
    "Bacteria" = formatter(
      "span",
      style = ~ style(color = "#7cbdc4", font.weight = "bold")
    ),
    area(col = 2:5) ~ color_tile("#c2dae8", "#1a6b85")
  )
)

# ---- PCA: age groups vs bacteria -------------------------------------------

numeric_age <- df_res_age[, c("G1_0_4", "G2_5_18", "G3_19_64", "G4_65plus")]
rownames(numeric_age) <- df_res_age$Bacteria

pca_age <- PCA(numeric_age, graph = FALSE)
summary(pca_age)

# PCA plot: bacteria
pca_age$ind$lab <- rownames(df_res_age)

fviz_pca_ind(
  pca_age,
  col.ind = "cos2",
  gradient.cols = c("#c2dae8", "#e9b855", "#c34a17"),
  title = "PCA of bacteria (age-specific resistance