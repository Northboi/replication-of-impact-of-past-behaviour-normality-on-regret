#### Preamble ####
# Purpose: Table 1 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)

# Load the data
data <- read_csv("inputs/data/osf-past-normality-regret-replication-exp1-data.csv")

# Select and rename the specified columns, and take the first 10 rows
selected_data <- data %>%
  select(Sc1_regret, sc1_socnorms1, sc1_socnorms2, sc1_combinednorms) %>%
  rename('Regret' = Sc1_regret, 'Injunctive norms' = sc1_socnorms1, 'Descriptive norms' = sc1_socnorms2, 'Negative affect' = sc1_combinednorms) %>%
  slice(1:10)

column_names <- c("Regret", "Injunctive norms", "Descriptive norms", "Negative affect")
kable_styled <- kable(selected_data, col.names = column_names, format = "html", align = 'c', escape = FALSE) %>%
  kable_styling(bootstrap_options = c("striped", "hover")) %>%
  
  # Print the styled table
  print(kable_styling)

file_path <- "replication/tables/Table1.csv"
write.csv(selected_data, file_path, row.names = FALSE)