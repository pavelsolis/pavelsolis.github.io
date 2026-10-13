* Clear memory and set program
capture program drop norm_sim
program define norm_sim, rclass
    version 17
    clear
    set obs 100
   
    * Generate data (true: mean = 5, std = 3)
    gen x = rnormal(5, 3)
    
	* Summarize
	summarize x
	
    * Save coefficients
    return scalar xbar = r(mean)
end

* Run the simulation 1,000 times
set seed 12345
simulate x_mean = r(xbar), reps(1000): norm_sim

* Analyze results
summarize x_mean
histogram x_mean, normal