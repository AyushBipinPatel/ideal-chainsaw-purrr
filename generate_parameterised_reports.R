## The Script to control and generate parameterised reports using PURRR ##



# Common steps ------------------------------------------------------------

## Loading Libraries --------

library(here)
library(purrr)

## Load data  --------

  ### We need the basic prepared data to create a list of inputs that will 
  ### generate the parameterised reports.

readr::read_csv(here("data_prepared/data_prepared.csv")) -> data_prepared


## Prepare parameters or inputs to reports -----

  ### In this instance we have only one input or parameter. 
  ### This is the district value. Here we create a list of 
  ### all the district values or the district for which we 
  ### need the report to be generated.

unique(data_prepared$district_name) -> sequence_param


# Create reports through .RMD files ---------------------------------------

  ### This invloves two steps.
  ### First, create a function to render .rmd files
  ### Second, map the function in first step over the list of inputs

## First, Create a function to render ------


warp_render <- function(para_input){
  
  rmarkdown::render(
    input = here("district_report.rmd"), # the file that needs to be rendered
    output_file = paste(
      "District_Report",
      para_input,
      ".html",
      sep = ""
      ), # Name of the rendered file
    output_dir = here("store_district_RmdReports/"), # folder location for rendered file
    params = list(
      dist_name = para_input # All the param and corresponding values
    )
      )
  
  
}


## Second, Map the warp_render over sequence_param to generate all reports at once

tictoc::tic()
map(sequence_param, warp_render)
tictoc::toc()

  ### This took nearly 6 minutes (361.63sec) to generate 26 reports.


# Create reports through .QMD files ---------------------------------------

## This involves same asteps as .RMD files

## First, Create a function to render ------


warp_render_quarto <- function(para_input){
  
  
  quarto::quarto_render(
    input = here("district_report.qmd"),
    output_file = paste(
      ".\\store_district_QmdReports\\District_Report",
      para_input,
      ".html",
      sep = ""
    ),
    execute_params = list(
      dist_name = para_input # All the param and corresponding values
    )
  )
  
  
}


## Second, Map the warp_render over sequence_param to generate all reports at once

tictoc::tic()
map(sequence_param, warp_render_quarto)
tictoc::toc()

### This took nearly 6 minutes (382.39sec) to generate 26 reports.
