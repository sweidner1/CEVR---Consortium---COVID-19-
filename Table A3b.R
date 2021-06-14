# Generating results and statistics for Table A3b

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)

sensitivity1_spend_acf <-  lme(spend_acf ~ Restricted + NewCases +
                                 DeltaNewCases,
                               data = Spending_Weekly_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

sensitivity2_spend_acf <-  lme(spend_acf ~ Restricted + NewDeaths +
                                 DeltaNewDeaths,
                               data = Spending_Weekly_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

sensitivity3_spend_acf <-  lme(spend_acf ~ Restricted,
                               data = Spending_Weekly_Data, 
                               random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))


tab_model(sensitivity1_spend_acf, sensitivity2_spend_acf, sensitivity3_spend_acf,
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Table A3b", dv.labels = 
            c("Restaurant/Accommodation Spending (Death rate removed)","Restaurant/Accommodation Spending (Case rate removed)", "Restaurant/Accommodation Spending (Death and case rates removed)"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A3b.html")

TableA3b_AIC <- numeric()
TableA3b_labels <- character()

acf_sensitivity1 <- summary(sensitivity1_spend_acf)
acf_sensitivity2 <- summary(sensitivity2_spend_acf)
acf_sensitivity3 <- summary(sensitivity3_spend_acf)
acf_fvalue_sensitivity1 <- anova(sensitivity1_spend_acf)
acf_fvalue_sensitivity2 <- anova(sensitivity2_spend_acf)
acf_fvalue_sensitivity3 <- anova(sensitivity3_spend_acf)

TableA3b_AIC <- append(TableA3b_AIC, AIC(acf_sensitivity1))
TableA3b_labels <- append(TableA3b_labels, "restaurant and accommodation consumer spending model (death rate removed)")
TableA3b_AIC <- append(TableA3b_AIC, AIC(acf_sensitivity2))
TableA3b_labels <- append(TableA3b_labels, "restaurant and accommodation consumer spending model (case rate removed)")
TableA3b_AIC <- append(TableA3b_AIC, AIC(acf_sensitivity3))
TableA3b_labels <- append(TableA3b_labels, "restaurant and accommodation consumer spending model (case and death rates removed)")


TableA3b_AIC_table <- data.frame(TableA3b_AIC, TableA3b_labels)

write.csv(TableA3b_AIC_table, "Table A3b AICs.csv")
write.csv(acf_fvalue_sensitivity1, "Table A3b anova acf spending sensitivity 1.csv")
write.csv(acf_fvalue_sensitivity2, "Table A3b anova acf spending sensitivity 2.csv")
write.csv(acf_fvalue_sensitivity3, "Table A3b anova acf spending sensitivity 3.csv")