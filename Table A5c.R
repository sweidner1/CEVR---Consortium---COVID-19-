# Generating results and statistics for Table A5c

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)


advanced_init_claims_model <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                  + DeltaNewCases + DeltaNewDeaths,
                                  data = Cleaned_Unemployment_Data, 
                                  random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))

advanced_init_claims_modelAR2 <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                     + DeltaNewCases + DeltaNewDeaths,
                                     data = Cleaned_Unemployment_Data, 
                                     random = ~1|statefips, correlation = corARMA(c(0.2,0.2),form = ~ Day_Count | statefips,p=2, q = 0))

advanced_init_claims_modelAR3 <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                     + DeltaNewCases + DeltaNewDeaths,
                                     data = Cleaned_Unemployment_Data, 
                                     random = ~1|statefips, correlation = corARMA(c(0.2,0.2,0.2),form = ~ Day_Count | statefips,p=3, q = 0))

advanced_init_claims_modelMA1 <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                     + DeltaNewCases + DeltaNewDeaths,
                                     data = Cleaned_Unemployment_Data, 
                                     random = ~1|statefips, correlation = corARMA(c(0.2),form = ~ Day_Count | statefips,p=0, q = 1))

advanced_init_claims_modelMA2 <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                     + DeltaNewCases + DeltaNewDeaths,
                                     data = Cleaned_Unemployment_Data, 
                                     random = ~1|statefips, correlation = corARMA(c(0.2,0.2),form = ~ Day_Count | statefips,p=0, q = 2))

advanced_init_claims_modelAR1MA1 <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                        + DeltaNewCases + DeltaNewDeaths,
                                        data = Cleaned_Unemployment_Data, 
                                        random = ~1|statefips, correlation = corARMA(c(0.2,0.2),form = ~ Day_Count | statefips,p=1, q = 1))

advanced_init_claims_modelAR1MA2 <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                        + DeltaNewCases + DeltaNewDeaths,
                                        data = Cleaned_Unemployment_Data, 
                                        random = ~1|statefips, correlation = corARMA(c(0.2,0.2,0.2),form = ~ Day_Count | statefips,p=1, q = 2))


tab_model(advanced_init_claims_model, advanced_init_claims_modelAR2, advanced_init_claims_modelAR3,
           advanced_init_claims_modelMA1,advanced_init_claims_modelMA2,
          advanced_init_claims_modelAR1MA1,advanced_init_claims_modelAR1MA2,
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Varying covariance structures for initial unemployment claims rate models", dv.labels = 
            c("initial unemployment claims rate AR1", "Initial unemployment claims rate AR2","Initial unemployment claims rate AR3",
               "Initial unemployment claims rate MA1", "Initial unemployment claims rate MA2",
              "Initial unemployment claims rate AR1MA1","Initial unemployment claims rate AR1MA2"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A5c.html")


covariance_models_initclaims_AICs <- numeric()
covariance_models_initclaims_labels <- character()

initclaims_AR1 <- summary(advanced_init_claims_model)
initclaims_AR2 <- summary(advanced_init_claims_modelAR2)
initclaims_AR3 <- summary(advanced_init_claims_modelAR3)
initclaims_MA1 <- summary(advanced_init_claims_modelMA1)
initclaims_MA2 <- summary(advanced_init_claims_modelMA2)
initclaims_AR1MA1 <- summary(advanced_init_claims_modelAR1MA1)
initclaims_AR1MA2 <- summary(advanced_init_claims_modelAR1MA2)
initclaims_AR1_fvalues <- anova(advanced_init_claims_model)
initclaims_AR2_fvalues <- anova(advanced_init_claims_modelAR2)
initclaims_AR3_fvalues <- anova(advanced_init_claims_modelAR3)
initclaims_MA1_fvalues <- anova(advanced_init_claims_modelMA1)
initclaims_MA2_fvalues <- anova(advanced_init_claims_modelMA2)
initclaims_AR1MA1_fvalues <- anova(advanced_init_claims_modelAR1MA1)
initclaims_AR1MA2_fvalues <- anova(advanced_init_claims_modelAR1MA2)

covariance_models_initclaims_AICs <- append(covariance_models_initclaims_AICs, AIC(advanced_init_claims_model))
covariance_models_initclaims_labels <- append(covariance_models_initclaims_labels, "AR1 model AIC")
covariance_models_initclaims_AICs <- append(covariance_models_initclaims_AICs, AIC(advanced_init_claims_modelAR2))
covariance_models_initclaims_labels <- append(covariance_models_initclaims_labels, "AR2 model AIC")
covariance_models_initclaims_AICs <- append(covariance_models_initclaims_AICs, AIC(advanced_init_claims_modelAR3))
covariance_models_initclaims_labels <- append(covariance_models_initclaims_labels, "AR3 model AIC")
covariance_models_initclaims_AICs <- append(covariance_models_initclaims_AICs, AIC(advanced_init_claims_modelMA1))
covariance_models_initclaims_labels <- append(covariance_models_initclaims_labels, "MA1 model AIC")
covariance_models_initclaims_AICs <- append(covariance_models_initclaims_AICs, AIC(advanced_init_claims_modelMA2))
covariance_models_initclaims_labels <- append(covariance_models_initclaims_labels, "MA2 model AIC")
covariance_models_initclaims_AICs <- append(covariance_models_initclaims_AICs, AIC(advanced_init_claims_modelAR1MA1))
covariance_models_initclaims_labels <- append(covariance_models_initclaims_labels, "AR1MA1 model AIC")
covariance_models_initclaims_AICs <- append(covariance_models_initclaims_AICs, AIC(advanced_init_claims_modelAR1MA2))
covariance_models_initclaims_labels <- append(covariance_models_initclaims_labels, "AR1MA2 model AIC")


covariance_models_initclaims_table <- data.frame(covariance_models_initclaims_AICs, covariance_models_initclaims_labels)

write.csv(covariance_models_initclaims_table, "Initial unemployment claims rate - different covariance structures.csv")
write.csv(initclaims_AR1_fvalues, "Initclaims rate models - different covariance structures - AR1 f values.csv")
write.csv(initclaims_AR2_fvalues, "Initclaims rate models - different covariance structures - AR2 f values.csv")
write.csv(initclaims_AR3_fvalues, "Initclaims rate models - different covariance structures - AR3 f values.csv")
write.csv(initclaims_MA1_fvalues, "Initclaims rate models - different covariance structures - MA1 f values.csv")
write.csv(initclaims_MA2_fvalues, "Initclaims rate models - different covariance structures - MA2 f values.csv")
write.csv(initclaims_AR1MA1_fvalues, "Initclaims rate models - different covariance structures - AR1MA1 f values.csv")
write.csv(initclaims_AR1MA2_fvalues, "Initclaims rate models - different covariance structures - AR1MA2 f values.csv")
