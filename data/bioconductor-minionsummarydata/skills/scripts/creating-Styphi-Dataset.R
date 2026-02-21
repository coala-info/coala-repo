# Code example from 'creating-Styphi-Dataset' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# setwd('/media/Storage/Work/MinION/')

## ----eval=FALSE---------------------------------------------------------------
# download.file(url='ftp://ftp.sra.ebi.ac.uk/vol1/ERA375/ERA375987/oxfordnanopore_native/H566_30_min_inc.tar.gz',
#               destfile = 'typhi.rep1.tar.gz')
# download.file(url='ftp://ftp.sra.ebi.ac.uk/vol1/ERA375/ERA375685/oxfordnanopore_native/H566_ON_inc.tar.gz',
#               destfile = 'typhi.rep2.tar.gz')
# download.file(url='ftp://ftp.sra.ebi.ac.uk/vol1/ERA376/ERA376255/oxfordnanopore_native/raw_2_rabsch_R7.tar.gz',
#               destfile = 'typhi.rep3.tar.gz')

## ----eval=FALSE---------------------------------------------------------------
# files.1 <- untar('typhi.rep1.tar.gz', list = TRUE)
# extract.1 <- grep(pattern = "/FMH.*\\.fast5", files.1)
# untar('typhi.rep1.tar.gz', files = files.1[extract.1], tar='internal', exdir = 'typhi.rep1')

## ----eval=FALSE---------------------------------------------------------------
# files.2 <- untar('typhi.rep2.tar.gz', list = TRUE)
# extract.2 <- grep(pattern = "/FMH.*\\.fast5", files.2)
# untar('typhi.rep2.tar.gz', files = files.2[extract.2], tar='internal', exdir = 'typhi.rep2')

## ----eval=FALSE---------------------------------------------------------------
# untar('typhi.rep3.tar.gz', files = 'raw_2_rabsch_R7/data_by_channel/', exdir = 'typhi.rep3')

## ----eval=FALSE---------------------------------------------------------------
# fast5.1 <- list.files(path = "typhi.rep1", pattern = "*.fast5$",
#                       full.names = TRUE, recursive = TRUE)
# fast5.2 <- list.files(path = "typhi.rep2", pattern = "*.fast5$",
#                       full.names = TRUE, recursive = TRUE)
# fast5.3 <- list.files(path = "typhi.rep3", pattern = "*.fast5$",
#                       full.names = TRUE, recursive = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# library(IONiseR)
# s.typhi.rep1 <- readFast5Summary(files = fast5.1)
# s.typhi.rep2 <- readFast5Summary(files = fast5.2)
# s.typhi.rep3 <- readFast5Summary(files = fast5.3)

## ----eval=FALSE---------------------------------------------------------------
# addPassFail <- function(summaryData) {
#     ## calculate the mean base quality score for 2D reads
#     meanBaseQuality <- alphabetScore(quality(fastq2D(summaryData))) / width(fastq2D(summaryData))
#     ## any greater than 9 is a PASS, less than is FAIL
#     passFail <- ifelse(meanBaseQuality > 9, yes = TRUE, no = FALSE)
#     ## match the PASS/FAIL status with an id
#     passFail <- data.table(baseCalled(summaryData) %>%
#                    filter(full_2D == TRUE, strand== "template") %>%
#                    select(id), pass = passFail)
#     ## create FALSE vector for all fast5 files, including those with no 2D
#     tmp <- rep(FALSE, length(summaryData))
#     ## use the id field to set PASS for appropriate reads
#     tmp[filter(passFail, pass==TRUE)[,id]] <- TRUE
#     ## update readInfo slot with extract column
#     summaryData@readInfo <- mutate(readInfo(summaryData), pass = tmp)
#     return(summaryData)
# }
# 
# s.typhi.rep1 <- addPassFail(s.typhi.rep1)
# s.typhi.rep2 <- addPassFail(s.typhi.rep2)
# s.typhi.rep3 <- addPassFail(s.typhi.rep3)

## ----eval=FALSE---------------------------------------------------------------
# save(s.typhi.rep1, file = "styphi.rep1.rda")
# save(s.typhi.rep2, file = "styphi.rep2.rda")
# save(s.typhi.rep3, file = "styphi.rep3.rda")

