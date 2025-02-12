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

####### Cleaning up data
# sometimes you need to skip header files to make the reading of the file more clear
taxon_dirty <- read_csv("data/taxon_abundance.csv", skip = 2)
head(taxon_dirty)

#only pick cyanobacteria
taxon_clean <- taxon_dirty %>%
  select(sample_id:Cyanobacteria)
  #what are the wide format dimensions? 71 rows by 7 columns
  dim(taxon_clean)

# Pivot_longer(): shape the data from wide into long format
taxon_long <- taxon_clean %>%
  pivot_longer(cols = Proteobacteria:Cyanobacteria, 
               names_to = "Phylum",
               values_to = "Abundance")

#check new dimensions
dim(taxon_long)
# before: 71 rows with 7 columns. NOW: 426 rows with 3 columns

taxon_long  %>% 
  group_by(Phylum) %>%
  summarize(avg_abund = mean(Abundance))

#Plot our data

taxon_long %>%
  ggplot(aes(x=sample_id, y=Abundance, fill=Phylum)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90))

#Joining data frames
sample_data %>% head(6)

taxon_clean %>% head(6)

#These two files have the same sample_id!!d

#inner join
sample_data %>%
inner_join(., taxon_clean, by = "sample_id")

#intuition check for ifltering joins
length(unique(taxon_clean$sample_id))
length(unique(sample_data$sample_id))

#anti join_ to exclude certain groups/rows

sample_data
anti_join(., tazon_clean, by = "sample ID")



            
sample_and_taxon <-  sample_data %>% 
  inner_join(., taxon_clean_goodSept)

#intuition check
  dim(sample_and_taxon)
  
  #test: to ensure trooth of R expression
  stopifnot(dim(sample_and_taxon) == nrow(sample_data))
  
  
  write_csv(sample_and_taxon, "data/sample_and_taxon.csv")

sample_and_taxon %>%
ggplot(aes(x=depth, y=Chloroflexi)) +
  geompoint() +
  #add a statistical model
  geom_smooth()
