# Remove useless column
df <- subset(df, select = -Unit)

# Rename columns
colnames(df)[1:9] <- c(
  "Record", "ResistanceType", "Year", "CountryCode", "Country",
  "Category", "Resistance", "Bacteria", "Antibiotic"
)

# Shorten bacteria names
original_bacteria <- c(
  "Escherichia coli", "Klebsiella pneumoniae", "Pseudomonas aeruginosa",
  "Streptococcus pneumoniae", "Staphylococcus aureus",
  "Enterococcus faecalis", "Enterococcus faecium"
)

short_bacteria <- c(
  "E. coli", "K. pneumoniae", "P. aeruginosa",
  "S. pneumoniae", "S. aureus", "E. faecalis", "E. faecium"
)

for (i in seq_along(original_bacteria)) {
  df$Bacteria[df$Bacteria == original_bacteria[i]] <- short_bacteria[i]
}

# Shorten antibiotic names
original_ab <- c(
  "Aminoglycosides", "Carbapenems",
  "Combined resistance (fluoroquinolones, aminoglycosides and carbapenems)",
  "Fluoroquinolones", "Aminopenicillins", "High-level gentamicin",
  "Vancomycin",
  "Combined resistance (third-generation cephalosporin, fluoroquinolones and aminoglycoside)",
  "Third-generation cephalosporins", "Ceftazidime",
  "Combined resistance (at least three of piperac. and tazob., fluoroq., ceftaz., aminogl. and carbapenems)",
  "PiperacillinTazobactam", "Meticillin (MRSA)", "Macrolides", "Penicillins"
)

short_ab <- c(
  "AG", "CAR", "XDR", "FQ", "AMP", "HGA", "VAN",
  "C3G/FQ/AG", "C3G", "CAZ", "TRIPLE", "PIP/TAZ",
  "MRSA", "MAC", "PEN"
)

for (i in seq_along(original_ab)) {
  df$Antibiotic[df$Antibiotic == original_ab[i]] <- short_ab[i]
}

# Round resistance values
df$Resistance <- round(df$Resistance, 2)

# Convert year to Date
df$Year <- as.Date(paste0(df$Year, "-01-01"))
