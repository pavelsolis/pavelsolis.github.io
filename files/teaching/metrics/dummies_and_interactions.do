

* ===============================================================
* 			DUMMY VARIABLES
* ===============================================================


/* In Stata you can:
- Create one dummy variable at a time with 'generate'
- Create a set of dummies at once with 'tabulate'
- Use dummy variables for all categories except one without creating them explicitly */


* Use 'generate' to create dummy variables for one category
* ---------------------------------------------------------------

/* Suppose variable 'age' is the workspace and you want to create
 a binary variable for individuals younger than 25 years */

	* Option 1
generate young = 0 
replace young = 1 if age<25
replace young = . if missing(age)

	* Option 2
generate young = age<25 if !missing(age) 

* Other examples
generate male = sex==1
generate top = answer=="very much"
generate eligible = sex=="male" & (age>55 | (age>40 & enrolled)) if !missing(age)



* Use 'tabulate' to create dummy variables for many categories
* ---------------------------------------------------------------

* Suppose variable 'group' takes on the values 1, 2, and 3.
list group	/* List all the values that the variable group takes */
tabulate group	/* Displays a breakdown of the number of observations in each category */

* To create a dummy variable for each category
tabulate group, generate(dv) /* Displays table and creates dummy variables dv1, dv2, dv3*/
list /* Shows dv1 is 1 when group==1, dv2 is 1 when group==2, and dv3 is 1 when group==3*/

* Suppose variable 'result' takes on the values bad, good, and excellent.
tabulate result, generate(dum)	/* Creates dummy variables dum1, dum2, dum3 */
describe			/* Shows what the values are for each variable */
list				/* Displays all the variables */

/* Example: High School Dataset
We want to explain writing test scores using information on reading, math and program type the student is in. 'prog' is a categorical variable with three levels.
In a regression analysis we can only use two of the three dummy variables.
Use the two dummy variables to test whether program type is statistically significant. */

use https://stats.idre.ucla.edu/stat/stata/notes/hsb2, clear
tabulate prog, generate(prog)
regress write read math prog2 prog3
test prog2 prog3



* Use factor variables instead of generating dummy variables
* ---------------------------------------------------------------

/* You can use dummy variables without having to create them explicitly
using factor variable notation: prefixes.
In this case, dummy variables are 'virtual' instead of created. */

* To see what factor notation does
list group i.group in 1/5

* Suppose 'size' is a discrete variable that takes on discrete values from 0 to 4.
regress y x i.size   /* size==0 is the default comparison group, or base level */
regress y x ib3.size /* size==3 is the default comparison group, or base level */

* To use a dummy that is 1 if size==3 and 0 otherwise
regress y x 3.size

* Example: High School Dataset (cont.)
regress write read math i.prog
test 2.prog 3.prog



* ===============================================================
* 			INTERACTIONS
* ===============================================================

/* Types of interactions:
- Binary x binary
- Binary x continuous
- Continuous x continuous */

* More on factor variables
* ---------------------------------------------------------------

/* Factor-variable operators:
- i. unary operator to specify indicators (dummies)
- c. unary operator to treat as continuous
- # binary operator to specify interactions
- ## binary operator to specify factorial interactions */


* Fitting an interaction model: Binary x binary interactions
* ---------------------------------------------------------------

regress y x1#x2			/* Specify interactions */
regress y x1##x2		/* Specify factorial interactions */
generate byte x1x2 = x1*x2	/* Manually create multiplicative term */
regress y x1 x2 x1x2


* Fitting an interaction model: Interactions with continuous variables
* --------------------------------------------------------------------

*Use c. prefix to indicate continuous variable and # or ## operators

/* To specify the interaction of each level of size (except the base level) and the continuous variable x */
regress y x i.size#c.x


* ===============================================================
* 			APPENDIX
* ===============================================================

input size
2
0
1
1
3
1
2
1
2
0
2
3
0
4
end

input group
1
3
2
1
2
2
end

input result
good
bad
good
excellent
bad
end