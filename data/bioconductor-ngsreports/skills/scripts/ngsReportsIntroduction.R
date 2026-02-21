# Code example from 'ngsReportsIntroduction' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(ngsReports)

## -----------------------------------------------------------------------------
fileDir <- system.file("extdata", package = "ngsReports")
files <- list.files(fileDir, pattern = "fastqc.zip$", full.names = TRUE)
fdl <- FastqcDataList(files)

## -----------------------------------------------------------------------------
getModule(fdl[[1]], "Summary")

## ----results='hide'-----------------------------------------------------------
reads <- readTotals(fdl)

## -----------------------------------------------------------------------------
library(dplyr)
library(pander)
reads %>%
    dplyr::filter(grepl("R1", Filename)) %>% 
    pander(
        big.mark = ",",
        caption = "Read totals from R1 libraries", 
        justify = "lr"
    )

## ----plotSummary, fig.cap="Default summary of FastQC flags.", fig.wide = TRUE----
plotSummary(fdl)

## -----------------------------------------------------------------------------
plotReadTotals(fdl)

## -----------------------------------------------------------------------------
plotReadTotals(fdl) +
    theme(
        legend.position = c(1, 1), 
        legend.justification = c(1, 1),
        legend.background = element_rect(colour = "black")
    )

## ----fig.cap = "Example showing the Per_base_sequence_quality plot for a single FastqcData object."----
plotBaseQuals(fdl[[1]])

## ----fig.cap="Example showing the Mean Per Base Squence Qualities for a set of FastQC reports."----
plotBaseQuals(fdl)

## -----------------------------------------------------------------------------
plotBaseQuals(fdl[1:4], plotType = "boxplot")

## ----fig.cap = "Example plot showing Per_sequence_quality_scores for an individual file."----
plotSeqQuals(fdl[[1]])

## ----fig.cap = "Example heatmaps showing Per_sequence_quality_scores for a set of files."----
plotSeqQuals(fdl)

## -----------------------------------------------------------------------------
r2 <- grepl("R2", names(fdl))
plotSeqQuals(fdl[r2], plotType = "line")

## ----fig.cap="Individual Per_base_sequence_content plot"----------------------
plotSeqContent(fdl[[1]])

## ----fig.cap="Combined Per_base_sequence_content plot"------------------------
plotSeqContent(fdl)

## -----------------------------------------------------------------------------
plotSeqContent(fdl[1:2], plotType = "line", nc = 1)

## ----fig.cap = "Adapter Content plot for a single FastQC report"--------------
plotAdapterContent(fdl[[1]]) 

## ----fig.cap = "Heatmap showing Total Adapter Content by position across a set of FastQC reports"----
plotAdapterContent(fdl)

## ----fig.cap = "Example Sequence Duplication Levels plot for an individual file."----
plotDupLevels(fdl[[1]])

## ----fig.cap = "Sequence Duplication Levels for multiple files"---------------
plotDupLevels(fdl)

## -----------------------------------------------------------------------------
gcAvail(gcTheoretical, "Genome")

## ----fig.cap = "Example GC Content plot using the Hsapiens Transcriptome for the theoretical distribution."----
plotGcContent(fdl[[1]], species = "Hsapiens", gcType = "Transcriptome")

## ----fig.cap = "Example GC content showing the difference between observed and theoretical GC content across multiple files."----
plotGcContent(fdl)

## ----fig.cap = "Example GC content plot represented as a line plot instead of a heatmap."----
plotGcContent(fdl, plotType = "line",  gcType = "Transcriptome")

## ----message=FALSE, warning=FALSE, eval=FALSE---------------------------------
# faFile <- system.file(
#     "extdata", "Athaliana.TAIR10.tRNA.fasta",
#     package = "ngsReports")
# plotGcContent(fdl, Fastafile = faFile, n = 1000)

## ----fig.wide = TRUE----------------------------------------------------------
plotOverrep(fdl[[1]])

## -----------------------------------------------------------------------------
plotOverrep(fdl)

## ----eval = FALSE-------------------------------------------------------------
# overRep2Fasta(fdl, n = 10)

## -----------------------------------------------------------------------------
fl <- c("Sample1.trimmomaticPE.txt")
trimmomaticLogs <- system.file("extdata", fl, package = "ngsReports")
df <- importNgsLogs(trimmomaticLogs)

## -----------------------------------------------------------------------------
df %>%
    dplyr::select("Filename", contains("Surviving"), "Dropped") %>%
    pander(
        split.tables = Inf,
        style = "rmarkdown", 
        big.mark = ",",
        caption = "Select columns as an example of output from trimmomatic."
    )

## -----------------------------------------------------------------------------
fls <- c("bowtiePE.txt", "bowtieSE.txt")
bowtieLogs <- system.file("extdata", fls, package = "ngsReports")
df <- importNgsLogs(bowtieLogs, type = "bowtie")

## -----------------------------------------------------------------------------
df %>%
    dplyr::select("Filename", starts_with("Reads")) %>%
    pander(
        split.tables = Inf,
        style = "rmarkdown", 
        big.mark = ",",
        caption = "Select columns as an example of output from bowtie."
    )

## -----------------------------------------------------------------------------
starLog <- system.file("extdata", "log.final.out", package = "ngsReports")
df <- importNgsLogs(starLog, type = "star")

## ----echo=FALSE---------------------------------------------------------------
df %>% 
    dplyr::select("Filename", contains("Unique")) %>%
    pander(
        split.tables = Inf,
        style = "rmarkdown", 
        big.mark = ",",
        caption = "Select columns as output from STAR"
    )

## -----------------------------------------------------------------------------
flagstatLog <- system.file("extdata", "flagstat.txt", package = "ngsReports")
df <- importNgsLogs(flagstatLog, type = "flagstat")

## ----echo=FALSE---------------------------------------------------------------
df %>% 
    pander(
        split.tables = Inf,
        style = "rmarkdown", 
        big.mark = ",",
        caption = "Flagstat output for a single file"
    )

## -----------------------------------------------------------------------------
sysDir <- system.file("extdata", package = "ngsReports")
fl <- list.files(sysDir, "Dedup_metrics.txt", full.names = TRUE)
dupMetrics <- importNgsLogs(fl, type = "duplicationMetrics", which = "metrics")
str(dupMetrics)

## ----fig.cap = "Example Bowtie logs for PE and SE sequencing"-----------------
plotAlignmentSummary(bowtieLogs, type = "bowtie")

## ----fig.cap = "Example STAR aligner logs"------------------------------------
plotAlignmentSummary(starLog, type = "star")

## ----fig.cap = "Example plot after running BUSCO v3 on the Drosophila melanogaster reference genome"----
buscoLog <- system.file("extdata", "short_summary_Dmelanogaster_Busco.txt", package = "ngsReports")
plotAssemblyStats(buscoLog, type = "busco")

## ----fig.cap = "Example plot after running quast on two shortread assemblies"----
fls <- c("quast1.tsv", "quast2.tsv")
quastLog <- system.file("extdata", fls, package = "ngsReports")
plotAssemblyStats(quastLog, type = "quast")

## ----fig.cap = "Example parallel coordinate plot after running quast on two shortread assemblies"----
plotAssemblyStats(quastLog, type = "quast", plotType = "paracoord")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

