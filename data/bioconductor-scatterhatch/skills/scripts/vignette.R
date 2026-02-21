# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----global.options, include = FALSE------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.align   = 'center'
)

knitr::opts_chunk$set(out.extra = 'style="display:block; margin:auto;"')  # center


## ----setup--------------------------------------------------------------------
library(scatterHatch)

## -----------------------------------------------------------------------------
data("pdacData")
pdacData$cellID <- paste0('cell_', 1:nrow(pdacData))
pdacData$Yt <- -pdacData$Yt
pancreas_frames = c(1:6, 27:31, 15:19, 40:44)
PDAC_frames = c(23:26, 35:37, 51:52, 64:65, 77)
small_intestines_frames = c(49:50, 63, 75:76, 88:89, 100:103, 112:116, 125:129, 137:140)
annotateLocation <- function(frame){
    if (frame %in% pancreas_frames){return("Pancreas")}
    if (frame %in% PDAC_frames){return("PDAC")}
    if (frame %in% small_intestines_frames){return("Small Intestine")}
    return("Other")
}
pdacData$location <- sapply(pdacData$frame, annotateLocation)

head(pdacData[, c('Xt', 'Yt', 'location', 'frame')])

## ----echo=TRUE, message=FALSE, warning=FALSE, tidy=TRUE, cache=FALSE, comment="", dev='png', out.width = "800px", out.height = "662px", fig.width = 11, fig.height = 8, dpi = 250, fig.align="center"----
plt <- scatterHatch(data = pdacData, x = "Xt", y = "Yt", 
    color_by = "location", legendTitle = "Tissue Type")
plot(plt)

## ----echo=TRUE, message=FALSE, warning=FALSE, tidy=TRUE, cache=FALSE, comment="", dev='png', out.width = "800px", out.height = "620px", fig.width = 11, fig.height = 8, dpi = 250, fig.align="center"----
patternList = list(list(pattern="/", angle = 70), list(pattern="-"), list(pattern="x", angle = c(135, 90, 45), lineWidth = 0.2), list(pattern="+"))
plt <- scatterHatch(data = pdacData, x = "Xt", y = "Yt", 
    color_by = "location", legendTitle = "Tissue Type", 
    patternList = patternList)
plot(plt)

## ----echo=FALSE---------------------------------------------------------------
parameters <- c('data', 'x', 'y', 'factor', 'legendTitle', 'pointSize', 'pointAlpha', 'gridSize', 'sparsePoints', 'patternList', 'colorPalette')
paramDescript = c('A dataframe of the dataset being plotted', 'A string describing the column name with the x-coordinates of the points being plotted', 'A string describing the column name with the y-coordinates of the points being plotted', 'A string describing the column name of the factor variable', 'The legend title', 'ggplot2 point size', 'Transparency of each point', 'Integer describing the precision of the hatched patterns.  Larger the value, greater the precision at the expense of efficiency.  Default segregates plots into 10000 bins', 'A logical vector that denotes the outlying points.  Default utilizies an in-built sparsity detector', 'List containing the aesthethics of each pattern', 'Character vector describing the point color of each group; default is color-blind friendly and uses colors from the dittoSeq package')

paramTable <- data.frame(parameters, paramDescript)
knitr::kable(paramTable, col.names = c("Argument","Description"))


## ----echo=FALSE---------------------------------------------------------------
aesthe = c('pattern', 'angle', 'lineWidth', 'lineColor', 'lineType')
aestheDescript = c('A string representing one of the possible 7 patterns to be used: (horizontal or "-"), (vertical or "|"), (positiveDiagonal or "/"), (negativeDiagonal or "\\"), (checkers or "+"), (cross or "x"), and (blank or "").', 'Vector or number denoting at what angle(s) the lines in a hatching pattern should be drawn - e.g. `c(45, 90, 135)`', 'Number representing the width of the lines in the pattern', 'String representing the colors of the lines in the pattern (black, white, etc.)', 'String representing the type of lines in the pattern (solid, dashed, etc.)')

aestheTable = data.frame(aesthe, aestheDescript)
knitr::kable(aestheTable, col.names = c("Aesthetics","Description"))

## -----------------------------------------------------------------------------
sessionInfo()

