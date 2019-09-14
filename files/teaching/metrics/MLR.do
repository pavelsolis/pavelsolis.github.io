* Multiple Linear Regression
* Pavel Solís
* 180.334 (02) Econometrics
* September 2019
* ===========================================


*cd "/Users/Pavel/Documents/JHU/TA/2019 Econometrics/TA Sections"

* Label your data
use https://stats.idre.ucla.edu/stat/stata/modules/autolab.dta, clear
describe

label data "Data for 1978 automobiles"
describe
label variable mpg "miles per gallon"
describe
browse foreign
table foreign
label define foreignlabel 0 "Domestic" 1 "Foreign"
label values foreign foreignlabel
browse foreign
table foreign
tabulate foreign

* Simple statistical analysis
summ mpg if foreign == 0
summ mpg if foreign
ttest mpg , by(foreign)

* Warning
sysuse auto, clear
summ
browse
generate repairs = rep78 > 0
table repairs
order repairs, after(rep78)		// Alternative?
browse
drop repairs
generate repairs = rep78 > 0 & rep78 != .
table repairs

* Linear regression
describe
summ
regress mpg weight
regress mpg weight foreign		// -.0065879*200

* Stored or returned results
* r-class (real values) and e-class (estimation)
ereturn list
display e(rss)/e(df_r)
matrix list e(b)

reg mpg rep78 
sum rep78 if e(sample)==1

quiet regress mpg weight foreign
display _b[weight]
display _b[foreign]
display _b[_cons]
display _b[_cons] + _b[weight]*200 + _b[foreign]*1
 
