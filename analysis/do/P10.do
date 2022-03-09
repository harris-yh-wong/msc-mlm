// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 10 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P10.log", replace

use "source/Schiz_long.dta"
describe


** in practice we probably want to keep the original score, but not binning into categories

// 1. Declare the dataset to be longitudinal data and describe the response patterns in the data
tsset id week
hist impso, discrete
* the highest number of observations in Category 2, lowest in Category 1


// 2. Generate an interaction between treatment and time
gen trt_wk = treatment * week

// 3. Use an ordinal logistic regression that accounts for clustering using robust standard errors to estimate the effect of treatment on impso score using a longitudinal model.


** robust standard error -- although being a valid inference approach, it may not be the as

// Hint: use an appropriate function of time as a covariate and identify the most parsimonious model that may include additional baseline covariates to include.

// Interpret the effect of each of the coefficients in your model.




// 4. Estimate the effect of treatment on impso using an appropriate mixed model with a random intercepts.
meologit impso week treatment trt_wk base || id:, or
estimates store meologit_rint

// Interpret the effect of each of the coefficients in your model.
** 70% reduction in the odds score resulting in a lower category of SCZ score if in the treatment group vs in the control group


// 5. Consider whether the model you selected in question 3 could be improved by including a random coefficient for time.

* this adds the random effect for the effect of time on score by each subject
meologit impso week treatment trt_wk base || id: week, cov(unstruc) or
estimates store meologit_rcoef

// Hint: consider the correlation between the random effects


// Does this improve the fit of the model?
lrtest meologit_rint meologit_rcoef
** highly significant p-value, 
* here, df = 2, because there are two new variables 
* (i) var(week) -- this is the ....
* (ii) cov(week, _cons) -- this is the ...

*** THIS WOULD BE THE FORMAT OF THE ASSIGNMENT
*** NO SINGLE RIGHT ANSWER, BUT NEED TO JUSTIFY THE FINAL MODEL CHOSEN

// 6. Estimate the effect of treatment on impso at week 6 by centring the time variable
gen cent_week = 6 - week
tsset id cent_week

meologit 
* at week 6, 
* the odds of having a worst score are 99% reduced in the treatment group 
* (well probably unrealistic but this is just a simulated dataset)


// 7. Consider using a non-linear effect of time such as the square root of week in the model you selected in Question 4.




***** 
/*
how ML handles missing data is basically to ignore them.
i.e. a complete case analysis, in which higher-level units (e.g. persons) with any measurements missing (e.g. in a timepoint) would be dropped
This is so-called 'LOW EFFICIENCY'.
This requires the MAR assumption (not MCAR because ...).
-  Normally in a trials context, the frequent forms are treatment group and baseline measurement. As long as you include these two, then basically we can assume MAR.
-  In observational data, this would be more troublesome because there would be potentially more variables that may affect the missing data generation mechanism.


** in this course we would not be doing multiple imputation

Therefore, in the other approach (which is ... )
there would be variation, hence the "Obs per group", "min;avg;max" in the modelling output.


*/
