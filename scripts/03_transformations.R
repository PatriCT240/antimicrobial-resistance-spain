df_age <- subset(df, ResistanceType == "R - resistant isolates proportion, by age")
df_gender <- subset(df, ResistanceType == "R - resistant isolates proportion, by gender")

df_age$Category <- factor(df_age$Category, levels = c("0-4", "5-18", "19-64", "65+"))
df_gender$Category <- ifelse(df_gender$Category == "Male", "Male",
                             ifelse(df_gender$Category == "Female", "Female", df_gender$Category))

df_ES <- subset(df, Country == "Spain", select = -c(CountryCode, Country))
df_age_ES <- subset(df_age, Country == "Spain", select = -c(CountryCode, Country))
df_gender_ES <- subset(df_gender, Country == "Spain", select = -c(CountryCode, Country))
