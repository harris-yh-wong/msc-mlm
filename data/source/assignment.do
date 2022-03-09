clear all
graph drop _all

use "Socrates_dataset.dta"
log using "assignment2.log", replace

/*
DATA CLEANING
*/
gen male=2-sex
label variable male "sex recoded to binary"
rename panss0 base
label variable base "PANSS score at baseline"

/* EDA, Q1-Q3

*! ANOMALIES
list if therapy==3 & therapi<.
* irrelevant therapist IDs


/*
EXPLORATORY ANALYSIS
*/
tab2 centre therapy, miss
* crossed clustering design with 3 centres in total

tab2 centre therapis, miss
* no therapist treats patients in >1 centre
* therapist is at a lower hierarchical level than centre. 



/*
1. 
Describe the baseline characteristics of the sample in this study. Consider if the randomization was adequately performed and the relevance of the sample to the target population. [3 marks] 
*/
tabstat base, by(therapy) stat(mean sd min p25 p50 p75 max range iqr)

tab2 therapy sex, chi miss
tab2 therapy episode, chi miss
tab2 therapy substmis, chi miss
*? do we need to conduct any statistical test?

/*
2. 
Summarize the patterns of missing data in the PANSS measure over time. [5 marks] 
*/
misstable summarize base panss1 panss3 panss9 panss18
misstable patterns base panss1 panss3 panss9 panss18, asis bypattern
misstable tree base panss1 panss3 panss9 panss18, asis


/*
3. 
Describe the statistical methods to be used in question 4, including any justification of covariates used in models, and, if relevant, any underlying assumptions of the statistical methods. 
Note: You may wish to structure this as the methods section of a journal article. [12 marks] 
*/

*/ 


/* Q4
Estimate the treatment effect of the combined intervention arm to routine care alone on PANSS scores at 18 months. 
Check the robustness of your results by performing suitable sensitivity analyses. 
[25 marks]

You should consider the following: 
• An appropriate longitudinal model, based on scaling of the time variable 
• Any additional sources of clustering in the data 
• An appropriate random effect structure, based on model comparisons 
• Choice of baseline variables to include in the model 
• Validity of underlying statistical assumptions 
• Graphical displays to summarise the findings from the modelling 
*/

frame copy default wide 

****** RESHAPING
frame default {
	reshape long panss, i(idnumber) j(month)
	sort idnumber
	label variable month "month of PANSS measurement"
	label variable panss "PANSS score"
}
frame rename default long
frame change long


****** TRANSFORM OUTCOME
gen logpanss=log10(panss)
label variable logpanss "PANSS score (log10)"
// gen transformed=sqrt(panss-30) if panss>25
// scatter logp transformed || function y = x, ra(logp) clpat(dash)

gen logbase=log10(base+1)
label variable logbase "PANSS score at baseline (log10 p+1)"





****** CHECK COVARIANCE STRUCTURE
preserve
keep logp panss idnumber month
reshape wide logp panss, i(idnumber) j(month)
corr panss*
/*
			 |   panss1   panss3   panss9  panss18
-------------+------------------------------------
	  panss1 |   1.0000
	  panss3 |   0.6567   1.0000
	  panss9 |   0.4815   0.6035   1.0000
	 panss18 |   0.4684   0.5757   0.6389   1.0000
*/

corr logp*
/*
			 |    logp1    logp3    logp9   logp18
-------------+------------------------------------
	   logp1 |   1.0000
	   logp3 |   0.6639   1.0000
	   logp9 |   0.4452   0.6000   1.0000
	  logp18 |   0.4558   0.5533   0.6447   1.0000

*/ 
restore





****** MODEL 1:
****** random intercept and random slope

mixed panss /*
*/ base i.month i.therapy male i.episode /*
*/ || centre: || idnumber : month, /*
*/ cov(unstr) mle
estimates store model1


*** ASSUMPTION CHECKING
estimates restore model1

predict resid, residual
predict rslope2 rslope rintercept, reffects
predict pred_rslope if e(sample), fitted

* (1) Normality
hist resid, name("hist_resid", replace)
hist rintercept if month==1, name("hist_rint", replace)
hist rslope if month==1, name("hist_rslope", replace)

* (2) Homoskedasticity
scatter resid pred_rslope, name("resid_v_fitted", replace)

* (3) residual variance over other covariates
* (3a) over time
graph box resid, over(month) name("resid_var_over_time", replace)
* (3b) over group
graph box resid, over(therapy) name("resid_var_over_therapy", replace)


/*
5
It is important to consider the impact of missing outcome data on the results. Restricting the sample to those participants with monotonic missingness, use a joint modelling approach to assess if non-random dropout might have influenced the estimates of the treatment effects.  Explain your findings.
[10 marks]
*/

///// MONOTONIC MISSINGNESS FLAG
frame change wide

gen monotone_miss=.
replace monotone_miss = 1 if /*
*/ (panss1==. & panss3==. & panss9==. & panss18==.) | /*
*/ (panss1==. & panss3==. & panss9==. & panss18!=.) | /*
*/ (panss1==. & panss3==. & panss9!=. & panss18!=.) | /*
*/ (panss1==. & panss3!=. & panss9!=. & panss18!=.)

* asssure monotone_miss is valid
* complete nesting if monotone_miss ==1 
misstable nested base panss1 panss3 panss9 panss18 if monotone_miss==1


///// SURVIVAL MODELLING
stset 
stjm 

	 
log close
