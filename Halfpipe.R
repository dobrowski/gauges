

# Takes a dataframe with indicators, rates and color and produces pretty clean colored gauges
# Scales and understands difference between DFS and Percent


half.pipe.dash <- function(df) {
    

 df %>%
    mutate(labeler = case_when(is.na(raw.rate) ~ NA,
                                 variable %in% c("susp", "chron", "grad", "cci", "elpi") ~  paste0(as.character(raw.rate*100), "%"),
                               TRUE ~ as.character(raw.rate)),
           percentage = case_when(is.na(raw.rate) ~ NA,
                                      variable %in% c( "grad", "cci", "elpi") ~  raw.rate,
                                  variable == "chron" ~ rescale(raw.rate,to = c(0,1), from = c(0,.5)),
                                  variable == "susp" ~ rescale(raw.rate,to = c(0,1), from = c(0,.1)),
                                      TRUE ~ rescale(raw.rate,to = c(0,1), from = c(-250,100))),
           title = case_match(variable,
                             "susp" ~ "Suspension",
                             "chron" ~ "Chronic\nAbsenteeism",
                             "grad" ~ "Graduation",
                             "cci" ~ "College/\nCareer\n Readiness",
                             "elpi" ~ "English Language Progress",
                             "math" ~ "Math",
                             "ela" ~ "ELA"
                             ),
           rancor = case_match(variable,
                               "susp" ~ 5,
                               "chron" ~ 4,
                               "grad" ~ 6,
                               "cci" ~ 7,
                               "elpi" ~ 3,
                               "math" ~ 2,
                               "ela" ~ 1
           )
    ) %>%
              


ggplot( aes(fill = kular, ymax = percentage, ymin = 0, xmax = 2, xmin = 1)) +
    geom_rect(aes(ymax=1, ymin=0, xmax=2, xmin=1), fill ="#ece8bd") +
    geom_rect() + 
    coord_polar(theta = "y",start=-pi/2) +
    xlim(c(0, 2)) + ylim(c(0,2)) +
    geom_text(aes(x = 0, y = 0, label = labeler, colour=kular), size=6.5) +
    geom_text(aes(x=1.5, y=1.5, label=title),  size=4.2) + 
     facet_wrap(~rancor, ncol = 3) +
     theme_void()  +
     scale_fill_manual(values = c("red"="#b30202", "orange"="#f08502", "green"="#108f14", "yellow" = "#f0dc02", "blue" = "#14108f")) + # Arc color
     scale_colour_manual(values = c("red"="#b30202", "orange"="#f08502", "green"="#108f14", "yellow" = "#f0dc02", "blue" = "#14108f")) + # Big Number color
     theme(strip.background = element_blank(),
           strip.text.x = element_blank()) +
     guides(fill=FALSE) +
     guides(colour=FALSE)

}



df <- tribble(~variable, ~raw.rate, ~kular, 
              "susp", .08 , "red" ,
              "chron", .23 , "yellow" , 
              "grad", .94 , "green" , 
              "math", -30 , "orange" , 
              "ela", -70 , "yellow" ,
              "cci", .6 , "blue" , 
)


half.pipe.dash(df) +
    labs(title = "Imaginary District 2023 Dashboard Results")
