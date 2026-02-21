# Code example from 'ADaCGH2' vignette. See references/ for full tutorial.

### R code from vignette source 'ADaCGH2.Rnw'

###################################################
### code chunk number 1: ADaCGH2.Rnw:313-318
###################################################
library(ADaCGH2)

data(inputEx)
summary(inputEx)
head(inputEx)


###################################################
### code chunk number 2: ADaCGH2.Rnw:409-414
###################################################
fnameRdata <- list.files(path = system.file("data", package = "ADaCGH2"),
                     full.names = TRUE, pattern = "inputEx.RData")

inputToADaCGH(ff.or.RAM = "RAM",
                      RDatafilename = fnameRdata)


###################################################
### code chunk number 3: ADaCGH2.Rnw:442-445
###################################################
data(inputEx) ## make inputEx available as a data frame with that name
inputToADaCGH(ff.or.RAM = "RAM",
                      dataframe = inputEx)


###################################################
### code chunk number 4: ADaCGH2.Rnw:456-460
###################################################
data(inputEx)
cgh.dat <- inputEx[, -c(1, 2, 3)]
chrom.dat <- as.integer(inputEx[, 2])
pos.dat <- inputEx[, 3]


###################################################
### code chunk number 5: ADaCGH2.Rnw:476-483
###################################################
fnametxt <- list.files(path = system.file("data", package = "ADaCGH2"),
                         full.names = TRUE, pattern = "inputEx.txt")

##    You might want to adapt mc.cores to your hardware
tmp <- inputToADaCGH(ff.or.RAM = "RAM",
                     textfilename = fnametxt,
                     mc.cores = 2)


###################################################
### code chunk number 6: ADaCGH2.Rnw:544-545 (eval = FALSE)
###################################################
## help(pSegment)


###################################################
### code chunk number 7: ADaCGH2.Rnw:548-553
###################################################
##    You might want to adapt mc.cores to your hardware
haar.RAM.fork <- pSegmentHaarSeg(cgh.dat, chrom.dat,
                                   merging = "MAD",
                                 typeParall = "fork",
                                 mc.cores = 2)


###################################################
### code chunk number 8: ADaCGH2.Rnw:559-561
###################################################
lapply(haar.RAM.fork, head)
summary(haar.RAM.fork[[1]])


###################################################
### code chunk number 9: ADaCGH2.Rnw:576-585
###################################################
##    You might want to adapt mc.cores to your hardware
pChromPlot(haar.RAM.fork,
           cghRDataName = cgh.dat,
           chromRDataName = chrom.dat,
           posRDataName = pos.dat,
           probenamesRDataName = probenames.dat,
           imgheight = 350,
           typeParall = "fork",
           mc.cores = 2)


###################################################
### code chunk number 10: ADaCGH2.Rnw:643-649
###################################################
if(.Platform$OS.type != "windows") {

originalDir <- getwd()
## make it explicit where we are
print(originalDir)
}


###################################################
### code chunk number 11: ADaCGH2.Rnw:652-657
###################################################
if(.Platform$OS.type != "windows") {
if(!file.exists("ADaCGH2_vignette_tmp_dir"))
  dir.create("ADaCGH2_vignette_tmp_dir")
setwd("ADaCGH2_vignette_tmp_dir")
}


###################################################
### code chunk number 12: ADaCGH2.Rnw:698-704
###################################################
if(.Platform$OS.type != "windows") {
fnameRdata <- list.files(path = system.file("data", package = "ADaCGH2"),
                     full.names = TRUE, pattern = "inputEx.RData")
inputToADaCGH(ff.or.RAM = "ff",
                      RDatafilename = fnameRdata)
}


###################################################
### code chunk number 13: ADaCGH2.Rnw:754-761 (eval = FALSE)
###################################################
## mcparallel(inputToADaCGH(ff.or.RAM = "ff",
##                                  RDatafilename = fnameRData),
##                                  silent = FALSE)
##   tableChromArray <- mccollect()
##   if(inherits(tableChromArray, "try-error")) {
##     stop("ERROR in input data conversion")
##   }


###################################################
### code chunk number 14: ADaCGH2.Rnw:775-780
###################################################
if(.Platform$OS.type != "windows") {
data(inputEx) ## make inputEx available as a data frame with that name
inputToADaCGH(ff.or.RAM = "ff",
                      dataframe = inputEx)
}


###################################################
### code chunk number 15: ADaCGH2.Rnw:796-805
###################################################
if(.Platform$OS.type != "windows") {
fnametxt <- list.files(path = system.file("data", package = "ADaCGH2"),
                         full.names = TRUE, pattern = "inputEx.txt")

##    You might want to adapt mc.cores to your hardware
inputToADaCGH(ff.or.RAM = "ff",
              textfilename = fnametxt,
              mc.cores = 2)
}


###################################################
### code chunk number 16: ADaCGH2.Rnw:856-868
###################################################
if(.Platform$OS.type != "windows") {
## Adapt number of nodes to your hardware    
number.of.nodes <- 2 ##detectCores()
cl2 <- parallel::makeCluster(number.of.nodes, "PSOCK")
parallel::clusterSetRNGStream(cl2)
parallel::setDefaultCluster(cl2) 
parallel::clusterEvalQ(NULL, library("ADaCGH2"))

wdir <- getwd()
parallel::clusterExport(NULL, "wdir")
parallel::clusterEvalQ(NULL, setwd(wdir))
}


###################################################
### code chunk number 17: ADaCGH2.Rnw:898-899 (eval = FALSE)
###################################################
## help(pSegment)


###################################################
### code chunk number 18: ADaCGH2.Rnw:901-907
###################################################
if(.Platform$OS.type != "windows") {
    haar.ff.cluster <- pSegmentHaarSeg("cghData.RData",
                                   "chromData.RData", 
                                   merging = "MAD",
                                   typeParall = "cluster")
}


###################################################
### code chunk number 19: ADaCGH2.Rnw:915-919
###################################################
if(.Platform$OS.type != "windows") {
lapply(haar.ff.cluster, open)
summary(haar.ff.cluster[[1]][,])
}


###################################################
### code chunk number 20: ADaCGH2.Rnw:932-943
###################################################
if(.Platform$OS.type != "windows") {
save(haar.ff.cluster, file = "hs_mad.out.RData", compress = FALSE)

pChromPlot(outRDataName = "hs_mad.out.RData",
           cghRDataName = "cghData.RData",
           chromRDataName = "chromData.RData",
           posRDataName = "posData.RData",
           probenamesRDataName = "probeNames.RData",
           imgheight = 350,
           typeParall = "cluster")
}


###################################################
### code chunk number 21: ADaCGH2.Rnw:948-951
###################################################
if(.Platform$OS.type != "windows") {
parallel::stopCluster(cl2)
}


###################################################
### code chunk number 22: ADaCGH2.Rnw:1011-1017
###################################################
if(.Platform$OS.type != "windows") {
fnameRdata <- list.files(path = system.file("data", package = "ADaCGH2"),
                     full.names = TRUE, pattern = "inputEx.RData")
inputToADaCGH(ff.or.RAM = "ff",
                      RDatafilename = fnameRdata)
}


###################################################
### code chunk number 23: ADaCGH2.Rnw:1031-1038 (eval = FALSE)
###################################################
## mcparallel(inputToADaCGH(ff.or.RAM = "ff",
##                                  RDatafilename = fnameRdata), 
##            silent = FALSE)
## tableChromArray <- collect()
## if(inherits(tableChromArray, "try-error")) {
##   stop("ERROR in input data conversion")
## }


###################################################
### code chunk number 24: ADaCGH2.Rnw:1051-1060
###################################################
if(.Platform$OS.type != "windows") {
fnametxt <- list.files(path = system.file("data", package = "ADaCGH2"),
                         full.names = TRUE, pattern = "inputEx.txt")

##    You might want to adapt mc.cores to your hardware
inputToADaCGH(ff.or.RAM = "ff",
              textfilename = fnametxt,
              mc.cores = 2)
}


###################################################
### code chunk number 25: ADaCGH2.Rnw:1121-1139
###################################################
if( (.Platform$OS.type == "unix") && (Sys.info()['sysname'] != "Darwin") ) {
  fnametxt <- list.files(path = system.file("data", package = "ADaCGH2"),
                          full.names = TRUE, pattern = "inputEx.txt")
  if(file.exists("cuttedFile")) {
    stop("The cuttedFile directory already exists. ",
         "Did you run this vignette from this directory before? ",
         "You will not want to do that, unless you modify the arguments ",
         "to inputToADaCGH below")
  } else dir.create("cuttedFile")
  setwd("cuttedFile")
  ## You might want to adapt mc.cores to your hardware
  cutFile(fnametxt, 1, 2, 3, sep = "\t", mc.cores = 2)
  cuttedFile.dir <- getwd()
  setwd("../")
} else {
  cuttedFile.dir <- system.file("example-datadir", 
                                 package = "ADaCGH2")
}


###################################################
### code chunk number 26: chunk0001
###################################################
if(.Platform$OS.type != "windows") {
## You might want to adapt mc.cores to your hardware    
inputToADaCGH(ff.or.RAM = "ff",
              path = cuttedFile.dir,
              verbose = TRUE,
              mc.cores = 2)
}


###################################################
### code chunk number 27: chunk0002
###################################################
if(.Platform$OS.type != "windows") {
## You might want to adapt mc.cores to your hardware
haar.ff.fork <- pSegmentHaarSeg("cghData.RData",
                                "chromData.RData",
                                 merging = "MAD",
                                typeParall = "fork",
                                mc.core = 2)
}


###################################################
### code chunk number 28: chunk0003
###################################################
if(.Platform$OS.type != "windows") {
save(haar.ff.fork, file = "haar.ff.fork.RData", compress = FALSE)

##    You might want to adapt mc.cores to your hardware
pChromPlot(outRDataName = "haar.ff.fork.RData",
           cghRDataName = "cghData.RData",
           chromRDataName = "chromData.RData",
           posRDataName = "posData.RData",
           probenamesRDataName = "probeNames.RData",
           imgheight = 350,
           typeParall = "fork",
           mc.cores = 2)
}


###################################################
### code chunk number 29: chunk0006 (eval = FALSE)
###################################################
## if(.Platform$OS.type != "windows") {
##   require("limma")
##   datadir <- system.file("testdata", package = "snapCGH")
##   targets.limma <- readTargets("targets.txt", path = datadir)
##   RG.limma <- read.maimages(targets.limma, path = datadir, 
##                             source="genepix")
##   RG.limma <- backgroundCorrect(RG.limma, method="normexp", 
##                                 offset=50)
##   MA.limma <- normalizeWithinArrays(RG.limma)
## }


###################################################
### code chunk number 30: chunk0007 (eval = FALSE)
###################################################
## if(.Platform$OS.type != "windows") {
## fclone <- list.files(path = system.file("testdata", package = "snapCGH"),
##                      full.names = TRUE, pattern = "cloneinfo.txt")
## fclone
## tmp <- inputToADaCGH(MAList = MA.limma, 
##                              cloneinfo = fclone,
##                              robjnames = c("cgh-ma.dat", "chrom-ma.dat",
##                                           "pos-ma.dat", "probenames-ma.dat"))
## }


###################################################
### code chunk number 31: chunk0008 (eval = FALSE)
###################################################
## if(.Platform$OS.type != "windows") {
## acloneinfo <- MA$genes
## tmp <- inputToADaCGH(MAList = MA.limma, 
##                              cloneinfo = acloneinfo,
##                              robjnames = c("cgh-ma.dat", "chrom-ma.dat",
##                                           "pos-ma.dat", "probenames-ma.dat"))
## }


###################################################
### code chunk number 32: chunk0009
###################################################
if(.Platform$OS.type != "windows") {
forcghr <- outputToCGHregions(haar.ff.cluster)
if(require(CGHregions)) {
  regions1 <- CGHregions(na.omit(forcghr))
  regions1
}
}


###################################################
### code chunk number 33: chunk00010
###################################################
if(.Platform$OS.type != "windows") {
## We are done with the executable code in the vignette.
## Restore the directory
setwd(originalDir)
print(getwd())
}


###################################################
### code chunk number 34: chunk00011
###################################################
if(.Platform$OS.type != "windows") {
## Remove the tmp dir. Sys.sleep to prevent Windoze problems.
## Sys.sleep(1)
## What is in that dir?
dir("ADaCGH2_vignette_tmp_dir")
unlink("ADaCGH2_vignette_tmp_dir", recursive = TRUE)
## Sys.sleep(1)
}


###################################################
### code chunk number 35: ADaCGH2.Rnw:2252-2253
###################################################
sessionInfo()


###################################################
### code chunk number 36: ADaCGH2.Rnw:2260-2263
###################################################
## try(closeAllConnections()) ## nope, breaks things
## Remove this sys.sleep; is this sometimes breaking windoze build in BioC?
## Sys.sleep(1) ## I hope we do not need this


