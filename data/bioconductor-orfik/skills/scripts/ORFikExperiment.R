# Code example from 'ORFikExperiment' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
library(ORFik)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
# 1. Pick directory (normally a folder with your aligned bam files)
NGS.dir <- system.file("extdata/Homo_sapiens_sample", "", package = "ORFik")
# 2. .gff/.gtf location
txdb <- system.file("extdata/references/homo_sapiens", "Homo_sapiens_dummy.gtf.db", package = "ORFik")
# 3. fasta genome location
fasta <- system.file("extdata/references/homo_sapiens", "Homo_sapiens_dummy.fasta", package = "ORFik")
# 4. Pick an experiment name
exper.name <- "ORFik_example_human"


list.files(NGS.dir)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
# This experiment is intentionally malformed, so we first make only a template:
template <- create.experiment(dir = NGS.dir,  # directory of the NGS files for the experiment
                              exper.name,     # Experiment name
                              txdb = txdb,    # gtf / gff / gff.db annotation
                              fa = fasta,     # Fasta genome
                              organism = "Homo sapiens", # Scientific naming
                              saveDir = NULL, # Create template instead of ready experiment
                              )
# The experiment contains 3 main parts:
# 1. Annotation, organism, general info:
data.frame(template)[1:3, ]
# 2. NGS data set-up info:
data.frame(template)[4:8, 1:5]
# 3. NGS File paths:
data.frame(template)[4:8, 6]

## ----eval = TRUE, echo = TRUE-------------------------------------------------
template$X5[5:6] <- "heart_valve" # <- fix non unique row (tissue fraction is heart valve)

df <- read.experiment(template)# read experiment from template

## ----eval = FALSE, echo = TRUE------------------------------------------------
# save.experiment(df, file = "path/to/save/experiment.csv")

## ----eval = FALSE, echo = TRUE------------------------------------------------
# ORFik.template.experiment()

## ----eval = TRUE, echo = TRUE-------------------------------------------------
df

## ----eval = TRUE, echo = TRUE-------------------------------------------------
filepath(df, type = "default")

## ----eval = TRUE, echo = TRUE-------------------------------------------------
filepath(df[df$libtype == "RFP", ], type = "pshifted")[2] # RFP = Ribo-seq, Default location for pshifted reads

## ----eval = TRUE, echo = TRUE-------------------------------------------------
envExp(df) #This will be the environment

## ----eval = TRUE, echo = TRUE-------------------------------------------------
bamVarName(df) #This will be the names:

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
outputLibs(df) # With default output.mode = "envir".

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
# remove.experiments(df)

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
outputLibs(df, output.mode = "envirlist")[1:2] # Save NGS to envir, then return as list

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
# Check envir, if it exist, list them and return, if not, only return list
outputLibs(df, output.mode = "list")[1:2]

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# files <- filepath(df, type = "default")
# CAGE_loaded_manually <- fimport(files[1])

## ----eval = TRUE, echo = TRUE-------------------------------------------------
df@expInVarName <- TRUE
bamVarName(df) #This will be the names:

## ----eval = TRUE, echo = TRUE-------------------------------------------------
df@expInVarName <- FALSE
remove.experiments(df)
outputLibs(df) 

## ----eval = TRUE, echo = TRUE, warning = FALSE--------------------------------
txdb <- loadTxdb(df) # transcript annotation

## ----eval = TRUE, echo = TRUE-------------------------------------------------
txNames <- filterTranscripts(txdb, minFiveUTR = 30, minCDS = 30, minThreeUTR = 30)
loadRegions(txdb, parts = c("leaders", "cds", "trailers"), names.keep = txNames)

## ----eval = TRUE, echo = TRUE, warning=FALSE----------------------------------
transcriptWindow(leaders, cds, trailers, df[9,], BPPARAM = BiocParallel::SerialParam())

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# shiftFootprintsByExperiment(df[df$libtype == "RFP",])

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# df.baz <- read.experiment("zf_bazzini14_RFP") # <- this exp. does not exist for you
# shiftPlots(df.baz, title = "Ribo-seq, zebrafish, Bazzini et al. 2014", type = "heatmap")

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# shifts_load(df)

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# filepath(df[df$libtype == "RFP",], type = "pshifted")

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# outputLibs(df[df$libtype == "RFP",], type = "pshifted")

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# convertLibs(df, type = "ofst") # Collapsed

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# QCreport(df)

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# countTable(df, region = "cds", type = "fpkm")

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# countTable(df, region = "mrna", type = "deseq")

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# QCstats(df)

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# QCfolder(df)

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# shiftFootprintsByExperiment(df)

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# RiboQC.plot(df)

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
#   BiocParallel::register(BiocParallel::SerialParam(), default = TRUE)

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# library(BiocParallel) # For parallel computation
# outputLibs(df, type = "pshifted") # Output all libraries, fastest way
# libs <- bamVarName(df) # <- here are names of the libs that were outputed
# cds <- loadRegion(df, "cds")
# # parallel loop
# bplapply(libs, FUN = function(lib, cds) {
#     return(entropy(cds, get(lib)))
# }, cds = cds)
# 

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
#  # Output all libraries, fastest way
# cds <- loadRegion(df, "cds")
# # parallel loop
# bplapply(outputLibs(df, type = "pshifted", output.mode = "list"),
#          FUN = function(lib, cds) {
#     return(entropy(cds, lib))
# }, cds = cds)
# 

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# files <- filepath(df, type = "pshifted")
# cds <- loadRegion(df, "cds")
# # parallel loop
# res <- bplapply(files, FUN = function(file, cds) {
#     return(entropy(cds, fimport(file)))
# }, cds = cds)
# 

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# files <- filepath(df, type = "pshifted")
# cds <- loadRegion(df, "cds")
# # Single thread loop
# lapply(files, FUN = function(file, cds) {
#     return(entropy(cds, fimport(file)))
# }, cds = cds)
# 

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# library(data.table)
# 
# outputLibs(df, type = "pshifted")
# libs <- bamVarName(df) # <- here are names of the libs that were outputed
# cds <- loadRegion(df, "cds")
# # parallel loop
# res <- bplapply(libs, FUN = function(lib, cds) {
#         return(entropy(cds, get(lib)))
#     }, cds = cds)
# 
# res.by.columns <- copy(res) # data.table copies default by reference
# # Add some names and convert
# names(res.by.columns) <- libs
# data.table::setDT(res.by.columns) # Will give 1 column per library
# res.by.columns # Now by columns

## ----eval = FALSE, echo = TRUE, warning=FALSE---------------------------------
# res.by.rows <- copy(res)
# # Add some names and convert
# names(res.by.rows) <- libs
# res.by.rows <- rbindlist(res.by.rows) # Will bind rows per library
# res.by.columns # now melted row-wise

