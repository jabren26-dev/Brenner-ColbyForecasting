#Creating Comparison Graphics
install.packages("viridis")
library(viridis)

####Monthly Changes####
#August
august_nowcast = nowcast |>
  slice("month", "Aug")
august_nowcast

august_forecast1 = forecast_rcp45_2055 |>
  slice("month", "Aug")
august_forecast

august_forecast2 = forecast_rcp45_2075 |>
  slice("month", "Aug")
august_forecast

comparing1 = c(august_nowcast, august_forecast1, august_forecast2, along = list(year = c(2025,2055,2075)))

plot(comparing1["default_rf"], col = viridis(100, option = "mako"))

#September
sep_nowcast = nowcast |>
  slice("month", "Sep")

sep_forecast1 = forecast_rcp45_2055 |>
  slice("month", "Sep")

sep_forecast2 = forecast_rcp45_2075 |>
  slice("month", "Sep")

comparing2 = c(sep_nowcast, sep_forecast1, sep_forecast2, along = list(year = c(2025,2055,2075)))

plot(comparing2["default_rf"], col = viridis(100, option = "mako"))


#October
oct_nowcast = nowcast |>
  slice("month", "Oct")

oct_forecast1 = forecast_rcp45_2055 |>
  slice("month", "Oct")

oct_forecast2 = forecast_rcp45_2075 |>
  slice("month", "Oct")

comparing3 = c(oct_nowcast, oct_forecast1, oct_forecast2, along = list(year = c(2025,2055,2075)))

plot(comparing3["default_rf"], col = viridis(100, option = "mako"))

#November
nov_nowcast = nowcast |>
  slice("month", "Nov")

nov_forecast1 = forecast_rcp45_2055 |>
  slice("month", "Nov")

nov_forecast2 = forecast_rcp45_2075 |>
  slice("month", "Nov")

comparing4 = c(nov_nowcast, nov_forecast1, nov_forecast2, along = list(year = c(2025,2055,2075)))

plot(comparing4["default_rf"], col = viridis(100, option = "mako"))


#March
mar_nowcast = nowcast |>
  slice("month", "Mar")

mar_forecast1 = forecast_rcp45_2055 |>
  slice("month", "Mar")

mar_forecast2 = forecast_rcp45_2075 |>
  slice("month", "Mar")

comparing5 = c(mar_nowcast, mar_forecast1, mar_forecast2, along = list(year = c(2025,2055,2075)))

plot(comparing5["default_rf"], col = viridis(100, option = "mako"))

#April
apr_nowcast = nowcast |>
  slice("month", "Apr")

apr_forecast1 = forecast_rcp85_2055 |>
  slice("month", "Apr")

apr_forecast2 = forecast_rcp85_2075 |>
  slice("month", "Apr")

comparing6 = c(apr_nowcast, apr_forecast1, apr_forecast2, along = list(year = c(2025,2055,2075)))

plot(comparing6["default_rf"], col = viridis(100, option = "mako"))

plot(apr_forecast1["default_rf"], col = viridis(100, option = "mako"))




contrasting1 = forecast_rcp85_2075 - nowcast

contrasting2 = forecast_rcp45_2075 - nowcast


plot(contrasting1["default_rf"], col = viridis(100, option = "mako"))

plot(contrasting2["default_rf"], col = viridis(100, option = "mako"))


