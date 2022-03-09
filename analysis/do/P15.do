// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 15 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P15.log", replace


use "source/divorce_P15.dta"



// The objective of this practical is to model the times from marriage to divorce using accelerated failure time models. We simultaneously model the effect of husband's race, mixed couple status, husband's education status, older husband and older wife on marriage survival. 

// 1)	Generate the putative predictor variables from the variables in the study data set.
stset dur, failure(divorce) id(id)

gen mixrace = ( heblack & !sheblack) | ( sheblack & !heblack)
gen hedropout = hiseduc<12
gen hecollege = hiseduc>=16 if hiseduc<.
gen heolder = agediff > 10 if agediff<.
gen sheolder = agediff < -10
*** imagine this is the same as one-hot encoding the agediff as < -10, within -10 and 10, and >10



// 2)	Fit a Weibull AFT model with this set of predictor variables.
streg heblack mixrace hedropout hecollege heolder sheolder, distribution(weibull) time

***** BEFORE FITTING THE MODEL
***** SHOULD PLOT OUT THE OBSERVED DATA
sts graph, hazard
* the raw data is the peak in hazard at around t=7 (7 years after marriage). 

// 3)	Interpret the effect of the putative predictor variables on the time scale. Which variables predict divorce. What are the predicted effects?
streg heblack mixrace hedropout hecollege heolder sheolder, distribution(weibull) time tratio
** While holder other covariates unchanged,
** The time to failure for a 'black' husband is estimated to be reduce by a factor of 0.81 compared to a non-'black' husband (statistically significant)
** The time to failure for mix-race status is estimated to reduce by a factor of ... (statistically significant)

stcurve, survival at1(heblack=1) at2(heblack=0)
stcurve, survival at1(mixrace=1) at2(mixrace=0)
stcurve, survival at1(hedropout=1) at2(hedropout=0)
stcurve, survival at1(sheolder=1) at2(sheolder=0)

// 4)	Interpret the effect of the putative predictor variables on the hazard function scale. How is the hazard function estimated to change with each significant predictor? How do the regression coefficient relate to the ones considered in the previous question?
streg heblack mixrace hedropout hecollege heolder sheolder, distribution(weibull)
estimates store weibull
** While holder other covariates unchanged,
** The hazard for divroce for a 'black' husband is estimated to increase by a factor of 1.20 compared to a non-'black' husband (statistically significant)
** The hazard for divorce for mix-race couple is estimated to increase by a factor of 1.24  (statistically significant)
** The hazard for divorce for a couple, in which the wife is 10 yearso r more older than the husband, is estimated to increase by a factor of 1.24  (statistically significant)

stcurve, hazard at1(heblack=1) at2(heblack=0)
stcurve, hazard at1(mixrace=1) at2(mixrace=0)
stcurve, hazard at1(hedropout=1) at2(hedropout=0)
stcurve, hazard at1(sheolder=1) at2(sheolder=0)

* we may or may not be making the correct parametric assumptions
* unfortunately, the weibull model does not seem to be a very good fit to the observed data.




// 5)	As an alternative fit a log-normal AFT for the divorce times. Discuss which of the two might be the better model. 

streg heblack mixrace hedropout hecollege heolder sheolder, distribution(lognormal)

estimates store lognormal
estat ic

estimates restore weibull
estat ic

** weibull has slighlty higher AIC and BIC

