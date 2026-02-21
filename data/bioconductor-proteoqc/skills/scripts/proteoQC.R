# Code example from 'proteoQC' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE--------------------
knitr::opts_chunk$set(tidy = FALSE,message = FALSE)

## ----echo=FALSE, results="hide"------------------------------------------
library("BiocStyle")
BiocStyle::markdown()

## ----echo=FALSE,warning=FALSE--------------------------------------------
suppressPackageStartupMessages(library("proteoQC"))
suppressPackageStartupMessages(library("R.utils"))

## ----eval=TRUE,warning=FALSE,error=FALSE,cache=TRUE----------------------
library("rpx")
px <- PXDataset("PXD000864")
px

## ----pxfiles, warning=FALSE,error=FALSE----------------------------------
head(pxfiles(px))
tail(pxfiles(px))

## ----eval=TRUE,warning=FALSE---------------------------------------------
mgfs <- grep("mgf", pxfiles(px), value = TRUE)
mgfs <- grep("-0[5-6]-[1|2]", mgfs, value=TRUE)
mgfs

## ----eval=FALSE,cache=TRUE-----------------------------------------------
#  mgffiles <- pxget(px, mgfs)
#  library("R.utils")
#  mgffiles <- sapply(mgffiles, gunzip)

## ----echo=FALSE, eval=FALSE----------------------------------------------
#  ## Generate the lightweight qc report,
#  ## trim the mgf files to 1/10 of their size.
#  
#  trimMgf <- function(f, m = 1/10, overwrite = FALSE) {
#      message("Reading ", f)
#      x <- readLines(f)
#      beg <- grep("BEGIN IONS", x)
#      end <- grep("END IONS", x)
#      n <- length(beg)
#      message("Sub-setting to ", m)
#      i <- sort(sample(n, floor(n * m)))
#      k <- unlist(mapply(seq, from = beg[i], to = end[i]))
#      if (overwrite) {
#          unlink(f)
#          message("Writing ", f)
#          writeLines(x[k], con = f)
#          return(f)
#      } else {
#          g <- sub(".mgf", "_small.mgf", f)
#          message("Writing ", g)
#          writeLines(x[k], con = g)
#          return(g)
#      }
#  }
#  
#  set.seed(1)
#  mgffiles <- sapply(mgffiles, trimMgf, overwrite = TRUE)

## ----eval=FALSE----------------------------------------------------------
#  fas <- pxget(px, "TTE2010.zip")
#  fas <- unzip(fas)
#  fas

## ----eval=FALSE, echo=FALSE----------------------------------------------
#  
#  ## code to regenerate the design file
#  sample <- rep(c("55","75"),each=4)
#  techrep <- rep(1:2, 4)
#  biorep <- rep(1, length(mgffiles))
#  frac <- rep((rep(5:6, each = 2)), 2)
#  des <- data.frame(file = mgffiles,
#                    sample = sample,
#                    bioRep = biorep, techRep = techrep,
#                    fraction = frac,
#                    row.names = NULL)
#  
#  write.table(des, sep = " ", row.names=FALSE,
#              quote = FALSE,
#              file = "../inst/extdata/PXD000864-design.txt")
#  

## ------------------------------------------------------------------------
design <- system.file("extdata/PXD000864-design.txt", package = "proteoQC")
design
read.table(design, header = TRUE)

## ----eval=FALSE, tidy=FALSE----------------------------------------------
#  qcres <- msQCpipe(spectralist = design,
#                    fasta = fas,
#                    outdir = "./qc",
#                    miss  = 0,
#                    enzyme = 1, varmod = 2, fixmod = 1,
#                    tol = 10, itol = 0.6, cpu = 2,
#                    mode = "identification")

## ------------------------------------------------------------------------
zpqc <- system.file("extdata/qc.zip", package = "proteoQC")
unzip(zpqc)
qcres <- loadmsQCres("./qc")

## ------------------------------------------------------------------------
print(qcres)

## ------------------------------------------------------------------------
showMods()

## ----message = FALSE-----------------------------------------------------
html <- reportHTML(qcres)

## ----message = FALSE-----------------------------------------------------
html <- reportHTML("./qc")

## ----eval=FALSE, echo=FALSE----------------------------------------------
#  ## Remove these files as they are really big
#  ## but this breaks reportHTML(qcres), though
#  unlink("./qc/database/target_decoy.fasta")
#  unlink("./qc/result/*_xtandem.xml")
#  unlink("../inst/extdata/qc.zip")
#  zip("../inst/extdata/qc.zip", "./qc")

## ----fig.width=6,fig.height=5--------------------------------------------
pep.zip <- system.file("extdata/pep.zip", package = "proteoQC")
unzip(pep.zip)
proteinGroup(file = "pep.txt", outfile = "pg.txt")

## ----warning=FALSE, cache=TRUE-------------------------------------------
mgf.zip <- system.file("extdata/mgf.zip", package = "proteoQC")
unzip(mgf.zip)
a <- labelRatio("test.mgf",reporter = 2)

## ----cache=TRUE----------------------------------------------------------
library(dplyr)
library(plotly)
mgf.zip <- system.file("extdata/mgf.zip", package = "proteoQC")
unzip(mgf.zip)
charge <- chargeStat("test.mgf")
pp <- plot_ly(charge, labels = ~Charge, values = ~Number, type = 'pie') %>%
        layout(title = 'Charge distribution',
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
pp

## ----echo=FALSE----------------------------------------------------------
sessionInfo()

