{smcl}
{txt}{sf}{ul off}{.-}
      name:  {res}<unnamed>
       {txt}log:  {res}C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling\do/P02_.do
  {txt}log type:  {res}smcl
 {txt}opened on:  {res}17 Jan 2022, 09:39:11
{txt}
{com}. 
. use "source/oest.dta"
{txt}
{com}. 
{txt}end of do-file

{com}. describe

{txt}Contains data from {res}source/oest.dta
{txt} Observations:{res}            63                  
{txt}    Variables:{res}             9                  26 Feb 2010 15:50
{txt}{hline}
Variable      Storage   Display    Value
    name         type    format    label      Variable label
{hline}
{p 0 48}{res}{bind:group          }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:group    }{bind:  }{res}{res}{p_end}
{p 0 48}{bind:bl1            }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}baseline 1{p_end}
{p 0 48}{bind:bl2            }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}baseline 2{p_end}
{p 0 48}{bind:v1             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 1{p_end}
{p 0 48}{bind:v2             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 2{p_end}
{p 0 48}{bind:v3             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 3{p_end}
{p 0 48}{bind:v4             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 4{p_end}
{p 0 48}{bind:v5             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 5{p_end}
{p 0 48}{bind:v6             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 6{p_end}
{txt}{hline}
Sorted by: 

{com}. browse

. do "C:\Users\Harris\AppData\Local\Temp\STD8ee0_000000.tmp"
{txt}
{com}. describe

{txt}Contains data from {res}source/oest.dta
{txt} Observations:{res}            63                  
{txt}    Variables:{res}             9                  26 Feb 2010 15:50
{txt}{hline}
Variable      Storage   Display    Value
    name         type    format    label      Variable label
{hline}
{p 0 48}{res}{bind:group          }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:group    }{bind:  }{res}{res}{p_end}
{p 0 48}{bind:bl1            }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}baseline 1{p_end}
{p 0 48}{bind:bl2            }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}baseline 2{p_end}
{p 0 48}{bind:v1             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 1{p_end}
{p 0 48}{bind:v2             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 2{p_end}
{p 0 48}{bind:v3             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 3{p_end}
{p 0 48}{bind:v4             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 4{p_end}
{p 0 48}{bind:v5             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 5{p_end}
{p 0 48}{bind:v6             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 6{p_end}
{txt}{hline}
Sorted by: 

{com}. gen id=_n
{txt}
{com}. 
{txt}end of do-file

{com}. describe

{txt}Contains data from {res}source/oest.dta
{txt} Observations:{res}            63                  
{txt}    Variables:{res}            10                  26 Feb 2010 15:50
{txt}{hline}
Variable      Storage   Display    Value
    name         type    format    label      Variable label
{hline}
{p 0 48}{res}{bind:group          }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:group    }{bind:  }{res}{res}{p_end}
{p 0 48}{bind:bl1            }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}baseline 1{p_end}
{p 0 48}{bind:bl2            }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}baseline 2{p_end}
{p 0 48}{bind:v1             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 1{p_end}
{p 0 48}{bind:v2             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 2{p_end}
{p 0 48}{bind:v3             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 3{p_end}
{p 0 48}{bind:v4             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 4{p_end}
{p 0 48}{bind:v5             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 5{p_end}
{p 0 48}{bind:v6             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}visit 6{p_end}
{p 0 48}{bind:id             }{txt}{bind: float   }{bind:{txt}%9.0g     }{space 1}{bind:         }{bind:  }{res}{res}{p_end}
{txt}{hline}
Sorted by: 
{res}     Note: Dataset has changed since last saved.

{com}. summarize

{txt}    Variable {c |}        Obs        Mean    Std. dev.       Min        Max
{hline 13}{c +}{hline 57}
{space 7}group {c |}{res}         63    .5714286    .4988466          0          1
{txt}{space 9}bl1 {c |}{res}         61    21.99803     3.19284         15         28
{txt}{space 9}bl2 {c |}{res}         63    21.15016    3.765958         15         28
{txt}{space 10}v1 {c |}{res}         61    14.74607    5.611666          1         27
{txt}{space 10}v2 {c |}{res}         53       13.46    6.659774          1         27
{txt}{hline 13}{c +}{hline 57}
{space 10}v3 {c |}{res}         46       10.98    5.778908          1         24
{txt}{space 10}v4 {c |}{res}         45       10.13    5.353423          0         23
{txt}{space 10}v5 {c |}{res}         45    8.855778    5.605167          0         24
{txt}{space 10}v6 {c |}{res}         45    8.217111    5.114231          1         23
{txt}{space 10}id {c |}{res}         63          32     18.3303          1         63

{com}. do "C:\Users\Harris\AppData\Local\Temp\STD8ee0_000000.tmp"
{txt}
{com}. graph box v1 v2 v3 v4 v5 v6, by(group)
{res}{txt}
{com}. 
{txt}end of do-file

{com}. help graph box

. do "C:\Users\Harris\AppData\Local\Temp\STD8ee0_000000.tmp"
{txt}
{com}. graph box v1 v2 v3 v4 v5 v6, by(group) name("boxplot_by_group")
{res}{txt}
{com}. 
{txt}end of do-file

{com}. do "C:\Users\Harris\AppData\Local\Temp\STD8ee0_000000.tmp"
{txt}
{com}. univar
{err}varlist required
{txt}{search r(100), local:r(100);}

end of do-file

{search r(100), local:r(100);}

{com}. do "C:\Users\Harris\AppData\Local\Temp\STD8ee0_000000.tmp"
{txt}
{com}. univar v1
                                        {txt}-------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
      v1 {res}     61    14.75     5.61     1.00    11.00    15.00    19.00    27.00
{txt}-------------------------------------------------------------------------------

{com}. 
{txt}end of do-file

{com}. summarize v1

{txt}    Variable {c |}        Obs        Mean    Std. dev.       Min        Max
{hline 13}{c +}{hline 57}
{space 10}v1 {c |}{res}         61    14.74607    5.611666          1         27

{com}. do "C:\Users\Harris\AppData\Local\Temp\STD8ee0_000000.tmp"
{txt}
{com}. univar bl1 bl2 v1 v2 v3 v4 v5 v6
                                        {txt}-------------- Quantiles --------------
Variable       n     Mean     S.D.      Min      .25      Mdn      .75      Max
-------------------------------------------------------------------------------
     bl1 {res}     61    22.00     3.19    15.00    20.00    22.00    24.00    28.00
     {txt}bl2 {res}     63    21.15     3.77    15.00    18.00    21.00    24.00    28.00
      {txt}v1 {res}     61    14.75     5.61     1.00    11.00    15.00    19.00    27.00
      {txt}v2 {res}     53    13.46     6.66     1.00     8.00    13.00    18.00    27.00
      {txt}v3 {res}     46    10.98     5.78     1.00     7.00    10.00    15.00    24.00
      {txt}v4 {res}     45    10.13     5.35     0.00     7.00    10.00    13.00    23.00
      {txt}v5 {res}     45     8.86     5.61     0.00     5.00     9.00    13.00    24.00
      {txt}v6 {res}     45     8.22     5.11     1.00     5.00     6.79    11.00    23.00
{txt}-------------------------------------------------------------------------------

{com}. 
{txt}end of do-file

{com}. do "C:\Users\Harris\AppData\Local\Temp\STD8ee0_000000.tmp"
{txt}
{com}. // 7PAVMALM Multilevel and Longitudinal Modelling
. // Session 1 - Practical 
. 
. cd "C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling"
{res}C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling
{txt}
{com}. log using "do/P02_.log", replace
{err}log file already open
{txt}{search r(604), local:r(604);}

end of do-file

{search r(604), local:r(604);}

{com}. log close
      {txt}name:  {res}<unnamed>
       {txt}log:  {res}C:\Users\Harris\OneDrive - The Chinese University of Hong Kong\msc\ASMHI\7PAVMALM Multilevel and Longitudinal Modelling\do/P02_.do
  {txt}log type:  {res}smcl
 {txt}closed on:  {res}17 Jan 2022, 09:45:49
{txt}{.-}
{smcl}
{txt}{sf}{ul off}