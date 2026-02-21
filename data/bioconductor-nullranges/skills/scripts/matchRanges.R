# Code example from 'matchRanges' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, echo=FALSE, fig.width=8.5, fig.height=6.5----

## Make grid of coordinates
makeCoords <- function(npts) {
  coords <- expand.grid(seq(1, 0, length.out = sqrt(npts)),
                        seq(0, 1, length.out = sqrt(npts)))[1:npts,]
  colnames(coords) <- c("y", "x")
  
  coords
}

## Define colors
colors <- c("#e19995", "#adaf64", "#4fbe9b", "#6eb3d9", "#d098d7")

## Create data.frame for points
set.seed(5)
df <- data.frame(color = factor(c(sample(colors, 16, replace = TRUE),
                                sample(colors, 120, replace = TRUE))),
                 size = c(abs(rnorm(16, 0.5, 0.25))+0.35,
                          abs(rnorm(120, 0.5, 0.25))+0.35),
                 set = c(rep('focal', 16),
                         rep('pool', 120)))

## Reorder factor level by colors
levels(df$color) <- colors

## Define focal and pool groups
focal <- df[df$set == 'focal',]
pool <- df[df$set != 'focal',]

## Sort by color
focal <- focal[order(focal$color, -focal$size),]

## Match ranges
library(nullranges)
set.seed(123)
x <- matchRanges(focal = focal,
                 pool = pool,
                 covar = ~color+size,
                 method = 'n', replace = TRUE)

## Sort by color
x <- x[order(x$color, -x$size),]

## Generate point grobs
library(grid)

## Focal set (sorted)
coords <- makeCoords(nrow(focal))
focalSet <- pointsGrob(x = unit(coords$x, 'native'),
                       y = unit(coords$y, 'native'),
                       pch = 21,
                       size = unit(focal$size, "char"),
                       gp = gpar(fill = as.character(focal$color), col = NA))

## Pool set (sorted)
coords <- makeCoords(nrow(pool))
poolSet <- pointsGrob(x = unit(coords$x, 'native'),
                      y = unit(coords$y, 'native'),
                      pch = 21,
                      size = unit(pool$size, "char"),
                      gp = gpar(fill = as.character(pool$color), col = NA))


## Matched set (sorted)
coords <- makeCoords(nrow(x))
matchedSet <- pointsGrob(x = unit(coords$x, 'native'),
                         y = unit(coords$y, 'native'),
                         pch = 21,
                         size = unit(x$size, "char"),
                         gp = gpar(fill = as.character(x$color), col = NA))


## Visualize sets
library(plotgardener)
pageCreate(width = 8.5, height = 6.5, showGuides = FALSE, xgrid = 0, ygrid =0)

## Pool set
plotGG(plot = poolSet, x = 1, y = 1, width = 2.5, height = 2.5)
plotText(label = "Pool Set",
            x = 2.25, y = 0.75,
            just = c("center", "bottom"),
            fontcolor = "#33A02C",
            fontface = "bold")

## Focal set
plotGG(plot = focalSet,
          x = 5.75, y = 1,
          width = (5/6)-(1/8),
          height = (5/6)-(1/8))
plotText(label = "Focal Set",
            x = 5.75 + ((5/6)-(1/8))/2,
            y = 0.75,
            just = c("center", "bottom"),
            fontcolor = "#1F78B4",
            fontface = "bold")

## Matched set
plotGG(plot = matchedSet,
          x = 5.75, y = 2.5,
          width = (5/6)-(1/8),
          height = (5/6)-(1/8))
plotText(label = "Matched Set",
            x = 5.75 + ((5/6)-(1/8))/2,
            y = 2.25,
            just = c("center", "bottom"),
            fontcolor = "#A6CEE3",
            fontface = "bold")

## Arrow and matchRanges label
plotSegments(x0 = 3.75, y0 = 2.5 + ((5/6)-(1/8))/2,
                x1 = 5.40, y1 = 2.5 + ((5/6)-(1/8))/2,
                arrow = arrow(type = "closed", length = unit(0.1, "inches")),
                fill = "black", lwd = 2)
plotText(label = "matchRanges()", fontfamily = 'mono',
            x = 4.625, y = 2.4 + ((5/6)-(1/8))/2,
            just = c("center", "bottom"))

## Matching plots
library(ggplot2)
smallText <- theme(legend.title = element_text(size=8),
                   legend.text=element_text(size=8),
                   title = element_text(size=8),
                   axis.title.x = element_text(size=8),
                   axis.title.y = element_text(size=8))

plot1 <-
  plotPropensity(x, sets=c('f','m','p')) +
  smallText +
  theme(legend.key.size = unit(0.5, 'lines'),
        title = element_blank())

plot2 <-
  plotCovariate(x=x, covar=covariates(x)[1], sets=c('f','m','p')) +
  smallText +
  theme(legend.text = element_blank(),
        legend.position = 'none')

plot3 <-
  plotCovariate(x=x, covar=covariates(x)[2], sets=c('f','m','p'))+
  smallText + 
  theme(legend.key.size = unit(0.5, 'lines'))


## Propensity scores
plotText(label = "plotPropensity()",
            x = 1.0, y = 4.24,
            just = c("left", "bottom"),
            fontface = "bold",
            fontfamily = 'mono')
plotText(label = "~color + size",
            x = 1.15, y = 4.5,
            just = c("left", "bottom"),
            fontsize = 10,
            fontfamily = "mono")
plotGG(plot = plot1,
          x = 0.9, y = 4.5, width = 2.5, height = 1.5,
          just = c("left", "top"))

## Covariate balance
plotText(label = "plotCovariate()",
            x = 3.65, y = 4.24,
            just = c("left", "bottom"),
            fontface = "bold",
            fontfamily = "mono")
plotText(label = covariates(x),
            x = c(3.9, 5.8), y = 4.5,
            just = c("left", "bottom"),
            fontsize = 10,
            fontfamily = "mono")
plotGG(plot = plot2,
          x = 3.40, y = 4.5, width = 1.8, height = 1.5,
          just = c("left", "top"))

plotGG(plot = plot3,
          x = 5.20, y = 4.5, width = 2.75, height = 1.5,
          just = c("left", "top"))

## ----message=FALSE, warning=FALSE---------------------------------------------
library(nullranges)
set.seed(123)
x <- makeExampleMatchedDataSet(type = 'GRanges')
x

## -----------------------------------------------------------------------------
set.seed(123)
mgr <- matchRanges(focal = x[x$feature1],
                   pool = x[!x$feature1],
                   covar = ~feature2 + feature3)
mgr

## ----message=FALSE, warning=FALSE---------------------------------------------
library(GenomicRanges)
sort(mgr)

## ----paged.print=FALSE--------------------------------------------------------
overview(mgr)

## -----------------------------------------------------------------------------
plotPropensity(mgr)

## -----------------------------------------------------------------------------
plotCovariate(mgr)

## ----message=FALSE, warning=FALSE, fig.height=6, fig.width=5------------------
library(patchwork)
plots <- lapply(covariates(mgr), plotCovariate, x=mgr, sets = c('f', 'm', 'p'))
Reduce('/', plots)

## -----------------------------------------------------------------------------
matchedData(mgr)

## ----results='hold'-----------------------------------------------------------
covariates(mgr)
method(mgr)
withReplacement(mgr)

## ----results='hold'-----------------------------------------------------------
summary(focal(mgr))
summary(pool(mgr))
summary(matched(mgr))
summary(unmatched(mgr))

## ----message=FALSE------------------------------------------------------------
library(plyranges)
bind_ranges(
  focal = focal(mgr),
  pool = pool(mgr),
  matched = matched(mgr), .id="type"
)

## -----------------------------------------------------------------------------
identical(matched(mgr), pool(mgr)[indices(mgr, set = 'matched')])

## -----------------------------------------------------------------------------
library(cobalt)
res <- bal.tab(f.build("set", covariates(mgr)),
               data = matchedData(mgr),
               distance = "ps", # name of column containing propensity score
               focal = "focal", # name of focal group in set column
               which.treat = "focal", # compare everything to focal
               s.d.denom = "all") # how to adjust standard deviation

res
love.plot(res)

## -----------------------------------------------------------------------------
set.seed(123)
mgr <- matchRanges(focal = x[x$feature1],
                   pool = x[!x$feature1],
                   covar = ~feature2 + feature3,
                   method = 'nearest',
                   replace = TRUE)
nn <- overview(mgr)
plotPropensity(mgr)

## ----results='hold'-----------------------------------------------------------
## Total number of duplicated indices
length(which(duplicated(indices(mgr))))

sum(table(indices(mgr)) > 1) # used more than once
sum(table(indices(mgr)) > 2) # used more than twice
sum(table(indices(mgr)) > 3) # used more than thrice

## -----------------------------------------------------------------------------
set.seed(123)
mgr <- matchRanges(focal = x[x$feature1],
                   pool = x[!x$feature1],
                   covar = ~feature2 + feature3,
                   method = 'rejection',
                   replace = FALSE)
rs <- overview(mgr)
plotPropensity(mgr)

## -----------------------------------------------------------------------------
set.seed(123)
mgr <- matchRanges(focal = x[x$feature1],
                   pool = x[!x$feature1],
                   covar = ~feature2 + feature3,
                   method = 'stratified',
                   replace = FALSE)
ss <- overview(mgr)
plotPropensity(mgr)

## -----------------------------------------------------------------------------
## Extract difference in propensity scores
## between focal and matched sets
fmps <- sapply(c(nn, rs, ss), `[[`, "quality")
c('nearest', 'rejection', 'stratified')[which.min(fmps)]


## -----------------------------------------------------------------------------
sessionInfo()

