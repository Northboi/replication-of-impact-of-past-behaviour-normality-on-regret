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


data <- read.csv("inputs/data/osf-past-normality-regret-replication-exp1-data.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")
str(data)
# Your previous code for calculating counts and percentages...

# Create the table data with 'Character' column
# Ensure that the data is assigned to the correct character
variables <- c("Sc1_regret", "sc1_socnorms1", "sc1_socnorms2", "sc1_combinednorms")
data[variables] <- lapply(data[variables], function(x) factor(x, levels = c(1,2), labels = c("Exception Jones", "Routine Smith")))

# Improved variable labeling
labels <- c("Who experiences higher regret (direct replication)", 
            "Descriptive norms - which is more common?",
            "Injunctive norms - who is more criticized by society?",
            "Who experiences higher regret, when asking participants to consider the norm")
names(labels) <- variables
for (var in variables) {
  label(data[[var]]) <- labels[var]
}

# Convert the count data to percentage for plotting
data_long <- data %>%
  select(all_of(variables)) %>%
  melt(id.vars = NULL, variable.name = "variable", value.name = "character")  # 'melt' is from the 'reshape2' package, similar to 'pivot_longer'
data_long <- na.omit(data_long)  # Exclude NAs

# Calculate the percentages
data_long <- data_long %>%
  group_by(variable, character) %>%
  summarise(count = n(), .groups = 'drop') %>%
  group_by(variable) %>%
  mutate(percentage = count / sum(count)) %>%
  ungroup()  # Make sure to ungroup after calculations


regret_counts <- table(data$Sc1_regret)
regret_percentages <- prop.table(regret_counts) * 100

social_norm_injunctive_counts <- table(data$sc1_socnorms1)
social_norm_injunctive_percentages <- prop.table(social_norm_injunctive_counts) * 100

social_norm_descriptive_counts <- table(data$sc1_socnorms2)
social_norm_descriptive_percentages <- prop.table(social_norm_descriptive_counts) * 100

negative_affect_counts <- table(data$sc1_combinednorms)
negative_affect_percentages <- prop.table(negative_affect_counts) * 100


table_data <- data.frame(
  Character = c("Routine Smith", "Exception Jones"),
  Regret_Count = c(as.numeric(regret_counts["Routine Smith"]), as.numeric(regret_counts["Exception Jones"])),
  Regret_Percentage = c(sprintf("%.1f%%", regret_percentages["Routine Smith"]), sprintf("%.1f%%", regret_percentages["Exception Jones"])),
  Social_Norm_Injunctive_Count = c(as.numeric(social_norm_injunctive_counts["Routine Smith"]), as.numeric(social_norm_injunctive_counts["Exception Jones"])),
  Social_Norm_Injunctive_Percentage = c(sprintf("%.1f%%", social_norm_injunctive_percentages["Routine Smith"]), sprintf("%.1f%%", social_norm_injunctive_percentages["Exception Jones"])),
  Social_Norm_Descriptive_Count = c(as.numeric(social_norm_descriptive_counts["Routine Smith"]), as.numeric(social_norm_descriptive_counts["Exception Jones"])),
  Social_Norm_Descriptive_Percentage = c(sprintf("%.1f%%", social_norm_descriptive_percentages["Routine Smith"]), sprintf("%.1f%%", social_norm_descriptive_percentages["Exception Jones"])),
  Negative_Affect_Count = c(as.numeric(negative_affect_counts["Routine Smith"]), as.numeric(negative_affect_counts["Exception Jones"])),
  Negative_Affect_Percentage = c(sprintf("%.1f%%", negative_affect_percentages["Routine Smith"]), sprintf("%.1f%%", negative_affect_percentages["Exception Jones"]))
)

# Rename columns for display using kable
column_names <- c("Character", "Count", "Percentage", "Count", "Percentage", "Count", "Percentage", "Count", "Percentage")

# Use kable from knitr to create the table, and kableExtra to style it
kable_styled <- kable(table_data, col.names = column_names, format = "html", align = 'c', escape = FALSE, caption = "Part 1 (hitchhiker): Counts and proportions for perceived regret, social norms, and negative affect") %>%
  kable_styling(bootstrap_options = c("striped", "hover")) %>%
  add_header_above(c(" " = 1, "Regret" = 2, "Social norms (injunctive)" = 2, "Social norms (descriptive)" = 2, "Negative affect" = 2))

# Print the table
print(kable_styled)

file_path <- "replication/tables/Table1.csv"
write.csv(table_data, file_path, row.names = FALSE)
