# CEVR---Consortium---COVID-19-
## **Overview:**  
The project used regression to estimate the impact of business restrictions on economic activity.  The unit of analysis was a state during a particular week.  
  
#### Outcomes (economic activity) included:  
* *Total consumer spending* – percent change since January 2020;  
* *Consumer spending on restaurants and accommodations* – percent change since January 2020;  
* *Weekly initial unemployment claims* – Percent of the 2019 US labor force.  

#### Predictors included:  
* *Restricted* – binary variable indicating if a state was “mostly closed” during a particular week  
* *NewCases* – state-specific, population-normalized daily case incidence (e.g., cases per day per 100,000 population)for a state during a particular week;  
* *NewDeaths* - state-specific, population-normalized daily mortality (e.g., deaths per day per 100,000 population) for a state during a particular week;  
* *DeltaNewCases* – Change in NewCases over the preceding two weeks;  
* *DeltaNewDeaths* – Change in NewDeaths over the preceding two weeks;  
    
    
## Variables - Details     
#### Total consumer spending  
* We created values using data from the Opportunity Insights Economic Tracker data repository, file *“Affinity - State – Daily.csv”*, column labeled spend_all.  We used data columns labeled “month”, “day”, and “statefips” to identify the state and week for each spending value. The data in the repository represents daily seven-day moving averages, and we retained one value for each week (each Sunday spanning the period September 20, 2020 to December 27, 2020). See below for step by step documentation describing how we downloaded and cleaned the data.   

#### Spending_restaurants_accommodations
* We created values using data from the Opportunity Insights Economic Tracker data repository, file *“Affinity - State – Daily.csv”*, column labeled spend_acf.  We used data columns labeled “month”, “day”, and “statefips” to identify the state and week for each spending value. The data in the repository represents daily seven-day moving averages, and we retained one value for each week (each Sunday spanning the period September 20, 2020to December 27, 2020). See below for step by step documentation describing how we downloaded and cleaned the data. 

#### Initial_weekly_UE_claims
* We created values using data from the Opportunity Insights Economic Tracker data repository, file *“UI Claims - State – Weekly.csv”*, column labeled initclaims_rate_regular.  We used data columns labeled “month”, “day_endofweek”, and “statefips” to identify the state and week for each spending value. The data in the repository represents weekly initial unemployment claims rate values, and we retained one value for each week (each Saturday spanning the period September 20, 2020to December 27, 2020). See below for step by step documentation describing how we downloaded and cleaned the data. 

#### Restricted
* We created base case values and three sets of alternative values to use in sensitivity analyses.
  * Base case values come from the New York Times database. Source data from the NY Times are available here (https://www.nytimes.com/interactive/2020/us/states-reopen-map-coronavirus.html).  We established the value for each week in each state by reviewing the contents of the NY Times database. If the NY Times database classified a state as “mostly closed”, we assigned Restricted a value of TRUE (Restricted = 1).  Otherwise (NY Times classifications of “open” or “marginally closed”), we assigned Restricted a value of FALSE (Restricted = 0).  Our designations appear in the files *“Generated Data for Analysis – Spending”* and *“Generated Data for Analysis – Unemployment”* in our GITHUB repository. See below for step by step documentation on how we downloaded and cleaned this data, and then merged it with our outcome dataset. 
  * **Sensitivity analysis 1** – Assign Restricted a value of TRUE only after restrictions have been in place in a state for at least 14 days.  Our designations appear in the files *“Generated Data for Analysis – Spending”* and *“Generated Data for Analysis – Unemployment”* in our GITHUB repository See below for step by step documentation on how we downloaded and cleaned this data, and then merged it with our outcome dataset.
  * **Sensitivity analysis 2** – Assign Restricted a value of TRUE only if the restrictions in place lasted for at least 21 days total.  Our designations appear in the files *“Generated Data for Analysis – Spending”* and *“Generated Data for Analysis – Unemployment”* in our GITHUB repository . See below for step by step documentation on how we downloaded and cleaned this data, and then merged it with our outcome dataset.
  * **Sensitivity analysis 3** – Assign Restricted a value of TRUE only if restrictions imposed have indoor dining fully closed.  Our designations appear in the files *“Generated Data for Analysis – Spending”* and *“Generated Data for Analysis – Unemployment”* in our GITHUB repository . See below for step by step documentation on how we downloaded and cleaned this data, and then merged it with our outcome dataset.

#### NewCases
* We created values using data from the Opportunity Insights Economic Tracker data repository, file *“COVID - State – Daily.csv”*, column labeled new_case_rate. We used data columns labeled “month”, “day”, and “statefips” to identify the state and week for each case rate value. The data in the repository represents a seven day moving average of new confirmed COVID cases in each particular state per 100,000 people in the state, and we retained one value for each week (creating separate files to correspond to the spending data reported on Sundays and the unemployment file reported on Saturdays). See below for step by step documentation describing how we downloaded and cleaned the data. 

#### NewDeaths
* We created values using data from the Opportunity Insights Economic Tracker data repository, file *“COVID - State – Daily.csv”*, column labeled new_death_rate. We used data columns labeled “month”, “day”, and “statefips” to identify the state and week for each death rate value. The data in the repository represents a seven day moving average of new confirmed COVID deaths in each particular state per 100,000 people in the state, and we retained one value for each week (creating separate files to correspond to the spending data reported on Sundays and the unemployment file reported on Saturdays). See below for step by step documentation describing how we downloaded and cleaned the data.

#### DeltaNewCases
* We created values using our data on new case rate from the Opportunity Insights Economic data repository, file *“COVID - State – Daily.csv”*. We took our column new_case_rate, and created this variable representing the rate of change in new_case_rate relative to two weeks prior. We matched each newly generated DeltaNewCases value to a particular week and state using the data columns “month”, “day”, and “statefips”. The file containing these DeltaNewCases (new_case_rate rate of change compared to two weeks prior) are stored in our GITHUB data repository in the files *“Generated Data for Analysis – Spending”* and *“Generated Data for Analysis – Unemployment”*.

#### DeltaNewDeaths
* We created values using our data on new death rate from the Opportunity Insights Economic data repository, file *“COVID - State – Daily.csv”*. We took our column new_death_rate, and created this variable representing the rate of change in new_death_rate relative to two weeks prior. We matched each newly generated DeltaNewDeaths value to a particular week and state using the data columns “month”, “day”, and “statefips”. The file containing these DeltaNewDeaths (new_death_rate rate of change compared to two weeks prior) are stored in our GITHUB data repository in the files *“Generated Data for Analysis – Spending”* and *“Generated Data for Analysis – Unemployment”*.

## Analysis – Details
We aimed to estimate the cost of COVID-19 state level business restrictions on state economies in the United States. Our analysis is conducted on weekly data observations, with each state (or D.C.) having weekly observations for the duration of our analysis’s timeline (September-December). Our main economic outcomes were total consumer spending, restaurant and accommodation spending, and the initial unemployment claims weekly rate, and we get this data from the Opportunity Insights Economic Tracker data repository. We have five explanatory variables, with one being of primary interest. Our primary explanatory variable is called Restricted, this is a binary variable that we created based on data from a NYTimes database regarding each states business restriction status as “mostly closed”, “marginally closed”, or “open” over time. We have a primary version of this variable, and three alternative versions used for sensitivity analyses. Our remaining explanatory variables are seven day moving averages of COVID new case rate, COVID new death rate, and the rates of change in these variables compared to two weeks prior, and we get our case and death data also from the Opportunity Insights Economic Tracker GITHUB repository. We ran a regression analysis using these variables, along with controls for state level differences in spending and employment and correlation between data points that are close together in time, and derived our results on the impact of state restrictions on spending and unemployment claims. 

#### Regression Analyses:
1.	**Base Case Analysis**: In our base case analyses we regressed each of our three outcomes, total consumer spending, restaurant and accommodation spending, and initial unemployment claims rate against five explanatory variables, including our primary variable of interest. The explanatory variables were as described above, Restricted, NewCases, NewDeaths, DeltaNewCases, and DeltaNewDeaths. Restricted served as our treatment variable helping us isolate the impact of state restrictions on our outcome variables, with the other four explanatory variables serving to control for the effects of case rates and death rates on our outcome variables. We included controls in our regression for the state level nesting of our data and controls for the correlation between outcome observations close together in units of time present in our time series data. See below for a step by step procedure of how to run this analysis and view the results.  
2.	**Ten state subgroup analysis**: In our ten state subgroup analysis we ran the same regression model as in our base case analysis, but we restricted our dataset to only data from the ten states that at some point had a value of TRUE for Restricted (Restricted = 1) i.e. were at some point under strict state level business restrictions. See below for a step by step procedure of how to run this analysis and view the results.
3.	**Sensitivity Analysis** – Removing case rate, death rate, and removing both as explanatory variables: In this sensitivity analysis we reran our base case regression for all outcomes with certain explanatory variables taken out. For the first sensitivity we took out NewCases and DeltaNewCases as explanatory variables, for the second we took out NewDeaths and DeltaNewDeaths, and for the third we took out all four of those leaving only Restricted in the equation. See below for a step by step procedure of how to run these analyses and view their results.
4.	**Sensitivity Analysis** – Alternate Definitions of Restricted: For the second sensitivity analysis we ran all of our base case regressions with our three alternate definitions of the Restricted variable. The first alternate definition imposed that Restricted did not update to a value of TRUE until the state level restrictions had been in place for at least two weeks. The second alternate definition imposed that Restricted did not update to a value of TRUE unless the state level restrictions in place were set to last for at least three in total duration. The third and final alternate definition imposed that Restricted did not update to a value of TRUE unless indoor dining was fully shut down as a result of the state level restrictions in question. See below for a step by step procedure on how to run these analyses and view their results. 
5.	**Sensitivity Analysis** – Alternate assumptions for outcome correlations over time: For our third and final sensitivity analysis we ran all of our base case regressions again with alternate assumptions for outcome correlations over time. In our base case, we implemented a first order autoregressive correlation structure. In our sensitivity analyses, we tried implementing higher order autoregressive structures, different orders of moving average correlation structures, and combinations of the two different structures. See below for a step by step procedure on how to run these analyses and view their results. 

#### Downloading and cleaning raw data:
1. To produce *“Final_Spending_COVID_Data.csv”* (file with outcome and explanatory variables for total consumer spending analysis and restaurant and accommodation spending analysis)
   1. From the Opportunity Insights Economic Tracker data repository (hosted on GITHUB), download the *“Affinity - State – Daily.csv”* file and the *“COVID - State - Daily.csv”* file. 
   2. From our GITHUB repository download the *“Generated Data for Analysis - Spending.csv”* file 
   3.	Store the CSVs in an accessible folder or R drive on your computer. 
   4.	Download the *“Data Cleaning.R”* R code script from our GITHUB repository.
   5.	Utilizing the R software in R Studio, open *“Data Cleaning.R”* and update the three fields within the read.csv() functions to access the correct folder containing the files below (the relevant fields to update are marked with commented code)
        * *“Affinity - State – Daily.csv”*
        *	*“COVID - State - Daily.csv”*
        *	*“Generated Data for Analysis - Spending.csv”*
   6.	Run *“Data Cleaning.R”*
   7.	Save the output of *“Final_Spending_COVID_Data.csv”* with your desired file name. This file is ready to be run through any of the analysis code files for the total consumer spending analysis, or the restaurant and accommodation spending analysis (base cases or sensitivities)
2.	To produce *“Final_Unemployment_COVID_Data.csv”* (file with outcome and explanatory variables for the Initial Unemployment Claims Rate Analysis)
    1.	From the Opportunity Insights Economic Tracker data repository (hosted on GITHUB), download the *“UI Claims - State - Weekly .csv”* file and the *“COVID - State - Daily.csv”* file. 
    2.	From our GITHUB repository download the *“Generated Data for Analysis - Unemployment.csv”* file 
    3.	Store the CSVs in an accessible folder or R drive on your computer. 
    4.	Download the *“Data Cleaning.R”* R code script from our GITHUB repository.
    5.	Utilizing the R software in R Studio, open *“Data Cleaning.R”* and update the three fields within the read.csv() functions to access the correct folder containing the files below (the relevant fields to update are marked with commented code)
    	   * *“UI Claims - State - Weekly.csv”*
         * *“COVID - State - Daily.csv”*
         * *“Generated Data for Analysis - Unemployment.csv”*
    6.	Run *“Data Cleaning.R”*
    7.	Save the output of *“Final_Unemployment_COVID_Data.csv”* with your desired file name. This file is ready to be run through any of the analysis code files for the initial unemployment claims rate analysis (base case or sensitivities)

#### Running analysis and generating results tables:
1.	Descriptive Statistics Table (Table 1)
    1.	Upload the *“Final_Spending_COVID_Data.csv”* file to R studio and save it in R as *“Spending_Weekly_Data”*
    2.	Upload the “Final_Unemployment_COVID_Data.csv” file to R studio and save it in R as *“Cleaned_Unemployment_Data”*
    3.	Download *“Table 1.R”* from our GITHHUB repository.
    4.	Save resulting CSV file *“summary_stats_table.csv”* with all descriptive statistics to your preferred destination.
  
Output will include:
*	*“summary_stats_table.csv”* (CSV containing all the most relevant descriptive statistics for our data)
  
2.	Running base case analyses for all three outcomes (Table 2)
    1.	Repeat steps 1a and 1b (above)
    2.	Download “Base Case.R” from our GITHHUB repository. 
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include:
*	*"Base Case.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions 

3.	Sensitivity Table – Models limited to 10 states (Table 3)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A2.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A2.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions 

4.	Sensitivity Table – Total consumer spending (removing case rate, death rate, or both as explanatory variables) (Table 4)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A3a.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A3a.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

5.	Sensitivity Table – Restaurant and Accommodation Spending (removing case rate, death rate, or both as explanatory variables) (Table 5)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A3b.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A3a.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

6.	Sensitivity Table – Weekly initial unemployment claims rate (removing case rate, death rate, or both as explanatory variables) (Table 6)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A3c.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A3c.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

7.	Sensitivity Table – Total consumer spending (alternate definitions of Restricted) (Table 7)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A4a.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A4a.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

8.	Sensitivity Table – Restaurant and Accommodation Spending (Alternate definitions of Restricted) (Table 8)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A4b.R”* from our GITHUB repository
    2.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A4b.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

9.	Sensitivity Table – Weekly initial unemployment claims rate (Alternate definitions of Restricted) (Table 9)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A4c.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A4c.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

10.	Sensitivity Table – Total consumer spending (Alternate assumptions for outcome correlations over time) (Table 10)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A5a.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A5a.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

11.	Sensitivity Table – Restaurant and Accommodation Spending (Alternate assumptions for outcome correlations over time) (Table 11)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A5b.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.
  
Output will include
*	*"Table A5b.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions

12.	Sensitivity Table – Weekly Initial Unemployment Claims Rate (Table 12)
    1.	Repeat steps 1a and 1b (above)
    2.	Download *“Table A5c.R”* from our GITHUB repository
    3.	Adjust destination for HTML table with regression results within code to preferred destination.

Output will include
*	*"Table A5c.HTML"* (regression results, coefficients and standard error)
*	CSV containing AIC values for regressions
*	CSVs containing F values for regressions
