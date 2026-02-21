# Code example from 'MsBackendRawFileReader' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(fig.wide = TRUE, fig.retina = 3)

## ----arch, echo=FALSE, out.width="80%", eval=TRUE, fig.cap="Integration of rawDiag and rawrr into the Spectra ecosystem (by courtesy of Johannes Rainer)."----
  knitr::include_graphics("arch.jpg")

## ----require------------------------------------------------------------------
suppressMessages(
  stopifnot(require(Spectra),
            require(MsBackendRawFileReader),
            require(tartare),
            require(BiocParallel))
)

## ----installAssemblies, echo=TRUE---------------------------------------------
if (isFALSE(file.exists(rawrr:::.rawrrAssembly()))){
 rawrr::installRawrrExe()
}

## ----tartareEH4547, warning=FALSE, message=FALSE, eval=TRUE-------------------
# fetch via ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub::ExperimentHub()

## ----tartare------------------------------------------------------------------
query(eh, c('tartare'))

## ----EH3220, message=FALSE, warning=FALSE-------------------------------------
EH3220 <- normalizePath(eh[["EH3220"]])
(rawfileEH3220 <- paste0(EH3220, ".raw"))
if (!file.exists(rawfileEH3220)){
  file.link(EH3220, rawfileEH3220)
}

EH3222 <- normalizePath(eh[["EH3222"]])
(rawfileEH3222 <- paste0(EH3222, ".raw"))
if (!file.exists(rawfileEH3222)){
  file.link(EH3222, rawfileEH3222)
}

EH4547  <- normalizePath(eh[["EH4547"]])
(rawfileEH4547  <- paste0(EH4547 , ".raw"))
if (!file.exists(rawfileEH4547 )){
  file.link(EH4547 , rawfileEH4547 )
}

## ----backendInitializeMsBackendRawFileReader, message=FALSE-------------------
beRaw <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = c(rawfileEH3220, rawfileEH3222, rawfileEH4547))

## ----show---------------------------------------------------------------------
beRaw

## ----spectraVariables---------------------------------------------------------
beRaw |> Spectra::spectraVariables()

## ----rawrrFigure2, fig.cap = "Peptide spectrum match. The vertical grey lines indicate the *in-silico* computed y-ions of the peptide precusor LGGNEQVTR++ as calculated by the [protViz]( https://CRAN.R-project.org/package=protViz) package."----
(S <- (beRaw |>  
   filterScan("FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]") )[437]) |> 
  plotSpectra()

# supposed to be scanIndex 9594
S

# add yIonSeries to the plot
(yIonSeries <- protViz::fragmentIon("LGGNEQVTR")[[1]]$y[1:8])
names(yIonSeries) <- paste0("y", seq(1, length(yIonSeries)))
abline(v = yIonSeries, col='#DDDDDD88', lwd=5)
axis(3, yIonSeries, names(yIonSeries))

## ----defineFilterIon----------------------------------------------------------
setGeneric("filterIons", function(object, ...) standardGeneric("filterIons"))

setMethod("filterIons", "MsBackend",
  function(object, mZ=numeric(), tol=numeric(), ...) {
    
    keep <- lapply(peaksData(object, BPPARAM = bpparam()),
                   FUN=function(x){
       NN <- protViz::findNN(mZ, x[, 1])
       hit <- (error <- mZ - x[NN, 1]) < tol & x[NN, 2] >= quantile(x[, 2], .9)
       if (sum(hit) == length(mZ))
         TRUE
       else
         FALSE
                   })
    object[unlist(keep)]
  })

## ----applyFilterIons----------------------------------------------------------
start_time <- Sys.time()
X <- beRaw |> 
  MsBackendRawFileReader::filterScan("FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]") |>
  filterIons(yIonSeries, tol = 0.005) |> 
  Spectra::Spectra() |>
  Spectra::peaksData() 
end_time <- Sys.time()

## ----runTime------------------------------------------------------------------
end_time - start_time

## ----definePlotLGGNEQVTR------------------------------------------------------
## A helper plot function to visualize a peptide spectrum match for 
## the LGGNEQVTR peptide.
.plot.LGGNEQVTR <- function(x){
  
  yIonSeries <- protViz::fragmentIon("LGGNEQVTR")[[1]]$y[1:8]
  names(yIonSeries) <- paste0("y", seq(1, length(yIonSeries)))
  
  plot(x, type = 'h', xlim = range(yIonSeries))
  abline(v = yIonSeries, col = '#DDDDDD88', lwd=5)
  axis(3, yIonSeries, names(yIonSeries))
  
  # find nearest mZ value
  idx <- protViz::findNN(yIonSeries, x[,1])
  
  data.frame(
    ion = names(yIonSeries),
    mZ.yIon = yIonSeries,
    mZ = x[idx, 1],
    intensity = x[idx, 2]
  )
}

## ----filterIons2, fig.height=8, fig.cap = "Visualizing of the LGGNEQVTR spectrum matches.", echo=FALSE----
op <- par(mfrow=c(4, 1), mar=c(4, 4, 4, 1))
XC <- X |>
  lapply(FUN = .plot.LGGNEQVTR) |>
  Reduce(f = rbind) 

## ----sanityCheck, error=FALSE-------------------------------------------------
stats::aggregate(mZ ~ ion, data = XC, FUN = base::mean)
stats::aggregate(intensity ~ ion, data = XC, FUN = base::max)

## ----combinePeaks, fig.cap = "Combined LGGNEQVTR peptide spectrum match plot.", error = TRUE----
try({
X |>
  Spectra::combinePeaks(ppm=10, intensityFun=base::max) |>
  .plot.LGGNEQVTR()
})

## ----MsBackendMgf-------------------------------------------------------------
if (require(MsBackendMgf)){
    ## Map Spectra variables to Mascot Server compatible vocabulary.
    map <- c(custom = "TITLE",
             msLevel = "CHARGE",
             scanIndex = "SCANS",
             precursorMz = "PEPMASS",
             rtime = "RTINSECONDS")
    
    ## Compose custom TITLE
    beRaw$custom <- paste0("File: ", beRaw$dataOrigin, " ; SpectrumID: ", S$scanIndex)
    
    (mgf <- tempfile(fileext = '.mgf'))
    
    (beRaw |>
            filterScan("FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]") )[437] |>
        Spectra::Spectra() |>
        Spectra::selectSpectraVariables(c("rtime", "precursorMz",
                                          "precursorCharge", "msLevel", "scanIndex", "custom")) |>
        MsBackendMgf::export(backend = MsBackendMgf::MsBackendMgf(),
                             file = mgf, map = map)
    readLines(mgf) |> head(12)
    readLines(mgf) |> tail()
}

## ----allMS2-------------------------------------------------------------------
S <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = c(rawfileEH4547)) |>
  Spectra() 

S

## ----writeMGF, eval=FALSE-----------------------------------------------------
# S |>
#   MsBackendMgf::export(backend = MsBackendMgf::MsBackendMgf(),
#                        file = mgf,
#                        map = map)

## ----defineScanTypePattern----------------------------------------------------
## Define scanType patterns
scanTypePattern <- list(
  EThcD.lowres = "ITMS.+sa Full ms2.+@etd.+@hcd.+",
  ETciD.lowres = "ITMS.+sa Full ms2.+@etd.+@cid.+",
  CID.lowres = "ITMS[^@]+@cid[^@]+$",
  HCD.lowres = "ITMS[^@]+@hcd[^@]+$",
  EThcD.highres = "FTMS.+sa Full ms2.+@etd.+@hcd.+",
  HCD.highres = "FTMS[^@]+@hcd[^@]+$"
)

## ----custom0------------------------------------------------------------------
beRaw <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = c(rawrr::sampleFilePath()))

## ----custom1------------------------------------------------------------------
beRaw <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = rawrr::sampleFilePath())

beRaw$custom <- paste0("File: ", gsub("/srv/www/htdocs/Data2San/", "", beRaw$dataOrigin), " ; SpectrumID: ", beRaw$scanIndex)

## ----generate_mgf-------------------------------------------------------------
.generate_mgf <- function(ext, pattern,  dir=tempdir(), ...){
  mgf <- file.path(dir, paste0(sub("\\.raw", "", unique(basename(beRaw$dataOrigin))),
                               ".", ext, ".mgf"))

  idx <- beRaw$scanType |> grepl(patter=pattern)

  if (sum(idx) == 0) return (NULL)

  message(paste0("Extracting ", sum(idx), " ",
                 pattern, " scans\n\t to file ", mgf, " ..."))

  beRaw[which(idx)] |>
    Spectra::Spectra() |>
    Spectra::selectSpectraVariables(c("rtime", "precursorMz",
    "precursorCharge", "msLevel", "scanIndex", "custom")) |>
    MsBackendMgf::export(backend = MsBackendMgf::MsBackendMgf(),
                         file = mgf,
                         map = map)

  mgf
}

#mapply(ext = names(scanTypePattern),
#      scanTypePattern,
#       FUN = .generate_mgf) |>
#  lapply(FUN = function(f){if (file.exists(f)) {readLines(f) |> head()}})

## ----defineTopN---------------------------------------------------------------
## Define a function that takes a matrix as input and derives
## the top n most intense peaks within a mass window.
## Of note, here, we require centroided data. (no profile mode!)
MsBackendRawFileReader:::.top_n

## ----applyProcessing----------------------------------------------------------
S_2 <- Spectra::addProcessing(S, MsBackendRawFileReader:::.top_n, n = 1) 

## ----plotSpectraMirror9594, fig.retina=3, fig.cap = "Spectra mirror plot of the filtered  (bottom) and unfiltered scan 9594.", error=TRUE----
try({
Spectra::plotSpectraMirror(S[9594], S_2[9594], ppm = 50)
})

## ----compare9594mZValues------------------------------------------------------
S_2[9594] |> mz() |> unlist()
yIonSeries

## ----readBenchmarkData, fig.cap="I/O Benchmark. The XY plot graphs how many spectra the backend can read in one second versus the chunk size of the rawrr::readSpectrum method for different compute architectures."----

ioBm <- file.path(system.file(package = 'MsBackendRawFileReader'),
               'extdata', 'specs.csv') |>
  read.csv2(header=TRUE)

# perform and include a local IO benchmark
ioBmLocal <- ioBenchmark(1000, c(32, 64, 128, 256), rawfile = rawfileEH4547)


lattice::xyplot((1 / as.numeric(time)) * workers ~ size | factor(n) ,
                group = host,
                data = rbind(ioBm, ioBmLocal),
                horizontal = FALSE,
		scales=list(y = list(log = 10)),
                auto.key = TRUE,
                layout = c(3, 1),
                ylab = 'spectra read in one second',
                xlab = 'number of spectra / file')

## ----mzXML--------------------------------------------------------------------
mzXMLEH3219 <- normalizePath(eh[["EH3219"]])
mzXMLEH3221 <- normalizePath(eh[["EH3221"]])

## ----backendInitialize, message=FALSE, fig.cap='Aggregated intensities mzXML versus raw of the 1st 100 spectra.', message=FALSE, warning=FALSE, fig.width=5, fig.height=5----
if (require(mzR)){
  beMzXML <- Spectra::backendInitialize(
    Spectra::MsBackendMzR(),
    files = c(mzXMLEH3219))
  
  beRaw <- Spectra::backendInitialize(
    MsBackendRawFileReader::MsBackendRawFileReader(),
    files = c(rawfileEH3220))
  
  intensity.xml <- sapply(intensity(beMzXML[1:100]), sum)
  intensity.raw <- sapply(intensity(beRaw[1:100]), sum)
  
  plot(intensity.xml ~ intensity.raw, log = 'xy', asp = 1,
    pch = 16, col = rgb(0.5, 0.5, 0.5, alpha=0.5), cex=2)
  abline(lm(intensity.xml ~ intensity.raw), 
  	col='red')
}

## -----------------------------------------------------------------------------
if (require(mzR)){
  table(scanIndex(beRaw) %in% scanIndex(beMzXML))
}

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

