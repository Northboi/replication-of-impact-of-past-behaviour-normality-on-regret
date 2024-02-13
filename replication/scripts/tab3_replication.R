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
str(data)

# Make sure your data is a factor with levels as "1" and "2" representing "Routine Adams" and "Exception White"
data$Sc2_regret <- factor(data$Sc2_regret, levels = c(1, 2), labels = c("Routine Adams", "Exception White"))
data$Sc2_luck <- factor(data$Sc2_luck, levels = c(1, 2), labels = c("Routine Adams", "Exception White"))

# Calculate counts and percentages
regret_counts_2 <- table(data$Sc2_regret)
regret_percentages_2 <- prop.table(regret_counts_2) * 100

luck_counts <- table(data$Sc2_lucky)
luck_percentage <- prop.table(luck_counts) * 100

# Create the data frame for the table
table_data <- data.frame(
  Character = c("Routine Adams", "Exception White"),
  Regret_Count = as.numeric(regret_counts_2),
  Regret_Percentage = sprintf("%.1f%%", regret_percentages_2),
  Luck_Count = as.numeric(luck_counts),
  Luck_Percentage = sprintf("%.1f%%", luck_percentage)
)

# Define column names for the kable, these are the subheaders
column_names <- c("Character", "Count", "Percentage", "Count", "Percentage")

# Generate the kable with proper headers
kable_styled <- kable(table_data, col.names = column_names, format = "html",align = c('l', rep('c', 4)), escape = FALSE, caption = "Part 2 (car accident): Counts and proportions for perceivedregret and luck.") %>%
  kable_styling(bootstrap_options = c("striped", "hover")) %>%
  add_header_above(c(" " = 1, "Regret" = 2, "Luck" = 2))

# Print the styled table
print(kable_styled)

file_path <- "replication/tables/Table2.csv"
write.csv(table_data, file_path, row.names = FALSE)

