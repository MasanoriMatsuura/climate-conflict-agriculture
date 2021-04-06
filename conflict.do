/*labor econ pj masanori*/
clear
capture log close
log using "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\pj\conflict\conflict_bd", replace text
set more off

cd "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\pj\conflict"
insheet using "conflict_bd.csv",clear
save conflict.dta,replace
use conflict.dta

destring admin2 generate
log close