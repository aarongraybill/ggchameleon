# There are three published datasets from Drown, Liebl, and Anderson (2022)
# 1. Measurements
# 2. Responses to simulated predation
# 3. Amount of color change in the eyes of different animals
#
# These three are linkable by their internal ids. First, we'll save the raw data
# locally so that we can't lose it. Then we will extract the ids to create a
# crosswalk. Then we'll do some data cleaning to make the data more easily
# interpretable. Then we need to save the three data sets.

# 1. Save data ----
measurements_url <- 'https://raw.githubusercontent.com/alliebl/Drown-et-al/main/Chameleon_Measurements_v3.csv'
download.file(measurements_url,'data-raw/measurements_raw.csv')

color_change_url <- 'https://raw.githubusercontent.com/alliebl/Drown-et-al/main/Chameleon%20Color%20JNDs.csv'
download.file(color_change_url,'data-raw/color_change_raw.csv')

predation_url <- 'https://raw.githubusercontent.com/alliebl/Drown-et-al/main/Chameleon%20Behavior%20Proportions.csv'
download.file(predation_url,'data-raw/predation_raw.csv')
