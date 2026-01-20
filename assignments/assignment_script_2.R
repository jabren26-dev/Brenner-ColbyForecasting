#### Brenner Assignment Script 2 #####

#Set the Scene
source("setup.R")

#Read in the data using our new function!
obs = read_observations("Anarhichas lupus")

#Read in the other data
coast = read_coastline()
db = brickman_database() |>
  filter(scenario == "STATIC", var == "mask")
mask = read_brickman(db)

#Count the number of observations per month
all_counts = count(st_drop_geometry(obs), month) # counting is faster without spatial baggage
all_counts

#Create a graph with the selected latitudes and longitudes
LON0 = -67
LAT0 = 46
ggplot() +
  geom_sf(data = obs, alpha = 0.2, shape = "circle small", size = 1) +
  geom_sf(data = coast, col = "orange") +
  geom_text(data = all_counts,
            mapping = aes(x = LON0, 
                          y = LAT0, 
                          label = sprintf("n: %i", .data$n)),
            size = 3) + 
  labs(x = "Longitude", y = "Latitude", title = "All observations") +
  facet_wrap(~month)

#We are now going to thin the data to limit sample bias, and only have one sample per cell in the brickman data
thinned_obs = sapply(month.abb,
                     function(mon){ 
                       temp_x = obs |> filter(month == mon)
                       if(nrow(temp_x) ==0) return(NULL)
                       thin_by_cell(temp_x, mask)
                     }, simplify = FALSE) |>
  dplyr::bind_rows() 
#Lets create a new count variable to hold the number of thinned observations
thinned_counts = count(st_drop_geometry(thinned_obs), month)

#We are also going to create a bias map
bias_map = rasterize_point_density(obs, mask)

#We are now going to figure out how many background points to use, by averaging the total over the 12 months
nback_avg = mean(all_counts$n) |>
  round()
nback_avg

#We are now going to randomly sample for the background using our thinned observations and bias map
obsbkg = sapply(month.abb,
                function(mon){
                  temp_x = thinned_obs |> filter(month == mon)
                  if(nrow(temp_x) == 0) return(NULL)
                  sample_background(temp_x, # <- just this month
                                    bias_map,
                                    method = "bias",  # <-- it needs to know it's a bias map
                                    return_pres = TRUE, # <-- give me the obs back, too
                                    n = nback_avg) |>   # <-- how many points
                    mutate(month = mon, .before = 1)
                }, simplify = FALSE) |>
  bind_rows() |>
  mutate(month = factor(month, levels = month.abb))

#Like before we are going to drop the geometry and count the total background and presence data for each month
count(st_drop_geometry(obsbkg), month, class)

#Workflow
#Open the data in the pipe, create 20 different groups based on month and class, and then randomly sample 1 point
sampled_data = obsbkg |>
  group_by(month, class) |>
  slice_sample(n=1) 
  
#Use each point to find the SSS, SST, and Tbtm and add it to the table - working on this

#Reread in the brickman database
db = brickman_database() |> 
  filter(scenario == "PRESENT", interval == "mon")

#Read in the covariates,
covars = read_brickman(db)

#







