# Plotting ake ontario microbia cell abundances
# Daphne Garcia
# Created: Jan 29 2025


#install packages:
install.packages("tidyverse")
library(tidyverse)



#load data
sample_data <- read_csv("sample_data.csv")

?read_csv


round(x = 3.1415) #outputs 3 (i guess rounds to integer)
round(x = 3.1415, digits = 2) #outputs 3.14 (rounds to 2 decimals)
round(digits = 2, x = 3.1415) #also 3.14, just changed order of last one
round(2, 3.1415) #just puts 2 (rounds number 2 to 3.14 decimal places)


#plotting!!

ggplot(data = sample_data) +
  aes(x=temperature, y=cells_per_ml/1000000, 
      color = env_group, size = chlorophyll) +
  labs(title = "does temp affect microbial abundance?", 
       x="temperature in C",
       y= "Cell abundance (millions/mL)",
       color = "Environmental Group", 
       size = "chlorophyll (ug/L)") +
  geom_point()


#BUOY DATA:

buoy_data <- read_csv("buoy_data.csv")
dim(buoy_data)

#plot the buoy data
ggplot(data=buoy_data) +
  aes(x=day_of_year, y=temperature, color=depth,
      group=depth) +
  geom_line() +
  facet_grid(rows = vars(buoy))


#to see all of the unique sensors in the buoy dataset
unique(buoy_data$sensor)




#cell abundances by environmental group
ggplot(data = sample_data) +
  aes(x=env_group, y = cells_per_ml,
      color = env_group, fill = env_group) +
  geom_boxplot(alpha = 0.3, outlier.shape = NA) +
  geom_jiter(aes(size=chlorophyll))



ggsave("cells_per_envGroup.png") 


########################### Homework ##########################

#plotting!!

#FOR NITROGEN
ggplot(data = sample_data) +
  aes(x=total_nitrogen, y=cells_per_ml/1000000, 
      color = env_group, size = temperature) +
  labs(title = "Does nitrogen levels inrease or decrease cell abundance?", 
       x="Total Nitrogen (µg N/L)",
       y= "Cell abundance (millions/mL)",
       color = "Environmental Group", 
       size = "Temperature (C)") +
  geom_point() +
  geom_smooth(method = "lm",
                inherit.aes = FALSE,
                aes(x=total_nitrogen, y=cells_per_ml/1000000),
                se = FALSE)

ggsave("Nitrogen_plot.png") 

#FOR PHOSPHORUS
ggplot(data = sample_data) +
  aes(x=total_phosphorus, y=cells_per_ml/1000000, 
      color = env_group, size = temperature) +
  labs(title = "Does phosphorus levels increase cell abundance?", 
       x="Total Phosphorus (µg P/L)",
       y= "Cell abundance (millions/mL)",
       color = "Environmental Group", 
       size = "Temperature (C)") +
  geom_point() +
  geom_smooth(method = "lm",
              inherit.aes = FALSE,
              aes(x=total_phosphorus, y=cells_per_ml/1000000),
              se = FALSE)
ggsave("Phosphorus_plot.png") 


