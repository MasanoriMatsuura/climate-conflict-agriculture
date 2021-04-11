/*labor econ pj masanori*/
clear
capture log close
log using "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\pj\bd_weather\weather", replace text
set more off
cd "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\pj\bd_weather"
insheet using "data_monthly_rainfall.csv", clear
save weather.dta, replace
use weather.dta


/*create climate variables */
drop if year < 2000
bysort station year: egen rain=sum(rainfall) //mean rainfall by station and year
bysort station: egen sdrain=sd(rainfall) //sd montly rainfall by station
bysort station: egen rainsd=sd(rain) // sd yearly rainfall by station
gen period=3*floor(year/3)
bysort station period: egen rain3sd=sd(rainfall) //3 years sd monthly rainfall
save weather.dta, replace

/*merge with station data*/
insheet using "weather.csv", clear
rename stationnames station
keep station latitude longitude
save weather_place.dta,replace
use weather_place, clear
replace station="Ambagan_ctg" if station=="Chittagong (City-Ambagan)"
replace station="Chittagong" if station=="Chittagong (IAP-Patenga)"
replace station="CoxsBazar" if station=="Cox's Bazar"
replace station="M.Court" if station=="Maijdee Court"
save weather_place.dta, replace
use weather.dta, clear
merge m:m station using weather_place.dta

/*drop blank data, sava, and export csv*/
drop if station=="Syedpur"
drop if station=="Chuadanga"
drop if station=="M.Court"
save weather_station.dta, replace
export delimited using "weather_station.csv", replace
log close 