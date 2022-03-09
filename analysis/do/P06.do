// 7PAVMALM Multilevel and Longitudinal Modelling
// Session 6 - Practical 


clear
graph drop _all

cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
log using "do/P06.log", replace

use "source/pefr.dta"


/// 1 format data
reshape long w, i(id) j(method occassion) 


/// 2 



* 450 is their mean average peak flow ('score'')

* we see that much more of the variability lies in the differences between people
* formalzied by ICC, via calling estat icc

* the essence is the model fitted
* then calculate ICC fromthe command outputs




// 5
** do a LRtest* 


// there are no covaraites in this pracitcal --
 // it's good to think about variance partitinoning