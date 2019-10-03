* Screening Your Data for Potential Errors
* Pavel Solís
* 180.334 (02) Econometrics
* October 2019
* ===========================================

sysuse auto
describe
destring						// if a numeric variable was read as a string
drop
keep							// careful

* Examining data
list varlist in 1/10
summarize varlist, detail
codebook price mpg
tabulate rep78
list varlist if condition
count if condition
correlate rep78-weight
pwcorr rep78-weight
pwcorr rep78-weight, sig obs

* Graphical methods for inspecting data
stem rep78 						// stem-and-leaf plot
scatter mpg weight
scatter mpg weight, mlabel(make)
twoway (scatter mpg weight, mlabel(make)) (lfit mpg weight)
graph box						// boxplot
graph matrix price mpg weight	// scatterplot matrix
histogram price, normal bin(20)
kdensity price, normal
* Others: symplot, qnorm, pnorm
* Transforming variables: ladder, gladder
