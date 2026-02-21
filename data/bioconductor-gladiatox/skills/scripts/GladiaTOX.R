# Code example from 'GladiaTOX' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("GladiaTOX")

## ----eval=TRUE, echo=TRUE, include=FALSE--------------------------------------
# Load GladiaTOX package and setup an output directory
# Change outdir accordingly to the folder path you want the reports to be saved
library(GladiaTOX)
outdir <- getwd()

## ----logo, echo=FALSE, out.width='60%'----------------------------------------
glPlotPieLogo()

## ----eval=TRUE, echo=TRUE, include=TRUE---------------------------------------
sqlite_src <- file.path(system.file(package="GladiaTOX"), "sql",
                        "gladiatoxdb.sqlite")

## ----eval=TRUE, echo=TRUE, include=TRUE---------------------------------------
# sqlite database location
gtoxConf(   drvr = "SQLite",
            host = NA,
            user = NA,
            pass = NULL,
            db = sqlite_src)

## ----eval=FALSE, echo=TRUE, include=TRUE--------------------------------------
# gtoxConf(   drvr = "MariaDB",
#             host = "local.host",
#             user = "username",
#             pass = "********",
#             db = "my_gl_database")

## ----eval=TRUE, echo=TRUE, include=TRUE---------------------------------------
# List available studies
gtoxLoadAsid()

## ----eval=TRUE, include=TRUE, echo=TRUE---------------------------------------
load(system.file("extdata", "data_for_vignette.rda", package="GladiaTOX"))

## ----eval=TRUE, echo=TRUE, include=TRUE---------------------------------------
print(head(plate), row.names = FALSE)

## ----eval=TRUE, echo=TRUE, include=TRUE---------------------------------------
print(head(chnmap, 7), row.names = FALSE)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
assay <- buildAssayTab(plate, chnmap)
print(head(assay, 4), row.names = FALSE)

## ----eval=TRUE, echo=TRUE, include=TRUE---------------------------------------
print(head(dat), row.names = FALSE)

## ----eval=TRUE----------------------------------------------------------------
## Set study parameters
std.nm <- "SampleStudy" # study name
phs.nm <- "PhaseII" # study phase

## ----echo=TRUE, eval=TRUE, message=FALSE, warning=TRUE------------------------
## List of studies before loading
gtoxLoadAsid()

## Load annotation in gtoxDB
loadAnnot(plate, assay, NULL)

## List of studies after loading
gtoxLoadAsid()

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
# Get assay source ID
asid = gtoxLoadAsid(fld = c("asnm", "asph"), val = list(std.nm, phs.nm))$asid
asid

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
# Prepare and load data
dat <- prepareDatForDB(asid, dat)
gtoxWriteData(dat[ , list(acid, waid, wllq, rval)], lvl = 0, type = "mc")

## ----echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE-----------------------
assignDefaultMthds(asid = asid)

## ----include=TRUE, results='hide', message=FALSE, warning=FALSE---------------
# Run level 1 to level 3 functions
res <- gtoxRun(asid = asid, slvl = 1, elvl = 3, mc.cores = 2)

## ----include=TRUE, results='hide', message=FALSE, warning=FALSE---------------
# Extract assay endpoints ids of the study
aeids <- gtoxLoadAeid(fld = "asid", val = asid)$aeid
# Compute Vehicle Median Absolute deviation
tmp <- mapply(function(xx){
    tryCatch(gtoxCalcVmad(inputs = xx, aeid = xx, 
    notes = "computed within study"), 
    error = function(e) NULL)},
    as.integer(aeids))

## ----include=TRUE, results='hide', message=FALSE, warning=FALSE---------------
# Apply all functions from level 1 to level 6
res <- gtoxRun(asid = asid, slvl = 1, elvl = 6, mc.cores = 2)

## ----eval=TRUE, include=TRUE, message=FALSE, warning=FALSE, results='hide'----
## QC report
gtoxReport(type = "qc", asid = asid, report_author = "report author",
report_title = "Vignette QC report", odir = outdir)

## ----eval=TRUE----------------------------------------------------------------
# Define assay component and extract assay component ID
acnm <- "DNA damage (pH2AX)_DNA damage (pH2AX)_4h"
acid <- gtoxLoadAcid(fld=c("asid", "acnm"), val=list(asid,acnm))[, acid]
# Extract assay plate ID corresponding to plate name S-000031351
apid <- gtoxLoadApid()[u_boxtrack == "S-000031351", apid]
# Load level 2 data (Raw data before normalization)
l2 <- gtoxLoadData(lvl = 2L, fld = "acid", val = acid)

## ----fig=TRUE, fig.width=12, fig.height=8, fig.cap='Example of heatmap of a plate raw values. Letters in well indicate the well type.'----
gtoxPlotPlate(dat = l2, apid = apid, id = acid)

## ----eval=TRUE----------------------------------------------------------------
# Extract assay endpoint ID
aeid <- gtoxLoadAeid(fld = c("acid", "analysis_direction"), 
                        val = list(acid, "up"))[, aeid]
# Extract sample ID
spid <- gtoxLoadWaid(fld = c("apid", "wllt"), 
                        val = list(apid, "c"))[,unique(spid)]
# Collect level 4 data (normalized data)
m4id <- gtoxLoadData(lvl = 4L, fld = c("spid", "aeid"), 
                        val = list(spid, aeid))[, m4id]

## ----eval=TRUE, fig.width=14, fig.height=8, fig.cap='Example of Positive control (chlorambucil chemical) plot with three concentrations, and three technical replicates per concentration.'----
gtoxPlotM4ID(m4id = m4id, lvl = 6, bline = "coff")

## ----eval=TRUE, echo=TRUE, include=TRUE---------------------------------------
apid <- gtoxLoadApid()[u_boxtrack%in%"S-000030318", apid] # plate id
waids <- gtoxLoadWaid(fld="apid", val=apid)$waid #well ids
m0ids <- gtoxLoadData(lvl = 0, fld = "waid", val = waids)$m0id # raw data ids
gtoxSetWllq(ids = m0ids, wllq = 0, type = "mc") # set well quality to zero

## ----echo=TRUE, eval=TRUE, results='hide', message=FALSE, warning=FALSE-------
res <- gtoxRun(asid = asid, slvl = 1, elvl = 6, mc.cores = 2)

## ----eval=TRUE, message=FALSE, warning=FALSE, results='hide'------------------
## Processing report
gtoxReport(type = "all", asid = asid, report_author = "report author",
report_title = "Vignette Processing report", odir = outdir)

## ----eval=TRUE, fig.width=7---------------------------------------------------
## Endpoint to plot
aeids <- gtoxLoadAeid(fld=c("asid", "aenm"),
val=list(asid, "DNA damage (pH2AX)_DNA damage (pH2AX)_24h_up"),
add.fld="asid")$aeid
## level 4 id to plot
m4id <- gtoxLoadData(lvl=4L)[(aeid==aeids & grepl("chromium", spid))]$m4id[1]

## ----eval=TRUE, fig.width=14, fig.height=8, fig.cap='Best fit selection.'-----
gtoxPlotM4ID(m4id = m4id, lvl = 6, bline = "coff")

## ----fig.width=8, fig.height=5, fig.cap='Example of dose-response curves.'----
## Get chemical id to plot
chid <- gtoxLoadChem(field = "chnm", val = "chromium",
include.spid = FALSE)$chid
## Plot dose-response curves
gtoxPlotWin(chid = chid, aeid = aeids, bline = "bmad", collapse = TRUE)

## ----echo=TRUE, include=TRUE, message=FALSE, warning=FALSE, results='hide'----
fname <- paste0(format(Sys.Date(), format="%y%m%d"), "_ASID", asid,"_MEC.pdf")
fname <- file.path(outdir, fname)
pdf(fname, width = 11, height = 7)
glPlotStat(asid)
dev.off()

## ----echo=FALSE, fig.width=8, fig.height=5, fig.cap='Example of MEC boxplot.'----
knitr::include_graphics('MECfig.png')

## ----eval=TRUE, echo=TRUE, include=TRUE, warning=FALSE, fig.width=10, fig.height=6, fig.cap='Example of pie plots. The figure shows three chemicals and all endpoints.'----
chnms <- c("mercury", "o-cresol", "p-cresol")
glPlotPie(asid, chnms = chnms)

## ----eval=TRUE, echo=TRUE, include=TRUE, warning=FALSE, fig.width=10, fig.height=6, fig.cap='Example of severity score plot.'----
glPlotToxInd(asid)

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

