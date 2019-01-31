* Do-file example with useful commands
* Pavel Solis
* January 2019
* ===========================================

/*
To work off-campus, you need to install Pulse Secure. To connect, 
you will need myIT Login Code.
To work either off-campus and on-campus, you need Citrix Receiver.
*/

*help videos
pwd /*To know where you are*/
ls 	/*To list the files in the current folder*/
cd "Your folder" /* To change to the folder where you want to work on*/
* Example: "//Client/C$/Users/Pavel/Documents/2019 Econometrics"
* To go up one level cd ..*


/* Create a log file to store output. Note that the lines preceding the next line do not show up in the log file */
log using stata_output.txt, text replace

clear all /* Clear memory*/
set more off /*Print all output; otherwise you need to be clicking to show more when output is long*/

* Import a csv file
insheet using intro_hs0.csv, clear

* You can save the data as a Stata file (.dta extension) and read it with
*use intro_hs0, clear /* This first clears the memory, and then reads the file*/

* Summarize the data
describe
summarize
list gender-write in 1/5
summarize read math science write
summarize if read >= 50 /* summarize all variables for which the condition for 'read' holds*/
summarize if prgtype == "vocati"
summarize read, detail

* Correlations
correlate write read science

* Modify the data
rename gender female
label variable socst "social studies"

* Create new variables
gen tscore = read + write + math + science
gen tscore2 = tscore^2

*Delete variables
drop schtyp

log close
translate stata_output.txt stata_output.pdf, replace /*Saves the output in a pdf*/

