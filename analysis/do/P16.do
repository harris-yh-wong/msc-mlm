// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 17 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P17.log", replace



use "source/catheter.dta"

**********************
***** Exercise 1 *****
**********************

stset time, id(patient) failure(infect)
// a) Fit a Weibull shared parameter model with gamma frailty for patient
streg age female, distribution(weibull) frailty(gamma) shared(patient) nolog
estimates store ex1_weibull
estat ic
/*
Significant theta -- 
Significant protective effect of female
Insignificant effect of age
*/

// b) Fit a Weibull shared parameter model with inverse normal frailty
streg age female, distribution(weibull) frailty(invgaussian) shared(patient) nolog
estimates store ex1_invgaussian
estat ic

/*
fairly similar estimates
AIC,BIC lower, 
marginally smaller log-likelihood 
both LRtests give significant
We would probably select the gamma distribution
*/


**********************
***** Exercise 2 *****
**********************


// a) Declare the data to be survival data


// b) Plot the survival function with 95% intervals


// c) Fit a Weibull shared parameter model with gamma frailty for centre and fixed effects for x1 and x2


// d) Fit a Weibull shared parameter model with inverse Gaussian frailty for centre and fixed effects for x1 and x2


// e) Fit a Cox model with shared frailty for centre and fixed effects for x1 and x2


// f) Fit a mixed effect survival model, with a random intercept and Weibull distribution, adjusting for fixed effects of x1 and x2
/*
- it seems could not converge / likelihood with 'discontinuous region encountered' 
- classmates report converging with distribution(lognormal)
*/ 





/*
Q1 
estat ic could not be used with Cox models
It only use partial likelihood -- so it is not fitted with ML


Q2 
visualizing data and choosing the distribution
it probably depends on your own knowledge of the shape of the distribution
certainly plotting is not a bad idea...

*/