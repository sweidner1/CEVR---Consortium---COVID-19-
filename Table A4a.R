# Generating results and statistics for Table 5

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)




sensitivity7_spend_all <- lme(spend_all ~ Restricted_2_weeks + NewCases + NewDeaths + DeltaNewCases +
                                DeltaNewDeaths,
                              data = Spending_Weekly_Data, 
                              random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))


sensitivity8_spend_all <- lme(spend_all ~ Restrictions_longer_3weeks + NewCases + NewDeaths + DeltaNewCases +
                                DeltaNewDeaths,
                              data = Spending_Weekly_Data, 
                              random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

sensitivity9_spend_all <- lme(spend_all ~ Restricted_indoor_dining + NewCases + NewDeaths + DeltaNewCases +
                                DeltaNewDeaths,
                              data = Spending_Weekly_Data, 
                              random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))


tab_model(sensitivity7_spend_all, sensitivity8_spend_all, sensitivity9_spend_all,
          pred.labels = c("(Intercept)", "Restricted (delayed effect)","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate",
                          "Restricted (at least 3 weeks)", "Restricted - no indoor dining"),
          title = "Table A4a", dv.labels = 
            c("Total consumer spending (restrictions delayed effect)", "Total consumer spending (restrictions last at least 3 weeks)", "Total consumer spending (indoor dining closed)"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A4a.html")


TableA4a_AIC <- numeric()
TableA4a_labels <- character()


all_sensitivity7<- summary(sensitivity7_spend_all)
all_sensitivity8 <- summary(sensitivity8_spend_all)
all_sensitivity9 <- summary(sensitivity9_spend_all)
all_fvalue_sensitivity7 <- anova(sensitivity7_spend_all)
all_fvalue_sensitivity8 <- anova(sensitivity8_spend_all)
all_fvalue_sensitivity9 <- anova(sensitivity9_spend_all)


TableA4a_AIC <- append(TableA4a_AIC, AIC(all_sensitivity7))
TableA4a_labels <- append(TableA4a_labels, "Total consumer spending model (Alternate Restricted definition - 2 week delay)")
TableA4a_AIC <- append(TableA4a_AIC, AIC(all_sensitivity8))
TableA4a_labels <- append(TableA4a_labels, "Total consumer spending model (Alternate Restricted definition - at least 3 weeks long)")
TableA4a_AIC <- append(TableA4a_AIC, AIC(all_sensitivity9))
TableA4a_labels <- append(TableA4a_labels, "Total consumer spending model (Alternate Restricted definition - indoor dining fully closed)")


TableA4a_AIC_fvalues_table <- data.frame(TableA4a_models_AIC, TableA4a_models_labels)

write.csv(TableA4a_AIC_fvalues_table, "Table A4a AICs.csv")
write.csv(all_fvalue_sensitivity7, "Table A4a anova all spending sensitivity 7.csv")
write.csv(all_fvalue_sensitivity8, "Table A4a anova all spending sensitivity 8.csv")
write.csv(all_fvalue_sensitivity9, "Table A4a anova all spending sensitivity 9.csv")

