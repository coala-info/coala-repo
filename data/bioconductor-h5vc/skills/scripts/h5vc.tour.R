# Code example from 'h5vc.tour' vignette. See references/ for full tutorial.

## ----install_h5vcData, eval=FALSE---------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("h5vcData")

## ----loadPackages-------------------------------------------------------------
suppressPackageStartupMessages(library(h5vc))
suppressPackageStartupMessages(library(rhdf5))

tallyFile <- system.file( "extdata", "example.tally.hfs5", package = "h5vcData" )

## ----listTallyFile------------------------------------------------------------
h5ls(tallyFile)

## ----getSampleData------------------------------------------------------------
sampleData <- getSampleData( tallyFile, "/ExampleStudy/16" )
sampleData

## ----setSampleData------------------------------------------------------------
sampleData$ClinicalVariable <- rnorm(nrow(sampleData))
setSampleData( tallyFile, "/ExampleStudy/16", sampleData )
sampleData

## ----h5readBlockExample-------------------------------------------------------
data <- h5readBlock(
  filename = tallyFile,
  group = "/ExampleStudy/16",
  names = c( "Coverages", "Counts" ),
  range = c(29000000,29001000)
  )
str(data)

## ----h5dapplyGRanges----------------------------------------------------------
suppressPackageStartupMessages(require(GenomicRanges))
data <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy",
  names = c( "Coverages" ),
  dims = c(3),
  range = GRanges("16", ranges = IRanges(start = seq(29e6, 30e6, 5e6), width = 1000))
  )
str(data)

## ----h5dapplyExample----------------------------------------------------------
#rangeA <- GRanges("16", ranges = IRanges(start = seq(29e6, 29.5e6, 1e5), width = 1000))
#rangeB <- GRanges("22", ranges = IRanges(start = seq(39e6, 39.5e6, 1e5), width = 1000))
range <- GRanges(
  rep(c("16", "22"), each = 6),
  ranges = IRanges(
    start = c(seq(29e6, 29.5e6, 1e5),seq(39e6, 39.5e6, 1e5)),
    width = 1000
  ))
coverages <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy",
  names = c( "Coverages" ),
  dims = c(3),
  range = range,
  FUN = binnedCoverage,
  sampledata = sampleData
  )
#options(scipen=10)
coverages <- do.call( rbind, lapply( coverages, function(x) do.call(rbind, x) ))
#rownames(coverages) <- NULL #remove block-ids used as row-names
coverages

## ----callVariantsExample------------------------------------------------------
variants <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy/16",
  names = c( "Coverages", "Counts", "Deletions", "Reference" ),
  range = c(29950000,30000000),
  blocksize = 10000,
  FUN = callVariantsPaired,
  sampledata = sampleData,
  cl = vcConfParams(returnDataPoints = TRUE)
  )
variants <- do.call( rbind, variants )
variants$AF <- (variants$caseCountFwd + variants$caseCountRev) / (variants$caseCoverageFwd + variants$caseCoverageRev)
variants <- variants[variants$AF > 0.2,]
rownames(variants) <- NULL # remove rownames to save some space on output :D
variants

## ----mismatchPlotExample, fig.width=10.5, fig.height=8.5, dpi=300, out.width="750px", fig.retina=1----
windowsize <- 35
position <- variants$Start[2]
data <- h5readBlock(
    filename = tallyFile,
    group = paste( "/ExampleStudy", variants$Chrom[2], sep="/" ),
    names = c("Coverages","Counts","Deletions", "Reference"),
    range = c( position - windowsize, position + windowsize)
  )
patient <- sampleData$Patient[sampleData$Sample == variants$Sample[2]]
samples <- sampleData$Sample[sampleData$Patient == patient]
p <- mismatchPlot(
  data = data,
  sampledata = sampleData,
  samples = samples,
  windowsize = windowsize,
  position = position
  )
print(p)

## ----mismatchPlotExamplesTheming, fig.width=10.5, fig.height=8.5, dpi=300, out.width="750px", fig.show='asis'----
print(p + theme(strip.text.y = element_text(family="serif", size=16, angle=0)))

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(require(IRanges))
suppressPackageStartupMessages(require(biomaRt))
mart <- useDataset(dataset = "hsapiens_gene_ensembl", mart = useMart("ENSEMBL_MART_ENSEMBL"))
exons <- getBM(attributes = c("ensembl_exon_id", "exon_chrom_start", "exon_chrom_end"), filters = c("chromosome_name"), values = c("16"), mart)
exons <- subset(exons, exon_chrom_start > 29e6 & exon_chrom_end < 30e6)
ranges <- IRanges(start = exons$exon_chrom_start, end = exons$exon_chrom_end)
coverages <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy/16",
  names = c( "Coverages" ),
  dims = c(3),
  range = ranges,
  FUN = binnedCoverage,
  sampledata = sampleData
  )
options(scipen=10)
coverages <- do.call( rbind, coverages )
rownames(coverages) <- NULL #remove block-ids used as row-names
coverages$ExonID <- exons$ensembl_exon_id
head(coverages)

## ----mismatchPlotRangesExample, fig.width=10.5, fig.height=8.5, dpi=300, out.width="750px", fig.retina=1----
windowsize <- 35
position <- variants$Start[2]
data <- h5dapply(
    filename = tallyFile,
    group = paste( "/ExampleStudy", variants$Chrom[2], sep="/" ),
    names = c("Coverages","Counts","Deletions", "Reference"),
    range = flank( IRanges(start = c(position - 10, position, position + 10), width = 1), width = 15, both = TRUE )
  )
p <- mismatchPlot(
  data = data,
  sampledata = sampleData,
  samples <- c("PT5ControlDNA", "PT5PrimaryDNA", "PT5RelapseDNA", "PT8ControlDNA", "PT8EarlyStageDNA", "PT8PrimaryDNA")
  )
print(p)

## ----loadFiles, eval = .Platform$OS.type == "unix", results="hide"------------
suppressPackageStartupMessages(library("h5vc"))
suppressPackageStartupMessages(library("rhdf5"))
files <- list.files( system.file("extdata", package = "h5vcData"), "Pt.*bam$" )
files
bamFiles <- file.path( system.file("extdata", package = "h5vcData"), files)

## ----chromDim, eval = (.Platform$OS.type == "unix")---------------------------
suppressPackageStartupMessages(library("Rsamtools"))
chromdim <- sapply( scanBamHeader(bamFiles), function(x) x$targets )
colnames(chromdim) <- files
head(chromdim)

## ----hdf5SetUp, eval = .Platform$OS.type == "unix"----------------------------
chrom <- "2"
chromlength <- chromdim[chrom,1]
study <- "/DNMT3A"
tallyFile <- file.path( tempdir(), "DNMT3A.tally.hfs5" )
if( file.exists(tallyFile) ){
  file.remove(tallyFile)
}
if( prepareTallyFile( tallyFile, study, chrom, chromlength, nsamples = length(files) ) ){
  h5ls(tallyFile)
}else{
  message( paste( "Preparation of:", tallyFile, "failed" ) )
}

## ----sampleDataSetUp, eval = .Platform$OS.type == "unix"----------------------
sampleData <- data.frame(
  File = files,
  Type = "Control",
  stringsAsFactors = FALSE
  )
sampleData$Sample <- gsub(x = sampleData$File, pattern = ".bam", replacement = "")
sampleData$Patient <- substr(sampleData$Sample, start = 1, 4)
sampleData$Column <- seq_along(files)
sampleData$Type[grep(pattern = "Cancer", x = sampleData$Sample)] <- "Case"
group <- paste( study, chrom, sep = "/" )
setSampleData( tallyFile, group, sampleData )
getSampleData( tallyFile, group )

## ----tallyingTheBamFiles, eval = .Platform$OS.type == "unix"------------------
suppressPackageStartupMessages(require(BSgenome.Hsapiens.NCBI.GRCh38))
suppressPackageStartupMessages(require(GenomicRanges))
dnmt3a <- read.table(system.file("extdata", "dnmt3a.txt", package = "h5vcData"), header=TRUE, stringsAsFactors = FALSE)
dnmt3a <- with( dnmt3a, GRanges(seqname, ranges = IRanges(start = start, end = end)))
dnmt3a <- reduce(dnmt3a)
require(BiocParallel)
register(MulticoreParam())
theData <- tallyRanges( bamFiles, ranges = dnmt3a, reference = Hsapiens )
str(theData[[1]])

## ----writingToTallyFile, eval = .Platform$OS.type == "unix"-------------------
writeToTallyFile(theData, tallyFile, study = "/DNMT3A", ranges = dnmt3a)

## ----extractingData, eval = .Platform$OS.type == "unix"-----------------------
data <- h5dapply(
    filename = tallyFile,
    group = "/DNMT3A",
    range = dnmt3a
  )
str(data[["2"]][[1]])

## ----callingVariants, eval = .Platform$OS.type == "unix"----------------------
vars <- h5dapply(
    filename = tallyFile,
    group = "/DNMT3A",
    FUN = callVariantsPaired,
    sampledata = getSampleData(tallyFile,group),
    cl = vcConfParams(),
    range = dnmt3a
  )
vars <- do.call(rbind, vars[["2"]])
vars

## ----plottingVariant, eval = .Platform$OS.type == "unix"----------------------
position <- vars$End[1]
windowsize <- 30
data <- h5readBlock(
    filename = tallyFile,
    group = group,
    range = c(position - windowsize, position + windowsize)
  )
sampleData <- getSampleData(tallyFile,group)
p <- mismatchPlot( data, sampleData, samples = c("Pt17Control", "Pt17Cancer"), windowsize=windowsize, position=position )
print(p)

## -----------------------------------------------------------------------------
tallyFileMS <- system.file( "extdata", "example.tally.hfs5", package = "h5vcData" )
data( "example.variants", package = "h5vcData" ) #example variant calls
head(variantCalls)
ms = mutationSpectrum( variantCalls, tallyFileMS, "/ExampleStudy" )
head(ms)

## ----plottingMS, fig.width=10.5, fig.height=7, dpi=300, out.width="750px"-----
plotMutationSpectrum(ms) + theme(
  strip.text.y = element_text(angle=0, size=10),
  axis.text.x = element_text(size = 7),
  axis.text.y = element_text(size = 10)) + scale_y_continuous(breaks = c(0,5,10,15))

## ----parallelTally, eval = .Platform$OS.type == "unix"------------------------
register(MulticoreParam())
multicore.time <- system.time(theData <- tallyRanges( bamFiles, ranges = dnmt3a, reference = Hsapiens ))
register(SerialParam())
serial.time <- system.time(theData <- tallyRanges( bamFiles, ranges = dnmt3a, reference = Hsapiens ))
serial.time["elapsed"]
multicore.time["elapsed"]

## ----parallelTallyToFile, eval = .Platform$OS.type == "unix"------------------
register(MulticoreParam())
multicore.time <- system.time(tallyRangesToFile( tallyFile, study, bamFiles, ranges = dnmt3a, reference = Hsapiens ))
register(SerialParam())
serial.time <- system.time(tallyRangesToFile( tallyFile, study, bamFiles, ranges = dnmt3a, reference = Hsapiens ))
serial.time["elapsed"]
multicore.time["elapsed"]

## ----eval = .Platform$OS.type == "unix"---------------------------------------
tallyFile <- system.file( "extdata", "example.tally.hfs5", package = "h5vcData" )
sampleData <- getSampleData(tallyFile, "/ExampleStudy/16")
theRanges <- GRanges("16", ranges = IRanges(start = seq(29e6,29.2e6,1000), width = 1000))
register(SerialParam())
system.time(
  coverages_serial <- h5dapply(
    filename = tallyFile,
    group = "/ExampleStudy",
    names = c( "Coverages" ),
    dims = c(3),
    range = theRanges,
    FUN = binnedCoverage,
    sampledata = sampleData
  )
)
register(MulticoreParam())
system.time(
  coverages_parallel <- h5dapply(
    filename = tallyFile,
    group = "/ExampleStudy",
    names = c( "Coverages" ),
    dims = c(3),
    range = theRanges,
    FUN = binnedCoverage,
    sampledata = sampleData
  )
)

## ----eval = FALSE-------------------------------------------------------------
# tallyRangesBatch( tallyFile, study = "/DNMT3A", bamfiles = bamFiles, ranges = dnmt3a, reference = Hsapiens )

## ----batchjobsconf, eval=FALSE------------------------------------------------
# cluster.functions <- makeClusterFunctionsLSF("/home/pyl/batchjobs/lsf.tmpl")
# mail.start <- "first"
# mail.done <- "last"
# mail.error <- "all"
# mail.from <- "<paul.theodor.pyl@embl.de>"
# mail.to <- "<pyl@embl.de>"
# mail.control <- list(smtpServer="smtp.embl.de")

## ----eval=FALSE---------------------------------------------------------------
# ## Default resources can be set in your .BatchJobs.R by defining the variable
# ## 'default.resources' as a named list.
# 
# ## remove everthing in [] if your cluster does not support arrayjobs
# #BSUB-J <%= job.name %>[1-<%= arrayjobs %>]         # name of the job / array jobs
# #BSUB-o <%= log.file %>                             # output is sent to logfile, stdout + stderr by default
# #BSUB-n <%= resources$ncpus %>                      # Number of CPUs on the node
# #BSUB-q <%= resources$queue %>                      # Job queue
# #BSUB-W <%= resources$walltime %>                   # Walltime in minutes
# #BSUB-M <%= resources$memory %>                     # Memory requirements in Kbytes
# 
# # we merge R output with stdout from LSF, which gets then logged via -o option
# R CMD BATCH --no-save --no-restore "<%= rscript %>" /dev/stdout

## ----eval=FALSE---------------------------------------------------------------
# library("BiocParallel")
# library("BatchJobs")
# cf <- makeClusterFunctionsLSF("/home/pyl/batchjobs/lsf.tmpl")
# bjp <- BatchJobsParam( cluster.functions=cf, resources = list("queue" = "medium_priority", "memory"="4000", "ncpus"="4", walltime="00:30") )
# bplapply(1:10, sqrt)
# bplapply(1:10, sqrt, BPPARAM=bjp)

