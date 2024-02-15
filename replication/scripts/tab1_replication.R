#### Preamble ####
# Purpose: Table 1 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(kableExtra)
# Load the data
data <- read_csv("../inputs/data/osf-past-normality-regret-replication-exp1-data.csv")

# Select and rename the specified columns, and take the first 10 rows
selected_data <- data %>%
  select(Sc1_regret, sc1_socnorms1, sc1_socnorms2, sc1_combinednorms) %>%
  rename("Regret" = Sc1_regret, 
         "Injunctive norms" = sc1_socnorms1, 
         "Descriptive norms" = sc1_socnorms2, 
         "Negative affect" = sc1_combinednorms) %>%
  slice(1:10)

# Generate the table with kable and apply kableExtra styling
kable(selected_data, format = "latex", booktabs = TRUE, align = 'c', escape = FALSE) %>%
  kable_styling(full_width = FALSE, position = "center") %>%
  add_header_above(c("Data for Part 1: Hitch-hiker" = 4))

file_path <- "../replication/tables/Table1.csv"
write.csv(selected_data, file_path, row.names = FALSE)