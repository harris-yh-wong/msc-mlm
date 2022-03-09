// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 2 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P02_.log", replace

use "source/oest.dta"

gen id=_n

// 1. Use only the first 4 visits but in the following analyses treat measurements for subject as observation units. This means that you have to use the data in long format. To start with ignore the dependency between the repeated measurements of a subject. 

// a)	Carry out a standard regression analysis to investigate the effects of group and time. 
reshape long v, i(id) j(time)
keep if inlist(time, 1,2,3,4)

preserve
regress v group time

// 2. We assumed independence of the observations within a subject in the previous regression analysis.
 
// a)	Check the assumption by correlating the residuals of each visit with each other.

predict resid, residual
reshape wide v resid, i(id) j(time)
estimates store OLS
corr resid*
restore

// b)	Is the assumption of independence violated?
* There is clearly positive correlation between repeated measures. 
* It appears that the size of the correlation decreases with increasing distance between visits.
* There is violation of the i.d.d. assumption
 

// 3. Use regression with standard errors that are robust against correlations within clusters to correct for the within cluster dependency. 
regress v group time, robust cluster(id)
estimates store OLS_robust

// a)	Do the standard error and confidence intervals of the parameter estimates change?
* SE increases, CI width increases

// b)	What would you have expected?
* 

log close