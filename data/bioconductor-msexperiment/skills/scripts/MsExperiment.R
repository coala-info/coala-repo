# Code example from 'MsExperiment' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(MsExperiment)
library(Spectra)
library(BiocStyle)

## ----load_pkg, message = FALSE------------------------------------------------
library("MsExperiment")

## ----load_spectra, message = FALSE--------------------------------------------
library("Spectra")

## ----px, eval = TRUE----------------------------------------------------------
library("rpx")
px <- PXDataset("PXD022816")
px
pxfiles(px)

## ----fls, eval = TRUE---------------------------------------------------------
(i <- grep(".+0[12].+mzML$", pxfiles(px), value = TRUE))
fls <- pxget(px, i)
fls

## ----make_exp, eval = TRUE----------------------------------------------------
msexp <- MsExperiment()
msexp

## ----make_exp_fls, eval = TRUE------------------------------------------------
msfls <- MsExperimentFiles(mzmls = fls,
                           fasta = "homo_sapiens.fasta")
msfls

## ----add_exp_fls, eval = TRUE-------------------------------------------------
experimentFiles(msexp) <- msfls
msexp

## ----add_sample_data, eval = TRUE---------------------------------------------
sampleData(msexp) <- DataFrame(
    mzmls = basename(experimentFiles(msexp)[["mzmls"]]),
    fractions = 1:2)
sampleData(msexp)

## ----sp, eval = TRUE----------------------------------------------------------
sp <- Spectra(experimentFiles(msexp)[["mzmls"]])
sp

## ----add_sp, eval = TRUE------------------------------------------------------
spectra(msexp) <- sp
msexp

## ----make_cmd, eval = TRUE----------------------------------------------------
mzids <- sub("mzML", "mzid", basename(experimentFiles(msexp)[["mzmls"]]))
paste0("java -jar /path/to/MSGFPlus.jar",
       " -s ", experimentFiles(msexp)[["mzmls"]],
       " -o ", mzids,
       " -d ", experimentFiles(msexp)[["fasta"]],
       " -t 20ppm",
       " -m 0",
       " int 1")

## ----touch, eval = TRUE-------------------------------------------------------
(output <- file.path(tempdir(), mzids))
cmd <- paste("touch", output)
cmd

## ----system, eval = TRUE------------------------------------------------------
sapply(cmd, system)

## ----add_mzids, eval = TRUE---------------------------------------------------
experimentFiles(msexp)[["mzids"]] <- mzids
experimentFiles(msexp)
msexp

## ----add_cmd, eval = TRUE-----------------------------------------------------
metadata(msexp)[["mzmls_to_mzids"]] <- cmd
metadata(msexp)

## ----exp_exists, eval = TRUE--------------------------------------------------
existMsExperimentFiles(msexp)

## ----save_exp, eval = TRUE----------------------------------------------------
saveRDS(msexp, "msexp.rds")
rm(list = ls())

## ----read_exp, eval = TRUE----------------------------------------------------
msexp <- readRDS("msexp.rds")
msexp
experimentFiles(msexp)

## ----plot_sp, eval = TRUE-----------------------------------------------------
sp <- spectra(msexp)
sp
plotSpectra(sp[1000])

## ----make_exp2----------------------------------------------------------------
lmse <- MsExperiment()
sd <- DataFrame(sample_id = c("QC1", "QC2"),
                sample_name = c("QC Pool", "QC Pool"),
                injection_idx = c(1, 3))
sampleData(lmse) <- sd

## ----add_fls2-----------------------------------------------------------------
fls <- dir(system.file("sciex", package = "msdata"), full.names = TRUE)
basename(fls)

experimentFiles(lmse) <- MsExperimentFiles(
    mzML_files = fls,
    annotations = "internal_standards.txt")

## ----add_sp2------------------------------------------------------------------
sps <- Spectra(fls, backend = MsBackendMzR())
spectra(lmse) <- sps
lmse

## ----link_sample_data---------------------------------------------------------
lmse <- linkSampleData(lmse, with = "experimentFiles.mzML_file",
                        sampleIndex = c(1, 2), withIndex = c(1, 2))

## ----echo = FALSE-------------------------------------------------------------
knitr::include_graphics("imgs/Links_01.png")

## ----link_sample_data2--------------------------------------------------------
lmse <- linkSampleData(lmse, with = "experimentFiles.annotations",
                        sampleIndex = c(1, 2), withIndex = c(1, 1))

## ----echo = FALSE-------------------------------------------------------------
knitr::include_graphics("imgs/Links_02.png")

## ----link_sample_data3--------------------------------------------------------
sampleData(lmse)$raw_file <- normalizePath(fls)
lmse <- linkSampleData(
    lmse, with = "sampleData.raw_file = spectra.dataOrigin")

## ----show_link----------------------------------------------------------------
sampleData(lmse)$raw_file
spectra(lmse)$dataOrigin |>
                head()

## ----echo = FALSE-------------------------------------------------------------
knitr::include_graphics("imgs/Links_03.png")

## ----show_exp2----------------------------------------------------------------
lmse

## -----------------------------------------------------------------------------
#' Show the sample assignment for the first few spectra
spectraSampleIndex(lmse) |>
    head()

## ----add_se, message = FALSE--------------------------------------------------
library(SummarizedExperiment)
sd <- DataFrame(sample = c("QC2", "QC1", "QC3"), idx = c(3, 1, 5))
se <- SummarizedExperiment(colData = sd, assay = cbind(1:10, 11:20, 21:30))

qdata(lmse) <- se

## ----link_sample_data4--------------------------------------------------------
sampleData(lmse)$sample_id
qdata(lmse)$sample

lmse <- linkSampleData(lmse, with = "sampleData.sample_id = qdata.sample")
lmse

## ----subset_exp2--------------------------------------------------------------
b <- lmse[2]
b

## ----extract_exp2-------------------------------------------------------------
assay(qdata(b))

## ----add_metadata-------------------------------------------------------------
metadata(lmse)$other <- data.frame(
                  sample_name = c("study_1", "POOL", "study_2"),
                  index = 1:3)
b <- lmse[2]
metadata(b)

## ----link_sample_data5--------------------------------------------------------
lmse <- linkSampleData(lmse, with = "metadata.other",
                      sampleIndex = 1:2, withIndex = c(2, 2))
b <- lmse[2]
metadata(b)

## ----show_subset_exp2---------------------------------------------------------
lmse <- lmse[c(2, 1)]
sampleData(lmse)

## ----show_expfls2_msml--------------------------------------------------------
experimentFiles(lmse)$mzML_file

## ----show_explfs2_annot-------------------------------------------------------
experimentFiles(lmse)$annotations

## -----------------------------------------------------------------------------
#' Filter the Spectra using the `filterRt` function providing also the
#' parameters for this function.
res <- filterSpectra(lmse, filterRt, rt = c(200, 210))
res

## -----------------------------------------------------------------------------
#' Extract spectra of the second sample after filtering
spectra(res[2L])

## -----------------------------------------------------------------------------
fls <- c(system.file("microtofq", "MM14.mzML", package = "msdata"),
         system.file("microtofq", "MM8.mzML", package = "msdata"))

## -----------------------------------------------------------------------------
library(MsBackendSql)
library(RSQLite)

#' Create the SQLite database where to store the data. For our
#' example we create the database in a temporary file.
sql_file <- tempfile()
con <- dbConnect(SQLite(), dbname = sql_file)

#' Write the MS data to the.
createMsBackendSqlDatabase(dbcon = con, fls)

## -----------------------------------------------------------------------------
#' Load the database as a Spectra object
sps <- Spectra(sql_file, source = MsBackendOfflineSql(), drv = SQLite())
sps

## -----------------------------------------------------------------------------
#' Define sample annotations. Ideally all experiment-relavant information
#' should be specified.
sdata <- data.frame(file_name = basename(fls),
                    sample_name = c("MM14", "MM8"),
                    sample_group = c("ctrl", "ctrl"))

#' To simplify subsequent linking between samples and data files we
#' define a new spectra variable with the file names of the raw data files.
sps$file_name <- basename(dataOrigin(sps))

#' Create the MsExperiment for that data
mse <- MsExperiment(sampleData = sdata, spectra = sps)

## -----------------------------------------------------------------------------
#' Establish the mapping between spectra and samples
mse <- linkSampleData(mse, with = "sampleData.file_name = spectra.file_name")
mse

## -----------------------------------------------------------------------------
#' Write sample data (and mapping between samples and spectra) to the
#' database
dbWriteSampleData(mse)

## -----------------------------------------------------------------------------
#' Create a Spectra object for the MS data of that database
sps <- Spectra(sql_file, source = MsBackendOfflineSql(), drv = SQLite())

## -----------------------------------------------------------------------------
#' Create the MsExperiment reading MS data and sample data from
#' the database
mse <- MsExperiment(spectra = sps)
mse

## -----------------------------------------------------------------------------
#' Create an MsExperiment with data from two (raw) data files
#' and associated sample annotations.
mse <- readMsExperiment(spectraFiles = fls, sampleData = sdata)
mse

## -----------------------------------------------------------------------------
#' Show the Spectra from the experiment
spectra(mse)

## -----------------------------------------------------------------------------
#' Define the SQLite database file
sql_file2 <- tempfile()

#' Change the backend of the Spectra data
spectra(mse) <- setBackend(spectra(mse), MsBackendOfflineSql(),
                           dbname = sql_file2, drv = SQLite())

spectra(mse)

## -----------------------------------------------------------------------------
#' Store also sample data to the database
dbWriteSampleData(mse)

## -----------------------------------------------------------------------------
#' Connect to the database
con <- dbConnect(SQLite(), dbname = sql_file2)

#' List the available database tables
dbListTables(con)

## -----------------------------------------------------------------------------
#' Get the content of the sample_data table
dbGetQuery(con, "select * from sample_data")

#' Close the connection to the database
dbDisconnect(con)

## ----si-----------------------------------------------------------------------
sessionInfo()

