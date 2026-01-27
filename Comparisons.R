#Creating Comparison Graphics

august_nowcast = nowcast |>
  slice("month", "Aug")
august_nowcast

august_forecast = forecast_2075 |>
  slice("month", "Aug")
august_forecast

comparing = c(august_nowcast, august_forecast, along = list(year = c(2025,2075)))

contrasting = august_forecast - august_nowcast

contrasting2 = forecast_2075 - nowcast


plot(z["default_rf"])

plot(x["default_rf"])

plot(contrasting2["default_rf"])


