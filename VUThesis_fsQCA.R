# ======================================================
# Thesis
# Methodology: Fuzzy Set Qualitative Comparative Analysis (fsQCA)
# Author: Daniel Commerford
# Purpose: Assess configurations leading to PSD success
# ======================================================

# ---- Libraries -------

library(QCA)
library(psych)
library(readxl)
library(ggplot2)
library(writexl)  # Optional: to save the output if needed
library(tidyverse)
library(knitr)
library(rmarkdown)
library(dplyr)
library(patchwork) 


# Load the dataset
data <- read_excel("IV - condition scores.xlsx", sheet = 1)

# View the data for inspection
head(data)

#### ---- 2. Outcome Calibration: fs_success ---- ####

## Direct calibration method ##

# Calibrate the raw scores 
data$fs_success <- calibrate(data$dv,
                             type = "fuzzy",
                             thresholds = c(0.71, 0.77, 0.83))

## Empirical Justification ##
# public service delivery (PSD) - where "success" is proxied by positive perception scores
# thresholds align closely with the distribution of raw scores:

# 0.83 = Full membership (1.0)

# 0.83 is approx. the 90th percentile: countries where positive perception ≥ 0.83 are clearly 
# perceived as successful — reflecting strong public approval of PSD.

# 0.77 = Crossover point (0.5)

# The crossover point logically sits at the middle of the distribution, where 
# cases are ambiguous — neither clearly successful nor unsuccessful. This is 
# common in fsQCA and grounded in statistical dispersion.

# 0.71 = Full non-membership (0.0)

# 0.71 aligns approx. with the 10th percentile, the lower edge of data. 
# Countries scoring at or below this point are clearly out of the set. 
# Countries with low levels of positive perception - not members of the success set


# View calibrated scores
head(data)

## Visualize

# show the S-curve behavior of the calibration

ggplot(data, aes(x = dv, y = fs_success)) +
  geom_point(color = "steelblue", size = 3) +
  geom_vline(xintercept = 0.71, linetype = "dashed", color = "red", linewidth = 1) +
  geom_vline(xintercept = 0.77, linetype = "dashed", color = "orange", linewidth = 1) +
  geom_vline(xintercept = 0.83, linetype = "dashed", color = "darkgreen", linewidth = 1) +
  labs(
    title = "Fuzzy Calibration of 'Positive Perception' into fs_success",
    subtitle = "Thresholds: 0.71 (Non-member), 0.77 (Crossover), 0.83 (Full member)",
    x = "Raw Score: Positive Perception",
    y = "Fuzzy Membership Score: fs_success"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 11),
    axis.title = element_text(size = 12)
  )

## These are the four fuzzy set categories based on calibration: 

# Fully in: Sweden, Hungary, Netherlands, Denmark

# More in than out: Croatia, Slovakia, Estonia, Malta, Poland, Luxembourg, Cyprus, Finland, Latvia, Czech Republic

# More out than in: Belgium, Ireland, Lithuania, Greece, Slovenia, Portugal, Bulgaria, Spain, Italy, Germany, Austria

# Fully out: France, Romania



#### Causal Conditions ####

# For causal conditions, i decided to do direct calibration 
# as all scores are continuous ranging from 0 to 100

colnames(data)


## User support 1/6 ##

# effectiveness of help tools - reflects varying levels of support 
# sophistication

# This is a high performing set, a "normal" score is already above 90
# the thresholds are meant to reflect this and the right skewed distribution

data$fs_user_support <- calibrate(data$HELP,
                                  type = "fuzzy",
                                  thresholds = c(80, 94.5, 98))

# mean was used as crossover point


## eID (electronic identification) 2/6 ##

# the level of digital identity integration — 
# how widely used eID is in interactions with PA

data$fs_eid <- calibrate(data$EID,
                         type = "fuzzy",
                         thresholds = c(60, 71.5, 93))

# Quite alot of variation in this set,
# There is a big cluster of countries that have a near perfect score,
# with a significant margin gap dropping after 0.93.
# thresholds meant to reflect this set with more empirical dispersion 

# The minimum value - 60 - was lenient due to the dispersion, but still 
# strict enough to exclude country with negligible eID use. 


## Availability 3/6 ##

# evaluates how services are made available to citizens online and on 
# mobile platforms

# countries perform very high in this set, meaning that even "low" scores still
# reflect strong digital availability

data$fs_availability <- calibrate(data$AVAIL,
                                  type = "fuzzy",
                                  thresholds = c(90, 94, 98))


# the calibration is more sensitive to try and reflect the compressed distribution
# also, the cutoffs are strict to reflect that this is a composite score: mobile + online
# some countries may succeed in one category, but not the other. 


## eDocument 4/6 ##

data$fs_edocument <- calibrate(data$EDOC,
                               type = "fuzzy",
                               thresholds = c(66.5, 86, 95.96))

# The eDocument indicator assesses how well citizens can submit or download 
# official documents online

# this crossover point reflects the median as opposed to the mean due to one
# outlier value - romania 

# The min cut off was selected because it reflects the 10th percentile - tries to 
# capture the difference in ability in lower performing nations since there is diversity 
# this set


## Transparency 5/6 ##

# Transparency of service delivery, design and personal data
# The indicator is an aggregate score of multiple elements and more broadly
# dispersed, so thresholds will be more strict

data$fs_transparency <- calibrate(data$TRANS,
                                  type = "fuzzy",
                                  thresholds = c(60, 70, 80))

# the strict cut off is 60 - anything less than that is unsuccessful -
# makes this set the one with most non-members - 8

## Pre-filled Forms 6/6 ##

# The indicator measures to what extent online forms are pre-filled 
# with personal information already known by the government

data$fs_prefilled <- calibrate(data$PRE,
                               type = "fuzzy",
                               thresholds = c(60, 71, 85))


# it will also have a strict cut off - anything less than 60 means countries are 
# likely to offer little to no meaningful pre-filling automation

# crossover point is the mean 75, above 85 is considered well integrated


# 2. (Re-)calibrate all six fuzzy sets
data$fs_user_support <- calibrate(data$HELP,  type="fuzzy", thresholds=c(80, 94.5, 98))
data$fs_eid          <- calibrate(data$EID,   type="fuzzy", thresholds=c(60, 71.5, 93))
data$fs_availability <- calibrate(data$AVAIL, type="fuzzy", thresholds=c(90, 94,   98))
data$fs_edocument    <- calibrate(data$EDOC,  type="fuzzy", thresholds=c(66.5, 86, 95.96))
data$fs_transparency <- calibrate(data$TRANS, type="fuzzy", thresholds=c(60,   70,  80))
data$fs_prefilled    <- calibrate(data$PRE,   type="fuzzy", thresholds=c(60,   71,  85))

# 3. Put their names in a vector
fuzzy_vars <- c(
  "fs_user_support", 
  "fs_eid", 
  "fs_availability", 
  "fs_edocument", 
  "fs_transparency", 
  "fs_prefilled"
)

# 4. Generate one histogram per fuzzy var
plots <- lapply(fuzzy_vars, function(var){
  ggplot(data, aes_string(x = var)) +
    geom_histogram(
      breaks = seq(0, 1, by = 0.05), 
      fill   = "steelblue", 
      color  = "white", 
      alpha  = 0.8
    ) +
    geom_rug(sides = "b", length = unit(0.02, "npc")) +
    geom_vline(
      xintercept = c(0, 0.5, 1),
      linetype   = "dashed",
      color      = c("red","orange","darkgreen"),
      size       = 0.7
    ) +
    scale_x_continuous(breaks = seq(0, 1, by = 0.1)) +
    labs(
      title = var,
      x     = "Fuzzy membership",
      y     = "Count"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size = 10),
      axis.title = element_text(size = 9),
      axis.text  = element_text(size = 8)
    )
})

# 5. Arrange them in a 3×2 grid
(plots[[1]] | plots[[2]] | plots[[3]]) /
  (plots[[4]] | plots[[5]] | plots[[6]])


### Verify calibrated conditions and confirm no values fall in 0.5 (ambiguity) ###

# List of your calibrated fuzzy sets
fuzzy_vars <- c("fs_user_support", "fs_eid", "fs_availability",
                "fs_edocument", "fs_transparency", "fs_prefilled")

# Loop through each one and report rows where membership == 0.5
for (var in fuzzy_vars) {
  ambiguous_cases <- data[data[[var]] == 0.5, ]
  if (nrow(ambiguous_cases) > 0) {
    cat("Cases with membership = 0.5 in", var, ":\n")
    print(ambiguous_cases)
    cat("\n")
  } else {
    cat("No 0.5 scores in", var, "\n")
  }
}

## it is confirmed no scores across the 6 categories falls into 0.5


#### Necessity Analysis ####

# after library(QCA)
library(SetMethods)        

# vector of your six calibrated conditions
fuzzy_vars <- c("fs_user_support", "fs_eid", "fs_availability",
                "fs_edocument", "fs_transparency", "fs_prefilled")

nec_all <- QCAfit(
  x       = data[, fuzzy_vars],
  y       = data$fs_success,
  neg.out = FALSE    
)
print(nec_all)

# there appear to be NO necessary conditions for the outcome since no consistency score is 
# above the needed threshold of 0.90 (Oana et al. suggested this threshold)

# since there appear to be no necessary conditions, a followup for DCK is not needed

# The highest Consistency you’ve got is ~0.70 for fs_availability, far below 0.90.

# All negations (~fs_*) are also below 0.90.

# Therefore, none of your individual causal conditions or their absence is strictly 
# “necessary” for public‐service‐delivery success.

nec_all <- QCAfit(
  x       = data[, fuzzy_vars],
  y       = data$fs_success,
  neg.out = TRUE    
)
print(nec_all)

# Neither any condition nor its absence is strictly necessary to produce dPSD


# Per Oana et al. guidelines, necessary disjunctions will also be explored
# Oana et al. (2021) stress that necessary-disjunction checks (SUIN routines) 
# are the counterpart to looking at single conditions—they complete the necessity 
# analysis by scanning all two-way OR combinations (and beyond, if warranted) 

suin <- superSubset( #QCA package has to be called specifically to avoid error
  data       = data,
  outcome    = "fs_success",
  conditions = c("fs_user_support", "fs_eid", "fs_availability",
                 "fs_edocument", "fs_transparency", "fs_prefilled"),
  incl.cut   = 0.90,
  cov.cut    = 0.60,
  ron.cut    = 0.60
)

print(suin)


#### core fsQCA analysis ####

## prepare data set for analysis ##

# Create working dataset

conditions <- c("fs_user_support", "fs_eid", "fs_availability", 
                "fs_edocument", "fs_transparency", "fs_prefilled")

tt <- truthTable(data, outcome = "fs_success",
                 conditions = conditions,
                 incl.cut = 0.8,  # Consistency threshold
                 sort.by = "incl", show.cases = TRUE)

print(tt)


# Minimization of Truth Table


solution <- minimize(tt, details = TRUE, show.cases = TRUE)
print(solution)



