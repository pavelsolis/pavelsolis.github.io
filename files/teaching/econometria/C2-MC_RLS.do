* Clear memory and set program
capture program drop reg_sim
program define reg_sim, rclass
    version 17
    clear
    set obs 100
   
    * Generate data (true: intercept = 2, slope = 3)
    gen x = rnormal(0, 1)
    gen u = rnormal(0, 1)
    gen y = 2 + 3 * x + u
   
    * Run regression
    regress y x
   
    * Save coefficients
    return scalar b0 = _b[_cons]
    return scalar b1 = _b[x]
end

* Run the simulation 1,000 times
set seed 12345
simulate beta0 = r(b0) beta1 = r(b1), reps(1000): reg_sim

* Analyze results
summarize beta0 beta1
histogram beta1, normal