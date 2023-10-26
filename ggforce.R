
# Works, does not currently have text in the middle.  Working out calculation to make pointer segment point accurately. 


library(ggforce)


df <- data.frame(Party = c("Very Low", "Low", "Medium", "High", "Very High"),
                 Number = c(20, 20, 20, 20, 20),
                 Color = c("Red", "Orange", "Yellow", "Green", "Blue"))
df$Party <- factor(df$Party)
df$Share <- df$Number / sum(df$Number)
df$ymax <- cumsum(df$Share)
df$ymin <- c(0, head(df$ymax, n= -1))

df %>%
    mutate_at(vars(starts_with("y")), rescale, to=pi*c(-.5,.5), from=0:1) %>%
    ggplot + 
    geom_arc_bar(aes(x0 = 0, y0 = 0, r0 = .5, r = 1, start = ymin, end = ymax, fill=Color)) +
    geom_segment(aes(x = 0, y = 0, xend = -.7, yend=.1, arrow = "open", linend = "butt" ) ) +
    scale_fill_identity() +
    coord_fixed() +
    theme_void() 
