# Generating results and statistics for Table A5b

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)


advanced_acf_weeklyspending_model <-  lme(spend_acf ~ Restricted + NewCases + NewDeaths +
                                            DeltaNewCases + DeltaNewDeaths,
                                          data = Spending_Weekly_Data, 
                                          random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

advanced_acf_weeklyspending_model_AR2 <-  lme(spend_acf ~ Restricted + NewCases + NewDeaths +
                                                DeltaNewCases + DeltaNewDeaths,
                                              data = Spending_Weekly_Data, 
                                              random = ~1|statefips, correlation = corARMA(c(0.2,0.2), form = ~ Week_Count| statefips, p=2, q = 0))

advanced_acf_weeklyspending_model_AR3 <-  lme(spend_acf ~ Restricted + NewCases + NewDeaths +
                                                DeltaNewCases + DeltaNewDeaths,
                                              data = Spending_Weekly_Data, 
                                              random = ~1|statefips, correlation = corARMA(c(0.2,0.2, 0.2), form = ~ Week_Count| statefips, p=3, q = 0))


advanced_acf_weeklyspending_modelAR1MA1 <-  lme(spend_acf ~ Restricted + NewCases + NewDeaths +
                                                  DeltaNewCases + DeltaNewDeaths,
                                                data = Spending_Weekly_Data, 
                                                random = ~1|statefips, correlation = corARMA(c(0.2,0.2), form = ~ Week_Count| statefips, p=1, q = 1))



advanced_acf_weeklyspending_modelMA1 <-  lme(spend_acf ~ Restricted + NewCases + NewDeaths +
                                               DeltaNewCases + DeltaNewDeaths,
                                             data = Spending_Weekly_Data, 
                                             random = ~1|statefips, correlation = corARMA(c(0.2), form = ~ Week_Count| statefips, p=0, q = 1))


advanced_acf_weeklyspending_modelMA2 <-  lme(spend_acf ~ Restricted + NewCases + NewDeaths +
                                               DeltaNewCases + DeltaNewDeaths,
                                             data = Spending_Weekly_Data, 
                                             random = ~1|statefips, correlation = corARMA(c(0.2,0.2), form = ~ Week_Count| statefips, p=0, q = 2))


tab_model(advanced_acf_weeklyspending_model, advanced_acf_weeklyspending_model_AR2, advanced_acf_weeklyspending_model_AR3,
           advanced_acf_weeklyspending_modelMA1,advanced_acf_weeklyspending_modelMA2,
          advanced_acf_weeklyspending_modelAR1MA1,
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Varying covariance structures for restaurant and accommodation spending models", dv.labels = 
            c("Restaurant/Accommodation Spending AR1", "Restaurant/Accommodation Spending AR2","Restaurant/Accommodation Spending AR3",
              "Restaurant/Accommodation Spending MA1", "Restaurant/Accommodation Spending MA2", "Restaurant/Accommodation Spending AR1MA1"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A5b.html")


covariance_models_restaurant_spending_AICs <- numeric()
covariance_models_restaurant_spending_labels <- character()

acf_AR1 <- summary(advanced_acf_weeklyspending_model)
acf_AR2 <- summary(advanced_acf_weeklyspending_model_AR2)
acf_AR3 <- summary(advanced_acf_weeklyspending_model_AR3)
acf_MA1 <- summary(advanced_acf_weeklyspending_modelMA1)
acf_MA2 <- summary(advanced_acf_weeklyspending_modelMA2)
acf_AR1MA1 <- summary(advanced_acf_weeklyspending_modelAR1MA1)
acf_AR1_fvalues <- anova(advanced_acf_weeklyspending_model)
acf_AR2_fvalues <- anova(advanced_acf_weeklyspending_model_AR2)
acf_AR3_fvalues <- anova(advanced_acf_weeklyspending_model_AR3)
acf_MA1_fvalues <- anova(advanced_acf_weeklyspending_modelMA1)
acf_MA2_fvalues <- anova(advanced_acf_weeklyspending_modelMA2)
acf_AR1MA1_fvalues <- anova(advanced_acf_weeklyspending_modelAR1MA1)

covariance_models_restaurant_spending_AICs <- append(covariance_models_restaurant_spending_AICs, AIC(advanced_acf_weeklyspending_model))
covariance_models_restaurant_spending_labels <- append(covariance_models_restaurant_spending_labels, "AR1 model AIC")
covariance_models_restaurant_spending_AICs <- append(covariance_models_restaurant_spending_AICs, AIC(advanced_acf_weeklyspending_model_AR2))
covariance_models_restaurant_spending_labels <- append(covariance_models_restaurant_spending_labels, "AR2 model AIC")
covariance_models_restaurant_spending_AICs <- append(covariance_models_restaurant_spending_AICs, AIC(advanced_acf_weeklyspending_model_AR3))
covariance_models_restaurant_spending_labels <- append(covariance_models_restaurant_spending_labels, "AR3 model AIC")
covariance_models_restaurant_spending_AICs <- append(covariance_models_restaurant_spending_AICs, AIC(advanced_acf_weeklyspending_modelMA1))
covariance_models_restaurant_spending_labels <- append(covariance_models_restaurant_spending_labels, "MA1 model AIC")
covariance_models_restaurant_spending_AICs <- append(covariance_models_restaurant_spending_AICs, AIC(advanced_acf_weeklyspending_modelMA2))
covariance_models_restaurant_spending_labels <- append(covariance_models_restaurant_spending_labels, "MA2 model AIC")
covariance_models_restaurant_spending_AICs <- append(covariance_models_restaurant_spending_AICs, AIC(advanced_acf_weeklyspending_modelAR1MA1))
covariance_models_restaurant_spending_labels <- append(covariance_models_restaurant_spending_labels, "AR1MA1 model AIC")



covariance_models_restaurant_spending_table <- data.frame(covariance_models_restaurant_spending_AICs, covariance_models_restaurant_spending_labels)

write.csv(covariance_models_restaurant_spending_table, "ACF spending models - different covariance structures.csv")
write.csv(acf_AR1_fvalues, "Acf spending models - different covariance structures - AR1 f values.csv")
write.csv(acf_AR2_fvalues, "Acf spending models - different covariance structures - AR2 f values.csv")
write.csv(acf_AR3_fvalues, "Acf spending models - different covariance structures - AR3 f values.csv")
write.csv(acf_MA1_fvalues, "Acf spending models - different covariance structures - MA1 f values.csv")
write.csv(acf_MA2_fvalues, "Acf spending models - different covariance structures - MA2 f values.csv")
write.csv(acf_AR1MA1_fvalues, "Acf spending models - different covariance structures - AR1MA1 f values.csv")
