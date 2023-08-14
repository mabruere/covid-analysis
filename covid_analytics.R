install.packages("tidyverse")
install.packages("Hmisc")

library(data.table) 
library(Hmisc)
library(ggplot2)

#Read data
dt <- fread("owid-covid-data.csv")

#View data
View(dt)

# total rows, total columns and column names
nrow(dt)
ncol(dt)

#Select data: Netherlands only
nl <- dt[location == 'Netherlands']

#Select data: Select columns
nl <- nl[, .(iso_code, location, date, total_vaccinations, people_vaccinated_per_hundred, people_fully_vaccinated_per_hundred)]
nl <- nl[!is.na(total_vaccinations)]

#Visualization

p1 <- ggplot(data = nl, aes(x = date, y = people_vaccinated_per_hundred, color = location))
p1 + geom_line(linewidth=1.2) + scale_y_continuous(breaks=c(0,20,40,60), labels= scales::comma) + 
  labs(titles = 'Vaccinated people in the Netherlands',
       x = 'Date',
       y = '% vaccinated people')


p1 <- ggplot(data = dt[location %in% c("Netherlands", "United Kingdom", "France") & !is.na(people_vaccinated_per_hundred)], aes(x = date, y = people_vaccinated_per_hundred, color = location))
p1 + geom_line(linewidth=1.2) + scale_y_continuous(breaks=c(0,20,40,60), labels= scales::comma) + 
  labs(titles = 'Vaccinated people in the Netherlands',
       x = 'Date',
       y = '% vaccinated people')
