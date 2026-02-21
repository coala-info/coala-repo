# Code example from 'analysis' vignette. See references/ for full tutorial.

## ----environment, echo=FALSE, message=FALSE, warning=FALSE--------------------
library("topdownr")
library("topdownrdata")
library("ranger")
library("ggplot2")
library("BiocStyle")

## ----citation, echo=FALSE, results="asis"-------------------------------------
ct <- format(citation("topdownr"), "textVersion")
cat(gsub("DOI: *(.*)$", "DOI: [\\1](https://doi.org/\\1)", ct), "\n")

## ----loadPackage--------------------------------------------------------------
library("topdownr")

## ----listFiles, eval=-1, echo=1, comment=NA-----------------------------------
list.files(topdownrdata::topDownDataPath("myoglobin"))
lapply(
    topdownr:::.listTopDownFiles(
        topdownrdata::topDownDataPath("myoglobin")),
    function(x) {
        c(head(
            file.path(
                "...",
                paste(
                    tail(strsplit(dirname(x), "/")[[1L]], 2),
                    collapse=.Platform$file.sep
                ),
                basename(x)
            ),
            2
        ), "...")
    }
)

## ----importFiles, warnings=FALSE----------------------------------------------
## the mass adduct for a proton
H <- 1.0078250321

myoglobin <- readTopDownFiles(
    ## directory path
    path = topdownrdata::topDownDataPath("myoglobin"),
    ## fragmentation types
    type = c("a", "b", "c", "x", "y", "z"),
    ## adducts (add -H/H to c/z and name
    ## them cmH/zpH (c minus H, z plus H)
    adducts = data.frame(
        mass=c(-H, H),
        to=c("c", "z"),
        name=c("cmH", "zpH")),
    ## initiator methionine removal
    modifications = "Met-loss",
    ## don't use neutral loss
    neutralLoss = NULL,
    ## tolerance for fragment matching
    tolerance = 5e-6,
    ## topdownrdata was generate with an older version of topdownr,
    ## the method files were generated with FilterString identification,
    ## use `conditions = "ScanDescription"` (default) for recent data.
    conditions = "FilterString"
)

myoglobin

## ----rowViews-----------------------------------------------------------------
rowViews(myoglobin)

## ----colData------------------------------------------------------------------
conditionData(myoglobin)[, 1:5]

## ----assayData----------------------------------------------------------------
assayData(myoglobin)[206:215, 1:10]

## ----subsetting---------------------------------------------------------------
# select the first 100 fragments
myoglobin[1:100]

# select all "c" fragments
myoglobin["c"]

# select just the 100. "c" fragment
myoglobin["c100"]

# select all "a" and "b" fragments but just the first 100 "c"
myoglobin[c("a", "b", paste0("c", 1:100))]

# select condition/run 1 to 10
myoglobin[, 1:10]

# select all conditions from one file
myoglobin[, myoglobin$File == "myo_1211_ETDReagentTarget_1e+06_1"]

# select all "c" fragments from a single file
myoglobin["c", myoglobin$File == "myo_1211_ETDReagentTarget_1e+06_1"]

## ----plotting, eval=1:2-------------------------------------------------------
# plot a single condition
plot(myoglobin[, "C0707.30_1.0e+05_1.0e+06_10.00_00_28_3"])
# example to plot the first ten conditions into a pdf
# (not evaluated in the vignette)
pdf("topdown-conditions.pdf", paper="a4r", width=12)
plot(myoglobin[, 1:10])
dev.off()

## ----importFiles2, ref.label="import_files", eval=FALSE-----------------------
# NA

## ----filterInjectionTimes-----------------------------------------------------
injTimeBefore <- colData(myoglobin)
injTimeBefore$Status <- "before filtering"

## filtering on max deviation and just keep the
## 2 technical replicates per condition with the
## lowest deviation
myoglobin <- filterInjectionTime(
    myoglobin,
    maxDeviation = log2(3),
    keepTopN = 2
)

myoglobin

injTimeAfter <- colData(myoglobin)
injTimeAfter$Status <- "after filtering"

injTime <- as.data.frame(rbind(injTimeBefore, injTimeAfter))

## use ggplot for visualisation
library("ggplot2")

ggplot(injTime,
    aes(x = as.factor(AgcTarget),
        y = IonInjectionTimeMs,
        group = AgcTarget)) +
    geom_boxplot() +
    facet_grid(Status ~ Mz)

## ----filterCv-----------------------------------------------------------------
myoglobin <- filterCv(myoglobin, threshold=30)
myoglobin

## ----filterIntensity----------------------------------------------------------
myoglobin <- filterIntensity(myoglobin, threshold=0.1)
myoglobin

## ----aggregate----------------------------------------------------------------
myoglobin <- aggregate(myoglobin)
myoglobin

## ----randomForest-------------------------------------------------------------
library("ranger")

## statistics
head(summary(myoglobin))

## number of fragments
nFragments <- summary(myoglobin)$Fragments

## features of interest
foi <- c(
    "AgcTarget",
    "EtdReagentTarget",
    "EtdActivation",
    "CidActivation",
    "HcdActivation",
    "Charge"
)

rfTable <- as.data.frame(colData(myoglobin)[foi])

## set NA to zero
rfTable[is.na(rfTable)] <- 0

rfTable <- as.data.frame(cbind(
    scale(rfTable),
    Fragments = nFragments
))

featureImportance <- ranger(
    Fragments ~ .,
    data = rfTable,
    importance = "impurity"
)$variable.importance

barplot(
    featureImportance/sum(featureImportance),
    cex.names = 0.7
)

## ----coerce2NCBSet------------------------------------------------------------
myoglobinNcb <- as(myoglobin, "NCBSet")
myoglobinNcb

## ----bestConditions-----------------------------------------------------------
bestConditions(myoglobinNcb, n=3)

## ----fragmentationMap---------------------------------------------------------
sel <-
    myoglobinNcb$Mz == 707.3 &
    myoglobinNcb$AgcTarget == 1e6 &
    (myoglobinNcb$EtdReagentTarget == 1e7 &
     !is.na(myoglobinNcb$EtdReagentTarget))

myoglobinNcbSub <- myoglobinNcb[, sel]

fragmentationMap(
    myoglobinNcbSub,
    nCombinations = 10,
    labels = seq_len(ncol(myoglobinNcbSub))
)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

