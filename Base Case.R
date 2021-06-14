# Generating results and statistics for Table A1

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

advanced_all_weeklyspending_model <-  lme(spend_all ~ Restricted + NewCases + NewDeaths +
                                            DeltaNewCases + DeltaNewDeaths,
                                          data = Spending_Weekly_Data, 
                                          random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count| statefips))

advanced_init_claims_model <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                  + DeltaNewCases + DeltaNewDeaths,
                                  data = Cleaned_Unemployment_Data, 
                                  random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))

tab_model(advanced_all_weeklyspending_model, advanced_acf_weeklyspending_model, advanced_init_claims_model, 
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Base Case Models", dv.labels = c("Total Spending", "Restaurant/Accommodation Spending", 
          "Initial Unemployment Claims Rate"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A1.html")

Base_case_models_AIC <- numeric()
Base_case_models_labels <- character()

acf <- summary(advanced_acf_weeklyspending_model)
all <- summary(advanced_all_weeklyspending_model)
init <- summary(advanced_init_claims_model)
acf_fvalues <- anova(advanced_acf_weeklyspending_model)
all_fvalues <- anova(advanced_all_weeklyspending_model)
init_fvalues <- anova(advanced_init_claims_model)

Base_case_models_AIC <- append(Base_case_models_AIC, AIC(acf))
Base_case_models_labels <- append(Base_case_models_labels, "restaurant and accommodation consumer spending model")
Base_case_models_AIC <- append(Base_case_models_AIC, AIC(all))
Base_case_models_labels <- append(Base_case_models_labels, "total consumer spending model")
Base_case_models_AIC <- append(Base_case_models_AIC, AIC(init))
Base_case_models_labels <- append(Base_case_models_labels, "initial unemployment claims model")

Base_case_tableA1 <- data.frame(Base_case_models_AIC, Base_case_models_labels)

write.csv(Base_case_tableA1, "Base Case AIC.csv")
write.csv(all_fvalues, "Base Case all spending F values.csv")
write.csv(acf_fvalues, "Base Case acf spending F values.csv")
write.csv(init_fvalues, "Base Case initial UI claims F values.csv")




