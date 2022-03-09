// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 3 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P03.log", replace

use "source/BtheB.dta"

// 1) Display the time course of depression in the two treatment arms using a mean profile plot.


reshape long bdi@m, i(subject) j(month)
rename bdim bdi
recode bdi (999=.)


preserve

collapse (mean) BDImean=bdi (sd) BDIsd=bdi /*
*/ (count) BDIcount=bdi, by(treat month)
**** similar to df %>% group_by(...) %>% summarise(var=..., var=...)
gen upper=BDImean+1.96*(1/sqrt(BDIcount))*BDIsd
gen lower=BDImean-1.96*(1/sqrt(BDIcount))*BDIsd

* jitter
gen month1=month-0.02
gen month2=month+0.02

* plot
twoway /*
*/ (line BDImean month1 if treat==0, clcolor(black)) /*
*/ (line BDImean month2 if treat==1,clcolor(red)) /* 
*/ (rcap lower upper month1 if treat==0, blcolor(black)) /*
*/ (rcap lower upper month2 if treat==1, blcolor(red)), /*
*/ ytitle("BDI")  xtitle("month") /*
*/ xlab(2 3 5 8) /*
*/ legend(order(1 "Treatment as usual" 2 "BtheB" 3 "95% CI" 4 "95% CI")) /*
*/ name("mean_profile", replace)

restore


// 2)
// a. Fit a random intercept model to the depression data using xtreg. Investigate the effects of treatment and time. Assume that the group effect does not depend on time. 
xtreg bdi treat bdipre i.surgery i.duration month, i(subject) mle
estimates store rintercept_xtreg

// b. Display the modelling results in a graph.
predict pred_xtreg if e(sample), xbu

sort subject month
twoway (line pred_xtreg month, /*
*/ connect(ascending)), by(treat) /* 
*/ xlab(2 3 5 8) /*
*/ name("pred_xtreg", replace)

// 	c. Specifically answer the following questions:
// (i) What is the estimated effect of the BtheB therapy?
* statistically significant decrease of -3.88 in BDI

// (ii) How much of the residual variability can be explained by subject differences?
* rho = ICC = 65.8%

// (iii) Does a random intercept model fit the data better than a regression model?
* yes, significant LR test

// 3) Refit the random effects model using mixed. 
mixed bdi treat bdipre i.surgery i.duration month || subject:, mle
estimates store rintercept_mixed


log close