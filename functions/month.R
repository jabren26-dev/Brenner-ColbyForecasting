month_lut = function(){
  
  #' Retrieve a look-up-table where the values are month numbers
  #' and the names are month.abb
  #' 
  #' @return named vector of month numbers
  seq_along(month.abb) |>
    rlang::set_names(month.abb)  
}

keep_under = function(x, under = 12){
  
  #' Coerce a set of whole numbers between 1 and `under`.  Wrapping occurs such 
  #' month 13 is associated with January while month 0 is associated with
  #' December.
  #' 
  #' @param x one of more numbers, which will be rounded
  #' @param under num, the upper range of numbers to coerce within
  (round(x)-1) %% under + 1
}

month_as_name = function(x = seq_len(12),
                         lut = month_lut()){
  #' Convert month numbers to month names (abbreviated) 
  #' 
  #' @param x num one or more month numbers
  #' @param lut named month look up table
  #' @return month names (abbreviated)

  names(lut[keep_under(x, under = 12)])
}

month_as_number = function(x = month.abb,
                           lut = month_lut()){
  
  #' Convert month names  (abbreviated)  to month numbers
  #' 
  #' @param x str one or more month names
  #' @param lut named month look up table
  #' @return month numbers (1-12)
  #' 
  lut[x]
}

