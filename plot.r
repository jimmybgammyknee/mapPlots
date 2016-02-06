library(plotly)
df <- read.csv('mathieson_cov.csv')
df$hover <- paste(df$name, df$cov, "x")


g <- list(
  scope = 'world',
  projection = list(type = 'spherical mercator'),
  showland = TRUE,
  landcolor = toRGB("gray85"),
  subunitwidth = 1,
  countrywidth = 1,
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white")
)

plot_ly(df, lon = lon, lat = lat, text = hover,
        marker = list(size = coverage),
        color = q, type = 'scattergeo', locationmode = 'ISO-3') %>%
  layout(title = 'European Samples', geo = g)