# Data Analysis

# load packages
library(tidyverse)

# Grab the data for our analysis
sample_data <- read_csv("data/sample_data.csv")
glimpse(sample_data)

#Summarize
summarize(sample_data, avg_cells = mean(cells_per_ml))

#syntax or style   %>% is the R version of a pipe!
sample_data %>% 
  #group data by env group
  group_by(env_group) %>%
  #calculate the mean of each env group
  summarize(avg_cells = mean(cells_per_ml))
