install.packages(c('tidyverse','nycflights13'), repos = 'hhtps://cran.rstudio.com', dependencies = "TRUE")
library(tidyverse)
starwars

## Use dplyr:: Filter
vignette('dplyr')

starwars %>%
  filter(species =="Human",
  height >= 190)

starwars %>%
  filter(species =="Human") %>%
  filter(height >= 190)

starwars %>%
  filter(grepl("Skywalker", name))

# Identifying and/or removing missing data cases
starwars %>%
  filter(is.na(height))

starwars %>%
  filter(!is.na(height))
starwars

## Use dplyr::arrange
starwars %>%
  arrange(birth_year)

starwars %>% 
  arrange(name)

# Arrange in descending order
starwars %>%
  arrange(desc(birth_year))

## Use dplyr::select
starwars %>%
  select(name:skin_color, species, -height)  # Show colums from name to skin colour, without height and plus skin colour

starwars %>%
  select(alias=name, crib=homeworld, sex=gender) #Rename variables (can also be done with rename() as below)

starwars %>%
  rename(alias=name, crib=homeworld, sex2=gender)
starwars

starwars %>%
  select(name, contains('color'))  # Select columns with the word color in it.

starwars %>%
  select(species, homeworld, everything()) %>% # Put species and homeworld first (on the left)
  head(5)

## Use dplyr::mutate
starwars %>%
  select(name, birth_year) %>%
  mutate(dog_years = birth_year*7)%>%
  mutate(comment = paste(name, "is", dog_years, "in dog years.")) #This is pretty cool
         
starwars %>%
  select(name, birth_year)%>%
  mutate(
    dog_years=birth_year*7,
    comment=paste(name, "is", dog_years, "in dog years")
  )
  
starwars %>%            # Using Boolean, logical and conditional operators with mutate(). 
  select(name, height)%>%
  filter(name %in% c("Luke Skywalker", "Anakin Skywalker"))%>%
  mutate(tall1=height > 180) %>%
  mutate(tall2 =ifelse(height>180, "Tall", "Short"))

starwars %>%      #Using mutate() and across() to change all lower case character strings to upper case across a range of columns
  select(name:eye_color) %>%
  mutate(across(where(is.character), toupper))

##Use dplyr::summarise, particularly useful in combination with the group_by() command
starwars %>%
  group_by(species, gender) %>%
  summarise(mean_height = mean(height, na.rm=TRUE)) # Summarise groups of species and gender by their average height
# Note important to include na.rm to remove NA values.

starwars %>%  #Use group_by, summarise and across to show average values of all numeric variables for specific groups.
  group_by(species)%>%
  summarise(across(where(is.numeric), mean, na.rm=T))
  
## Other useful data manipulation stuff
vignette("window-functions")


##Using joins in dplyr
library(nycflights13)
flights
planes

#Left join
left_join(flights,planes, by="tailnum") %>%
  select(year, month, day, dep_time, arr_time, carrier, flight, tailnum, type, model)
flights
planes

left_join(flights, planes, by ="tailnum") %>%
  select(contains("year"), month, day, dep_time, arr_time, carrier, flight, tailnum, type,model)


##Using tidyr:pivot_longer
stocks = tibble(time =as.Date('2009-01-1')+ 0:1,
                X= rnorm(2,0,1),
                Y= rnorm(2,0,2),
                Z=rnorm(2,0,4))

stocks
stocks %>%
  pivot_longer(-time, names_to="stock", values_to="price")
tidy_stocks = stocks %>%
  pivot_longer(-time, names_to="stock", values_to="price")

##Using tidyr::pivot_wider
tidy_stocks %>%
  pivot_wider(names_from=stock, values_from=price)
tidy_stocks %>%
  pivot_wider(names_from=time, values_from=price)
tidy_stocks


##Using tidyr::separate
economists = tibble(name =c("Adam.Smith", "Paul.Samuelson", "Milton.Friedman"))
economists

economists %>%
  separate(name, c("first_name", "last_name"))

#Using separate_rows
jobs =tibble(
  name=c("Jack", "Jill"),
  occupation = c("Homemaker", "Philosopher, Philanthropost, Troublemaker"))
jobs

jobs %>% separate_rows(occupation)


##Using tidyr::unite
gdp = tibble(
  yr =rep(2016, times=4),
  mnth =rep(1, times =4),
  dy =1:4,
  gdp = rnorm(4, mean=11, sd=2))
gdp

gdp %>% unite(date, c("yr", "mnth", "dy"), sep="-")
library(lubridate)

gdp %>% mutate(date = ymd(date))

