#### Preamble ####
# Purpose: Figure 1 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(psych)
library(effsize)
library(ggplot2)
library(dplyr) 
library(reshape2)


# Formatting options
options(scipen=999.99, digits = 7)

# Attempt to set working directory to the current R script location

# Data loading and initial processing
data <- read.csv("../inputs/data/osf-past-normality-regret-replication-exp1-data.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")

# Demographics handling and descriptive statistics
data$age[data$age == 99] <- NA  # Handling outlier or incorrect age data
data$gender <- as.factor(data$gender)  # Converting gender to a factor for better analysis


# Factor conversion and labeling for Experiment 1 variables
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
  melt(id.vars = NULL, variable.name = "variable", value.name = "Character")  # 'melt' is from the 'reshape2' package, similar to 'pivot_longer'
data_long <- na.omit(data_long)  # Exclude NAs

# Calculate the percentages
data_long <- data_long %>%
  group_by(variable, Character) %>%
  summarise(count = n(), .groups = 'drop') %>%
  group_by(variable) %>%
  mutate(percentage = count / sum(count)) %>%
  ungroup()  # Make sure to ungroup after calculations

# Define new labels for the x-axis
new_labels <- setNames(c("Regret", "Social norms (injunctive)", "Social norms (descriptive)", "Negative affect"),
                       c("Sc1_regret", "sc1_socnorms1", "sc1_socnorms2", "sc1_combinednorms"))

# Plot the percentages using ggplot2 with updated labels and excluding NAs
ggplot(data_long, aes(x = variable, y = percentage, fill = Character)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9)) +  # Adjust the dodge width
  scale_y_continuous(labels = scales::percent_format()) +
  scale_x_discrete(labels = new_labels) +
  labs(x = NULL, y = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 0.5, size = 5),  # Set angle to 0 for horizontal labels
        legend.position = "bottom")

ggsave(
  "../replication/plots/figure1.png",
  height = 8,
  width = 16,
  units = "in",
  dpi = 300
)
