#### Preamble ####
# Purpose: Downloads and saves the data of Climate Perception Study (OpenDataToronto)
# Author: Aamishi Avarsekar
# Date: 24th September 2024
# Contact: aamishi.avarsekar@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)


#### Download data ####
# get package
package_id_string <- "66ab9e95-a343-4f07-bc4f-56f82dcdc598"
package <- show_package(package_id_string)

# get all resources for this package
resources <- list_package_resources(package_id_string)

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% 
  get_resource()

#### Save data ####
write_csv(data, "data/raw_data/raw_data.csv")
         
