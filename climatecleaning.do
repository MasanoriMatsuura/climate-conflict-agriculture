/*labor econ pj masanori*/
clear
capture log close
log using "C:\Users\mm_wi\Documents\ntu_agecon\laborecon\pj\bd_weather\weather", replace text
set mores off

insheet using "weather.csv", clear
save weather.dta, replace
use weather.dta


/*create climate variables of temperature, precipitation, wind, humidity*/
bysort stationname: egen meantem=mean({maxtemp+mintemp}/2)
bysort stationname: egen
bysort stationname year: egen meanrain=sum(rainfall) //mean rainfall by station and year
bysort stationname: egen sdrain=sd(rainfall) //sd rainfall by station and year
bysort stationname: egen meanhum=mean(relativehumidity) //mean humidity by station
bysort stationname: egen meanwind=mean(windspeed)// mean wind speed by station
bysort stationname: egen sdwind=sd(windspeed) //sd wind speed 
/*create the variable of district*/
recode stationname ()

log close 