# A parser for raw and identification mass-spectrometry data

Bernd Fischer, Steffen Neumann, Laurent Gatto and Qiang Kou

#### 30 October 2025

#### Package

mzR 2.44.0

# 1 Introduction

The *[mzR](https://bioconductor.org/packages/3.22/mzR)* package aims at providing a common,
low-level interface to several mass spectrometry data formats, namely,
`mzXML` (Pedrioli et al. [2004](#ref-Pedrioli2004)), `mzML` (Martens et al. [2010](#ref-Martens2010)) for raw data, and
`mzIdentML` (Jones et al. [2012](#ref-Jones2012)), somewhat similar to the Bioconductor package
affyio for affymetrix raw data. No processing is done in `r BiocStyle::Biocpkg("mzR")`, which is left to packages such as `r BiocStyle::Biocpkg("xcms")` (Smith et al. [2006](#ref-Smith:2006), Tautenhahn:2008) or `r BiocStyle::Biocpkg("MSnbase")` (Gatto and Lilley [2012](#ref-Gatto:2012)). These packages also
provide more convenient, high-level interfaces to raw and
identification. data

Most importantly, access to the data should be fast and memory
efficient. This is made possible by allowing on-disk random file
access, i.e. retrieving specific data of interest without having to
sequentially browser the full content nor loading the entire data into
memory.

The actual work of reading and parsing the data files is handled by the included
C/C++ libraries or *backends*. The C++ reference implementation for the `mzML`
is the proteowizard library (Kessner et al. [2008](#ref-Kessner08)) (pwiz in short), which in turn makes
use of the boost C++ (<http://www.boost.org/>) library. More recently, the
proteowizard (<http://proteowizard.sourceforge.net/>) (Chambers et al. [2012](#ref-Chambers2012)) has been
fully integrated using the `mzRpwiz` backend for raw data, and is not the
default option. The `mzRnetCDF` backend provides support to `CDF`-based
formats. Finally, the `mzRident` backend is available to access identification
data (`mzIdentML`) through pwiz.

The *[mzR](https://bioconductor.org/packages/3.22/mzR)* package is in essence a collection of wrappers
to the C++ code, and benefits from the C++ interface provided through
the Rcpp package (Eddelbuettel and François [2011](#ref-Rcpp11)).

**IMPORTANT** New developers that need to access and manipulate raw
mass spectrometry data are advised against using this infrastucture
directly. They are invited to use the corresponding `MSnExp` (with *on
disk* mode) from the*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package instead. The
latter supports reading multiple files at once and offers access to
the spectra data (m/z and intensity) as well as all the spectra
metadata using a coherent interface. The MSnbase infrastructure itself
used the low level classes in mzR, thus offering fast and efficient
access.

# 2 Mass spectrometry raw data

All the mass spectrometry file formats are organized similarly, where
a set of metadata nodes about the run is followed by a list of spectra
with the actual masses and intensities. In addition, each of these
spectra has its own set of metadata, such as the retention time and
acquisition parameters.

## 2.1 Spectral data access

Access to the spectral data is done via the `peaks` function. The
return value is a list of two-column mass-to-charge and intensity
matrices or a single matrix if one spectrum is queried.

## 2.2 Chromatogram access

Access to the chromatogram(s) is done using the `chromatogram` (or
`chromatograms`) function, that return one (or a list of)
data.frames. See `?chromatogram` for details. Chromatogram header information
is available via the `chromatogramHeader` function that returns one (or
a list of) data.frames. See `?chromatogramHeader` for details. This
functionality is only available with the `pwiz` backend.

## 2.3 Identification result access

The main access to identification result is done via `psms`, `score`
and `modifications`. `psms` and `score` will return the detailed
information on each psm and scores. `modifications` will return the
details on each modification found in peptide.

## 2.4 Metadata access

**Run metadata** is available via several functions such as
`instrumentInfo()` or `runInfo()`. The individual fields can be
accessed via e.g. `detector()` etc.

**Spectrum metadata** is available via `header()`, which will return a
list (for single scans) or a dataframe with information such as the
`basePeakMZ`, `peaksCount`, … or, for higher-order MS the `msLevel`
and precursor information.

**Identification metadata**is available via `mzidInfo()`, which will
return a list with information such as the `software`,
`ModificationSearched`, `enzymes`, `SpectraSource` and other
information for this identification result.

The availability of this metadata can not always be guaranteed, and
depends on the MS software which converted the data.

# 3 Example

## 3.1 `mzXML`/`mzML` files

A short example sequence to read data from a mass spectrometer.
First open the file.

```
library(mzR)
```

```
## Loading required package: Rcpp
```

```
library(msdata)

mzxml <- system.file("threonine/threonine_i2_e35_pH_tree.mzXML",
                     package = "msdata")
aa <- openMSfile(mzxml)
```

We can obtain different kind of header information.

```
runInfo(aa)
```

```
## $scanCount
## [1] 55
##
## $lowMz
## [1] 50.0036
##
## $highMz
## [1] 298.673
##
## $dStartTime
## [1] 0.3485
##
## $dEndTime
## [1] 390.027
##
## $msLevels
## [1] 1 2 3 4
##
## $startTimeStamp
## [1] NA
```

```
instrumentInfo(aa)
```

```
## $manufacturer
## [1] "Thermo Scientific"
##
## $model
## [1] "LTQ Orbitrap"
##
## $ionisation
## [1] "electrospray ionization"
##
## $analyzer
## [1] "fourier transform ion cyclotron resonance mass spectrometer"
##
## $detector
## [1] "unknown"
##
## $software
## [1] "Xcalibur software 2.2 SP1"
##
## $sample
## [1] ""
##
## $source
## [1] ""
```

```
header(aa,1)
```

```
##   seqNum acquisitionNum msLevel polarity peaksCount totIonCurrent retentionTime
## 1      1              1       1        1        684     341427000        0.3485
##   basePeakMZ basePeakIntensity collisionEnergy electronBeamEnergy
## 1    120.066         211860000              NA                 NA
##   ionisationEnergy   lowMZ  highMZ precursorScanNum precursorMZ precursorCharge
## 1                0 50.3254 298.673               NA          NA              NA
##   precursorIntensity mergedScan mergedResultScanNum mergedResultStartScanNum
## 1                 NA         NA                  NA                       NA
##   mergedResultEndScanNum injectionTime filterString
## 1                     NA             0         <NA>
##                                   spectrumId centroided ionMobilityDriftTime
## 1 controllerType=0 controllerNumber=1 scan=1       TRUE                   NA
##   isolationWindowTargetMZ isolationWindowLowerOffset isolationWindowUpperOffset
## 1                      NA                         NA                         NA
##   scanWindowLowerLimit scanWindowUpperLimit
## 1              50.3254              298.673
```

Read a single spectrum from the file.

```
pl <- peaks(aa,10)
peaksCount(aa,10)
```

```
## [1] 317
```

```
head(pl)
```

```
##            mz intensity
## [1,] 50.08176  6984.858
## [2,] 50.62267  7719.419
## [3,] 50.70530  7185.290
## [4,] 50.73298  7509.140
## [5,] 50.83848  9366.624
## [6,] 50.88303  8012.808
```

```
plot(pl[,1], pl[,2], type="h", lwd=1)
```

![](data:image/png;base64...)

One should always close the file when not needed any more. This will
release the memory of cached content.

```
close(aa)
```

## 3.2 `mzIdentML` files

You can use `openIDfile` to read a `mzIdentML` file (version 1.1),
which use the pwiz backend.

```
library(mzR)
library(msdata)

file <- system.file("mzid", "Tandem.mzid.gz", package="msdata")
x <- openIDfile(file)
```

`mzidInfo` function will return general information about this
identification result.

```
mzidInfo(x)
```

```
## $FileProvider
## [1] "researcher"
##
## $CreationDate
## [1] "2012-07-25T14:03:16"
##
## $software
## [1] "xtandem x! tandem CYCLONE (2010.06.01.5) "
## [2] "ProteoWizard MzIdentML 3.0.21263 ProteoWizard"
##
## $ModificationSearched
## [1] "Oxidation"       "Carbamidomethyl"
##
## $FragmentTolerance
## [1] "0.8 dalton"
##
## $ParentTolerance
## [1] "1.5 dalton"
##
## $enzymes
## $enzymes$name
## [1] "Trypsin"
##
## $enzymes$nTermGain
## [1] "H"
##
## $enzymes$cTermGain
## [1] "OH"
##
## $enzymes$minDistance
## [1] "0"
##
## $enzymes$missedCleavages
## [1] "1"
##
##
## $SpectraSource
## [1] "D:/TestSpace/NeoTestMarch2011/55merge.mgf"
```

`psms` will return the detailed information on each
peptide-spectrum-match, include `spectrumID`, `chargeState`,
`sequence`. `modNum` and others.

```
p <- psms(x)
colnames(p)
```

```
##  [1] "spectrumID"               "chargeState"
##  [3] "rank"                     "passThreshold"
##  [5] "experimentalMassToCharge" "calculatedMassToCharge"
##  [7] "sequence"                 "peptideRef"
##  [9] "modNum"                   "isDecoy"
## [11] "post"                     "pre"
## [13] "start"                    "end"
## [15] "DatabaseAccess"           "DBseqLength"
## [17] "DatabaseSeq"              "DatabaseDescription"
## [19] "spectrum.title"           "acquisitionNum"
```

The modifications information can be accessed using `modifications`,
which will return the `spectrumID`, `sequence`, `name`, `mass` and
`location`.

```
m <- modifications(x)
head(m)
```

```
##   spectrumID                 sequence
## 1   index=12  LCYIALDFDEEMKAAEDSSDIEK
## 2   index=12  LCYIALDFDEEMKAAEDSSDIEK
## 3  index=285   KDLYGNVVLSGGTTMYEGIGER
## 4   index=83   KDLYGNVVLSGGTTMYEGIGER
## 5   index=21 VIDENFGLVEGLMTTVHAATGTQK
## 6  index=198          GVGGAIVLVLYDEMK
##                                            peptideRef            name    mass
## 1 LCYIALDFDEEMKAAEDSSDIEK_15.9949@M$12;_57.0215@C$2;_ Carbamidomethyl 57.0215
## 2 LCYIALDFDEEMKAAEDSSDIEK_15.9949@M$12;_57.0215@C$2;_       Oxidation 15.9949
## 3              KDLYGNVVLSGGTTMYEGIGER_15.9949@M$15;__       Oxidation 15.9949
## 4              KDLYGNVVLSGGTTMYEGIGER_15.9949@M$15;__       Oxidation 15.9949
## 5            VIDENFGLVEGLMTTVHAATGTQK_15.9949@M$13;__       Oxidation 15.9949
## 6                     GVGGAIVLVLYDEMK_15.9949@M$14;__       Oxidation 15.9949
##   location
## 1        2
## 2       12
## 3       15
## 4       15
## 5       13
## 6       14
```

Since different software will use different scoring function, we
provide a `score` to extract the scores for each psm. It will return a
data.frame with different columns depending on software generating
this file.

```
scr <- score(x)
colnames(scr)
```

```
## [1] "spectrumID"          "X.Tandem.expect"     "X.Tandem.hyperscore"
```

# 4 Future plans

Other file formats provided by HUPO, such as `mzQuantML` for
quantitative data (Walzer et al. [2013](#ref-Walzer:2013)) are also possible in the future.

# 5 Session information

Chambers, Matthew C., Brendan Maclean, Robert Burke, Dario Amodei, Daniel L. Ruderman, Steffen Neumann, Laurent Gatto, et al. 2012. “A cross-platform toolkit for mass spectrometry and proteomics.” *Nat Biotech* 30 (10): 918–20. <https://doi.org/10.1038/nbt.2377>.

Eddelbuettel, Dirk, and Romain François. 2011. “Rcpp: Seamless R and C++ Integration.” *Journal of Statistical Software* 40 (8): 1–18. <http://www.jstatsoft.org/v40/i08/>.

Gatto, L, and K S Lilley. 2012. “MSnbase – an R/Bioconductor Package for Isobaric Tagged Mass Spectrometry Data Visualization, Processing and Quantitation.” *Bioinformatics* 28 (2): 288–9. <https://doi.org/10.1093/bioinformatics/btr645>.

Jones, A R, M Eisenacher, G Mayer, O Kohlbacher, J Siepen, S J Hubbard, J N Selley, et al. 2012. “The mzIdentML Data Standard for Mass Spectrometry-Based Proteomics Results.” *Mol Cell Proteomics* 11 (7): M111.014381. <https://doi.org/10.1074/mcp.M111.014381>.

Kessner, Darren, Matt Chambers, Robert Burke, David Agus, and Parag Mallick. 2008. “ProteoWizard: Open Source Software for Rapid Proteomics Tools Development.” *Bioinformatics* 24 (21): 2534–6. <https://doi.org/10.1093/bioinformatics/btn323>.

Martens, Lennart, Matthew Chambers, Marc Sturm, Darren Kessner, Fredrik Levander, Jim Shofstahl, Wilfred H Tang, et al. 2010. “MzML - a Community Standard for Mass Spectrometry Data.” *Molecular and Cellular Proteomics : MCP*. <https://doi.org/10.1074/mcp.R110.000133>.

Pedrioli, Patrick G A, Jimmy K Eng, Robert Hubley, Mathijs Vogelzang, Eric W Deutsch, Brian Raught, Brian Pratt, et al. 2004. “A Common Open Representation of Mass Spectrometry Data and Its Application to Proteomics Research.” *Nat. Biotechnol.* 22 (11): 1459–66. <https://doi.org/10.1038/nbt1031>.

Smith, C A, E J Want, G O’Maille, R Abagyan, and G Siuzdak. 2006. “XCMS: Processing Mass Spectrometry Data for Metabolite Profiling Using Nonlinear Peak Alignment, Matching, and Identification.” *Anal Chem* 78 (3): 779–87. <https://doi.org/10.1021/ac051437y>.

Walzer, M, D Qi, G Mayer, J Uszkoreit, M Eisenacher, T Sachsenberg, F F Gonzalez-Galarza, et al. 2013. “The mzQuantML Data Standard for Mass Spectrometry-Based Quantitative Studies in Proteomics.” *Mol Cell Proteomics* 12 (8): 2332–40. <https://doi.org/10.1074/mcp.O113.028506>.