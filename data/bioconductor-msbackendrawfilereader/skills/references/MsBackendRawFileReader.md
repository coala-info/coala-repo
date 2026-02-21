# On Using and Extending the `MsBackendRawFileReader` Backend

Tobias Kockmann1\* and Christian Panse1,2\*\*

1Functional Genomics Center Zurich - Swiss Federal Institute of Technology in Zurich
2Swiss Institute of Bioinformatics

\*Tobias.Kockmann@fgcz.ethz.ch
\*\*cp@fgcz.ethz.ch

#### 30 October 2025

#### Abstract

*[MsBackendRawFileReader](https://bioconductor.org/packages/3.22/MsBackendRawFileReader)* implements an
MsBackend for the *[Spectra](https://bioconductor.org/packages/3.22/Spectra)* package using
Thermo Fisher Scientific’s NewRawFileReader .Net libraries.
The package is generalizing the functionallity provided by the
*[rawrr](https://bioconductor.org/packages/3.22/rawrr)*. The vignette utilizes data provided through
the *[tartare](https://bioconductor.org/packages/3.22/tartare)* package.

#### Package

MsBackendRawFileReader 1.16.0

The figure below depicts the idea of the *[Spectra](https://bioconductor.org/packages/3.22/Spectra)* framework.
For a detailed description, read (RforMassSpectrometry Package Maintainer, Laurent Gatto, Johannes Rainer, Sebastian Gibb [2020](#ref-Spectra)).

![Integration of rawDiag and rawrr into the Spectra ecosystem (by courtesy of Johannes Rainer).](data:image/jpeg;base64...)

Figure 1: Integration of rawDiag and rawrr into the Spectra ecosystem (by courtesy of Johannes Rainer)

# 1 Requirements

```
suppressMessages(
  stopifnot(require(Spectra),
            require(MsBackendRawFileReader),
            require(tartare),
            require(BiocParallel))
)
```

assemblies aka Common Intermediate Language bytecode The download and install
can be done on all platforms using the command:
`rawrr::installRawFileReaderDLLs()`

```
if (isFALSE(file.exists(rawrr:::.rawrrAssembly()))){
 rawrr::installRawrrExe()
}
```

# 2 Load data

```
# fetch via ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub::ExperimentHub()
```

```
query(eh, c('tartare'))
```

```
## ExperimentHub with 5 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Functional Genomics Center Zurich (FGCZ)
## # $species: NA
## # $rdataclass: Spectra
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH3219"]]'
##
##            title
##   EH3219 | Q Exactive HF-X mzXML
##   EH3220 | Q Exactive HF-X raw
##   EH3221 | Fusion Lumos mzXML
##   EH3222 | Fusion Lumos raw
##   EH4547 | Q Exactive HF Orbitrap raw
```

The RawFileReader libraries require a file extension ending with `.raw`.

```
EH3220 <- normalizePath(eh[["EH3220"]])
(rawfileEH3220 <- paste0(EH3220, ".raw"))
```

```
## [1] "/home/biocbuild/.cache/R/ExperimentHub/1085c91ca638b3_3236.raw"
```

```
if (!file.exists(rawfileEH3220)){
  file.link(EH3220, rawfileEH3220)
}

EH3222 <- normalizePath(eh[["EH3222"]])
(rawfileEH3222 <- paste0(EH3222, ".raw"))
```

```
## [1] "/home/biocbuild/.cache/R/ExperimentHub/1085c9122df8f2_3238.raw"
```

```
if (!file.exists(rawfileEH3222)){
  file.link(EH3222, rawfileEH3222)
}

EH4547  <- normalizePath(eh[["EH4547"]])
(rawfileEH4547  <- paste0(EH4547 , ".raw"))
```

```
## [1] "/home/biocbuild/.cache/R/ExperimentHub/1085c94582c2d3_4590.raw"
```

```
if (!file.exists(rawfileEH4547 )){
  file.link(EH4547 , rawfileEH4547 )
}
```

# 3 Usage

Call the constructor using `Spectra::backendInitialize`, see also (RforMassSpectrometry Package Maintainer, Laurent Gatto, Johannes Rainer, Sebastian Gibb [2020](#ref-Spectra)).

```
beRaw <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = c(rawfileEH3220, rawfileEH3222, rawfileEH4547))
```

Call the print method

```
beRaw
```

```
## MsBackendRawFileReader with 32500 spectra
##         msLevel      rtime scanIndex
##       <integer>  <numeric> <integer>
## 1             1 0.00358906         1
## 2             1 0.01189523         2
## 3             1 0.01847028         3
## 4             1 0.02504740         4
## 5             1 0.03161818         5
## ...         ...        ...       ...
## 32496         2    34.9964     21877
## 32497         2    34.9978     21878
## 32498         2    34.9992     21879
## 32499         2    35.0007     21880
## 32500         2    35.0021     21881
##  ... 30 more variables/columns.
##
## file(s):
## 1085c91ca638b3_3236.raw
## 1085c9122df8f2_3238.raw
## 1085c94582c2d3_4590.raw
```

```
beRaw |> Spectra::spectraVariables()
```

```
##  [1] "msLevel"                 "rtime"
##  [3] "acquisitionNum"          "scanIndex"
##  [5] "mz"                      "intensity"
##  [7] "dataStorage"             "dataOrigin"
##  [9] "centroided"              "smoothed"
## [11] "polarity"                "precScanNum"
## [13] "precursorMz"             "precursorIntensity"
## [15] "precursorCharge"         "collisionEnergy"
## [17] "isolationWindowLowerMz"  "isolationWindowTargetMz"
## [19] "isolationWindowUpperMz"  "scanType"
## [21] "charge"                  "masterScan"
## [23] "dependencyType"          "monoisotopicMz"
## [25] "AGC"                     "injectionTime"
## [27] "resolution"              "isolationWidth"
## [29] "isolationOffset"         "AGCTarget"
## [31] "collisionEnergyList"     "AGCFill"
## [33] "isStepped"
```

# 4 Application example

## 4.1 Peptide Identification

Here we reproduce the Figure 2 of Kockmann and Panse ([2021](#ref-rawrr)) *[rawrr](https://bioconductor.org/packages/3.22/rawrr)*.
The *[MsBackendRawFileReader](https://github.com/fgcz/MsBackendRawFileReader)* ships with a
`filterScan` method using functionality provided by the C# libraries by
Thermo Fisher Scientific Shofstahl ([2016](#ref-rawfilereader)).

```
(S <- (beRaw |>
   filterScan("FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]") )[437]) |>
  plotSpectra()

# supposed to be scanIndex 9594
S
```

```
## MsBackendRawFileReader with 1 spectra
##     msLevel     rtime scanIndex
##   <integer> <numeric> <integer>
## 1         2   15.4204      9594
##  ... 30 more variables/columns.
##
## file(s):
## 1085c94582c2d3_4590.raw
```

```
# add yIonSeries to the plot
(yIonSeries <- protViz::fragmentIon("LGGNEQVTR")[[1]]$y[1:8])
```

```
## [1] 175.1190 276.1666 375.2350 503.2936 632.3362 746.3791 803.4006 860.4221
```

```
names(yIonSeries) <- paste0("y", seq(1, length(yIonSeries)))
abline(v = yIonSeries, col='#DDDDDD88', lwd=5)
axis(3, yIonSeries, names(yIonSeries))
```

![Peptide spectrum match. The vertical grey lines indicate the *in-silico* computed y-ions of the peptide precusor LGGNEQVTR++ as calculated by the [protViz]( https://CRAN.R-project.org/package=protViz) package.](data:image/png;base64...)

Figure 2: Peptide spectrum match
The vertical grey lines indicate the *in-silico* computed y-ions of the peptide precusor LGGNEQVTR++ as calculated by the [protViz](https://CRAN.R-project.org/package%3DprotViz) package.

## 4.2 Class extension

For demonstration reasons, we extent the `MsBackend` class by a filter method.
The `filterIons` function returns spectra if and only if all fragment ions,
given as argument, match. We use *[protViz](https://CRAN.R-project.org/package%3DprotViz)*`::findNN`
binary search
method for determining the nearest mZ peak for each ion.
If the mass error between an ion and an mz value is less than the given mass
tolerance, an ion is considered a hit.

```
setGeneric("filterIons", function(object, ...) standardGeneric("filterIons"))
```

```
## [1] "filterIons"
```

```
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
```

The lines below implement a simple targeted peptide search engine. The R code
snippet takes as input a `MsBackendRawFileReader` object containing
32500 spectra and y-fragment-ion mZ values determined for
`LGGNEQVTR++`.

```
start_time <- Sys.time()
X <- beRaw |>
  MsBackendRawFileReader::filterScan("FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]") |>
  filterIons(yIonSeries, tol = 0.005) |>
  Spectra::Spectra() |>
  Spectra::peaksData()
end_time <- Sys.time()
```

The defined `filterIons` method runs on
995 input spectra and returns 4 spectra.

The runtime is shown below.

```
end_time - start_time
```

```
## Time difference of 3.374647 secs
```

Next, we define and apply a method for graphing `LGGNEQVTR` peptide spectrum
matches. Also, the function returns some statistics of the match.

```
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
```

![Visualizing of the LGGNEQVTR spectrum matches.](data:image/png;base64...)

Figure 3: Visualizing of the LGGNEQVTR spectrum matches

```
stats::aggregate(mZ ~ ion, data = XC, FUN = base::mean)
```

```
##   ion       mZ
## 1  y1 175.1190
## 2  y2 276.1665
## 3  y3 375.2349
## 4  y4 503.2936
## 5  y5 632.3362
## 6  y6 746.3791
## 7  y7 803.4003
## 8  y8 860.4216
```

```
stats::aggregate(intensity ~ ion, data = XC, FUN = base::max)
```

```
##   ion intensity
## 1  y1   1505214
## 2  y2   2583122
## 3  y3   2364014
## 4  y4   3179124
## 5  y5   2286947
## 6  y6   1236341
## 7  y7   4586484
## 8  y8  12894520
```

We demonstrate the `Spectra::combinePeaks` method and aggregate the four spectra
into a single peak matrix. The statistics returned by `.plot.LGGNEQVTR()` should
be identical to the aggregation code snippet output above.

```
X |>
  Spectra::combinePeaks(ppm=10, intensityFun=base::max) |>
  .plot.LGGNEQVTR()
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'plot': unable to find an inherited method for function 'combinePeaks' for signature 'object = "SimpleList"'
```

## 4.3 Export Mascot Generic Format File

Below we demonstrate the interaction with the *[MsBackendMgf](https://bioconductor.org/packages/3.22/MsBackendMgf)*
package while composing a Mascot Generic Format
[mgf](http://www.matrixscience.com/help/data_file_help.html#GEN) file which
is compatible with conducting an MS/MS Ions Search using Mascot Server (>=2.7)
Perkins et al. ([1999](#ref-Perkins1999)).

```
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
```

```
## Loading required package: MsBackendMgf
```

```
## [1] "862.427612304688 154045.78125" "870.404846191406 159569.8125"
## [3] "871.395141601562 196302.6875"  "880.671020507812 65916"
## [5] "END IONS"                      ""
```

To extract all tandem spectra, you can use the code snippets below

```
S <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = c(rawfileEH4547)) |>
  Spectra()

S
```

```
## MSn data (Spectra) with 21881 spectra in a MsBackendRawFileReader backend:
##         msLevel      rtime scanIndex
##       <integer>  <numeric> <integer>
## 1             1 0.00258665         1
## 2             2 0.00686231         2
## 3             2 0.00828043         3
## 4             2 0.00971328         4
## 5             2 0.01112509         5
## ...         ...        ...       ...
## 21877         2    34.9964     21877
## 21878         2    34.9978     21878
## 21879         2    34.9992     21879
## 21880         2    35.0007     21880
## 21881         2    35.0021     21881
##  ... 30 more variables/columns.
##
## file(s):
## 1085c94582c2d3_4590.raw
```

```
S |>
  MsBackendMgf::export(backend = MsBackendMgf::MsBackendMgf(),
                       file = mgf,
                       map = map)
```

Next, we generate an mgf file for each scan type. This is helpful,
e.g., for optimizing search settings tandem mass spectrometry sequence
database search tool as comet Eng, Jahan, and Hoopmann ([2012](#ref-comet2012)) or mascot server Perkins et al. ([1999](#ref-Perkins1999)).

```
## Define scanType patterns
scanTypePattern <- list(
  EThcD.lowres = "ITMS.+sa Full ms2.+@etd.+@hcd.+",
  ETciD.lowres = "ITMS.+sa Full ms2.+@etd.+@cid.+",
  CID.lowres = "ITMS[^@]+@cid[^@]+$",
  HCD.lowres = "ITMS[^@]+@hcd[^@]+$",
  EThcD.highres = "FTMS.+sa Full ms2.+@etd.+@hcd.+",
  HCD.highres = "FTMS[^@]+@hcd[^@]+$"
)
```

```
beRaw <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = c(rawrr::sampleFilePath()))
```

```
beRaw <- Spectra::backendInitialize(
  MsBackendRawFileReader::MsBackendRawFileReader(),
  files = rawrr::sampleFilePath())

beRaw$custom <- paste0("File: ", gsub("/srv/www/htdocs/Data2San/", "", beRaw$dataOrigin), " ; SpectrumID: ", beRaw$scanIndex)
```

```
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
```

## 4.4 Procesing queue

Given the task, we want to filter an MS2 of peak list recorded on an Orbitrap
device to be interested only in the top peak within 100 Da mass windows. The
following code snippet will demonstrate a solution.

```
## Define a function that takes a matrix as input and derives
## the top n most intense peaks within a mass window.
## Of note, here, we require centroided data. (no profile mode!)
MsBackendRawFileReader:::.top_n
```

```
## function (x, n = 10, mass_window = 100, ...)
## {
##     if (nrow(x) < n) {
##         return(x)
##     }
##     idx <- unlist(lapply(seq(0, 2000, by = mass_window), function(mZ) {
##         i <- which((mZ < x[, 1] & x[, 1] <= mZ + mass_window))
##         r <- i[order(x[, 2][i], decreasing = TRUE)]
##         if (length(x[, 2]) > length(i))
##             return(r[1:n])
##         return(r)
##     }, ...))
##     x[sort(idx[!is.na(idx)]), ]
## }
## <bytecode: 0x5681595a2e10>
## <environment: namespace:MsBackendRawFileReader>
```

We add our custom code to the processing queue of the Spectra object.
Of note, we use `n = 1` in praxis `n = 10` for a 100 Da mass window, which seems
to be a practical choice.

```
S_2 <- Spectra::addProcessing(S, MsBackendRawFileReader:::.top_n, n = 1)
```

The plot below displays a visual control of the custom filter function `top_n.`
On the top is the original spectrum, and the filtered one is on the bottom.
A point indicates peaks that match.

```
Spectra::plotSpectraMirror(S[9594], S_2[9594], ppm = 50)
```

![Spectra mirror plot of the filtered  (bottom) and unfiltered scan 9594.](data:image/png;base64...)

Figure 4: Spectra mirror plot of the filtered (bottom) and unfiltered scan 9594

The following snippet prints the values of the filtered peaklist and the mZ
values of the y-ions.

```
S_2[9594] |> mz() |> unlist()
```

```
## [1] 171.1129 276.1667 375.2351 486.2656 503.2942 632.3369 746.3797 860.4223
```

```
yIonSeries
```

```
##       y1       y2       y3       y4       y5       y6       y7       y8
## 175.1190 276.1666 375.2350 503.2936 632.3362 746.3791 803.4006 860.4221
```

# 5 Evaluation

## 5.1 Efficiency - I/O Benchmark

When reading spectra the
`MsBackendRawFileReader:::.RawFileReader_read_peaks`
method is calling the
`rawrr::readSpectrum`
method.

The figure below displays the time performance for reading a single spectrum in
dependency from the chunk size (how many spectra are read in one function call)
for reading different numbers of overall spectra.

```
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
```

![I/O Benchmark. The XY plot graphs how many spectra the backend can read in one second versus the chunk size of the rawrr::readSpectrum method for different compute architectures.](data:image/png;base64...)

Figure 5: I/O Benchmark
The XY plot graphs how many spectra the backend can read in one second versus the chunk size of the rawrr::readSpectrum method for different compute architectures.

## 5.2 Effectiveness

We compare the output of the Thermo Fischer Scientific raw files versus
their corresponding mzXML files using `Spectra::MsBackendMzR` relying on the
*[mzR](https://bioconductor.org/packages/3.22/mzR)* package.

```
mzXMLEH3219 <- normalizePath(eh[["EH3219"]])
```

```
## see ?tartare and browseVignettes('tartare') for documentation
```

```
## loading from cache
```

```
mzXMLEH3221 <- normalizePath(eh[["EH3221"]])
```

```
## see ?tartare and browseVignettes('tartare') for documentation
## loading from cache
```

```
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
```

![Aggregated intensities mzXML versus raw of the 1st 100 spectra.](data:image/png;base64...)

Figure 6: Aggregated intensities mzXML versus raw of the 1st 100 spectra

Are all scans of the raw file in the mzXML file?

```
if (require(mzR)){
  table(scanIndex(beRaw) %in% scanIndex(beMzXML))
}
```

```
##
## FALSE  TRUE
##   113  1764
```

# Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] mzR_2.44.0                    Rcpp_1.1.0
##  [3] MsBackendMgf_1.18.0           tartare_1.23.0
##  [5] ExperimentHub_3.0.0           AnnotationHub_4.0.0
##  [7] BiocFileCache_3.0.0           dbplyr_2.5.1
##  [9] MsBackendRawFileReader_1.16.0 Spectra_1.20.0
## [11] BiocParallel_1.44.0           S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0           generics_0.1.4
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0        xfun_0.53              bslib_0.9.0
##  [4] httr2_1.2.1            lattice_0.22-7         Biobase_2.70.0
##  [7] vctrs_0.6.5            tools_4.5.1            curl_7.0.0
## [10] parallel_4.5.1         tibble_3.3.0           AnnotationDbi_1.72.0
## [13] RSQLite_2.4.3          rawrr_1.18.0           cluster_2.1.8.1
## [16] blob_1.2.4             pkgconfig_2.0.3        lifecycle_1.0.4
## [19] compiler_4.5.1         Biostrings_2.78.0      tinytex_0.57
## [22] Seqinfo_1.0.0          codetools_0.2-20       ncdf4_1.24
## [25] clue_0.3-66            htmltools_0.5.8.1      sass_0.4.10
## [28] yaml_2.3.10            pillar_1.11.1          crayon_1.5.3
## [31] jquerylib_0.1.4        MASS_7.3-65            cachem_1.1.0
## [34] magick_2.9.0           MetaboCoreUtils_1.18.0 tidyselect_1.2.1
## [37] digest_0.6.37          purrr_1.1.0            dplyr_1.1.4
## [40] bookdown_0.45          BiocVersion_3.22.0     grid_4.5.1
## [43] fastmap_1.2.0          cli_3.6.5              magrittr_2.0.4
## [46] withr_3.0.2            filelock_1.0.3         rappdirs_0.3.3
## [49] bit64_4.6.0-1          protViz_0.7.9          rmarkdown_2.30
## [52] XVector_0.50.0         httr_1.4.7             bit_4.6.0
## [55] png_0.1-8              memoise_2.0.1          evaluate_1.0.5
## [58] knitr_1.50             IRanges_2.44.0         rlang_1.1.6
## [61] glue_1.8.0             DBI_1.2.3              BiocManager_1.30.26
## [64] jsonlite_2.0.0         R6_2.6.1               fs_1.6.6
## [67] ProtGenerics_1.42.0    MsCoreUtils_1.22.0
```

# References

Eng, Jimmy K., Tahmina A. Jahan, and Michael R. Hoopmann. 2012. “Comet: An Open-Source MS/MS Sequence Database Search Tool.” *PROTEOMICS* 13 (1): 22–24. <https://doi.org/10.1002/pmic.201200439>.

Kockmann, Tobias, and Christian Panse. 2021. “The Rawrr R Package: Direct Access to Orbitrap Data and Beyond.” *Journal of Proteome Research*. <https://doi.org/10.1021/acs.jproteome.0c00866>.

Perkins, David N., Darryl J. C. Pappin, David M. Creasy, and John S. Cottrell. 1999. “Probability-Based Protein Identification by Searching Sequence Databases Using Mass Spectrometry Data.” *Electrophoresis* 20 (18): 3551–67. [https://doi.org/10.1002/(sici)1522-2683(19991201)20:18<3551::aid-elps3551>3.0.co;2-2](https://doi.org/10.1002/%28sici%291522-2683%2819991201%2920%3A18%3C3551%3A%3Aaid-elps3551%3E3.0.co;2-2).

RforMassSpectrometry Package Maintainer, Laurent Gatto, Johannes Rainer, Sebastian Gibb. 2020. “Spectra.” Bioconductor. <https://doi.org/10.18129/B9.BIOC.SPECTRA>.

Shofstahl, Jim. 2016. “New Rawfilereader from Thermo Fisher Scientific.” 2016. <https://planetorbitrap.com/rawfilereader>.