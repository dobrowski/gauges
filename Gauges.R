
# Looks nice but is actually an html widget and not an image.  Would need to use in shiny.  Also seems to be fairly dated so not sure if being maintained. 


library(rAmCharts4)

gradingData <- data.frame(
    label = c("Very Low","Low", "Medium", "High", "Very High"),
    color = c("red", "orange", "yellow", "green", "blue"),
    lowScore = c(0, 20, 40, 60, 80),
    highScore = c(20, 40, 60, 80 , 100)
)

amGaugeChart(
    score = 13, minScore = 0, maxScore = 100, gradingData = gradingData,
    hand = amHand(innerRadius = 40, width = 15, color = "black", strokeColor = "black"),
    gridLines = FALSE,
    export = TRUE
)

ggsave()
