#Set the Scene
source("setup.R")

#Load in the data
buoys = gom_buoys()
coast = read_coastline()
db = brickman_database()

#Filter just data from Buoy M01
buoys = buoys |> 
  filter(id == "M01")

#Filter just the Present data by month
db = db |> 
  filter(scenario == "PRESENT", interval == "mon")

#read the covariates
covars = read_brickman(db)

#Extract the variabes from covars
x = extract_brickman(covars, buoys, form = "wide")

#Edit the month variable to be in monthly order not alphabetical
x = x |>
  mutate(month = factor(month, levels = month.abb))

#Create a plot now
ggplot(data = x,
       mapping = aes(x = month, y = SST)) +
  geom_point() + 
  labs(y = "SST (C)", 
       title = "Sea Surface Temperature at buoy M01")

ggsave("images/M01_SST.png")



