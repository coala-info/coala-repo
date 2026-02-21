# Code example from 'splots' vignette. See references/ for full tutorial.

## ----exampledata1, message=FALSE, warning=FALSE-------------------------------
data("featuresPerWell", package = "HD2013SGI")

## ----exampledata2-------------------------------------------------------------
str(featuresPerWell[[1]])

## ----exampledata3-------------------------------------------------------------
str(featuresPerWell[[2]])

## ----exampledata4, echo = FALSE-----------------------------------------------
stopifnot(nrow(featuresPerWell[[1]]) == nrow(featuresPerWell[[2]]))

## ----exampledata5, message=FALSE, warning=FALSE-------------------------------
library("dplyr")
sgi = tibble(featuresPerWell[[1]], count = featuresPerWell[[2]][, "count"]) |>
  filter(plate %in% unique(plate)[1:40],
         field == "1") |>
  mutate (col = as.integer(col),
          row = match(row, LETTERS))
sgi

## ----plotgg, fig.wide = TRUE, fig.cap = "Visualization using `ggplot`", fig.dim=c(10, 18), message=FALSE, warning=FALSE----
library("ggplot2")
ggplot(sgi, aes(x = col, y = row, fill = count)) + geom_raster() +
  facet_wrap(vars(plate), ncol = 4) +
  scale_fill_gradient(low = "white", high = "#00008B")

## ----xl1, results = "hide"----------------------------------------------------
np = 40
nx = 24
ny = 16
plateNames = unique(featuresPerWell[[1]]$plate)
assertthat::assert_that(length(plateNames) >= np)
plateNames = plateNames[seq_len(np)]
xl = lapply(plateNames, function(pl) {
  sel = with(featuresPerWell[[1]], plate == pl & field == "1")
  rv = rep(NA_real_, nx * ny)
  r = match(featuresPerWell[[1]]$row[sel], LETTERS)
  c = match(featuresPerWell[[1]]$col[sel], paste(seq_len(nx)))
  i = (r-1) * nx + c
  assertthat::assert_that(!any(is.na(r)), !any(is.na(c)), !any(duplicated(i)),
                          all(r>=1), all(r<=ny), all(c>=1), all(c<=nx))
  rv[i] = featuresPerWell[[2]][sel, "count"]
  rv
})
names(xl) = plateNames

## ----xl2----------------------------------------------------------------------
length(xl)
names(xl)[1:4]
unique(vapply(xl, function(x) paste(class(x), length(x)), character(1)))
xl[[1]][1:30]

## ----fig1, fig.wide = TRUE, fig.cap = "Visualization using `splots::plotScreen`", fig.dim=c(10, 18)----
splots::plotScreen(xl, nx = nx, ny = ny, ncol = 4, 
           fill = c("white", "#00008B"), 
           main = "HD2013SGI", legend.label = "count",
           zrange = c(0, max(unlist(xl), na.rm = TRUE)))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

