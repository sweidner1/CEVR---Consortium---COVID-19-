# Generating results and statistics for Table A3a

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)

sensitivity1_spend_all <-  lme(spend_all ~ Restricted + NewCases +
                                 DeltaNewCases,
                               data = Spending_Weekly_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

sensitivity2_spend_all <-  lme(spend_all ~ Restricted + NewDeaths +
                                 DeltaNewDeaths,
                               data = Spending_Weekly_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

sensitivity3_spend_all <-  lme(spend_all ~ Restricted,
                               data = Spending_Weekly_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))


tab_model(sensitivity1_spend_all, sensitivity2_spend_all, sensitivity3_spend_all,
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Table A3a", dv.labels = 
            c("Total consumer Spending (Death rate removed)","Total consumer Spending (Case rate removed)", "Total consumer Spending (Death and case rates removed)"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A3a.html")

TableA3a_AIC <- numeric()
TableA3a_labels <- character()
TableA3a_Fvalues <- numeric()

all_sensitivity1 <- summary(sensitivity1_spend_all)
all_sensitivity2 <- summary(sensitivity2_spend_all)
all_sensitivity3 <- summary(sensitivity3_spend_all)
all_fvalue_sensitivity1 <- anova(sensitivity1_spend_all)
all_fvalue_sensitivity2 <- anova(sensitivity2_spend_all)
all_fvalue_sensitivity3 <- anova(sensitivity3_spend_all)

TableA3a_AIC <- append(TableA3a_AIC, AIC(all_sensitivity1))
TableA3a_labels <- append(TableA3a_labels, "total consumer spending model (death rate removed)")
TableA3a_AIC <- append(TableA3a_AIC, AIC(all_sensitivity2))
TableA3a_labels <- append(TableA3a_labels, "total consumer spending model (case rate removed)")
TableA3a_AIC <- append(TableA3a_AIC, AIC(all_sensitivity3))
TableA3a_labels <- append(TableA3a_labels, "total consumer spending model (case and death rates removed)")


TableA3a_AIC_table <- data.frame(TableA3a_AIC, TableA3a_labels)

write.csv(TableA3a_AIC_table, "Table A3a AICs.csv")
write.csv(all_fvalue_sensitivity1, "Table A3a anova all spending sensitivity 1.csv")
write.csv(all_fvalue_sensitivity2, "Table A3a anova all spending sensitivity 2.csv")
write.csv(all_fvalue_sensitivity3, "Table A3a anova all spending sensitivity 3.csv")