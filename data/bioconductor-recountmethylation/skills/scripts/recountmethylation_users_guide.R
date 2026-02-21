# Code example from 'recountmethylation_users_guide' vignette. See references/ for full tutorial.

## ----setup, echo = FALSE, warning = FALSE-------------------------------------
suppressMessages(library(knitr))
suppressMessages(library(GenomicRanges))
suppressMessages(library(limma))
suppressMessages(library(minfi))
suppressMessages(library(ExperimentHub))
suppressMessages(library(recountmethylation))
knitr::opts_chunk$set(echo = TRUE, eval = TRUE, warning = FALSE, 
  message = FALSE)

## -----------------------------------------------------------------------------
dft <- data.frame(release = c("first", "second", "third", "total"),
                  version.label = c("0.0.1", "0.0.2", "0.0.3", "all"),
                  date = c("11/20/2020", "01/06/2021", "12/21/2022", "12/21/2022"),
                  hm450k.samples = c(35360, 50400, 7546, 
                                     sum(c(35360, 50400, 7546))),
                  epic.samples = c(0, 12650, 25472, 
                                   sum(c(0, 12650, 25472))))
dft$combined.samples <- dft$hm450k.samples + dft$epic.samples
knitr::kable(dft, align = "c")

## ----echo = TRUE, message = TRUE----------------------------------------------
sm <- as.data.frame(smfilt(get_servermatrix()))
if(is(sm, "data.frame")){knitr::kable(sm, align = "c")}

## ----eval = F-----------------------------------------------------------------
# cache.path <- tools::R_user_dir("recountmethylation")
# setExperimentHubOption("CACHE", cache.path)
# hub <- ExperimentHub::ExperimentHub()                    # connect to the hubs
# rmdat <- AnnotationHub::query(hub, "recountmethylation") # query the hubs

## ----eval = F-----------------------------------------------------------------
# fpath <- rmdat[["EH3778"]] # download with default caching
# rhdf5::h5ls(fpath)         # load the h5 file

## -----------------------------------------------------------------------------
dn <- "remethdb-h5se_gr-test_0-0-1_1590090412"
path <- system.file("extdata", dn, package = "recountmethylation")
h5se.test <- HDF5Array::loadHDF5SummarizedExperiment(path)

## -----------------------------------------------------------------------------
class(h5se.test) # inspect object class

## -----------------------------------------------------------------------------
dim(h5se.test) # get object dimensions

## -----------------------------------------------------------------------------
summary(h5se.test) # summarize dataset components

## -----------------------------------------------------------------------------
h5se.md <- minfi::pData(h5se.test) # get sample metadata
dim(h5se.md)                       # get metadata dimensions

## -----------------------------------------------------------------------------
colnames(h5se.md) # get metadata column names

## -----------------------------------------------------------------------------
h5se.bm <- minfi::getBeta(h5se.test) # get dnam fractions
dim(h5se.bm)                         # get dnam fraction dimensions

## -----------------------------------------------------------------------------
colnames(h5se.bm) <- h5se.test$gsm       # assign sample ids to dnam fractions
knitr::kable(head(h5se.bm), align = "c") # show table of dnam fractions 

## -----------------------------------------------------------------------------
an <- minfi::getAnnotation(h5se.test) # get platform annotation
dim(an)                               # get annotation dimensions

## -----------------------------------------------------------------------------
colnames(an) # get annotation column names

## -----------------------------------------------------------------------------
ant <- as.matrix(t(an[c(1:4), c(1:3, 5:6, 9, 19, 24, 26)])) # subset annotation
knitr::kable(ant, align = "c")                              # show annotation table

## -----------------------------------------------------------------------------
dn <- "remethdb-h5_rg-test_0-0-1_1590090412.h5"     # get the h5se directory name
h5.test <- system.file("extdata", "h5test", dn, 
                    package = "recountmethylation") # get the h5se dir path

## -----------------------------------------------------------------------------
h5.rg <- getrg(dbn = h5.test, all.gsm = TRUE) # get red/grn signals from an h5 db

## -----------------------------------------------------------------------------
h5.red <- minfi::getRed(h5.rg)     # get red signal matrix
h5.green <- minfi::getGreen(h5.rg) # get grn signal matrix
dim(h5.red)                        # get dimensions of red signal matrix

## -----------------------------------------------------------------------------
knitr::kable(head(h5.red), align = "c") # show first rows of red signal matrix

## -----------------------------------------------------------------------------
knitr::kable(head(h5.green), align = "c") # show first rows of grn signal matrix

## -----------------------------------------------------------------------------
identical(rownames(h5.red), rownames(h5.green)) # check cpg probe names identical

## ----eval = FALSE-------------------------------------------------------------
# # download from GEO
# dlpath <- tempdir()                                     # get a temp dir path
# gsmv <- c("GSM1038308", "GSM1038309")                   # set sample ids to identify
# geo.rg <- gds_idat2rg(gsmv, dfp = dlpath)               # load sample idats into rgset
# colnames(geo.rg) <- gsub("\\_.*", "", colnames(geo.rg)) # assign sample ids to columns

## ----eval = FALSE-------------------------------------------------------------
# geo.red <- minfi::getRed(geo.rg)      # get red signal matrix
# geo.green <- minfi::getGreen(geo.rg)  # get grn signal matrix

## ----eval = FALSE-------------------------------------------------------------
# int.addr <- intersect(rownames(geo.red), rownames(h5.red)) # get probe address ids
# geo.red <- geo.red[int.addr,]                              # subset geo rgset red signal
# geo.green <- geo.green[int.addr,]                          # subset gro rgset grn signal
# geo.red <- geo.red[order(match(rownames(geo.red), rownames(h5.red))),]
# geo.green <- geo.green[order(match(rownames(geo.green), rownames(h5.green))),]
# identical(rownames(geo.red), rownames(h5.red))             # check identical addresses, red
# identical(rownames(geo.green), rownames(h5.green))         # check identical addresses, grn
# class(h5.red) <- "integer"; class(h5.green) <- "integer"   # set matrix data classes to integer

## ----eval = FALSE-------------------------------------------------------------
# identical(geo.red, h5.red) # compare matrix signals, red

## ----eval = FALSE-------------------------------------------------------------
# identical(geo.green, h5.green) # compare matrix signals, grn

## ----eval = FALSE-------------------------------------------------------------
# geo.gr <- minfi::preprocessNoob(geo.rg) # get normalized se data

## ----eval = FALSE-------------------------------------------------------------
# geo.bm <- as.matrix(minfi::getBeta(geo.gr)) # get normalized dnam fractions matrix

## ----eval = FALSE-------------------------------------------------------------
# h5se.bm <- as.matrix(h5se.bm) # set dnam fractions to matrix
# int.cg <- intersect(rownames(geo.bm), rownames(h5se.bm))
# geo.bm <- geo.bm[int.cg,]     # subset fractions on shared probe ids
# geo.bm <- geo.bm[order(match(rownames(geo.bm), rownames(h5se.bm))),]

## ----eval = FALSE-------------------------------------------------------------
# identical(summary(geo.bm), summary(h5se.bm)) # check identical summary values

## ----eval = FALSE-------------------------------------------------------------
# identical(rownames(geo.bm), rownames(h5se.bm)) # check identical probe ids

## ----eval = FALSE-------------------------------------------------------------
# detectionP(rg[,1:50]) # get detection pvalues from rgset
# "Error in .local(Red, Green, locusNames, controlIdx, TypeI.Red, TypeI.Green, dim(Red_grid) == dim(detP_sink_grid) are not all TRUE"

## ----eval = FALSE-------------------------------------------------------------
# preprocessFunnorm(rg) # get noob-normalized data
# "Error: 'preprocessFunnorm()' only supports matrix-backed minfi objects.""

## ----eval = FALSE-------------------------------------------------------------
# rg.h5se <- loadHDF5SummarizedExperiment(rg.path)        # full h5se RGChannelSet
# rg.sub <- rg.h5se[,c(1:20)]                             # subset samples of interest
# rg.new <- RGChannelSet(Red = getRed(rg.sub),
#                        Green = getGreen(rg.sub),
#                        annotation = annotation(rg.sub)) # re-make as non-DA object
# gr <- preprocessFunnorm(rg.new)                         # repeat preprocessing

## ----get_sessioninfo----------------------------------------------------------
sessionInfo()

