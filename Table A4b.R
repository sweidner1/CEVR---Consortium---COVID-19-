# Generating results and statistics for Table A4b

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)

sensitivity7_spend_acf <- lme(spend_acf ~ Restricted_2_weeks + NewCases + NewDeaths + DeltaNewCases +
                                DeltaNewDeaths,
                              data = Spending_Weekly_Data, 
                              random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

sensitivity8_spend_acf <- lme(spend_acf ~ Restrictions_longer_3weeks + NewCases + NewDeaths + DeltaNewCases +
                                DeltaNewDeaths,
                              data = Spending_Weekly_Data, 
                              random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

sensitivity9_spend_acf <- lme(spend_acf ~ Restricted_indoor_dining + NewCases + NewDeaths + DeltaNewCases +
                                DeltaNewDeaths,
                              data = Spending_Weekly_Data, 
                              random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))


tab_model(sensitivity7_spend_acf, sensitivity8_spend_acf, sensitivity9_spend_acf,
          pred.labels = c("(Intercept)", "Restricted_2_weeks","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate", "Restrictions_longer_3weeks", "Restricted_indoor_dining"),
          title = "Table A4b", dv.labels = 
            c("Restaurant/Accommodation Spending (Alternate restricted definition)","Restaurant/Accommodation Spending (Alternate restricted definition)", "Restaurant/Accommodation Spending (Alternate restricted definition)"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A4b.html")

TableA4b_AIC <- numeric()
TableA4b_labels <- character()

acf_sensitivity7 <- summary(sensitivity7_spend_acf)
acf_sensitivity8 <- summary(sensitivity8_spend_acf)
acf_sensitivity9 <- summary(sensitivity9_spend_acf)
acf_fvalue_sensitivity7 <- anova(sensitivity7_spend_acf)
acf_fvalue_sensitivity8 <- anova(sensitivity8_spend_acf)
acf_fvalue_sensitivity9 <- anova(sensitivity9_spend_acf)

TableA4b_AIC <- append(TableA4b_AIC, AIC(acf_sensitivity7))
TableA4b_labels <- append(TableA4b_labels, "Restaurant and accommodation consumer spending model (Alternate Restricted definition - 2 week delay)")
TableA4b_AIC <- append(TableA4b_AIC, AIC(acf_sensitivity8))
TableA4b_labels <- append(TableA4b_labels, "Restaurant and accommodation consumer spending model (Alternate Restricted definition - at least 3 weeks long)")
TableA4b_AIC <- append(TableA4b_AIC, AIC(acf_sensitivity9))
TableA4b_labels <- append(TableA4b_labels, "Restaurant and accommodation consumer spending model (Alternate Restricted definition - indoor dining fully closed)")


TableA4b_AIC_table <- data.frame(TableA4b_AIC, TableA4b_labels)

write.csv(TableA4b_AIC_table, "Table A4b AICs.csv")
write.csv(acf_fvalue_sensitivity7, "Table A4b anova acf spending sensitivity 7.csv")
write.csv(acf_fvalue_sensitivity8, "Table A4b anova acf spending sensitivity 8.csv")
write.csv(acf_fvalue_sensitivity9, "Table A4b anova acf spending sensitivity 9.csv")
