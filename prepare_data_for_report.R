## This Script is aimed to prepare raw data for reporting.##


# libraries ---------------------------------------------------------------

library(here) # ease for managing directories
library(readxl) # read in datd from xlsx files
library(dplyr) # data wrangling
library(janitor) # data cleaning


# Read in data ------------------------------------------------------------

read_xlsx(
  here("data_raw/DCHB_Village_Release_2400.xlsx")
          ) -> data_raw

# the column names in the census data have spaces and special chars. We
# need clean names.

clean_names(data_raw) -> data_raw


# keeping relevant information for analysis -------------------------------

# When creating parameterised reports it is prudent to
# carry out, as much as possible, all the data wrangling and cleaning
# task beforehand and prepare the data in a manner that will allow
# for least amount of manipulation in the .rmd or .qmd files

# Here we are only interested in some of the variables that are 
# in the raw data.

data_raw %>% 
  select(
    state_name,
    district_name,
    sub_district_name,
    village_name,
    gram_panchayat_name,
    sub_district_head_quarter_name,
    sub_district_head_quarter_distance_in_km,
    district_head_quarter_name,
    district_head_quarter_distance_in_km,
    nearest_statutory_town_name,
    nearest_statutory_town_distance_in_km,
    total_geographical_area_in_hectares:total_scheduled_tribes_female_population_of_village,
    forest_area_in_hectares : area_irrigated_by_source_in_hectares
  ) -> data_raw



# save the prepared data  -------------------------------------------------


Sys.time()
data_raw %>% 
  write.csv(here("data_prepared/data_prepared.csv")) 
Sys.time()
## save the file in desired format, show how to save ass feather file 
## for demonstration. 

data_raw %>% 
  feather::write_feather(here("data_prepared/data_prepared.feather"))
