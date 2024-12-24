#54 lines of code
#this code filters the raw data from the stroop task, keeping only what's relevant to our analysis
#written by Tamari Geron, December 24th 2024

### SCRIPT 2 - FILTERED DATA ###

#Cleaning the workspace
rm(list = ls())

#Loading data file
load(".//raw_data.rdata")


#Subjects
cat("Number of unique subjects:", length(unique(df$subject)))

#Data frame before removal
df_before <- data.frame(df)

#Removing NA
df <- df %>%
  filter(!is.na(rt))

#Removing outliers
df <- df %>%
  filter(rt >= 300 & rt <= 3000)

#Remaining trials percentage
df %>%  
  group_by(subject) %>%  
  summarise(percentage = 1 - (n() / 400)) %>%   
  print(n = Inf)

#Trial mean and sd
total_steps_before <- nrow(df_before)
total_steps_after <- nrow(df)
percent_removed <- ((total_steps_before - total_steps_after) / total_steps_before) * 100

summary_stats <- df_before %>%
  group_by(subject) %>%  
  summarise(
    steps_before = n(),                             
    steps_after = sum(!is.na(rt) & rt >= 300 & rt <= 3000), 
    percent_removed = ((steps_before - steps_after) / steps_before) * 100  
  ) %>%
  summarise(
    mean_percent_removed = mean(percent_removed, na.rm = TRUE),  
    sd_percent_removed = sd(percent_removed, na.rm = TRUE)     
  )

summary_stats

#Save file
save(df, file = ".//filtered_data.rdata")