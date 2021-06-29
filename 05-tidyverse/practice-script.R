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
  
starwars %>%            # Using Boolean, logical and conditional operators with mutate. 
  select(name, height)%>%
  filter(name %in% c("Luke Skywalker", "Anakin Skywalker"))%>%
  mutate(tall1=height > 180) %>%
  mutate(tall2 =ifelse(height>180, "Tall", "Short"))
