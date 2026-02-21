# Code example from 'bumphunterExample' vignette. See references/ for full tutorial.

## ----'findRegions'------------------------------------------------------------
## Load bumphunter
library("bumphunter")

## Create data from the vignette
pos <- list(
    pos1 = seq(1, 1000, 35),
    pos2 = seq(2001, 3000, 35),
    pos3 = seq(1, 1000, 50)
)
chr <- rep(paste0("chr", c(1, 1, 2)), times = sapply(pos, length))
pos <- unlist(pos, use.names = FALSE)

## Find clusters
cl <- clusterMaker(chr, pos, maxGap = 300)

## Build simulated bumps
Indexes <- split(seq_along(cl), cl)
beta1 <- rep(0, length(pos))
for (i in seq(along = Indexes)) {
    ind <- Indexes[[i]]
    x <- pos[ind]
    z <- scale(x, median(x), max(x) / 12)
    beta1[ind] <- i * (-1)^(i + 1) * pmax(1 - abs(z)^3, 0)^3 ## multiply by i to vary size
}

## Build data
beta0 <- 3 * sin(2 * pi * pos / 720)
X <- cbind(rep(1, 20), rep(c(0, 1), each = 10))
set.seed(23852577)
error <- matrix(rnorm(20 * length(beta1), 0, 1), ncol = 20)
y <- t(X[, 1]) %x% beta0 + t(X[, 2]) %x% beta1 + error

## Perform bumphunting
tab <- bumphunter(y, X, chr, pos, cl, cutoff = .5)

## Explore data
lapply(tab, head)

## ----'buildGRanges'-----------------------------------------------------------
library("GenomicRanges")

## Build GRanges with sequence lengths
regions <- GRanges(
    seqnames = tab$table$chr,
    IRanges(start = tab$table$start, end = tab$table$end),
    strand = "*", value = tab$table$value, area = tab$table$area,
    cluster = tab$table$cluster, L = tab$table$L, clusterL = tab$table$clusterL
)

## Assign chr lengths
library(GenomeInfoDb)  # for getChromInfoFromUCSC()
seqlengths(regions) <- seqlengths(
    getChromInfoFromUCSC("hg19", as.Seqinfo = TRUE)
)[
    names(seqlengths(regions))
]

## Explore the regions
regions

## ----'loadLib'----------------------------------------------------------------
## Load regionReport
library("regionReport")

## ----'createReport', eval = FALSE---------------------------------------------
# ## Now create the report
# report <- renderReport(regions, "Example bumphunter",
#     pvalueVars = NULL,
#     densityVars = c(
#         "Area" = "area", "Value" = "value",
#         "Cluster Length" = "clusterL"
#     ), significantVar = NULL,
#     output = "bumphunter-example", outdir = "bumphunter-example",
#     device = "png"
# )

## ----'reproducibility'------------------------------------------------------------------------------------------------
## Date generated:
Sys.time()

## Time spent making this page:
proc.time()

## R and packages info:
options(width = 120)
sessioninfo::session_info()

