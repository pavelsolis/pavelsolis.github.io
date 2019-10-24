* Dummy Variables and Interactions
* Pavel Solís
* 180.334 (02) Econometrics
* Fall 2019
* ===============================================================



* ---------------------------------------------------------------
* 			Dummy Variables
* ---------------------------------------------------------------

/* In Stata you can:
A.- Create one dummy variable at a time with 'generate'
B.- Create a set of dummies at once with 'tabulate'
C.- Use dummies for all categories but one without creating them explicitly */


* A. Use 'generate' to create dummy variables for one category
* ---------------------------------------------------------------

/* Suppose variable 'age' is in the workspace and you want to create
 a binary variable for individuals younger than 25 years 

	* Option 1
generate young = 0 
replace young = 1 if age < 25
replace young = . if missing(age)

	* Option 2
generate young = age < 25 if !missing(age) 

	* Other examples
generate male = sex == 1
generate top = answer == "very much"
generate eligible = sex == "male" & (age > 55 | (age > 40 & enrolled)) if !missing(age)
*/

* Example: Auto dataset
sysuse auto
generate fewreps = rep78 <= 3
browse rep78 fewreps 
generate fewrfgn = rep78 <= 3 & foreign == 1
browse rep78 fewreps foreign fewrfgn	// what can you say about foreign cars in terms of repairs?



* B. Use 'tabulate' to create dummy variables for many categories
* ---------------------------------------------------------------

/* Example: High school dataset
We want to explain writing test scores using information on reading, math and the program type student is in. 
'prog' is a categorical variable with three levels: general, academic, vocational.
In a regression analysis we can only use two out of the three dummy variables (why?).
Use the two dummy variables to test whether program type is statistically significant. */

use https://stats.idre.ucla.edu/stat/stata/notes/hsb2, clear
browse prog								// look at the the values the variable group takes
tabulate prog							// breakdown of the number of observations in each category
tabulate prog, generate(prog)			// creates dummy variables prog1, prog2, prog3
describe								// shows the labels for prog1, prog2, prog3
browse prog prog1 prog2 prog3			// verify that prog1 is 1 when prog==general, prog2 is 1 when prog==academic, prog3 is 1 when prog==vocation
regress write read math prog2 prog3		// how do you interpret the coefficients for prog2 and prog3
test prog2 prog3						// does program type is statistically significant?

regress write read math
dis ((9938.81034-9708.28876)/9708.28876)*(195/2)



* C. Use factor variable notation (no need to create dummies explicitly)
* ---------------------------------------------------------------

/* Factor variable notation uses prefixes. In this case, dummy variables are
'virtual' instead of created. */

* Example: High school dataset (cont.)
use https://stats.idre.ucla.edu/stat/stata/notes/hsb2, clear
list prog i.prog in 1/10				// see how factor notation works
regress write read math i.prog			// what is the base group?
test 2.prog 3.prog

regress write read math ib2.prog		// what is the base group?
dis _b[_cons] + _b[1.prog]				// compare against previous coefficients
dis _b[3.prog] - _b[1.prog]

regress write read math 3.prog			// what dummy variable is used?




* ---------------------------------------------------------------
* 			Interactions
* ---------------------------------------------------------------

/* Types of interactions:
- Binary x binary
- Binary x continuous
- Continuous x continuous */



* More on factor variables
* ---------------------------------------------------------------

/* Factor-variable operators:
- i. unitary operator to specify indicator variables (dummies)
- c. unitary operator to treat variable as continuous
- # binary operator to specify interactions
- ## binary operator to specify factorial interactions */



* Interaction model: Binary x binary interactions
* ---------------------------------------------------------------
/* You can either manually create a multiplicative term and use it or directly
use it without defining it
 
generate byte x1x2 = x1*x2	// create multiplicative term
regress y x1 x2 x1x2
regress y x1#x2				// specify interactions
regress y x1##x2			// specify factorial interactions
*/

* Example: High school dataset (cont.)
use https://stats.idre.ucla.edu/stat/stata/notes/hsb2, clear
generate prog2 = prog == 2
generate highmath = math > 50
regress write read highmath#prog2		// how do you interpret the coefficients?
regress write read highmath##2.prog



* Interaction model: Interactions with continuous variables
* --------------------------------------------------------------------

/* Use c. prefix to indicate continuous variables.
To specify the interaction of each level of a categorical variable (except the
base level) x1 and the continuous variable w1

regress y w1 i.x1#c.w1
*/
