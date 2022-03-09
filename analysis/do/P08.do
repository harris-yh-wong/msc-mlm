// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 8 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P08.log", replace

use "source/mood.dta"
describe

// 1. Summarise the variation across days and beep in Happy, Hopeless and Anger
tabstat Happy Hopeless Anger, by(Participant) stat(mean sd n)
* 
tabstat Happy Hopeless Anger, by(Day) stat(mean sd n)
* much less data in later days (e.g. especially Day 6)


****** some graphical display

// 2. Fit a variance components model for each of these symptoms
mixed Happy || Participant: || Day: 
estimates store happy_fixedint

mixed Hopeless || Participant: || Day: 
estimates store hopeless_fixedint

mixed Anger || Participant: || Day: 
estimates store anger_fixedint

// a)	Calculate the ICC at each level
estimates restore happy_fixedint
estat icc

estimates restore hopeless_fixedint
estat icc

estimates restore anger_fixedint
estat icc

// 3. Examine the hypothesis that Anger is a predictor of Happy
// a)	Using the concurrent measure of Anger
mixed Happy Anger || Participant: || Day:
estimates store happy_anger
* significant coefficient of  -.0780899


// b)	Using a lagged measure of Anger
sort Participant Day Beep

***** lagged varaibles
gen eplace Anger_lag1 = Anger[_n-1] if Day == Day[_n-1]
* replace Anger_lag1 = Anger[_n-1] if (Day == Day[_n-1] &  Part == Part[_n-1])
** well this does not work!!
gen Happy_lag1 = Happy[_n-1] if Day == Day[_n-1]

**the if-clause already prevents leakge across participants (only if participant has >1 day)
mixed Happy Anger_lag1 || Participant: || Day:
estimates store happy_angerlag1
*** using anger lag(1), the coefficient becomes smaller and statistially insignificant
** intuitively, that means that the association between anger now and happiness later is much weaker than the association betwen anger now and happiness now


// c)	Adjusting each of these models for BDI
mixed Happy Anger BDI || Participant: || Day:
estimates store happy_anger_adjBDI
* stronger (?)
mixed Happy Anger_lag1 BDI || Participant: || Day:
estimates store happy_angerlag1_adjBDI
* still insignificant

// 4. Examine the moderating effect of alcohol_misuse on these associations and consider displaying this graphically

** moderation is statistically insignificant, 
** the association between __ and __ is more-or-less unchanged by alcohol misuse
** graphically, the 'slopes' of the inverse relationships between alcohol misuse (Y/N) do not vary too much



// 5. Repeat questions 3 and 4 testing the hypothesis that Anger is a predictor of Hopeless




***** the idea of 'stress testing'  the model
* but then the problem is the 

** modelling (e.g. testing for associations) vs prediction modelling
