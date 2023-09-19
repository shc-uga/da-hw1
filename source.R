setwd("/Users/sellerscrisp/Nextcloud/Documents/College/02_UGA/Fall 2023/Data Analytics/qog")
df <- read.csv("qog_bas_ts_jan23.csv")

library(tidyverse)
library(ggplot2)
library(naniar)

# Q2
# corruption perceptions index: integer
class(df$ti_cpi)
summary(df$ti_cpi)

# world development indicators: access to electricity (% of pop.): double
class(df$wdi_acel)
summary(df$wdi_acel)

# dichotomous democracy measure: integer
class(df$bmr_dem)
summary(df$bmr_dem)

# convert democracy to factor
df$bmr_dem <- as.factor(df$bmr_dem)

# Q3
# create a subset dataframe
df_subset <- df[, c('ti_cpi', 'wdi_acel', 'bmr_dem')]

# rename variables
colnames(df_subset) <- c('CorruptionPerceptionsIndex', 'AccessToElectricity', 'Democracy')

# plot missing values
gg_miss_var(df_subset)

# delete rows with missing values
#? should you update a var in-place?
#? i.e. df_subset <- na.omit(df_subset)
df_subset_omitted <- na.omit(df_subset)

# Q4
ggplot(df_subset_omitted, aes(x = AccessToElectricity)) +
  geom_histogram() +
  xlab("WDI: Access to Electricity (% of population)") +
  ylab("Count")

# Q5
ggplot(df_subset_omitted, aes(x = CorruptionPerceptionsIndex, y = AccessToElectricity)) +
  geom_point() +
  geom_smooth() +
  xlab("Corruption Perceptions Index") +
  ylab("WDI: Access to Electricity (% of population)")

# Q6
ggplot(df_subset_omitted, aes(x = as.factor(Democracy), y = AccessToElectricity)) +
  geom_boxplot() +
  xlab("Dichotomous Democracy Measure") +
  ylab("WDI: Access to Electricity (% of population)")

# Q7
ggplot(df_subset_omitted, aes(x = CorruptionPerceptionsIndex, y = AccessToElectricity)) +
  geom_point(aes(color = Democracy)) +
  geom_smooth(aes(group = Democracy, color = Democracy)) +
  xlab("Corruption Perceptions Index") +
  ylab("WDI: Access to Electricity (% of population)")