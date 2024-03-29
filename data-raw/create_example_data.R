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
chameleons_url <- 'https://raw.githubusercontent.com/alliebl/Drown-et-al/main/Chameleon_Measurements_v3.csv'
download.file(chameleons_url,'data-raw/chameleons_raw.csv')

predation_url <- 'https://raw.githubusercontent.com/alliebl/Drown-et-al/main/Chameleon%20Behavior%20Proportions.csv'
download.file(predation_url,'data-raw/predation_raw.csv')

# 2. Create id Crosswalk ----
library(dplyr)

chameleons_raw <- read.csv('data-raw/chameleons_raw.csv')

id_crosswalk <-
  chameleons_raw |>
  # Done so ids go in the order: hatchling, juvenile, adult
  mutate(sort_order = factor(
    substr(indv, 1, 1),
    levels = c("H", "J", "A"),
    ordered = TRUE
  )) |>
  arrange(sort_order) |>
  # Assign a unique id to each internal id
  mutate(id = cur_group_id(),
         .by = indv) |>
  # Only keep unique internal id to new id pairs
  distinct(indv, id)

# 3. Clean Measurments Data ----
chameleons <-
  chameleons_raw |>
  rename(
    head_length = HL,
    head_height = HH,
    casque_height = CH,
    casque_width = CW,
    lower_jaw_length = LJL,
    head_width = HW,
    jaw_width = JW,
    snout_vent_length = SVL,
    max_bite_force = max.bite.force,
    normalized_peak_velocity = normalized.peak.velocity,
    peak_velocity_m = peak.velocity.m,
    peak_velocity_cm = peak.velocity.cm
  ) |>
  mutate(
    growth_stage = case_when(
      substr(indv,1,1)=="A" ~ "adult",
      substr(indv,1,1)=="J" ~ "juvenile",
      substr(indv,1,1)=="H" ~ "hatchling"
    )
  ) |>
  mutate(
    growth_stage = factor(growth_stage,c("hatchling","juvenile","adult"),ordered=T)
  )

chameleons <-
  chameleons |>
  left_join(id_crosswalk, by = 'indv') |>
  select(id,growth_stage,everything(),-indv) |>
  arrange(id)

usethis::use_data(chameleons, overwrite = TRUE)

# 4. Clean Predation Data ----
predation_raw <- read.csv('data-raw/predation_raw.csv')

predation <- predation_raw

# Fix a missing value
predation$prop.nothing[predation$Individual == "CcalypH09" &
                         predation$Habitat == "Closed" &
                         predation$Predator == "Snake"] <- .25

predation <-
  predation %>%
  select(predator=Predator,habitat=Habitat,starts_with("prop."),Individual) %>%
  tidyr::pivot_longer(starts_with("prop."),names_to = "response",values_to = "proportion") %>%
  mutate(response = gsub("^prop\\.","",response)) %>%
  # Each combination of treatments was applied 4 times
  mutate(trials = 4*proportion) %>%
  mutate(predator = tolower(predator),
         habitat = tolower(habitat)) %>%
  mutate(foliage = ifelse(habitat=="open","sparse","dense")) %>%
  mutate(response = case_when(
    response == "agg" ~ "aggregression",
    response == "crypsis" ~ "crypsis",
    response == "drop" ~ "free-falling",
    response == "flee" ~ "fleeing",
    response == "leaf" ~ "leaf-mimicking",
    response == "nothing" ~ "nothing",
    response == "ring" ~ "ring-flipping"
  )) %>%
  select(predator,foliage,trials,response,Individual) %>%
  tidyr::uncount(trials) %>%
  mutate(
    foliage = factor(foliage,c("sparse","dense"), ordered=T),
    response = factor(response,ordered = F),
    predator = factor(predator,ordered = F)
  )

predation <-
  predation |>
  mutate(indv = gsub("^Ccalyp","",Individual)) |>
  left_join(
    id_crosswalk,
    by = "indv"
  ) |>
  select(id,everything(),-indv,-Individual) |>
  arrange(id)

usethis::use_data(predation, overwrite = TRUE)
