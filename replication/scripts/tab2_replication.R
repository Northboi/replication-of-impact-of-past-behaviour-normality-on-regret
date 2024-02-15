#### Preamble ####
# Purpose: Table 1 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(dplyr)
library(knitr)
library(kableExtra)
library(reshape2)


data <- read.csv("../inputs/data/osf-past-normality-regret-replication-exp1-data.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")
# Your previous code for calculating counts and percentages...

# Assuming 'data' is already loaded and pre-processed as per previous steps

# Calculate counts and percentages
regret_counts <- table(data$Sc1_regret)
regret_percentages <- prop.table(regret_counts) * 100

social_norm_injunctive_counts <- table(data$sc1_socnorms1)
social_norm_injunctive_percentages <- prop.table(social_norm_injunctive_counts) * 100

social_norm_descriptive_counts <- table(data$sc1_socnorms2)
social_norm_descriptive_percentages <- prop.table(social_norm_descriptive_counts) * 100

negative_affect_counts <- table(data$sc1_combinednorms)
negative_affect_percentages <- prop.table(negative_affect_counts) * 100

# Create the
table_data <- data.frame(
  Character = c("Exception Jones", "Routine Smith"),
  Regret_Count = as.numeric(regret_counts),
  Regret_Percent = sprintf("%.1f%%", regret_percentages),
  Social_Norm_Injunctive_Count = as.numeric(social_norm_injunctive_counts),
  Social_Norm_Injunctive_Percent = sprintf("%.1f%%", social_norm_injunctive_percentages),
  Social_Norm_Descriptive_Count = as.numeric(social_norm_descriptive_counts),
  Social_Norm_Descriptive_Percent = sprintf("%.1f%%", social_norm_descriptive_percentages),
  Negative_Affect_Count = as.numeric(negative_affect_counts),
  Negative_Affect_Percent = sprintf("%.1f%%", negative_affect_percentages)
)

# Prepare the labels for the headers
header_labels <- c(" " = 1, "Regret" = 2, "Social norms (injunctive)" = 2, 
                   "Social norms (descriptive)" = 2, "Negative affect" = 2)

# Generate the table
kable(table_data, format = "latex", booktabs = TRUE, col.names = c("Character", rep(c("Count", "Percentage"), 4))) %>%
  kable_styling(latex_options = c("striped", "scale_down")) %>%
  add_header_above(header_labels) %>%
  column_spec(1, bold = TRUE)

file_path <- "../replication/tables/Table2.csv"
write.csv(table_data, file_path, row.names = FALSE)
