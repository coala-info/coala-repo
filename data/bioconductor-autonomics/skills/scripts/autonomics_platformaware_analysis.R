# Code example from 'autonomics_platformaware_analysis' vignette. See references/ for full tutorial.

## ----echo=FALSE, message=FALSE, include=TRUE----------------------------------
knitr::opts_chunk$set(
  echo = TRUE, collapse = TRUE, cache = TRUE, fig.show = 'hold')
#str(knitr::opts_chunk$get())

## ----fig.width=7, fig.height=10, out.width='60%', fig.align='center'----------
require(autonomics, quietly = TRUE)
file <- system.file('extdata/billing19.rnacounts.txt', package = 'autonomics')
object <-  read_rnaseq_counts(file = file, fit = 'limma', plot = TRUE, label = 'gene')

## ----results = 'hide', eval = FALSE-------------------------------------------
# # not run to avoid issues with R CMD CHECK
# if (requireNamespace('Rsubread')){
#   object <- read_rnaseq_bams(
#                 dir    = download_data('billing16.bam.zip'),
#                 paired = TRUE,
#                 genome = 'hg38',
#                 pca    = TRUE,
#                 fit   = 'limma',
#                 plot   = TRUE)
# }

## -----------------------------------------------------------------------------
  file <- system.file('extdata/billing19.rnacounts.txt', package = 'autonomics')
# log2counts
  object <- read_rnaseq_counts(file, 
       cpm = FALSE, voom = FALSE, fit = 'limma', verbose = FALSE, plot = FALSE)
  colSums(summarize_fit(fdt(object), 'limma')[-1, c(3,4)])
# log2cpm
  object <- read_rnaseq_counts(file,
       cpm = TRUE,  voom = FALSE, fit = 'limma', verbose = FALSE, plot = FALSE)
  colSums(summarize_fit(fdt(object), 'limma')[-1, c(3,4)])
# log2cpm + voom
  object <- read_rnaseq_counts(file,  # log2 cpm + voom
       cpm = TRUE,  voom = TRUE,  fit = 'limma', verbose = FALSE, plot = FALSE)
  colSums(summarize_fit(fdt(object), 'limma')[-1, c(3,4)])

## ----fig.width=7, fig.height=10, out.width='60%', fig.align='center'----------
file <- system.file('extdata/fukuda20.proteingroups.txt', package = 'autonomics')
object <- read_maxquant_proteingroups(file = file, plot = TRUE)

## ----fig.width=7, fig.height=10, out.width='60%', fig.align='center'----------
file <- system.file('extdata/billing19.proteingroups.txt', package = 'autonomics')
subgroups <- c('E00_STD', 'E01_STD', 'E02_STD', 'E05_STD', 'E15_STD', 'E30_STD', 'M00_STD')
object <- read_maxquant_proteingroups(file = file, subgroups = subgroups, plot = TRUE)

## ----fig.width=7, fig.height=10, out.width='60%', fig.align='center'----------
fosfile <- system.file('extdata/billing19.phosphosites.txt',  package = 'autonomics')
profile <- system.file('extdata/billing19.proteingroups.txt', package = 'autonomics')
subgroups <- c('E00_STD', 'E01_STD', 'E02_STD', 'E05_STD', 'E15_STD', 'E30_STD', 'M00_STD')
object <- read_maxquant_phosphosites(fosfile = fosfile, profile = profile, subgroups = subgroups, plot = TRUE)

## ----fig.width=7, fig.height=10, out.width='60%', fig.align='center'----------
file <- system.file('extdata/atkin.metabolon.xlsx', package = 'autonomics')
object <- read_metabolon(file,  block = 'Subject', plot = TRUE)

## ----fig.width=7, fig.height=10, out.width='60%', fig.align='center'----------
file <- system.file('extdata/atkin.somascan.adat', package = 'autonomics')
object <- read_somascan(file, block = 'Subject', plot = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

