raw_path <- file.path(PROJECT_ROOT, "data", "raw", "ecdc.csv")
df <- readr::read_csv(raw_path)