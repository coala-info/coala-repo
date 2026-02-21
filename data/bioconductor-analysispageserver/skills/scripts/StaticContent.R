# Code example from 'StaticContent' vignette. See references/ for full tutorial.

## ----echo = FALSE--------------------------------------------------------
options(markdown.HTML.options = "toc")

## ----echo = FALSE--------------------------------------------------------
## Remove target directories, if they already exist.
for(subdir in c("static-example", "static-example2", "static-example3", "static-example4"))  {
  if(file.exists(subdir))
    unlink(subdir, recursive = TRUE)
}

## ------------------------------------------------------------------------
n <- 100
x <- rnorm(n)
y <- rnorm(n)
words <- rep(c("A","few","words"), length = n)
numbers <- rep(c(42, pi, 3, -1), length = n)
col <- rep(c("red","orange","yellow","green","blue","purple"), length = n)

scatter.data <- data.frame(x = x,
                           y = y,
                           words = words,
                           numbers = numbers,
                           colors = col)
head(scatter.data)

## ------------------------------------------------------------------------
plot(x, y, main = "Scatter data", pch = 19, col = col)

## ----results='hide'------------------------------------------------------
plotfile <- tempfile(fileext = ".svg")
svg(plotfile, width = 9, height = 7)
plot(x, y, main = "Scatter data", pch = 19, col = col)
dev.off()

## ----warning = FALSE, message = FALSE------------------------------------
library(AnalysisPageServer)
result <- static.analysis.page(outdir = "static-example",
                               svg.files = plotfile,
                               dfs = scatter.data,
                               show.xy = TRUE,
                               title = "Random scatter data")

## ------------------------------------------------------------------------
result

## ----echo = FALSE--------------------------------------------------------
library(knitr)
make.link <- function(result, title)  {
  url <- sub(".*AnalysisPageServer/vignettes/", "", result$URL)
  if(missing(title))  title <- url
  asis_output(paste0("<a href=\"", url, "\" target=\"_new\">", title, "</a>"))
}
make.link(result)

## ----eval = FALSE--------------------------------------------------------
#  browseURL(result$URL)

## ------------------------------------------------------------------------
head(cars)

## ------------------------------------------------------------------------
## List of stopping distances for cars at each speed
dist.by.speed <- split(cars$dist, cars$speed)
## Average stopping distance for each speed (vector)
avg.dist <- sapply(dist.by.speed, mean)
## Number of measurements taken at each speed (vector)
n.at.speed <- sapply(dist.by.speed, length)
## Number of distinct speeds observed
n.speeds <- length(dist.by.speed)
## x-coordinates for bars in plot
x <- 1:n.speeds
## y-coordinates for bars in plot. For barplots the elements are
## recorded by their bottom coordinates, which are all 0 here
y <- rep(0, n.speeds)

barplot(n.at.speed, ylab = "Number of Cars", xlab = "Speed (mph)",
  cex.names=0.8)

## ------------------------------------------------------------------------
dist.summaries <- t(sapply(dist.by.speed, summary))
colnames(dist.summaries) <- paste(colnames(dist.summaries), "Dist")
cars.data <- data.frame(x = x, y = y,
  speed = as.integer(names(avg.dist)), n = n.at.speed,
  dist.summaries, check.names = FALSE)
head(cars.data)

## ----results='hide'------------------------------------------------------
plotfile2 <- tempfile(fileext = ".svg")
svg(filename = plotfile2, width = 9, height = 7)
barplot(n.at.speed, ylab = "Number of Cars", xlab = "Speed (mph)",
  cex.names=0.8)
dev.off()

## ------------------------------------------------------------------------
head(iris)

## ------------------------------------------------------------------------
svg.files <- c(plotfile, plotfile2, NA)
dfs <- list(scatter.data, cars.data, iris)
captions <- c("Random scatter data", "A summarization of the cars
dataset from R", "The iris data")

## We'll show the XY coordinates for the scatter data, where they have
## some meaning in interpreting the data, but not for the barplot,
## where they are only used to locate the plotted elements. The 
## third element of show.xy is ignored since there is no plot.
result <- static.analysis.page(outdir = "static-example2",
                     svg.files = svg.files,
                     dfs = dfs,
                     show.xy = c(TRUE, FALSE, TRUE),
                     title = captions)
result

## ----echo = FALSE--------------------------------------------------------
make.link(result, title = "Open the *three*-dataset report")

## ------------------------------------------------------------------------
image(volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano")

## ------------------------------------------------------------------------
x <- rep(1:nrow(volcano), each = ncol(volcano))
y <- rep(1:ncol(volcano), nrow(volcano))
volcano.cells <- data.frame(x = x, y = y, Height = as.vector(t(volcano)))
head(volcano.cells)

## ----results='hide'------------------------------------------------------
plotfile3 <- tempfile(fileext = ".svg")
svg(filename = plotfile3, width = 9, height = 7)
image(volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano")
dev.off()
result <- static.analysis.page(outdir = "static-example3",
                     svg.files = plotfile3,
                     dfs = volcano.cells,
                     show.xy = TRUE,
                     title = "Maunga Whau Volcano")
result

## ----echo = FALSE--------------------------------------------------------
make.link(result, "Link to interactive page")

## ----results = "hide"----------------------------------------------------
library(ggplot2)
plotfile4 <- tempfile(fileext = ".svg")
svg(filename = plotfile4, width = 7, height = 7)
p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
p + facet_grid(vs ~ am)
dev.off()

## ------------------------------------------------------------------------
df <- mtcars
xy.fields <- c("mpg", "wt")
df <- df[c(xy.fields, setdiff(names(df), xy.fields))]
head(df)

## ------------------------------------------------------------------------
groups <- unname(split(df, list(df$vs, df$am)))
df <- do.call(rbind, groups)

## ------------------------------------------------------------------------
group.lens <- sapply(groups, nrow)

## ------------------------------------------------------------------------
result <- static.analysis.page(outdir = "static-example4",
                               svg.files = plotfile4,
                               dfs = df,
                               show.xy = TRUE,
                               title = "Motor Trend Cars Data",
                               group.length.vecs = group.lens)

## ----echo = FALSE--------------------------------------------------------
make.link(result, "Link to interactive page")

