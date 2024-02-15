#### Preamble ####
# Purpose: Figure 1 replication
# Author: Shiji Zhang, Zongcheng Cao
# Date: 8 February 2024
# Contact: kane.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(readr)

data_test <- read_csv("inputs/data/osf-past-normality-regret-replication-exp1-data.csv")


# Test for part 1 (Hitch-hiker):

## Test there is only 1 and 2 in Sc1_regret (Regret)
min(data_test$Sc1_regret, na.rm=TRUE) > 0
max(data_test$Sc1_regret, na.rm=TRUE) < 3
all(data_test$Sc1_regret == floor(data_test$Sc1_regret), na.rm = TRUE)


## Test there is only 1 and 2 in sc1_socnorms1 (Social injunctive norms)
min(data_test$sc1_socnorms1, na.rm=TRUE) > 0
max(data_test$sc1_socnorms1, na.rm=TRUE) < 3
all(data_test$sc1_socnorms1 == floor(data_test$sc1_socnorms1), na.rm = TRUE)

## Test there is only 1 and 2 in sc1_socnorms2 (Social descriptive norms)
min(data_test$sc1_socnorms2, na.rm=TRUE) > 0
max(data_test$sc1_socnorms2, na.rm=TRUE) < 3
all(data_test$sc1_socnorms2 == floor(data_test$sc1_socnorms2), na.rm = TRUE)

## Test there is only 1 and 2 in sc1_combinednorms (Negative affect)
min(data_test$sc1_combinednorms, na.rm=TRUE) > 0
max(data_test$sc1_combinednorms, na.rm=TRUE) < 3
all(data_test$sc1_combinednorms == floor(data_test$sc1_combinednorms), na.rm = TRUE)


# Test for part 2 (Car accident):

## Test there is only 1 and 2 in Sc2_regret (Regret)
min(data_test$Sc2_regret, na.rm=TRUE) > 0
max(data_test$Sc2_regret, na.rm=TRUE) < 3
all(data_test$Sc2_regret == floor(data_test$Sc2_regret), na.rm = TRUE)

## Test there is only 1 and 2 in Sc2_lucky (Luck)
min(data_test$Sc2_lucky, na.rm=TRUE) > 0
max(data_test$Sc2_lucky, na.rm=TRUE) < 3
all(data_test$Sc2_lucky == floor(data_test$Sc2_lucky), na.rm = TRUE)


# Test for part 3 (Store robbery), the rating scale of compensation is from 0 to 10 but there are 11 numbers, and the rating scale of regret is from 0 to 5 and there are 6 numbers:

## Experiment 1:

### Test the value of sc3_c1_compensation is between 0 and 11 (Compensation)
all(data_test$sc3_c1_compensation >= 0 & data_test$sc3_c1_compensation <= 11, na.rm = TRUE)

### Test the value of sc3_c1_regret is between 0 and 6 (Regret)
all(data_test$sc3_c1_regret >= 0 & data_test$sc3_c1_regret <= 6, na.rm = TRUE)

### Test the value of sc3_c2_compensation is between 0 and 11 (Compensation)
all(data_test$sc3_c2_compensation >= 0 & data_test$sc3_c2_compensation <= 11, na.rm = TRUE)

### Test the value of sc3_c2_regret is between 0 and 6 (Regret)
all(data_test$sc3_c2_regret >= 0 & data_test$sc3_c2_regret <= 6, na.rm = TRUE)

### Test the value of sc3_c3_compensation is between 0 and 11 (Compensation)
all(data_test$sc3_c3_compensation >= 0 & data_test$sc3_c3_compensation <= 11, na.rm = TRUE)

### Test the value of sc3_c3_regret is between 0 and 6 (Regret)
all(data_test$sc3_c3_regret >= 0 & data_test$sc3_c3_regret <= 6, na.rm = TRUE)

data_test_2 <- read_csv("inputs/data/osf-past-normality-regret-replication-exp2-data-v2.csv")
## Experiment 2:

### Test the value of sc3_c1_compensation is between 0 and 11 (Compensation)
all(data_test$sc3_c1_compensation >= 0 & data_test$sc3_c1_compensation <= 11, na.rm = TRUE)

### Test the value of sc3_c1_regret is between 0 and 6 (Regret)
all(data_test$sc3_c1_regret >= 0 & data_test$sc3_c1_regret <= 6, na.rm = TRUE)

### Test the value of sc3_c2_compensation is between 0 and 11 (Compensation)
all(data_test$sc3_c2_compensation >= 0 & data_test$sc3_c2_compensation <= 11, na.rm = TRUE)

### Test the value of sc3_c2_regret is between 0 and 6 (Regret)
all(data_test$sc3_c2_regret >= 0 & data_test$sc3_c2_regret <= 6, na.rm = TRUE)

### Test the value of sc3_c3_compensation is between 0 and 11 (Compensation)
all(data_test$sc3_c3_compensation >= 0 & data_test$sc3_c3_compensation <= 11, na.rm = TRUE)

### Test the value of sc3_c3_regret is between 0 and 6 (Regret)
all(data_test$sc3_c3_regret >= 0 & data_test$sc3_c3_regret <= 6, na.rm = TRUE)

