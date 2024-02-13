#### Preamble ####
# Purpose: Figure 3 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
# For experiment 1:
# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)

#read the data for experiment 1:
data <- read.csv("inputs/data/osf-past-normality-regret-replication-exp1-data.csv")

# Assuming your data has these columns already as numeric:
# sc3_c1_compensation, sc3_c1_regret, sc3_c2_compensation, sc3_c2_regret, sc3_c3_compensation, sc3_c3_regret

# Update the dataset with calculated averages for exception conditions
data_before3 <- data
data <- data %>%
  mutate(
    sc3_c1_compensation = as.numeric(sc3_c1_compensation),
    sc3_c1_regret = as.numeric(sc3_c1_regret),
    sc3_c2_compensation = as.numeric(sc3_c2_compensation),
    sc3_c2_regret = as.numeric(sc3_c2_regret),
    sc3_c3_compensation = as.numeric(sc3_c3_compensation),
    sc3_c3_regret = as.numeric(sc3_c3_regret),
    exception_compensation = rowMeans(cbind(sc3_c2_compensation, sc3_c3_compensation), na.rm = TRUE),
    exception_regret = rowMeans(cbind(sc3_c2_regret, sc3_c3_regret), na.rm = TRUE)
  )

# Reshape the data into a long format suitable for plotting
plot_data <- data %>%
  select(sc3_c1_compensation, exception_compensation, sc3_c1_regret, exception_regret) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Condition_Measure",
    values_to = "Value"
  ) %>%
  mutate(
    Condition = case_when(
      str_detect(Condition_Measure, "compensation") ~ "Compensation",
      TRUE ~ "Regret"
    ),
    Measure = case_when(
      str_detect(Condition_Measure, "c1") ~ "Routine",
      TRUE ~ "Exception"
    )
  ) %>%
  select(-Condition_Measure) %>%
  drop_na(Value) # Drop NA values

# Plotting
p <- ggplot(plot_data, aes(x = Measure, y = Value, fill = Measure)) +
  geom_violin(trim = FALSE) +
  geom_jitter(width = 0.2, color = "black", alpha = 0.5) +
  facet_wrap(~Condition, scales = "free_y") +
  labs(y = "", x = "") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 0.5))

#For experiment 2:

# Load the new dataset
data2 <- read.csv("inputs/data/osf-past-normality-regret-replication-exp2-data-v2.csv")

# Update the new dataset with calculated averages for exception conditions
data2_before3 <- data2
data2 <- data2 %>%
  mutate(
    sc3_c1_compensation = as.numeric(sc3_c1_compensation),
    sc3_c1_regret = as.numeric(sc3_c1_regret),
    sc3_c2_compensation = as.numeric(sc3_c2_compensation),
    sc3_c2_regret = as.numeric(sc3_c2_regret),
    sc3_c3_compensation = as.numeric(sc3_c3_compensation),
    sc3_c3_regret = as.numeric(sc3_c3_regret),
    exception_compensation = rowMeans(cbind(sc3_c2_compensation, sc3_c3_compensation), na.rm = TRUE),
    exception_regret = rowMeans(cbind(sc3_c2_regret, sc3_c3_regret), na.rm = TRUE)
  )

# Reshape the new data into a long format suitable for plotting
plot_data2 <- data2 %>%
  select(sc3_c1_compensation, exception_compensation, sc3_c1_regret, exception_regret) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Condition_Measure",
    values_to = "Value"
  ) %>%
  mutate(
    Condition = case_when(
      str_detect(Condition_Measure, "compensation") ~ "Compensation",
      TRUE ~ "Regret"
    ),
    Measure = case_when(
      str_detect(Condition_Measure, "c1") ~ "Routine",
      TRUE ~ "Exception"
    )
  ) %>%
  select(-Condition_Measure) %>%
  drop_na(Value) # Drop NA values

# Plotting for the new data
p2 <- ggplot(plot_data2, aes(x = Measure, y = Value, fill = Measure)) +
  geom_violin(trim = FALSE) +
  geom_jitter(width = 0.2, color = "black", alpha = 0.5) +
  facet_wrap(~Condition, scales = "free_y") +
  labs(y = "", x = "") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 0.5))

# Combine the plots. The nrow parameter specifies the number of rows in the grid.
combined_plot <- grid.arrange(p, p2, nrow = 2)

# Print the combined plot

print(combined_plot)

# Now use ggsave to save the combined plot
ggsave(
  filename = "replication/plots/figure3.png",
  plot = combined_plot, # Ensure combined_plot is the latest plot
  width = 16, # Adjust the width to give more space for the labels
  height = 8, # Adjust the height as needed
  units = "in",
  dpi = 300 # A lower dpi may be sufficient and result in smaller file sizes
)