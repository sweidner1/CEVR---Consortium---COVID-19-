# Generating results and statistics for Table A5a

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)


advanced_all_weeklyspending_model <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                            DeltaNewCases + DeltaNewDeaths,
                                          data = Spending_Weekly_Data, 
                                          random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

advanced_all_weeklyspending_model_AR2 <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                                DeltaNewCases + DeltaNewDeaths,
                                              data = Spending_Weekly_Data, 
                                              random = ~1|statefips, correlation = corARMA(c(0.2,0.2), form = ~ Week_Count| statefips, p=2, q = 0))

advanced_all_weeklyspending_model_AR3 <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                                DeltaNewCases + DeltaNewDeaths,
                                              data = Spending_Weekly_Data, 
                                              random = ~1|statefips, correlation = corARMA(c(0.2,0.2, 0.2), form = ~ Week_Count| statefips, p=3, q = 0))

advanced_all_weeklyspending_model_AR4 <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                                DeltaNewCases + DeltaNewDeaths,
                                              data = Spending_Weekly_Data, 
                                              random = ~1|statefips, correlation = corARMA(c(0.2,0.2, 0.2, 0.2), form = ~ Week_Count| statefips, p=4, q = 0))


advanced_all_weeklyspending_modelAR1MA1 <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                                  DeltaNewCases + DeltaNewDeaths,
                                                data = Spending_Weekly_Data, 
                                                random = ~1|statefips, correlation = corARMA(c(0.2,0.2), form = ~ Week_Count| statefips, p=1, q = 1))

advanced_all_weeklyspending_modelAR1MA2 <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                                  DeltaNewCases + DeltaNewDeaths,
                                                data = Spending_Weekly_Data, 
                                                random = ~1|statefips, correlation = corARMA(c(0.2,0.2, 0.2), form = ~ Week_Count| statefips, p=1, q = 2))


advanced_all_weeklyspending_modelMA1 <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                               DeltaNewCases + DeltaNewDeaths,
                                             data = Spending_Weekly_Data, 
                                             random = ~1|statefips, correlation = corARMA(c(0.2), form = ~ Week_Count| statefips, p=0, q = 1))


advanced_all_weeklyspending_modelMA2 <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                               DeltaNewCases + DeltaNewDeaths,
                                             data = Spending_Weekly_Data, 
                                             random = ~1|statefips, correlation = corARMA(c(0.2,0.2), form = ~ Week_Count| statefips, p=0, q = 2))


tab_model(advanced_all_weeklyspending_model, advanced_all_weeklyspending_model_AR2, advanced_all_weeklyspending_model_AR3,
          advanced_all_weeklyspending_model_AR4, advanced_all_weeklyspending_modelMA1,advanced_all_weeklyspending_modelMA2,
          advanced_all_weeklyspending_modelAR1MA1,advanced_all_weeklyspending_modelAR1MA2,
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Varying covariance structures for total consumer spending models", dv.labels = 
            c("Total consumer Spending AR1", "Total consumer Spending AR2","Total consumer Spending AR3",
              "Total consumer Spending AR4", "Total consumer Spending MA1", "Total consumer Spending MA2",
              "Total consumer Spending AR1MA1","Total consumer Spending AR1MA2"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A5a.html")


covariance_models_total_spending_AICs <- numeric()
covariance_models_total_spending_labels <- character()

all_AR1 <- summary(advanced_all_weeklyspending_model)
all_AR2 <- summary(advanced_all_weeklyspending_model_AR2)
all_AR3 <- summary(advanced_all_weeklyspending_model_AR3)
all_AR4 <- summary(advanced_all_weeklyspending_model_AR4)
all_MA1 <- summary(advanced_all_weeklyspending_modelMA1)
all_MA2 <- summary(advanced_all_weeklyspending_modelMA2)
all_AR1MA1 <- summary(advanced_all_weeklyspending_modelAR1MA1)
all_AR1MA2 <- summary(advanced_all_weeklyspending_modelAR1MA2)
all_AR1_fvalues <- anova(advanced_all_weeklyspending_model)
all_AR2_fvalues <- anova(advanced_all_weeklyspending_model_AR2)
all_AR3_fvalues <- anova(advanced_all_weeklyspending_model_AR3)
all_AR4_fvalues <- anova(advanced_all_weeklyspending_model_AR4)
all_MA1_fvalues <- anova(advanced_all_weeklyspending_modelMA1)
all_MA2_fvalues <- anova(advanced_all_weeklyspending_modelMA2)
all_AR1MA1_fvalues <- anova(advanced_all_weeklyspending_modelAR1MA1)
all_AR1MA2_fvalues <- anova(advanced_all_weeklyspending_modelAR1MA2)

covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_model))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "AR1 model AIC")
covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_model_AR2))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "AR2 model AIC")
covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_model_AR3))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "AR3 model AIC")
covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_model_AR4))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "AR4 model AIC")
covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_modelMA1))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "MA1 model AIC")
covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_modelMA2))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "MA2 model AIC")
covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_modelAR1MA1))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "AR1MA1 model AIC")
covariance_models_total_spending_AICs <- append(covariance_models_total_spending_AICs, AIC(advanced_all_weeklyspending_modelAR1MA2))
covariance_models_total_spending_labels <- append(covariance_models_total_spending_labels, "AR1MA2 model AIC")


covariance_models_total_spending_table <- data.frame(covariance_models_total_spending_AICs, covariance_models_total_spending_labels)

write.csv(covariance_models_total_spending_table, "All spending models - different covariance structures.csv")
write.csv(all_AR1_fvalues, "All spending models - different covariance structures - AR1 f values.csv")
write.csv(all_AR2_fvalues, "All spending models - different covariance structures - AR2 f values.csv")
write.csv(all_AR3_fvalues, "All spending models - different covariance structures - AR3 f values.csv")
write.csv(all_AR4_fvalues, "All spending models - different covariance structures - AR4 f values.csv")
write.csv(all_MA1_fvalues, "All spending models - different covariance structures - MA1 f values.csv")
write.csv(all_MA2_fvalues, "All spending models - different covariance structures - MA2 f values.csv")
write.csv(all_AR1MA1_fvalues, "All spending models - different covariance structures - AR1MA1 f values.csv")
write.csv(all_AR1MA2_fvalues, "All spending models - different covariance structures - AR1MA2 f values.csv")

