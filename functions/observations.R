
read_observations = function(scientificname,
                             minimum_year = 1970, 
                             minimum_count = 1,
                             maximum_count = NULL,
                             record_type = NULL,
                             ...){
  
  #' Read raw OBIS data and then filter it
  #' 
  #' @param scientificname chr, the name of the species to read
  #' @param minimum_year num, the earliest year of observation to accept or 
  #'   set to NULL to skip
  #' @param ... other arguments passed to `read_obis()`
  #' @return a filtered table of observations
  
  # Happy coding!
  
  # read in the raw data
  x = read_obis(scientificname, ...) |>
    dplyr::mutate(month = factor(month, levels = month.abb))
  
  # if the user provided a non-NULL filter by year
  if (!is.null(minimum_year)){
    x = x |>
      filter(year >= minimum_year)
  }
  
  #filter out the data where eventDate and individual count is NA
  x = x |>
    filter(!is.na(eventDate)) |>
    filter(!is.na(individualCount))
  
  #if the user provided a non-NULL filter by minimum_count
  if (!is.null(minimum_count)){
    x = x |>
      filter(individualCount >= minimum_count)
  }
  
  #if the user provided a non-NULL filter by minimum_count
  if (!is.null(maximum_count)){
    x = x |>
      filter(individualCount <= maximum_count)
  }
  
  #if the user provided a non-NULL filter by record_type
  if (!is.null(record_type)){
    x = x |>
      filter(basisOfRecord == record_type)
  }
  
  
  return(x)
}
