#### Preamble ####
# Purpose: Figure 4 replication
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

# Assuming your data_before3 has these columns already as numeric:
# sc3_c1_compensation, sc3_c1_regret, sc3_c2_compensation, sc3_c2_regret, sc3_c3_compensation, sc3_c3_regret

#read the data for experiment 1:
data_before3 <- read.csv("inputs/data/osf-past-normality-regret-replication-exp1-data.csv")

# Convert compensation and regret columns to numeric type
data_before3 <- data_before3 %>%
  mutate(
    sc3_c1_compensation = as.numeric(sc3_c1_compensation),
    sc3_c1_regret = as.numeric(sc3_c1_regret),
    sc3_c2_compensation = as.numeric(sc3_c2_compensation),
    sc3_c2_regret = as.numeric(sc3_c2_regret),
    sc3_c3_compensation = as.numeric(sc3_c3_compensation),
    sc3_c3_regret = as.numeric(sc3_c3_regret)
  )

# Reshape the data into a long format suitable for plotting
plot_data3 <- data_before3 %>%
  select(sc3_c1_compensation, sc3_c1_regret, sc3_c2_compensation, sc3_c2_regret, sc3_c3_compensation, sc3_c3_regret) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Condition_Measure",
    values_to = "Value"
  ) %>%
  mutate(
    Condition = case_when(
      str_detect(Condition_Measure, "c1") ~ "Routine",
      str_detect(Condition_Measure, "c2") ~ "Self-produced\nexception",
      str_detect(Condition_Measure, "c3") ~ "Other-produced\nexception"
    ),
    Measure = case_when(
      str_detect(Condition_Measure, "compensation") ~ "Compensation",
      TRUE ~ "Regret"
    )
  ) %>%
  select(-Condition_Measure) %>%
  drop_na(Value) # Drop NA values

# Define custom colors
custom_colors <- c("Self-produced\nexception" = "#E24A33", 
                   "Other-produced\nexception" = "#00BA78", 
                   "Routine" = "#348ABD")

# Plotting with custom colors and updated labels
p3 <- ggplot(plot_data3, aes(x = Condition, y = Value, fill = Condition)) +
  geom_violin(trim = FALSE) +
  geom_jitter(width = 0.2, color = "black", alpha = 0.5) +
  facet_wrap(~Measure, scales = "free_y", ncol = 3, labeller = label_parsed) +
  scale_fill_manual(values = custom_colors) +
  labs(y = "", x = "") +
  theme_minimal() +
  theme(
    legend.position = "none",
    strip.text.x = element_text(size = 10, margin = margin(2, 0, 2, 0)),
    axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 0.5) # Set angle to 0 for horizontal labels
  )

# For experiment 2:

# Assuming your data_before3 has these columns already as numeric:
# sc3_c1_compensation, sc3_c1_regret, sc3_c2_compensation, sc3_c2_regret, sc3_c3_compensation, sc3_c3_regret

data2_before3 <- read.csv("inputs/data/osf-past-normality-regret-replication-exp2-data-v2.csv")
# Convert compensation and regret columns to numeric type
data2_before3 <- data2_before3 %>%
  mutate(
    sc3_c1_compensation = as.numeric(sc3_c1_compensation),
    sc3_c1_regret = as.numeric(sc3_c1_regret),
    sc3_c2_compensation = as.numeric(sc3_c2_compensation),
    sc3_c2_regret = as.numeric(sc3_c2_regret),
    sc3_c3_compensation = as.numeric(sc3_c3_compensation),
    sc3_c3_regret = as.numeric(sc3_c3_regret)
  )

# Reshape the data into a long format suitable for plotting
plot2_data3 <- data2_before3 %>%
  select(sc3_c1_compensation, sc3_c1_regret, sc3_c2_compensation, sc3_c2_regret, sc3_c3_compensation, sc3_c3_regret) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Condition_Measure",
    values_to = "Value"
  ) %>%
  mutate(
    Condition = case_when(
      str_detect(Condition_Measure, "c1") ~ "Routine",
      str_detect(Condition_Measure, "c2") ~ "Self-produced\nexception",
      str_detect(Condition_Measure, "c3") ~ "Other-produced\nexception"
    ),
    Measure = case_when(
      str_detect(Condition_Measure, "compensation") ~ "Compensation",
      TRUE ~ "Regret"
    )
  ) %>%
  select(-Condition_Measure) %>%
  drop_na(Value) # Drop NA values

# Plotting with custom colors and updated labels
p32 <- ggplot(plot2_data3, aes(x = Condition, y = Value, fill = Condition)) +
  geom_violin(trim = FALSE) +
  geom_jitter(width = 0.2, color = "black", alpha = 0.5) +
  facet_wrap(~Measure, scales = "free_y", ncol = 3, labeller = label_parsed) +
  scale_fill_manual(values = custom_colors) +
  labs(y = "", x = "") +
  theme_minimal() +
  theme(
    legend.position = "none",
    strip.text.x = element_text(size = 10, margin = margin(2, 0, 2, 0)),
    axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 0.5) # Set angle to 0 for horizontal labels
  )

# Print the plot
# Combine the plots. The nrow parameter specifies the number of rows in the grid.
combined_plot <- grid.arrange(p3, p32, nrow = 2)

# Print the combined plot

print(combined_plot)

# Now use ggsave to save the combined plot
ggsave(
  filename = "replication/plots/figure4.png",
  plot = combined_plot, # Ensure combined_plot is the latest plot
  width = 16, # Adjust the width to give more space for the labels
  height = 8, # Adjust the height as needed
  units = "in",
  dpi = 300 # A lower dpi may be sufficient and result in smaller file sizes
)