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

replace substmis=8 if substmis==0
* consider "0" to be "none"


/* Q1 */
tab2 therapy sex
tab2 therapy substmis
tab2 therapy episode
tabstat base yearsofe ageentr dup, by(therapy) stat(p50 sd)


/* Q2 */ 
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

frame copy default default_cp
frame rename default wide



****** RESHAPING
frame default_cp {
	reshape long panss, i(idnumber) j(month)
	sort idnumber
	label variable month "month of PANSS measurement"
	label variable panss "PANSS score"
}
frame rename default_cp long


frame long {
	****** TRANSFORM OUTCOME
	gen logpanss=log10(panss)
	label variable logpanss "PANSS score (log10)"
	// gen transformed=sqrt(panss-30) if panss>25
	// scatter logp transformed || function y = x, ra(logp) clpat(dash)

	gen logbase=log10(base+1)
	label variable logbase "PANSS score at baseline (log10 p+1)"
}







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

///// RESTRICTING TO SUBJECTS WITH MONOTONE MISSINGNESS

frame copy wide monotone_miss 
frame change monotone_miss

** generate flag for monotone missingness 
gen monotone_miss=0
replace monotone_miss = 1 if /*
*/ (panss1!=. & panss3!=. & panss9!=. & panss18!=.) | /*
*/ (panss1!=. & panss3!=. & panss9!=. & panss18==.) | /*
*/ (panss1!=. & panss3!=. & panss9==. & panss18==.) | /*
*/ (panss1!=. & panss3==. & panss9==. & panss18==.)
label variable monotone_miss "binary flag for monotone missingness"

* assure monotone_miss is valid
misstable pattern panss1 panss3 panss9 panss18 if monotone_miss==1, freq bypattern asis

** Restricting the sample to those participants with monotonic missingness
keep if monotone_miss==1


///// PLOTTING MEAN SCORE BY DROPOUT PATTERN

frame copy monotone_miss dropout_ptrn_viz
frame change dropout_ptrn_viz

///// CLONE THE BASELINE VARIABLE FOR PLOTTING
clonevar panss0 = base
** number of non-missing observations by individual
egen nobs=rownonmiss(panss*)
label variable nobs "number of non-missing PANSS measurements"

///// PREPARING THE DATA

** Reshaping
reshape long panss, i(idnumber) j(month)
sort idnumber
label variable month "month of PANSS measurement"
label variable panss "PANSS score"

//// VISUALIZE DATA

** recode month
recode month (0=0) (1=6) (3=12) (9=36) (18=72), generate(week)
label variable week "week of PANSS measurement"

** visualization: mean trajectory by group
keep if nobs>1
by week nobs, sort: egen panss_ptrn = mean(panss)
qui reshape wide panss_ptrn, i(idnumber week) j(nobs)

#delimit ;
twoway line panss_ptrn* week, sort 
	title("Observed mean PANSS by dropout pattern") 
	ytitle("PANSS score") 
	xlabel(0 6 12 36 72)
	legend(
		cols(1) textwidth(60)
		lab(1 "Dropout at 6 weeks")
		lab(2 "Dropout at 3 months")
		lab(3 "Dropout at 6 months")
		lab(4 "Completers")
	)
	name("jm_mean_score_by_dropout_ptrn", replace)
;
#delimit cr







///// MODELLING

***** MODEL 5A
mixed panss interven##i.week || idnumber:
estimates store mod_5a


** delete rows corresponding to missing measurement
drop if panss==.




///// START

frame copy monotone_miss joint_modelling
frame change joint_modelling

** number of non-missing observations by individual
egen nobs=rownonmiss(panss*)
label variable nobs "number of non-missing PANSS measurements"

///// PREPARING THE DATA

** Reshaping
reshape long panss, i(idnumber) j(month)
sort idnumber
label variable month "month of PANSS measurement"
label variable panss "PANSS score"

** recode month
recode month (0=0) (1=6) (3=12) (9=36) (18=72), generate(week)
label variable week "week of PANSS measurement"

** generate analysis time
drop if panss==.
bysort idnumber: egen survtime = max(week)


** preprocessing
bysort idnumber: gen start = week
bysort idnumber: gen stop = start[_n+1]
gen event = 0
gen episode1st = 2-episode
bysort idnumber: replace stop = survtime if _n==_N
bysort idnumber: replace event = episode1st if _n==_N

tab interven, gen(interven_)

stset stop, enter(start) failure(event=1) id(idnumber)
stjm panss interven_1 interven_2, /*
*/ panel(idnumber) survmodel(weibull) ffp(1) /*
*/ timeinteraction(interven_1 interven_2) /*
*/ survcov(interven_1 interven_2) /*
*/ intassociation nocurrent gh(10)


/*
 
** number of non-missing observations by individual
egen nobs=rownonmiss(panss*)
label variable nobs "number of non-missing PANSS measurements"

///// PREPARING THE DATA

** Reshaping
reshape long panss, i(idnumber) j(month)
sort idnumber
label variable month "month of PANSS measurement"
label variable panss "PANSS score"

//// VISUALIZE DATA

** recode month
recode month (0=0) (1=6) (3=12) (9=36) (18=72), generate(week)
label variable week "week of PANSS measurement"

** generate analysis time
drop if panss==.
bysort idnumber: egen survtime = max(week)

drop month
reshape wide panss, i(idnumber) j(week)

*/

/*

stset survtime, failure(inform=1) id(indv)
streg i.treat, distribution(weibull) nohr 
stcurve, surv at1(treat=1) at2(treat=2) at3(treat=3)

*Reshape the data for joint modelling
reshape long PANSS, i(indv) j(week)
drop if PANSS==.

*Create the correct format for stjm models
bys indv: gen start = week
bys indv: gen stop = start[_n+1]
gen event = 0
bys indv: replace stop = survtime if _n==_N
bys indv: replace event = inform if _n==_N

tab treat, gen(trt)

stset stop, enter(start) failure(event=1) id(indv)
stjm PANSS trt2 trt3, panel(indv) survm(w) ffp(1) timeinteraction(trt2 trt3) survcov(trt2 trt3) intassociation nocurrent gh(10)

*/ 
















** TRANSFORM OUTCOME
gen logpanss=log10(panss)
label variable logpanss "PANSS score (log10)"
gen logbase=log10(base+1)
label variable logbase "PANSS score at baseline (log10 p+1)"
	 
log close
