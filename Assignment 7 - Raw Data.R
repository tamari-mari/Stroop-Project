# R course for beginners
# Week 7
# assignment by Tamari Geron, id 314833195

#71 lines of code
#this code handles and organizes the raw data from the stroop task
#written by Tamari Geron, December 24th 2024

### SCRIPT 1 - RAW DATA ###


### CREATE DATAFRAME ###

#File upload
folder_path <- "C:\\Users\\tamar\\Documents\\University\\Psychology 2\\R\\stroop_data"
file_list <- dir(folder_path, pattern = "\\.csv$", full.names = TRUE)
df <- data.frame()
for (file in file_list) {
  temp_data <- read.csv(file, stringsAsFactors = FALSE)
  df <- rbind(df, temp_data)
}

head(df)

#Task & congruence
df <- df %>%
  mutate(
    task       = ifelse(grepl("ink_naming", condition), "ink_naming", "word_reading"),
    congruency = ifelse(grepl("incong", condition), "congruent", "incongruent"),
    acc        = ifelse(participant_response == correct_response, 1, 0)
  ) 

#Accuracy
df <- df %>%
  mutate(
    accuracy = ifelse(participant_response == correct_response, 1, 0)
  )

#Variable check
df <- df %>%
  select(
    subject,     
    task,         
    congruency,  
    block,        
    trial,       
    accuracy,
    rt
  )

df <- df %>%
  mutate(
    subject    = as.factor(subject),
    task       = as.factor(task),
    congruency = as.factor(congruency),
    block      = as.numeric(block),
    trial      = as.numeric(trial),
    accuracy   = as.numeric(accuracy),
    rt         = as.numeric(rt)
  )

summary(df)

#Factor check
contrasts(df$task)<-c(1,0)
contrasts(df$task)
contrasts(df$congruency)<-c(1,0)
contrasts(df$congruency)

#Save file
save(df, file = ".//raw_data.rdata")