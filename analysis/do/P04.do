// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 4 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P04.log", replace

use "source/BtheB.dta"

/// 1)
/// a. Fit the random intercept model using  mixed. 

reshape long bdi@m, i(subject) j(month)
rename bdim bdi
recode bdi (999 =.)

mixed bdi treat month || subject:, mle
estimates store rintercept

/// b. Extend the model to a random intercept and slope model. 
mixed bdi treat month || subject: month, /* 
*/ cov(unstruc) mle 

estimates store rcoefficient

/// (i) Is the latter necessary? 
lrtest rcoefficient rintercept
* the p-value is insignifcant. there is an absence of evidence for a better fit using the random coefficient model (by introducing the u_i2 term for heterogeneity in slopes (what slope?)) compared to the random intercept model

/// c. Display the results of the random intercept and slope model.
estimates restore rintercept
predict pred_rintercept, fitted
estimates restore rcoefficient
predict pred_rcoefficient_fit, fitted

** comment: the trendlines look more-or-less parallel
* there is not a lot of variation among the slopes
* var(month) is very much closer to zero (compared to var(_cons)) 


// 2)  Check the assumptions of your final chosen model.
// a)	Investigate a possible therapy  time interaction.
// b)	Investigate whether there might be any nonlinear trend over time.
// c)	Check other model assumptions. 



log close