# Data cleaning 

library(caret)

COVID_Statistics_Raw <- read.csv("C:\\Users\\sweidner\\Desktop\\COVID modeling project\\Data files to be cleaned\\COVID - State - Daily.csv", header = TRUE)
Spending_Statistics_Raw <- read.csv("C:\\Users\\sweidner\\Desktop\\COVID modeling project\\Data files to be cleaned\\Affinity - State - Daily.csv", header = TRUE)
Unemployment_Statistics_Raw <-read.csv("C:\\Users\\sweidner\\Desktop\\COVID modeling project\\Data files to be cleaned\\UI Claims - State - Weekly.csv", header = TRUE)

COVID_Statistics_Raw_Spending <- subset(COVID_Statistics_Raw, statefips != 11)
COVID_Statistics_Raw_Spending <- COVID_Statistics_Raw_Spending[!(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 9 & COVID_Statistics_Raw_Spending$day == 20) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 9 & COVID_Statistics_Raw_Spending$day == 27) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 10 & COVID_Statistics_Raw_Spending$day == 4) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 10 & COVID_Statistics_Raw_Spending$day == 11) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 10 & COVID_Statistics_Raw_Spending$day == 18) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 10 & COVID_Statistics_Raw_Spending$day == 25) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 11 & COVID_Statistics_Raw_Spending$day == 1) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 11 & COVID_Statistics_Raw_Spending$day == 8) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 11 & COVID_Statistics_Raw_Spending$day == 15) |
                                                     !(COVID_Statistics_Raw_Spending$statefips == 50 & COVID_Statistics_Raw_Spending$month == 11 & COVID_Statistics_Raw_Spending$day == 29),]
COVID_Statistics_Raw_Spending <- subset(COVID_Statistics_Raw_Spending, (month == 9 & day == 20) | (month == 9 & day == 27) | (month == 10 & day == 4) |
                                                               (month == 10 & day == 11) | (month == 10 & day == 18) | (month == 10 & day == 25) |
                                                               (month == 11 & day == 1) | (month == 11 & day == 8) | (month == 11 & day == 15) |
                                                               (month == 11 & day == 22) | (month == 11 & day == 29) | (month == 12 & day == 6) |
                                                               (month == 12 & day == 13) | (month == 12 & day == 20) | (month == 12 & day == 27))


Spending_Statistics_Raw <- subset(Spending_Statistics_Raw, statefips != 11)
Spending_Statistics_Raw <- Spending_Statistics_Raw[!(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 9 & Spending_Statistics_Raw$day == 20) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 9 & Spending_Statistics_Raw$day == 27) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 10 & Spending_Statistics_Raw$day == 4) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 10 & Spending_Statistics_Raw$day == 11) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 10 & Spending_Statistics_Raw$day == 18) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 10 & Spending_Statistics_Raw$day == 25) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 11 & Spending_Statistics_Raw$day == 1) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 11 & Spending_Statistics_Raw$day == 8) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 11 & Spending_Statistics_Raw$day == 15) |
                                                     !(Spending_Statistics_Raw$statefips == 50 & Spending_Statistics_Raw$month == 11 & Spending_Statistics_Raw$day == 29),]
Spending_Statistics_Raw <- subset(Spending_Statistics_Raw, (month == 9 & day == 20) | (month == 9 & day == 27) | (month == 10 & day == 4) |
                                    (month == 10 & day == 11) | (month == 10 & day == 18) | (month == 10 & day == 25) |
                                    (month == 11 & day == 1) | (month == 11 & day == 8) | (month == 11 & day == 15) |
                                    (month == 11 & day == 22) | (month == 11 & day == 29) | (month == 12 & day == 6) |
                                    (month == 12 & day == 13) | (month == 12 & day == 20) | (month == 12 & day == 27))

COVID_Statistics_Raw_UI <- COVID_Statistics_Raw[!(COVID_Statistics_Raw$statefips == 33 & COVID_Statistics_Raw$month == 9 & COVID_Statistics_Raw$day == 19),]
COVID_Statistics_Raw_UI <- COVID_Statistics_Raw_UI[!(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 9 & COVID_Statistics_Raw_UI$day == 19) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 9 & COVID_Statistics_Raw_UI$day == 26) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 10 & COVID_Statistics_Raw_UI$day == 3) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 10 & COVID_Statistics_Raw_UI$day == 10) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 10 & COVID_Statistics_Raw_UI$day == 17) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 10 & COVID_Statistics_Raw_UI$day == 24) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 10 & COVID_Statistics_Raw_UI$day == 31) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 11 & COVID_Statistics_Raw_UI$day == 7) |
                                                             !(COVID_Statistics_Raw_UI$statefips == 50 & COVID_Statistics_Raw_UI$month == 11 & COVID_Statistics_Raw_UI$day == 14),]
COVID_Statistics_Raw_UI <- subset(COVID_Statistics_Raw_UI, (month == 9 & day == 19) | (month == 9 & day == 26) | (month == 10 & day == 3) |
                                          (month == 10 & day == 10) | (month == 10 & day == 17) | (month == 10 & day == 24) |
                                          (month == 10 & day == 31) | (month == 11 & day == 7) | (month == 11 & day == 14) |
                                          (month == 11 & day == 21) | (month == 11 & day == 28) | (month == 12 & day == 5) |
                                          (month == 12 & day == 12) | (month == 12 & day == 19))


Unemployment_Statistics_Raw <- Unemployment_Statistics_Raw[!(Unemployment_Statistics_Raw$statefips == 33 & Unemployment_Statistics_Raw$month == 9 & Unemployment_Statistics_Raw$day_endofweek == 19),]
Unemployment_Statistics_Raw <- Unemployment_Statistics_Raw[!(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 9 & Unemployment_Statistics_Raw$day_endofweek == 19) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 9 & Unemployment_Statistics_Raw$day_endofweek == 26) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 10 & Unemployment_Statistics_Raw$day_endofweek == 3) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 10 & Unemployment_Statistics_Raw$day_endofweek == 10) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 10 & Unemployment_Statistics_Raw$day_endofweek == 17) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 10 & Unemployment_Statistics_Raw$day_endofweek == 24) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 10 & Unemployment_Statistics_Raw$day_endofweek == 31) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 11 & Unemployment_Statistics_Raw$day_endofweek == 7) |
                                      !(Unemployment_Statistics_Raw$statefips == 50 & Unemployment_Statistics_Raw$month == 11 & Unemployment_Statistics_Raw$day_endofweek == 14),]
Unemployment_Statistics_Raw <- subset(Unemployment_Statistics_Raw, (month == 9 & day_endofweek == 19) | (month == 9 & day_endofweek == 26) | (month == 10 & day_endofweek == 3) |
                                    (month == 10 & day_endofweek == 10) | (month == 10 & day_endofweek == 17) | (month == 10 & day_endofweek == 24) |
                                    (month == 10 & day_endofweek == 31) | (month == 11 & day_endofweek == 7) | (month == 11 & day_endofweek == 14) |
                                    (month == 11 & day_endofweek == 21) | (month == 11 & day_endofweek == 28) | (month == 12 & day_endofweek == 5) |
                                    (month == 12 & day_endofweek == 12) | (month == 12 & day_endofweek == 19))
index_UI <- c(1:713)
Unemployment_Statistics_Raw$index <- index_UI
COVID_Statistics_Raw_UI$index <- index_UI
Unemployment_COVID_Data <- merge(Unemployment_Statistics_Raw, COVID_Statistics_Raw_UI, by.x = "index", by.y = "index")
index_spend <- c(1:750)
Spending_Statistics_Raw$index <- index_spend
COVID_Statistics_Raw_Spending$index <- index_spend
Spending_COVID_Data <- merge(Spending_Statistics_Raw, COVID_Statistics_Raw_Spending, by.x = "index", by.y = "index")

Spending_COVID_Data <- transform(Spending_COVID_Data, dataobsID = paste0(month.x,day.x,statefips.x))
Unemployment_COVID_Data <- transform(Unemployment_COVID_Data, dataobsID = paste0(month.x,day_endofweek,statefips.x))

write.csv(Spending_COVID_Data, "Spending_COVID_Data.csv")
write.csv(Unemployment_COVID_Data, "Unemployment_COVID_Data.csv")

internal_data_spending <- read.csv("C:\\Users\\sweidner\\Desktop\\COVID modeling project\\Data we generated\\Generated Data for Analysis - Spending.csv", header = TRUE)
internal_data_unemployment <- read.csv("C:\\Users\\sweidner\\Desktop\\COVID modeling project\\Data we generated\\Generated Data for Analysis - Unemployment.csv", header = TRUE)

Final_Spending_COVID_Data <- merge(Spending_COVID_Data, internal_data_spending, by.x = "dataobsID", by.y = "dataobsID")
Final_Unemployment_COVID_Data <- merge(Unemployment_COVID_Data, internal_data_unemployment, by.x = "dataobsID", by.y = "dataobsID")


write.csv(Final_Spending_COVID_Data, "Final_Spending_COVID_Data.csv")
write.csv(Final_Unemployment_COVID_Data, "Final_Unemployment_COVID_Data.csv")


