#### Preamble ####
# Purpose: Simulates the results of Toronto Citizens' Climate Change Perception
# Author: Aamishi Avarsekar
# Date: 24th September 2024
# Contact: aamishi.avarsekar@mail.utoronto.ca
# License: MIT

### Install packages
install.packages("tidyverse")

#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
set.seed(613)

# Set the number of random participants to generate
number_of_participants <- 100

# Questions Options
question_1_options <-sample(c("Very Likely", "Likely", "Neutral", "Unlikely", "Very Unlikely"), 
                            number_of_participants, replace = TRUE)
question_2_options <- sample(c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"), 
                            number_of_participants, replace = TRUE)
question_3_options <- sample(c("Aware, Participating", "Aware, Not Participating", "Not Participating"), 
                             number_of_participants, replace = TRUE)
sex <- sample(c("Male", "Female"), number_of_participants, replace = TRUE)
area_of_city <- sample(c("Toronto", "Markham", "North York", "Scarborough"), 
                      number_of_participants, replace = TRUE)

# Simulate 100 random ages with a mean of 35 and a standard deviation of 10
age_data <- rnorm(100, mean = 35, sd = 10)

# Round the ages to whole numbers and set minimum and maximum age bounds
age_data <- round(age_data)
age_data[age_data < 18] <- 18  # set minimum age to 18
age_data[age_data > 80] <- 80  # set maximum age to 80


#### Simulate data ####
survey_data <- data.frame(
  Sex = sex,
  Age = age_data,
  Area = area_of_city,
  Climate_Concern = question_1_options,
  Govt_Efforts = question_2_options,
  Personal_Action = question_3_options
)





