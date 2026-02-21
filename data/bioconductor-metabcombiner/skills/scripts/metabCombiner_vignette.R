# Code example from 'metabCombiner_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
head(list.files())



## ----eval = FALSE-------------------------------------------------------------
# metdata = read.delim("path_to_data_file.txt", sep = "\t", header = TRUE,
#                     stringsAsFactors = FALSE)

## ----setup, message = FALSE---------------------------------------------------
#loading package
library(metabCombiner)
data("plasma30")
data("plasma20")

## -----------------------------------------------------------------------------
#header names of plasma dataset
names(plasma20)

## ----eval = FALSE-------------------------------------------------------------
# p20 = metabData(plasma20, mz = "mz", rt = "rt", id = "id", adduct = "adduct",
#                 samples = "CHEAR.20min",...)
# 
# ##all of the following values for id argument give the same result
# p20 = metabData(plasma20, ..., id = "identity", ...)    #full column name
# p20 = metabData(plasma20, ..., id = "^id", ...)  #column names starting with id
# 
# #any one of these three keywords
# p20 = metabData(plasma20, ..., id = c("compound,identity,name"),...)
# 
# ##all of the following inputs for samples argument give the same result
# p20 = metabData(plasma20, samples = c("CHEAR.20min.1, CHEAR.20min.2,
#                                 CHEAR.20min.3, CHEAR.20min.4, CHEAR.20min.5")
# 
# p20 = metabData(plasma20, samples = names(plasma20)[6:10], ...)
# 
# #recommended: use a keyword common and exclusive to sample names of interest
# p20 = metabData(plasma20, ..., samples = "CHEAR", ...)
# p20 = metabData(plasma20, ..., samples = "CH", ...)

## ----eval = FALSE-------------------------------------------------------------
# p20 = metabData(plasma20, mz = "mz", rt = "rt", id = "id", adduct = "adduct",
#                 samples = "CHEAR", extra = c("Red", "POOL", "Blank"),...)
# 
# getSamples(p20)   #should return column names containing "CHEAR"
# getExtra(p20)   #should return column containing "Red Cross", "POOL", "Blank"

## -----------------------------------------------------------------------------
head(sort(plasma20$rt), 10)
tail(sort(plasma20$rt), 10)

## -----------------------------------------------------------------------------
p20 <- metabData(table = plasma20, mz = "mz", rt = "rt", id = "identity", adduct = "adduct", samples = "CHEAR", extra = c("Red", "POOL"), rtmin = "min", rtmax = 17.25, measure = "median", zero = FALSE, duplicate = c(0.0025, 0.05))

## -----------------------------------------------------------------------------
p30 <- metabData(table = plasma30, samples = "Red", extra = c("CHEAR", "POOL", "Blank"))
getSamples(p30) ##should print out red cross sample names
getExtra(p30) ##should print out extra sample names
getStats(p30) ##prints a list of dataset statistics
print(p30)   ##object summary

## -----------------------------------------------------------------------------
p.combined = metabCombiner(xdata = p30, ydata = p20, binGap = 0.0075)

## -----------------------------------------------------------------------------
p.results = combinedTable(p.combined)
names(p.results)[1:15]

## ----fig.width= 5, fig.height=4, fig.align='center'---------------------------
p.combined.2 = selectAnchors(p.combined, windx = 0.03,windy = 0.02, tolQ = 0.3, tolmz = 0.003, tolrtq = 0.3, useID = FALSE)
a = getAnchors(p.combined.2)
plot(a$rtx, a$rty, main = "Fit Template", xlab = "rtx", ylab = "rty")

## -----------------------------------------------------------------------------
set.seed(100) #controls cross validation pseudo-randomness

p.combined.3 = fit_gam(p.combined.2, useID = FALSE, k = seq(12,20,2), iterFilter = 2, coef = 2, prop = 0.5, bs = "bs", family = "gaussian", m = c(3,2))

## ----fig.width= 5, fig.height=4, fig.align='center'---------------------------
plot(p.combined.3, main = "Example metabCombiner Plot", xlab = "P30 RTs", ylab = "P20 RTs", lcol = "blue", pcol = "black", lwd = 3, pch = 19,
     outlier = "highlight")

grid(lty = 2, lwd = 1)

## -----------------------------------------------------------------------------
p.combined.4 = calcScores(p.combined.3, A = 70, B = 15, C = 0.5, usePPM = FALSE, useAdduct = FALSE, groups = NULL)

## -----------------------------------------------------------------------------
scores = evaluateParams(p.combined.3, A = seq(50, 120, 10), B = 5:15, C = seq(0,1,0.1), usePPM = FALSE, minScore = 0.5, penalty = 10)

head(scores)

## -----------------------------------------------------------------------------
combined.table = combinedTable(p.combined.4)

##version 1: score-based conflict detection
combined.table.2 = labelRows(combined.table, minScore = 0.5, maxRankX = 3, maxRankY = 3, method = "score", delta = 0.2, remove = FALSE, balanced = TRUE)

##version 2: mzrt-based conflict detection
combined.table.3 = labelRows(combined.table, minScore = 0.5, maxRankX = 3, maxRankY = 3, method = "mzrt", balanced = TRUE, delta = c(0.003,0.5,0.003,0.2))

## ----eval = FALSE-------------------------------------------------------------
# write2file(combined.table, file = "Combined.Table.Report.txt", sep = "\t")

