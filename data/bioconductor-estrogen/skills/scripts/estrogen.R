# Code example from 'estrogen' vignette. See references/ for full tutorial.

## ----cwd,echo=FALSE,results='hide'--------------------------------------------
cwd <- getwd()

## ----pkgs, results = 'hide', message = FALSE, warning = FALSE-----------------
library("affy")
library("estrogen")
library("vsn")
library("genefilter")

## ----datadir------------------------------------------------------------------
system.file("extdata", package="estrogen")
datadir <- function(x)
    file.path(system.file("extdata", package="estrogen"), x)

## ----loadpdata----------------------------------------------------------------
pd <- read.AnnotatedDataFrame(datadir("estrogen.txt"), 
                              header = TRUE, sep = "", row.names = 1)
pData(pd)

## ----a.read,results='hide'----------------------------------------------------
a <- ReadAffy(filenames = datadir(rownames(pData(pd))), 
              phenoData = pd,
              verbose = TRUE)

## ----a.show-------------------------------------------------------------------
a

## ----x.calc, results='hide'---------------------------------------------------
x <- vsnrma(a)

## ----x.show-------------------------------------------------------------------
x

## ----image1, dev = "png", include = FALSE-------------------------------------
image(a[, 1])

## ----image2, dev = "png", include = FALSE-------------------------------------
badc <- ReadAffy(filenames = datadir("bad.cel"))
image(badc)

## ----hist, include = FALSE, fig.width = 5, fig.height = 5---------------------
hist(log2(intensity(a[, 4])), breaks=100, col="blue")

## ----boxplots, include = FALSE, fig.width = 4, fig.height = 5-----------------
boxplot(a,col="red")
boxplot(data.frame(exprs(x)), col="blue")

## ----classx-------------------------------------------------------------------
class(x)
class(exprs(x))

## ----scp, include = FALSE, results='hide', fig.width = 6, fig.height = 6, dev = "png", dpi = 180----
plot(exprs(a)[, 1:2], log="xy", pch=".", main="all")
plot(pm(a)[, 1:2], log="xy", pch=".", main="pm")
plot(mm(a)[, 1:2], log="xy", pch=".", main="mm")
plot(exprs(x)[, 1:2], pch=".", main="x")

## ----heatmapa-----------------------------------------------------------------
rsd <- rowSds(exprs(x))
sel <- order(rsd, decreasing=TRUE)[1:50] 

## ----heatmap, include = FALSE, fig.width = 6, fig.height = 6, dev = "png", dpi = 180----
heatmap(exprs(x)[sel, ], col = gentlecol(256))

## ----deflm--------------------------------------------------------------------
lm.coef <- function(y) 
  lm(y ~ estrogen * time.h)$coefficients
eff <- esApply(x, 1, lm.coef)

## ----showlmres----------------------------------------------------------------
dim(eff)
rownames(eff)
affyids <- colnames(eff)

## ----gn-----------------------------------------------------------------------
library(hgu95av2.db) 
ls("package:hgu95av2.db")

## ----eff-show, fig.width = 5, fig.height = 4----------------------------------
hist(eff[2,], breaks=100, col="blue", main="estrogen main effect")
lowest <- sort(eff[2,], decreasing=FALSE)[1:3]
mget(names(lowest), hgu95av2GENENAME)

highest <- sort(eff[2,], decreasing=TRUE)[1:3]
mget(names(highest), hgu95av2GENENAME)

hist(eff[4,], breaks=100, col="blue", main="estrogen:time interaction")
highia <- sort(eff[4,], decreasing=TRUE)[1:3]
mget(names(highia), hgu95av2GENENAME)

