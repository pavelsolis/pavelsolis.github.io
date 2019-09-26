* Multiple Linear Regression: Properties
* Pavel Solís
* 180.334 (02) Econometrics
* September 2019
* ===========================================

sysuse auto

* Simple regression: Fitted line
regress mpg weight
graph twoway (lfit mpg weight) (scatter mpg weight)		// create a scatterplot with a fitted line
graph twoway (lfitci mpg weight) (scatter mpg weight)	// same but with confindence intervals

* Check that lfit and yhat yield the same results
*predict yhat, xb
*graph twoway (lfit mpg weight) (scatter yhat weight)

* Multiple regression: Fitted values and residuals
regress mpg weight foreign
predict uhat, r		// create a new variable (uhat) equal to the residuals of the estimated model
predict yhat, xb	// create a new variable (yhat) equal to the fitted values of the estimated model
scatter uhat yhat	// plot your residuals against your fitted values

* Check algebraic properties
summ uhat
summ mpg yhat
corr yhat uhat
summ mpg weight foreign
display _b[_cons] + _b[weight]*3019.459 + _b[foreign]*.2972973

* Estimate sigma (standard deviation of the error)
generate uhat2 = uhat^2
quiet summ uhat2
display sqrt(r(sum)/e(df_r))		// Compare with Root MSE in regression output

* Perfect collinearity and units of measurment
generate wgt1k = weight/1000
scatter weight wgt1k
regress mpg weight wgt1k
regress mpg wgt1k
