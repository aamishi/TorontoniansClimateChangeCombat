#### Preamble ####
# Purpose: Tests the results of Toronto Citizens' Climate Change Perception
# Author: Aamishi Avarsekar
# Date: 24th September 2024
# Contact: aamishi.avarsekar@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Test data ####
data <- read_csv("data/raw_data/simulated.csv")

# Test for negative numbers
data$number_of_marriage |> min() <= 0

# Test for NAs
all(is.na(data$number_of_marriage))
