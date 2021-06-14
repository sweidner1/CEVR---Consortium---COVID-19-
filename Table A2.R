# Generating results and statistics for Table A2

library(tidyverse)
library(dbplyr)
library(lubridate)
library(anytime)
library(nlme)
library(sjPlot)
library(ggplot2)
library(ggthemes)
library(dynlm)


Spending_Weekly_Data_10state <- Spending_Weekly_Data %>%
  filter(Spending_Weekly_Data$State_Name == "California" |
           Spending_Weekly_Data$State_Name == "Illinois" |
           Spending_Weekly_Data$State_Name == "Kentucky" |
           Spending_Weekly_Data$State_Name == "Michigan" |
           Spending_Weekly_Data$State_Name == "Minnesota" |
           Spending_Weekly_Data$State_Name == "New Mexico" |
           Spending_Weekly_Data$State_Name == "Rhode Island" |
           Spending_Weekly_Data$State_Name == "Washington" |
           Spending_Weekly_Data$State_Name == "Oregon" |
           Spending_Weekly_Data$State_Name == "Pennsylvania")


Cleaned_Unemployment_Data_10state <- Cleaned_Unemployment_Data %>%
  filter(Cleaned_Unemployment_Data$State_name == "California" |
           Cleaned_Unemployment_Data$State_name == "Illinois" |
           Cleaned_Unemployment_Data$State_name == "Kentucky" |
           Cleaned_Unemployment_Data$State_name == "Michigan" |
           Cleaned_Unemployment_Data$State_name == "Minnesota" |
           Cleaned_Unemployment_Data$State_name == "New Mexico" |
           Cleaned_Unemployment_Data$State_name == "Rhode Island" |
           Cleaned_Unemployment_Data$State_name == "Washington" |
           Cleaned_Unemployment_Data$State_name == "Oregon" |
           Cleaned_Unemployment_Data$State_name == "Pennsylvania" |
           Cleaned_Unemployment_Data$State_name == "Arizona")

advncallspndmodel_rstrctd_weekly <- lme(spend_all ~ Restricted + NewCases + NewDeaths + DeltaNewCases +
                                          DeltaNewDeaths,
                                        data = Spending_Weekly_Data_10state, 
                                        random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

advncacfspndmodel_rstrctd_weekly <- lme(spend_acf ~ Restricted + NewCases + NewDeaths + DeltaNewCases +
                                          DeltaNewDeaths,
                                        data = Spending_Weekly_Data_10state, 
                                        random = ~1|statefips, correlation = corCAR1(form = ~ Week_Count | statefips))

advanced_init_claims_model_10state <- lme(initclaims_rate_regular ~ Restricted + NewCases + NewDeaths
                                          + DeltaNewCases + DeltaNewDeaths,
                                          data = Cleaned_Unemployment_Data_10state, 
                                          random = ~1|statefips, correlation = corCAR1(form = ~ Day_Count | statefips))


tab_model(advncallspndmodel_rstrctd_weekly, advncacfspndmodel_rstrctd_weekly, advanced_init_claims_model_10state, 
          pred.labels = c("(Intercept)", "Restricted","Case rate", "Death Rate", "Delta Case Rate", "Delta Death Rate"),
          title = "Table A2", dv.labels = c("Total Spending", "Restaurant/Accommodation Spending", 
                                                    "Initial Unemployment Claims Rate"),
          file = "C:\\Users\\Sam\\Desktop\\CEVR Covid Modeling Project Material\\Figures and plots\\Table A2.html")

TableA2_models_AIC <- numeric()
TableA2_models_labels <- character()
TableA2_Fvalues <- numeric()

acf_TableA2 <- summary(advncacfspndmodel_rstrctd_weekly)
all_TableA2 <- summary(advncallspndmodel_rstrctd_weekly)
init_TableA2 <- summary(advanced_init_claims_model_10state)
acf_TableA2_Fvalues <- anova(advncacfspndmodel_rstrctd_weekly)
all_TableA2_Fvalues <- anova(advncallspndmodel_rstrctd_weekly)
init_TableA2_Fvalues <- anova(advanced_init_claims_model_10state)

TableA2_models_AIC <- append(TableA2_models_AIC, AIC(acf_TableA2))
TableA2_models_labels <- append(TableA2_models_labels, "10 state restaurant and accommodation consumer spending model")
TableA2_models_AIC <- append(TableA2_models_AIC, AIC(all_TableA2))
TableA2_models_labels <- append(TableA2_models_labels, "10 state total consumer spending model")
TableA2_models_AIC <- append(TableA2_models_AIC, AIC(init_TableA2))
TableA2_models_labels <- append(TableA2_models_labels, "10 state initial unemployment claims model")

TableA2_AIC_table <- data.frame(TableA2_models_AIC, TableA2_models_labels)

write.csv(TableA2_AIC_table, "10 state models AIC.csv")
write.csv(acf_TableA2_Fvalues, "Anova table for Table A2 acf spending.csv")
write.csv(all_TableA2_Fvalues, "Anova table for Table A2 all spending.csv")
write.csv(init_TableA2_Fvalues, "Anova table for Table A2 initial claims rate.csv")
