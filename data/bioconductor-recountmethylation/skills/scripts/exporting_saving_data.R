# Code example from 'exporting_saving_data' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, eval = FALSE)
libv <- c("minfiData", "HDF5Array", "minfi")
sapply(libv, library, character.only = TRUE)

## -----------------------------------------------------------------------------
# rg.hm450k <- get(data("RGsetEx"))

## -----------------------------------------------------------------------------
# rg.epic <- convertArray(rg.hm450k, "IlluminaHumanMethylationEPIC")

## -----------------------------------------------------------------------------
# ms.hm450k <- preprocessRaw(rg) # make MethylSet
# ms.hm450k <- mapToGenome(ms.hm450k) # make GenomicMethylSet

## -----------------------------------------------------------------------------
# gr.hm450k <- GenomicMethylSet(gr = granges(ms.hm450k),
#                               Meth = getMeth(ms.hm450k),
#                               Unmeth = getUnmeth(ms.hm450k),
#                               annotation = annotation(ms.hm450k))

## -----------------------------------------------------------------------------
# saveHDF5SummarizedExperiment(gr.hm450k, dir = "gr_h5se_new")

## -----------------------------------------------------------------------------
# gr.h5se <- loadHDF5SummarizedExperiment(dir = "gr_h5se_new")

## ----eval = FALSE-------------------------------------------------------------
# # get flat files
# m.beta <- getBeta(gr.h5se)
# anno <- as.data.frame(getAnnotation(gr.h5se))
# coldata <- as.data.frame(colData(gr.h5se))
# # save flat files
# save(m.beta, file = "mbeta_new.rda")
# save(anno, file = "anno_new.rda")
# save(coldata, file = "coldata_new.rda")

## ----eval = FALSE-------------------------------------------------------------
# write.table(m.beta, file = "mbeta_new.txt")
# write.csv(m.beta, file = "mbeta_new.csv")
# data.table::fwrite(m.beta, file = "mbeta_new.txt")

## ----eval = FALSE-------------------------------------------------------------
# save(rg, file = "rg_new.rda")
# save(gm, file = "gm_new.rda")
# save(gr, file = "gr_new.rda")

## -----------------------------------------------------------------------------
# rg.h5se <- rg.h5se[seq(1000),] # subset the h5se object
# quickResaveHDF5SummarizedExperiment(rg.h5se) # rapidly update stored file

