# Generating results and statistics for Table A3c

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)

sensitivity1_initclaims <-  lme(initclaims_rate_regular ~ Restricted + NewCases
                                + DeltaNewCases,
                                data = Cleaned_Unemployment_Data, 
                                random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))

sensitivity2_initclaims <-  lme(initclaims_rate_regular ~ Restricted + NewDeaths
                                + DeltaNewDeaths,
                                data = Cleaned_Unemployment_Data, 
                                random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))

sensitivity3_initclaims <-  lme(initclaims_rate_regular ~ Restricted,
                                data = Cleaned_Unemployment_Data, 
                                random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))


tab_model(sensitivity1_initclaims, sensitivity2_initclaims, sensitivity3_initclaims,
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Table A3c", dv.labels = 
            c("Initial unemployment claims rate (Death rate removed)","Initial unemployment claims rate (Case rate removed)", "Initial unemployment claims rate (Death and case rates removed)"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A3c.html")

TableA3c_AIC <- numeric()
TableA3c_labels <- character()

initclaims_sensitivity1 <- summary(sensitivity1_initclaims)
initclaims_sensitivity2 <- summary(sensitivity2_initclaims)
initclaims_sensitivity3 <- summary(sensitivity3_initclaims)
initclaims_fvalue_sensitivity1 <- anova(sensitivity1_initclaims)
initclaims_fvalue_sensitivity2 <- anova(sensitivity2_initclaims)
initclaims_fvalue_sensitivity3 <- anova(sensitivity3_initclaims)

TableA3c_AIC <- append(TableA3c_AIC, AIC(initclaims_sensitivity1))
TableA3c_labels <- append(TableA3c_labels, "Initial unemployment claims model (death rate removed)")
TableA3c_AIC <- append(TableA3c_AIC, AIC(initclaims_sensitivity2))
TableA3c_labels <- append(TableA3c_labels, "Initial unemployment claims model (case rate removed)")
TableA3c_AIC <- append(TableA3c_AIC, AIC(initclaims_sensitivity3))
TableA3c_labels <- append(TableA3c_labels, "Initial unemployment claims model (case and death rates removed)")

TableA3c_AIC_table <- data.frame(TableA3c_AIC, TableA3c_labels)

write.csv(TableA3c_AIC_table, "Table A3c AICs.csv")
write.csv(initclaims_fvalue_sensitivity1, "Table A3c anova init claims sensitivity 1.csv")
write.csv(initclaims_fvalue_sensitivity2, "Table A3c anova init claims sensitivity 2.csv")
write.csv(initclaims_fvalue_sensitivity3, "Table A3c anova init claims sensitivity 3.csv")