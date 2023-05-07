library(httr)

# payload <- list(
#   image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Panther_chameleon_%28Furcifer_pardalis%29_male_Nosy_Be.jpg',
#   size = 'auto'
# )
# result = POST(url = 'https://api.remove.bg/v1.0/removebg',
#               body = payload,
#               add_headers(`X-Api-Key` = readLines('bg_api_key')),
#               encode= 'json'
# )
# out <- content(result)
# png::writePNG(out,'data-raw/chameleon.png')

library(magick)
library(dplyr)
tiger <- image_read('data-raw/chameleon.png')
#tiger <- image_read('https://upload.wikimedia.org/wikipedia/commons/2/2d/Panther_chameleon_%28Furcifer_pardalis%29_male_Nosy_Be.jpg')
#print(tiger)

df <- image_data(tiger)
#df <- image_data(image_scale(tiger,"200"))
m <- paste0("#",df[1,,],df[2,,],df[3,,]) %>% matrix(nrow = dim(df)[2],ncol=dim(df)[3])
outdf <- data.frame(x = c(t(row(m))),y = -1*c(t(col(m))), hex = c(t(m)))

# ggplot(outdf)+
#   geom_point(aes(x=x,y=y,color = hex))+
#   scale_color_identity()+
#   #theme(legend.position = "None")+
#   #theme_void()+
#   coord_equal(ratio=new_height/new_width)


lums <- outdf %>%
  mutate(lum = {farver::decode_colour(hex) %>% farver::convert_colour("rgb","lab")}[,1]) %>%
  mutate(lum = floor(lum))# %>%
  #filter(lum >10)


library(ggplot2)

pal <- custom_viridis_palette()(1:5/5)
pal[1] <- '#00000000'

p <- ggplot(lums)+
  geom_contour_filled(aes(x=x,y=y,z=lum),bins = 5)+
  coord_equal()+
  theme_void()+
  scale_fill_manual(values = pal)+
  theme(legend.position = "None")+
  xlab(NULL)+
  ylab(NULL)

library(grid)
svg("data-raw/rotated_contour_chameleon.svg",bg = "#00000000")
print(p,vp = viewport(angle = 60))
dev.off()


library(hexSticker)
sticker("data-raw/rotated_contour_chameleon.svg",
        package="ggchameleon",
        s_height= .96,
        s_width = .96,
        h_fill = the$main_palette$main,
        h_color = the$main_palette$intermediate,
        s_x = 1.1,
        s_y = .94,
        p_x = .6,
        p_size = 8.5,
        filename = 'data-raw/logo.png'
) %>% plot()

sticker("data-raw/rotated_contour_chameleon.svg",
        package="ggchameleon",
        s_height= .96,
        s_width = .96,
        h_fill = the$main_palette$main,
        h_color = the$main_palette$intermediate,
        s_x = 1.1,
        s_y = .94,
        p_x = .6,
        p_size = 2.8,
        filename = 'data-raw/logo.svg'
) %>% plot()

usethis::use_logo('data-raw/logo.svg')

