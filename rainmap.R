setwd("C:/Users/mm_wi/Documents/ntu_agecon/laborecon/pj/bd_weather")
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)
###read the data
rain <- read.csv("weather_station.csv")
###cleaning the data and plot
rain %>%
  group_by(station, year) %>%
  summarise(sumrain=sum(rainfall)) ->rain_years_station
head(rain_years)
ggplot(aes(x=year,y=sumrain),data=rain_years_station)+geom_smooth() + labs(y='Mean Annual Rainfall') +
  facet_wrap(~station,nrow=6) + theme_light() + theme(axis.text.x = element_text((angle=90))) ###mean rain
ggplot(aes(x=year,y=rain3sd),data=rain)+geom_smooth() + labs(y='Standard Deviation for Three Year Rainfall') +
  facet_wrap(~station,nrow=4) + theme_light() + theme(axis.text.x = element_text(angle = 90))###sd rain

###map
install.packages("leaflet")
library(leaflet)
rain %>% 
  arrange(year, rainsd) -> rain2
local_monthplot <- function(station,raindata) {
  raindata %>% filter(Station == station) -> local_rd
  local_rd$Rainfall %>% ts(freq=12,start=1850) -> rain_ts
  rain_ts %>% monthplot(col='dodgerblue',col.base='indianred',lwd.base=3)}