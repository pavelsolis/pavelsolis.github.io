* This code may help to save log files when working in Stata using Citrix Retriever
* Pavel Solís
* 180.334 (02) Econometrics
* September 2019
* ===========================================


local mainpath "\\Client\C$\Users\Pavel\Project"
local datapath "Data\mydata.dta"
local logpath "Code\results.txt"
local pdfpath "Code\results.pdf"

use "`mainpath'\\`datapath'"

log using "`mainpath'\\`logpath'", text replace

* Commands for which you want the output to be stored in the log file

log close
translate "`mainpath'\\`logpath'" "`mainpath'\\`pdfpath'"
