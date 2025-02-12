# Data Analysis

# load packages
library(tidyverse)

# Grab the data for our analysis
sample_data <- read_csv("data/sample_data.csv")
glimpse(sample_data)

#Summarize
summarize(sample_data, avg_cells = mean(cells_per_ml))

#syntax or style   %>% is the R vercsion of a pipe!
sample_data %>% 
  #group data by env group
  group_by(env_group) %>%
  #calculate the mean of each env group
  summarize(avg_cells = mean(cells_per_ml))


############## Lab Feb 12 #####################

#Filter: subset data by rows based on value
sample_data %>%
  #subset samples only from the deep
  filter(temperature <5) %>%
  #calculate mean cell abundances
  summarize(avg_cells = mean(cells_per_ml))


sample_data %>%
# Mutate: cerates a new column
  #calculate a new column with TN : TP ratio
mutate(tn_tp_ratio = total_nitrogen / total_phosphorus) %>%
  #visualize it
  view()

#select(): subset by entire column
sample_data %>% 
  #pick specific columns (from sample_id to temperature)
  select (sample_id:temperature)


#if you want to remove column add (-)
sample_data %>% 
  select(-c(diss_org_carbon, chlorophyll))

