#### Preamble ####
# Purpose: Figure 2 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(ggplot2)

# Correcting the mistakenly entered values for 'Sc2_random_1' and 'Sc2_random_2'
data <- read.csv("inputs/data/osf-past-normality-regret-replication-exp1-data.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")

agg_data <- data.frame(
  category = rep(c("Regret", "Luck"), each = 2),
  character = rep(c("Adams - Routine", "White - Exception"), 2),
  count = c(table(data$Sc2_regret), table(data$Sc2_lucky))
)

# Step 2: Calculate proportions
agg_data$proportion <- with(agg_data, count / tapply(count, category, FUN = sum)[category])

# Step 3: Plot using ggplot2
ggplot(agg_data, aes(x = category, y = proportion, fill = character)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_y_continuous(labels = scales::percent) +
  labs(x = NULL, y = "Percentage", fill = "Character") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5))

ggsave(
  "../replication/plots/figure2.png",
  height = 100,
  width = 133.33,
  units = "mm",
  dpi = 900)