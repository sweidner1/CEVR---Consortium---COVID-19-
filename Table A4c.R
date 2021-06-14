
# Generating results and statistics for Table A4c

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)

sensitivity7_initclaims <- lme(initclaims_rate_regular ~ Restricted_2_weeks + NewCases + NewDeaths
                               + DeltaNewCases + DeltaNewDeaths,
                               data = Cleaned_Unemployment_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))

sensitivity8_initclaims <- lme(initclaims_rate_regular ~ Restrictions_longer_3weeks + NewCases + NewDeaths
                               + DeltaNewCases + DeltaNewDeaths,
                               data = Cleaned_Unemployment_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))

sensitivity9_initclaims <- lme(initclaims_rate_regular ~ Restricted_indoor_dining + NewCases + NewDeaths
                               + DeltaNewCases + DeltaNewDeaths,
                               data = Cleaned_Unemployment_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))


tab_model(sensitivity7_initclaims, sensitivity8_initclaims, sensitivity9_initclaims,
          pred.labels = c("(Intercept)", "Restricted_2_weeks","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate", "Restrictions_longer_3weeks", "Restricted_indoor_dining"),
          title = "Table A4c", dv.labels = 
            c("Initial unemployment claims model (Alternate restricted definition)","Initial unemployment claims model (Alternate restricted definition)", "Initial unemployment claims model (Alternate restricted definition)"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A4c.html")

TableA4c_AIC <- numeric()
TableA4c_labels <- character()

initclaims_sensitivity7 <- summary(sensitivity7_initclaims)
initclaims_sensitivity8 <- summary(sensitivity8_initclaims)
initclaims_sensitivity9 <- summary(sensitivity9_initclaims)
initclaims_fvalue_sensitivity7 <- anova(sensitivity7_initclaims)
initclaims_fvalue_sensitivity8 <- anova(sensitivity8_initclaims)
initclaims_fvalue_sensitivity9 <- anova(sensitivity9_initclaims)

TableA4c_AIC <- append(TableA4c_AIC, AIC(initclaims_sensitivity7))
TableA4c_labels <- append(TableA4c_labels, "Initial unemployment claims rate model (Alternate Restricted definition - 2 week delay)")
TableA4c_AIC <- append(TableA4c_AIC, AIC(initclaims_sensitivity8))
TableA4c_labels <- append(TableA4c_labels, "Initial unemployment claims rate model (Alternate Restricted definition - at least 3 weeks long)")
TableA4c_AIC <- append(TableA4c_AIC, AIC(initclaims_sensitivity9))
TableA4c_labels <- append(TableA4c_labels, "Initial unemployment claims rate model (Alternate Restricted definition - indoor dining fully closed)")


TableA4c_AIC_table <- data.frame(TableA4c_AIC,TableA4c_labels)

write.csv(TableA4c_AIC_table, "Table A4c AICs.csv")
write.csv(initclaims_fvalue_sensitivity7, "Table A4c anova initclaims rate sensitivity 7.csv")
write.csv(initclaims_fvalue_sensitivity8, "Table A4c anova initclaims rate sensitivity 8.csv")
write.csv(initclaims_fvalue_sensitivity9, "Table A4c anova initclaims rate sensitivity 9.csv")