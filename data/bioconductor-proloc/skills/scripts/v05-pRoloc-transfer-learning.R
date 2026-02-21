# Code example from 'v05-pRoloc-transfer-learning' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----env, include=FALSE, echo=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(stop_on_error = 1L)
suppressPackageStartupMessages(library("MSnbase"))
suppressWarnings(suppressPackageStartupMessages(library("pRoloc")))
suppressPackageStartupMessages(library("pRolocdata"))
suppressPackageStartupMessages(library("class"))
set.seed(1)
setStockcol(NULL)

## ----loadpkg------------------------------------------------------------------
library("pRoloc")

## -----------------------------------------------------------------------------
library("pRolocdata")
data("andy2011")

## -----------------------------------------------------------------------------
andy2011

## -----------------------------------------------------------------------------
head(exprs(andy2011))

## -----------------------------------------------------------------------------
getMarkers(andy2011, fcol = "markers.tl")

## ----loaddata-----------------------------------------------------------------
data("andy2011goCC")
andy2011goCC

## -----------------------------------------------------------------------------
dim(andy2011goCC)
exprs(andy2011goCC)[1:10, 1:10]

## -----------------------------------------------------------------------------
all(featureNames(andy2011) == featureNames(andy2011goCC))

head(featureNames(andy2011))
head(featureNames(andy2011goCC))

## -----------------------------------------------------------------------------
data("andy2011hpa")
andy2011

## ----tabdelim-----------------------------------------------------------------
ppif <- system.file("extdata/tabdelimited._gHentss2F9k.txt.gz", package = "pRolocdata")
ppidf <- read.delim(ppif, header = TRUE, stringsAsFactors = FALSE)
head(ppidf)

## ----ppiset-------------------------------------------------------------------
uid <- unique(c(ppidf$X.node1, ppidf$node2))
ppim <- diag(length(uid))
colnames(ppim) <- rownames(ppim) <- uid

for (k in 1:nrow(ppidf)) {
    i <- ppidf[[k, "X.node1"]]
    j <- ppidf[[k, "node2"]]
    ppim[i, j] <- ppidf[[k, "combined_score"]]
}

ppim[1:5, 1:8]

## ----ppiset2------------------------------------------------------------------
andyppi <- andy2011
featureNames(andyppi) <- sub("_HUMAN", "", fData(andyppi)$UniProtKB.entry.name)
cmn <- intersect(featureNames(andyppi), rownames(ppim))
ppim <- ppim[cmn, ]
andyppi <- andyppi[cmn, ]

ppi <- MSnSet(ppim, fData = fData(andyppi),
              pData = data.frame(row.names = colnames(ppim)))
ppi <- filterZeroCols(ppi)

## -----------------------------------------------------------------------------
andyppi

## ----mclasses, echo=FALSE-----------------------------------------------------
data(andy2011) ## load clean LOPIT data

## marker classes for andy2011
m <- unique(fData(andy2011)$markers.tl)
m <- m[m != "unknown"]

## ----andypca, fig.width=6, fig.height=6, echo=FALSE, fig.cap = "PCA plot of `andy2011`. The multivariate protein profiles are summarised along the two first principal components. Proteins of unknown localisation are represented by empty grey points. Protein markers, which are well-known residents of specific sub-cellular niches are colour-coded and form clusters on the figure."----
setStockcol(paste0(getStockcol(), "80"))
plot2D(andy2011, fcol = "markers.tl")
setStockcol(NULL)
addLegend(andy2011, fcol = "markers.tl",
          where = "topright", bty = "n", cex = .7)

## ----thetas0, echo=TRUE-------------------------------------------------------
head(thetas(3, by = 0.5))
dim(thetas(3, by = 0.5))

## ----thetas1, echo=TRUE-------------------------------------------------------
dim(thetas(5, length.out = 4))

## ----thetaandy----------------------------------------------------------------
## marker classes for andy2011
m <- unique(fData(andy2011)$markers.tl)
m <- m[m != "unknown"]
th <- thetas(length(m), length.out=4)
dim(th)

## ----thetaopt0, eval=FALSE----------------------------------------------------
# topt <- knntlOptimisation(andy2011, andy2011goCC,
#                           th = th,
#                           k = c(3, 3),
#                           fcol = "markers.tl",
#                           times = 50)

## ----thetaopt, eval=TRUE------------------------------------------------------
set.seed(1)
i <- sample(nrow(th), 12)
topt <- knntlOptimisation(andy2011, andy2011goCC,
                          th = th[i, ],
                          k = c(3, 3),
                          fcol = "markers.tl",
                          times = 5)
topt

## ----getParam-----------------------------------------------------------------
getParams(topt)

## ----besttheta----------------------------------------------------------------
(bw <- experimentData(andy2011)@other$knntl$thetas)

## ----tlclass------------------------------------------------------------------
andy2011 <- knntlClassification(andy2011, andy2011goCC,
                                bestTheta = bw,
                                k = c(3, 3),
                                fcol = "markers.tl")

## ----tlpreds------------------------------------------------------------------
andy2011 <- getPredictions(andy2011, fcol = "knntl")

## ----andypca2, fig.width=6, fig.height=6, fig.cap = "PCA plot of `andy2011` after transfer learning classification. The size of the points is proportional to the classification scores."----
setStockcol(paste0(getStockcol(), "80"))
ptsze <- exp(fData(andy2011)$knntl.scores) - 1
plot2D(andy2011, fcol = "knntl", cex = ptsze)
setStockcol(NULL)
addLegend(andy2011, where = "topright",
          fcol = "markers.tl",
          bty = "n", cex = .7)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

