// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 8 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P12.log", replace

*******************
***** Group 1 *****
*******************

use "source/epilepsy.dta"
