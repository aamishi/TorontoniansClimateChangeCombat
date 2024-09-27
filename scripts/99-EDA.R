#### Preamble ####
# Purpose: EDS
# Author: Aamishi Avarsekar
# Date: 27th September 2024
# Contact: aamishi.avarsekar@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(knitr)


# Load Final Data: analysis_data
analysis_data <- read_csv("data/analysis_data/analysis_data_demo.csv")
ggplot(analysis_data, aes(x = CouncilBudget)) +
  geom_bar() +
  labs(title = "Council Budget Distribution", x = "Council Budget", y = "Count") +
  theme_minimal()

# Create a histogram with vertical x-axis labels
ggplot(analysis_data, aes(x = CouncilBudget)) +
  geom_bar() +
  labs(title = "Council Budget Distribution", x = "Council Budget", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Create a histogram with vertical x-axis labels
ggplot(analysis_data, aes(x = DecreaseFunding)) +
  geom_bar() +
  labs(title = "Council Budget Distribution", x = "Council Budget", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Create a histogram with a legend instead of x-axis labels
ggplot(analysis_data, aes(x = "", fill = CouncilBudget)) +
  geom_bar() +
  labs(title = "Council Budget Distribution", x = "Council Budget", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),  # Hide x-axis labels
        axis.ticks.x = element_blank()) +  # Hide x-axis ticks
  scale_fill_discrete(name = "Council Budget Categories")


test <- knitr::kable(head(analysis_data), caption = "Table: First few rows of the dataset")

field <- analysis_data$HomelessExperience

# Summarize data to get counts
data_summary <- analysis_data %>%
  group_by(CouncilBudget) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) # Sort by frequency in descending order

n <- 5
top_bins <- data_summary %>%
  top_n(n, wt = count)

# Create a bar plot for the top n bins
ggplot(top_bins, aes(x = reorder(CouncilBudget, -count), y = count)) +
  geom_bar(stat = "identity", color = "black", fill = "skyblue") +
  labs(title = paste("Top", n, "Bins"), x = "Values", y = "Count")

# DecreaseFunding
data_summary <- analysis_data %>%
  group_by(DecreaseFunding) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) # Sort by frequency in descending order

n <- 5
top_bins <- data_summary %>%
  top_n(n, wt = count)

# Create a bar plot for the top n bins
ggplot(top_bins, aes(x = reorder(DecreaseFunding, -count), y = count)) +
  geom_bar(stat = "identity", color = "black", fill = "pink") +
  labs(title = paste("Top", n, "Bins"), x = "Values", y = "Count")


# Create a bar plot (instead of a histogram) to show frequency
ggplot(data_summary, aes(x = reorder(PostalCode, -count), y = count)) +
  geom_bar(stat = "identity", color = "black", fill = "skyblue") +
  labs(title = "Bar Plot Sorted by Frequency", x = "Values", y = "Count")



# demographs for funding more
# Step 1: Summarize to get total counts for DecreaseFunding (ignoring age and gender for now)
top_increase_funding <- analysis_data %>%
  group_by(CouncilBudget) %>%
  summarise(total_count = n()) %>%
  arrange(desc(total_count)) %>%
  top_n(5, wt = total_count) %>%
  pull(CouncilBudget)

# Step 2: Now group by DecreaseFunding, age, and gender and filter only top 5 bins
data_summary <- analysis_data %>%
  filter(CouncilBudget %in% top_increase_funding) %>%  # Filter for only top 5 bins
  group_by(CouncilBudget, Age, LowIncome) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# Step 3: Create the bar plot for the top 5 bins, with fill for gender
ggplot(data_summary, aes(x = reorder(CouncilBudget, -count), y = count, fill = LowIncome)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +  # Use 'stack' for stacked bars instead
  labs(title = "Top 5 CouncilBudget Bins with Age and Gender", x = "DecreaseFunding", y = "Count") +
  # facet_wrap(~ Age) +  # Optional: create separate plots for each age group
  theme_minimal()



# demographs for defunding
# Step 1: Summarize to get total counts for DecreaseFunding (ignoring age for now)
top_decrease_funding <- analysis_data %>%
  group_by(DecreaseFunding) %>%
  summarise(total_count = n()) %>%
  arrange(desc(total_count)) %>%
  top_n(5, wt = total_count) %>%
  pull(DecreaseFunding)

# Step 2: Now group by DecreaseFunding and age, and filter for the top 5 bins
data_summary <- analysis_data %>%
  filter(DecreaseFunding %in% top_decrease_funding) %>%  # Filter for only top 5 bins
  group_by(DecreaseFunding, Age) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# Step 3: Create the bar plot for the top 5 bins, facet by age
ggplot(data_summary, aes(x = reorder(DecreaseFunding, -count), y = count, fill = Age)) +
  geom_bar(stat = "identity", position = "stack", color = "black") +  # Or 'stack' for stacked bars
  labs(title = "Top 5 DecreaseFunding Bins with Age Information", x = "DecreaseFunding", y = "Count") +
  theme_minimal()












