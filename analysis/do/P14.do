// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 14 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P14.log", replace


use "source/divorce_P14.dta"


// a) Declare the data to be survival data
stset dur, failure(divorce) id(id)

// b) List the survival functions
sts list in 1/20

// c) Plot the survival function.  Add the number of people censored, and the 95% confidence intervals.
sts graph, riskt ci
*** because the population is so big, it seems to be a smooth function rather than a step function

// d) Plot the hazard and cumulative hazard functions
sts graph, hazard

// e) Examine whether the survival functions differ by whether the male is older
sts graph, by(heolder) riskt
sts test heolder, logrank
* not significant

// f) Examine whether the survival functions differ by whether the relationship is mixrace
sts graph, by(mixrace) riskt
sts test mixrace, logrank
** significant

// g) Example whether the survival functions differ by whether the male was a school dropout
sts graph, by(hedropout) riskt
sts test hedropout, logrank
* significant


*** can we combine covariates? --> motivation for modelling covariates (covered in coming lectures)