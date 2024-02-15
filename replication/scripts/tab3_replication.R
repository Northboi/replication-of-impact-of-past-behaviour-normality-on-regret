#### Preamble ####
# Purpose: Table 2 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(knitr)
library(kableExtra)

data <- read.csv("inputs/data/osf-past-normality-regret-replication-exp1-data.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")

# Make sure your data is a factor with levels as "1" and "2" representing "Routine Adams" and "Exception White"
data$Sc2_regret <- factor(data$Sc2_regret, levels = c(1, 2), labels = c("Routine Adams", "Exception White"))
data$Sc2_luck <- factor(data$Sc2_luck, levels = c(1, 2), labels = c("Routine Adams", "Exception White"))

# Calculate counts and percentages
regret_counts_2 <- table(data$Sc2_regret)
regret_percentages_2 <- prop.table(regret_counts_2) * 100

luck_counts <- table(data$Sc2_luck)
luck_percentage <- prop.table(luck_counts) * 100

# Create the data frame for the table
table_data <- data.frame(
  Character = c("Routine Adams", "Exception White"),
  Regret_Count = as.numeric(regret_counts_2),
  Regret_Percentage = sprintf("%.1f%%", regret_percentages_2),
  Luck_Count = as.numeric(luck_counts),
  Luck_Percentage = sprintf("%.1f%%", luck_percentage)
)

# Prepare the labels for the headers
header_labels <- c(" " = 1, "Regret" = 2, "Luck" = 2)

# Generate the table with LaTeX formatting
kable(table_data, format = "latex", booktabs = TRUE, col.names = c("Character", rep(c("Count", "Percentage"), 2))) %>%
  kable_styling(latex_options = c("striped", "scale_down")) %>%
  add_header_above(header_labels) %>%
  column_spec(1, bold = TRUE)

file_path <- "../replication/tables/Table3.csv"
write.csv(table_data, file_path, row.names = FALSE)