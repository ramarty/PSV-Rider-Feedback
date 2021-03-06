# PSV Rider Feedback

read.csv_filename <- function(filepath){
  df <- read.csv(filepath,
                 stringsAsFactors=F)
  
  for(var in names(df)){
    df[[paste0(var, "_asked")]] <- "yes"
  } 
  
  df$file <- filepath
  return(df)
}

# Read Data --------------------------------------------------------------------
data <- file.path(onedrive_file_path, "Data", "Rider Feedback", "Echo Mobile Data", "RawData - PII") %>%
  list.files(pattern = "*.csv", full.names = T) %>%
  lapply(read.csv_filename) %>%
  bind_rows()

# Prep Variables ---------------------------------------------------------------

#### Hash Phone Number
data$phone_hash <- data$phone %>% as.character() %>% md5()
data$phone <- NULL

# Export -----------------------------------------------------------------------
write.csv(data, file.path(dropbox_file_path, "Data", "Rider Feedback", "Echo Mobile Data", "RawData", 
                          "echo_data.csv"), row.names = F)
saveRDS(data, file.path(dropbox_file_path, "Data", "Rider Feedback", "Echo Mobile Data", "RawData", 
                          "echo_data.Rds"))


