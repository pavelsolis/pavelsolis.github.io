version 18
cd ~\Documentos\eco3404
clear
sysuse dir
sysuse auto
browse
summarize
summarize price foreign
describe
histogram price
scatter length weight
scatter price mpg
scatter price trunk
correlate length weight
stem rep78
tabulate rep78
tabulate rep78, missing
browse rep78
count if missing(rep78)
browse rep78 if missing(rep78)
tabulate foreign
tab foreign rep78
sort price
sort rep78 price
sort foreign make
help list
list
list ma
list m*
list p
list price-weight
list ma?e
help operators
list if mpg < 15
list if mpg <= 15
list if (mpg < 15) & !missing(rep78)
list make mpg price gear if (mpg> 22) | (price > 8000 & gear < 3.5)
tab rep78
list if rep78 > 4
list if rep78 > 4 & rep78 != .
list if mpg = 21
list if mpg == 21
list if mpg == 21 if weight > 4000
list if mpg == 21 and weight > 4000
list if mpg == 21 & weight > 4000
list if rep78 < 2 & rep78 > 5
list if rep78 < 2 | rep78 > 5
list if make == Datsun 510
list if make == "Datsun 510"
list if foreign == "Domestic"
codebook foreign
list if foreign == 0
browse
list in 1
list in 1/5
list in -1
list in 70/74
list in -3/-2
list ma p g f, sepby(foreign)
list in 1/10, separator(3)
log using C1-Intro.log, replace
tabulate foreign
log off
summarize
summarize if foreign == 0
summarize if !foreign
summarize if foreign == 1
summarize if foreign
by foreign: summarize
sort make
by foreign: summarize
bysort foreign: summarize
log on
return list
display r(N)
log close
translate C1-Intro.log C1-Intro.pdf, replace
drop gear_ratio
sysuse auto
sysuse auto, clear
generate lsqd = length^2
order lsqd, after(length)
rename lsqd lengthsqd
generate domestic = 0
replace domestic = 1 if foreign == 0
browse
label define lbldom 0 "Foreign" 1 "Domestic"
label values domestic lbldom
browse
label variable domestic "Car origin"
keep if domestic
drop if !domestic
browse
drop foreign domestic
tab rep78, missing
recode rep78 (. = 999)
recode rep78 (999 = .)
tostring turn, generate(string)
destring string, replace
drop string
save auto_clean, replace
use auto_clean, clear