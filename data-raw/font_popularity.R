## code to prepare `font_popularity` dataset
library(rvest)
library(dplyr)

page <- read_html('data-raw/Analytics - Google Fonts.html')

# Each font has its own '.stat-row' with popularity info
test <- page %>%
  html_elements(css = ".stat-row") %>%
  as.list()

# The urls for each of the fonts parsed
urls <-
  test %>%
  html_element('li') %>%
  html_children() %>%
  html_attr('href')

# get stats (and name) as text, and convert to matrix then to a
# dataframe
df <-
  test %>%
  html_elements('li') %>%
  html_children() %>%
  html_text2() %>%
  matrix(nrow = 4) %>%
  t() %>%
  as.data.frame() %>%
  rename(family = 1,
         designer = 2,
         total = 3,
         weekly = 4) %>%
  mutate(url = urls)

# This font db includes the type of each font (sans, mono, etc)
font_db <-
  sysfonts::font_info_google(db_cache = F)

# Should have exactly the same fonts, so inner=right=left joins
font_popularity <- inner_join(df,font_db)

# parse numbers as numeric
font_popularity <-
  font_popularity %>%
  mutate(
    total = as.numeric(gsub(',',"",total)),
    weekly = as.numeric(gsub(',',"",weekly))
  )

usethis::use_data(font_popularity, overwrite = TRUE,internal = TRUE)
