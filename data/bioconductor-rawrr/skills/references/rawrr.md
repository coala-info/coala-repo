# The rawrr R package - Direct Access to Orbitrap Data and Beyond

Tobias Kockmann1\* and Christian Panse1,2\*\*

1Functional Genomics Center Zurich (FGCZ) - University of Zurich | ETH Zurich, Winterthurerstrasse 190, CH-8057 Zurich, Switzerland
2Swiss Institute of Bioinformatics (SIB), Quartier Sorge - Batiment Amphipole, CH-1015 Lausanne, Switzerland

\*Tobias.Kockmann@fgcz.ethz.ch
\*\*cp@fgcz.ethz.ch

#### 30 October 2025

#### Abstract

This vignette provides implementation details and describes the main
functionalities of the *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* package (Kockmann and Panse [2021](#ref-Kockmann2021)). In addition,
it reports two use cases inspired by real-world research tasks that
demonstrate the application of the package for the analysis of bottom-up
proteomics LC-MS data.

#### Package

rawrr 1.18.0

![](data:image/png;base64...)

# 1 Introduction

Mass spectrometry-based proteomics and metabolomics are the preferred technologies to study the protein and metabolite landscape of complex biological systems. The Orbitrap mass analyzer is one of the key innovations that propelled the field by providing high-resolution accurate mass (HRAM) data on a chromatographic time scale. Driven by the need to analyze the resulting LC-MS data, several specialized software tools have been developed in the last decade. In the academic environment, [MaxQuant](https://maxquant.org/)(Cox and Mann [2008](#ref-Cox2008)) and [Skyline](https://skyline.ms/project/home/begin.view)(MacLean et al. [2010](#ref-MacLean2010)) are by far the most popular ones. These software tools usually offer GUIs that control running predefined analysis templates/workflows, including free parameters that need to be defined by the user. In parallel, projects like [OpenMS](https://www.openms.de/)(Röst et al. [2016](#ref-Rst2016)) or *[pyteomics](https://github.com/levitsky/pyteomics)*(Goloborodko et al. [2013](#ref-Goloborodko2013)) chose a fundamentally different approach. They aim at providing software libraries bound to specific programming languages like `C++` or `Python`. Naturally, these offer greater analytical flexibility but require programming skills from the end-user and have therefore not reached the popularity of their GUI counterparts. Proteomics and metabolomics specific libraries have also been developed for the [`R`](https://www.r-project.org/) statistical environment, but these mainly support high-level statistical analysis once the raw measurement data has undergone extensive preprocessing and aggregation by external software tools (often the GUI-based ones listed above). A typical example is the `R` package [MSstats](http://msstats.org/)(Choi et al. [2014](#ref-Choi2014)) for the statistical analysis of LC-MS experiments with complex designs or *[MSqRob](https://github.com/statOmics/MSqRob)*(Goeminne, Gevaert, and Clement [2015](#ref-Goeminne2015)). MSstats can process MaxQuant or Skyline outputs and creates protein/peptide level estimates for whether the biological system shows statistically significant regulation. In a nutshell, these tools provide statistical postprocessing. Libraries that support working with the spectral data in `R` also exist, for instance, the Bioconductor package *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* (Gatto and Lilley [2011](#ref-Gatto2011)). However, they require conversion of raw data to exchange formats like [mzML](http://www.psidev.info/mzML), which is primarily supported by the [ProteoWizard](http://proteowizard.sourceforge.net/)(Chambers et al. [2012](#ref-Chambers2012)) or *[ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)*(Hulstaert et al. [2019](#ref-ThermoRawFileParser)) projects and its software tool `MSconvert`.

We strongly believe that a library providing raw data reading would finally close the gap and facilitate modular end-to-end analysis pipeline development in `R`. This could be of special interest to research environments/projects dealing with either big data analytics or scientists interested in code prototyping without formal computer science education. Another key aspect regarding multi-omics integration is the fact that high-throughput genomic data analysis is already done mostly in `R`. This is primarily due to the [Bioconductor project](https://www.bioconductor.org/)(Huber et al. [2015](#ref-Huber2015)) that currently provides >1900 open-source software packages, training and teaching, and a very active user and developer community. Having these thoughts in mind, we decided to implement our `R` package named *[rawrr](https://bioconductor.org/packages/3.22/rawrr)*. *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* utilizes a vendor-provided API named `RawFileReader` (Shofstahl [2015](#ref-rawfilereader)) to access spectral data logged in proprietary Thermo Fisher Scientific raw files. These binary files are among others written by all Orbitrap mass spectrometers, unlocking an incredible amount of the recent global LC-MS data, also stored in public repositories like [ProteomeExchange](http://www.proteomexchange.org/). This manuscript presents a first package version/release and showcases its usage for bottom-up proteomics data analysis with a focus on Orbitrap data.

# 2 Implementation

Our implementation consists of two language layers, the top `R` layer and the hidden `C#` layer. Specifically, `R` functions requesting access to data stored in binary raw files (reader family functions listed in Table 1) invoke compiled `C#` wrapper methods using a system call. Calling a wrapper method typically results in the execution of methods defined in the `RawFileReader` dynamic link library provided by Thermo Fisher Scientific. Our `.NET 8.0` (Microsoft [2024](#ref-dotnet)) precompiled wrapper methods are bundled, including the runtime, in the *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* executable file and shipped with the released `R` package.
Our package also contains the `C#` source code (rawrr.cs), hopefully allowing other developers to follow and improve our code (open source). In order to return extracted data back to the `R` layer we use file I/O. More specifically, the extracted information is written to a temporary location on the harddrive, read back into memory and parsed into `R` objects.
The graphic below depicts the described software stack.

|  |
| --- |
| `R>` |
| `system2` or `text connection` |
| .NET or Mono Runtime |
| Managed Assembly (CIL/.NET code)   rawrr.exe |
| ThermoFisher.CommonCore.\*.dll |

Since mass spectrometry typically uses two basic data items, the mass spectrum and the mass chromatogram, we decided to implement corresponding objects following `R`’s `S3` OOP system (Becker, Chambers, and Wilks [1988](#ref-newS)) named `rawrrSpectrum` and `rawrrChromatogram`. These objects function as simplistic interface to almost all data stored in raw-formatted files. The package provides functions to create and validate class instances. While class constructors primarily exist for (unit) testing purposes, instances are typically generated by the reader family of functions enumerated in Table 1 and returned as object sets (`rawrrSpectrumSet`, `rawrrChromatogramSet`). The names of objects encapsulated within `rawrrSpectrum` instances are keys returned by the `RawFileReader` API and the corresponding values become data parts of the objects, typically vectors of type `numeric`, `logical` or `character`. It needs to be mentioned that the `rawrrSpectrum` content partially depends on the instrument model and installed instrument control software version. For instance, the keys `FAIMS Voltage On:` and `FAIMS CV:` are only written by instruments that support FAIMS acquisition. We also implemented basic generics for printing and plotting of objects in base `R` to minimize dependencies.

### 2.0.1 Example data

The example file `20181113_010_autoQC01.raw` used throughout this manuscript contains Fourier-transformed Orbitrap spectra (FTMS) recorded on a Thermo Fisher Scientific Q Exactive HF in positive mode (+). The mass spectrometer was operated in line with a nano UPLC and a nano electrospray source (NSI). MS2 spectra were generated by HCD fragmentation at normalized collision energy (NCE) of 27. All spectra were written to file after applying centroiding (c) and lock mass correction. The analyzed sample consisted of the iRT peptide mix (Biognosys) in a tryptic BSA digest (NEB) and was separated applying a 20 min linear gradient on C18 reversed-phase material at a constant flow rate of 300 nl/min. The file is part of the MassIVE dataset [MSV000086542](https://massive.ucsd.edu/ProteoSAFe/dataset.jsp?accession=MSV000086542) (Kockmann [2020](#ref-MSV000086542)) and can be obtained through the FTP download link
(MD5: a1f5df9627cf9e0d51ec1906776957ab). Individual scans have been assigned a universal spectrum identifier (USI)(Deutsch et al. [2020](#ref-Deutsch2020.12.07.415539)) by [MassIVE](https://massive.ucsd.edu/ProteoSAFe/static/massive.jsp).

If the environment variable `MONO_PATH` does not include a directory
containing the RawFileReader .NET assemblies are
installed in a directory derived by the `rawrr::rawrrAssemblyPath()` function.

```
rawrr::installRawrrExe()
```

```
## NULL
```

Additional raw data for demonstration and extended testing is available through the Bioconductor data package *[tartare](https://bioconductor.org/packages/3.22/tartare)* (Panse and Kockmann [2019](#ref-tartare)).

```
# fetch via ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub::ExperimentHub()
EH4547 <- normalizePath(eh[["EH4547"]])

(rawfile <- paste0(EH4547, ".raw"))
```

```
## [1] "/home/biocbuild/.cache/R/ExperimentHub/1085c94582c2d3_4590.raw"
```

```
if (!file.exists(rawfile)){
  file.copy(EH4547, rawfile)
}
```

# 3 Results

The following sections are inspired by real-world research/infrastructure projects but have been stripped down to the bare scientific essentials to put more emphasis on the software application. We display source code in grey-shaded boxes, including syntax highlights. Corresponding `R` command line output starts with `##` and is shown directly below the code fragment that triggered the output. All figures are generated using the generic plotting functions of the package. Additional graphical elements were added using base `R` plotting functions to increase the comprehensibility.

## 3.1 Use Case I - Analyzing Orbitrap Spectra

```
H <- rawrr::readFileHeader(rawfile = rawfile)
```

The Orbitrap detector has been a tremendous success story in MS, since it offers HRAM data on a time scale that is compatible with chromatographic analysis (LC-MS)(Makarov [2000](#ref-Makarov2000)) and is therefore heavily used in bottom-up proteomics. However, analyzing Orbitrap data in `R` has so far only been possible after raw data conversion to exchange formats like mz(X)ML. Unfortunately, conversion is accompanied by a loss of Orbitrap-specific information. This use case shows how easy it is to work directly with raw-formated Orbitrap data after installing our `R` package *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* which applies vendor APIs for data access. We use a complete LC-MS run recorded on a Q Exactive HF Orbitrap by parallel reaction monitoring (PRM)(Gallien et al. [2012](#ref-Gallien2012)) for demonstration purposes (File name: 1085c94582c2d3\_4590.raw). The 35 min run resulted in 21881 scans that were written to the file. Already typesetting the above lines uses *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* functionality, since instrument model, file name, time range of data acquisition, and number of scans is extracted from the binary file header (Note: This manuscript was written in `R markdown` and combines `R` code with narration). The respective function is called `readFileHeader()` and returns a simple `R` object of type `list` (see Table 1).

lists *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* package functions connected to reading functionality. More details can be found in the package man pages.

| Function Name | Description | Return value |
| --- | --- | --- |
| `readFileHeader()` | Reads meta information from a raw file header | `list` |
| `readIndex()` | Generates a scan index from a raw file | `data.frame` |
| `readSpectrum()` | Reads spectral data from a raw file | `rawrrSpectrum(Set)` |
| `readTrailer()` | Reads trailer values for each scan event | `vector` |
| `readChromatogram()` | Reads chromatographic data from a raw file | `rawrrChromatogram(Set)` |

Individual scans or scan collections (sets) can be read by the function `readSpectrum()` which returns a `rawrrSpectrum` object or `rawrrSpectrumSet`. Our package also provides generics for printing and plotting these objects. The following code chunk depicts how a set of scans is read from the raw file (scan numbers were selected based on a database search). The corresponding Figure 1 shows the resulting plot for scan `9594` (USI: [mzspec:MSV000086542:20181113\_010\_autoQC01:scan:9594:LGGNEQVTR/2](http://massive.ucsd.edu/ProteoSAFe/usi.jsp#%7B%22usi%22:%22mzspec:MSV000086542:20181113_010_autoQC01:scan:9594:LGGNEQVTR/2%22%7D)) assigned to the doubly-charged iRT peptide LGGNEQVTR by MS-GF+ (Score: 144, SpecProb: 1.9e-12, DB E-Value: 4.4e-4, see [MassIVE RMSV000000336.1](https://massive.ucsd.edu/ProteoSAFe/dataset.jsp?task=575538e190e84cbfbf6c17aa1219e403#reanalyses_header) for details of the search):

```
i <- c(9594, 11113, 11884, 12788, 12677, 13204, 13868, 14551, 16136, 17193, 17612)
S <- rawrr::readSpectrum(rawfile = rawfile, scan = i)
class(S)
```

```
## [1] "rawrrSpectrumSet"
```

```
class(S[[1]])
```

```
## [1] "rawrrSpectrum"
```

```
summary(S[[1]])
```

```
## Total Ion Current:    62374688
## Scan Low Mass:    100
## Scan High Mass:   1015
## Scan Start Time (min):    15.42042
## Scan Number:  9594
## Base Peak Intensity:  12894520
## Base Peak Mass:   860.4223
## Scan Mode:    FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]
```

```
plot(S[[1]], centroid=TRUE)
```

![Plot of scan number 9594 (USI: mzspec:MSV000086542:20181113_010_autoQC01:scan:9594) showing a centroided tandem mass spectrum of the iRT peptide precursor LGGNEQVTR++ in positive mode. The scan was acquired on an Orbitrap detector including lock mass correction and using a transient of 64 ms (equal to a resolving power of 30'000 at 200 m/z) and an AGC target of 1e5 elementary charges.Peak attributes like m/z, charge (z), and resolution (R) are shown above the peaks. ](data:image/png;base64...)

Figure 1: Plot of scan number 9594 (USI: mzspec:MSV000086542:20181113\_010\_autoQC01:scan:9594)
showing a centroided tandem mass spectrum of the iRT peptide precursor LGGNEQVTR++
in positive mode. The scan was acquired on an Orbitrap detector including
lock mass correction and using a transient of 64 ms (equal to a resolving
power of 30’000 at 200 m/z) and an AGC target of 1e5 elementary charges.Peak
attributes like m/z, charge (z), and resolution (R) are shown above the
peaks.

The plot shows typical Orbitrap peak attributes like resolution (R) and charge (z) above the most intense peaks when centroided data is available and selected. Centroided data also makes it possible to graph spectra using signal-to-noise as response value. This is potentially interesting since Orbitrap detectors follow \(S/N \propto charges \cdot \sqrt R\) with \(S/N\) being the signal to noise ratio, \(charges\) meaning elementary charges in the Orbitrap, and \(R\) being the resolving power of the scan (Kelstrup et al. [2014](#ref-Kelstrup2014)). Signal-to-noise makes judging the signal quantity more intuitive than using arbitrary signal intensity units. Figure 2 shows that all y-ion signals are several ten or even hundred folds above the noise estimate (Note: The spectrum shown in Figure 2 is decorated with y-ions calculated for LGGNEQVTR++ using the *[protViz](https://CRAN.R-project.org/package%3DprotViz)* package.). By adding some diagnostic information related to the Orbitrap’s advanced gain control (AGC) system, it becomes apparent that the C-trap managed to collect the defined 100,000 charges within 2.8 ms, corresponding to only ~5% of the maximum injection time of 55 ms.

```
plot(S[[1]], centroid=TRUE, SN = TRUE, diagnostic = TRUE)
# S/N threshold indicator
abline(h = 5, lty = 2, col = "blue")
# decorate plot with y-ion series of target peptide LGGNEQVTR++
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

![Spectrum plot using signal-to-noise option. The vertical grey lines indicate the *in-silico* computed y-ions of the peptide precusor LGGNEQVTR++ as calculated by the [protViz]( https://CRAN.R-project.org/package=protViz) package [@protViz]. The horizontal blue line indicates a signal to noise ratio of 5. Diagnostic information related to AGC is shown in grey.](data:image/png;base64...)

Figure 2: Spectrum plot using signal-to-noise option
The vertical grey lines indicate the *in-silico* computed y-ions of the peptide precusor LGGNEQVTR++ as calculated by the [protViz](https://CRAN.R-project.org/package%3DprotViz) package (Panse and Grossmann [2020](#ref-protViz)). The horizontal blue line indicates a signal to noise ratio of 5. Diagnostic information related to AGC is shown in grey.

In total, the API provides 83 data items for this particular scan covering ion optics settings, mass calibration, and other diagnostic data (use `print()` to gain an overview). It needs to be mentioned that this list is highly dynamic and changes with instrument model and installed instrument control software version. Our reader method is designed in a flexible way so that also newly introduced items will be passed onto the `R` environment in the future. In general, access to `rawrrSpectrum` items are provided by the subsetting operators `$` and `[[`. But for programmatic access we highly recommend using accessor functions like `scanNumber()` instead of using `$scan` or `[["scan"]]`, since the accessors will also take care of casting values stored as-returned by the API (mostly base type `character`). Another argument for favoring the accessor function mechanism is the more restrictive error handling in case the requested information is not available and more descriptive function names without white spaces. Users can create missing accessor functions by applying a function factory named `makeAccessor()` or request them from the package maintainers. The following code chunk demonstrates the above mentioned aspects:

```
# value casting
(x <- S[[1]]$scan)
```

```
## [1] 9594
```

```
class(x)
```

```
## [1] "numeric"
```

```
(y <- rawrr::scanNumber(S[[1]]))
```

```
## [1] 9594
```

```
class(y)
```

```
## [1] "integer"
```

```
# error handling
S[[1]]$`FAIMS Voltage On:`
```

```
## NULL
```

```
try(rawrr::faimsVoltageOn(S[[1]]))
```

```
## Error in rawrr::faimsVoltageOn(S[[1]]) :
##   FAIMS Voltage On: is not available!
```

```
# generating a well-behaved accessor
maxIonTime <- rawrr::makeAccessor(key = "Max. Ion Time (ms):", returnType = "double")
maxIonTime(S[[1]])
```

```
## [1] 55
```

More sophisticated analysis workflows applying *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* functionalities have also been demonstrated recently. For example, *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* was used to annotate and compare marker ions found in HCD MS2 spectra for ADP-ribosylated peptides at different collision energies (Gehrig et al. [2020](#ref-Gehrig2020)), as well as for the annotation of small molecule spectra after UVPD dissociation (Panse et al. [2020](#ref-Panse2020)). Such information can be conveniently extracted, since the `rawrrSpectrum` object provides easy access to normalized and absolute HCD energies.

## 3.2 Use Case II - iRT Regression for System Suitability Monitoring

By applying linear regression, one can convert observed peptide retention times (RTs) into dimensionless scores termed iRT values and *vice versa* (Escher et al. [2012](#ref-Escher2012)). This can be used for retention time calibration/prediction. In addition, fitted iRT regression models provide highly valuable information about LC-MS run performance. This example shows how easy it is to perform iRT regression in `R` by just using the raw measurement data, our package *[rawrr](https://bioconductor.org/packages/3.22/rawrr)*, and well known `base R` functions supporting linear modeling. To get a first impression of the data we calculate a total ion chromatogram (TIC) using the `readChromatogram()` function. Plotting the TIC shows chromatographic peaks between 15 and 28 min that could be of peptidic origin (see Figure 3). Of note, there is also a `type = "bpc"` option if you prefer a base peak chromatogram (BPC):

```
message(rawfile)
```

```
## /home/biocbuild/.cache/R/ExperimentHub/1085c94582c2d3_4590.raw
```

```
rawrr::readChromatogram(rawfile = rawfile, type = "tic") |>
  plot()
```

![Total ion chromatogram (TIC) calculated from all MS1-level scans contained in 20181113_010_autoQC01.raw.](data:image/png;base64...)

Figure 3: Total ion chromatogram (TIC) calculated from all MS1-level scans contained in 20181113\_010\_autoQC01.raw

```
rawrr::readChromatogram(rawfile = rawfile, type = "bpc") |>
  plot()
```

![Base peak chromatogram (BPC) calculated from all MS1-level scans contained in 20181113_010_autoQC01.raw.](data:image/png;base64...)

Figure 4: Base peak chromatogram (BPC) calculated from all MS1-level scans contained in 20181113\_010\_autoQC01.raw

The initial step of iRT regression is to estimate the empirical RTs of a peptide set with known iRT scores. In the simplest case, this is achieved by computing an extracted ion chromatogram (XIC) for iRT peptide precursors, provided they were spiked into the sample matrix prior to data acquisition. The code chunk below demonstrates how the function `readChromatogram()` is called on the `R` command line to return a `rawrrChromatogramSet` object of the type `xic`. This object is plotted for visual inspection (see Figure 4 for resulting plot).

```
iRTmz <- c(487.2571, 547.2984, 622.8539, 636.8695, 644.8230, 669.8384, 683.8282,
            683.8541, 699.3388, 726.8361, 776.9301)

names(iRTmz) <- c("LGGNEQVTR", "YILAGVENSK", "GTFIIDPGGVIR", "GTFIIDPAAVIR",
                 "GAGSSEPVTGLDAK", "TPVISGGPYEYR", "VEATFGVDESNAK",
                 "TPVITGAPYEYR", "DGLDAASYYAPVR", "ADVTPADFSEWSK",
                 "LFLQFGAQGSPFLK")

C <- rawrr::readChromatogram(rawfile, mass = iRTmz, tol = 10, type = "xic", filter = "ms")
class(C)
```

```
## [1] "rawrrChromatogramSet"
```

```
plot(C, diagnostic = TRUE)
```

![Extracted ion chromatograms (XIC) for iRT peptide precursors. Each XIC was calculated using a tolerance of 10 ppm around the target mass and using only MS1-level scans.](data:image/png;base64...)

Figure 5: Extracted ion chromatograms (XIC) for iRT peptide precursors
Each XIC was calculated using a tolerance of 10 ppm around the target mass and using only MS1-level scans.

Be reminded that the intensity traces are not computed within `R`, for instance, by reading all scans of a raw file and subsequently iterating over a scan subset. Instead, traces are retrieved by a `C#` method that calls the vendor API. The API takes care of the scan filtering process (checks filter validity and applies the filter). On the `R` code level there is no need to know *a priori* which scans match the filter rule or implement vectorized operations (we generate multiple XICs simultaneously here). Only the API-returned output needs to be parsed into `rawrrChromatogram` objects. By changing the scan filter, one can easily switch between generating precursor traces and fragment ion traces. The following code chunk shows how to create fragment ion chromatograms (y6 to y8) generated from scans that target LGGNEQVTR++ (see Figure 5 for plot output):

```
rawrr::readChromatogram(rawfile = rawfile,
      mass = yIonSeries[c("y6", "y7", "y8")],
      type = 'xic',
      tol = 10,
      filter = "FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]") |>
  plot(diagnostic = TRUE)
```

![Extracted ion chromatograms (XICs) for LGGNEQVTR++ fragment ions y6, y7, and y8. Each target ion (see legend) was extracted with a tolerance of 10 ppm from all scans matching the provided filter.](data:image/png;base64...)

Figure 6: Extracted ion chromatograms (XICs) for LGGNEQVTR++ fragment ions y6, y7, and y8
Each target ion (see legend) was extracted with a tolerance of 10 ppm from all scans matching the provided filter.

By using the `readIndex()` function a `data.frame` that indexes all scans found in a raw file is returned. When subsetting it for our scan type of interest it becomes clear that the example data was recorded using parallel reaction monitoring (PRM) since the parent ion 487.2567 was isolated in regularly-spaced intervals for fragment ion recording:

```
rawrr::readIndex(rawfile = rawfile) |>
  subset(scanType == "FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]") |>
  head()
```

```
##     scan                                                     scanType
## 2      2 FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]
## 24    24 FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]
## 46    46 FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]
## 68    68 FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]
## 90    90 FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]
## 112  112 FTMS + c NSI Full ms2 487.2567@hcd27.00 [100.0000-1015.0000]
##       StartTime precursorMass MSOrder charge masterScan dependencyType
## 2   0.006862313      487.2567     Ms2      2         NA             NA
## 24  0.042385827      487.2567     Ms2      2         NA             NA
## 46  0.077909329      487.2567     Ms2      2         NA             NA
## 68  0.113423450      487.2567     Ms2      2         NA             NA
## 90  0.148931680      487.2567     Ms2      2         NA             NA
## 112 0.184455230      487.2567     Ms2      2         NA             NA
##     monoisotopicMz
## 2                0
## 24               0
## 46               0
## 68               0
## 90               0
## 112              0
```

The delta between consecutive scans is always 22 scans (one PRM cycle) and the `depedencyType` of the MS2 scans is `NA` (since it was triggered by an inclusion list).

For regression, we now extract the RTs at the maximum of the fitted intensity traces stored in the `rawrrChromatogram` object and fit a linear model of the form \(rt = a + b \cdot score\). In theory, we could do this at the precursor or fragment ion level. For simplicity, we show only the first option.

```
par(mfrow = c(3, 4), mar=c(4,4,4,1))
rtFittedAPEX <- C |>
  rawrr:::pickPeak.rawrrChromatogram() |>
  rawrr:::fitPeak.rawrrChromatogram() |>
  lapply(function(x){
    plot(x$times, x$intensities, type='p',
         ylim=range(c(x$intensities,x$yp)),
         main=x$mass); lines(x$xx, x$yp,
                             col='red'); x}) |>
  sapply(function(x){x$xx[which.max(x$yp)[1]]})

## a simple alternative to derive rtFittedAPEX could be
rt <- sapply(C, function(x) x$times[which.max(x$intensities)[1]])
```

![The plots show the fitted peak curves in red.](data:image/png;base64...)

Figure 7: The plots show the fitted peak curves in red

```
iRTscore <- c(-24.92, 19.79, 70.52, 87.23, 0, 28.71, 12.39, 33.38, 42.26, 54.62, 100)
fit <- lm(rtFittedAPEX ~ iRTscore)
```

The fitted model can then be inspected using standard procedures. Figure 6, shows a visual inspection by plotting observed RTs as a function of iRT score together with the fitted model regression line. The corresponding R-squared indicates that the RTs behave highly linear. This is expected since the iRT peptides were separated on a 20 min linear gradient from 5% buffer B to 35% buffer B using C18 reversed-phase material (the change rate is therefore constant at 1.5% per minute). The magnitude of the slope parameter (b) is a direct equivalent of this gradient change rate. The intercept (a) is equal to the predicted RT of iRT peptide `GAGSSEPVTGLDAK` since it was defined to have a zero score on the iRT scale.

![iRT regression. Plot shows observed peptide RTs as a function of iRT scores and fitted regression line of corresponding linear model obtained by ordinary least squares (OLS) regression.](data:image/png;base64...)

Figure 8: iRT regression
Plot shows observed peptide RTs as a function of iRT scores and fitted regression line of corresponding linear model obtained by ordinary least squares (OLS) regression.

## 3.3 Extension

An extended and dynamic version of the above use cases can be found at (<https://fgcz-ms.uzh.ch/~cpanse/rawrr/test/functional_test.html>). The web page displays spectra and iRT regression models obtained over a set of raw files recorded approximately every 12 hours on different Orbitrap mass spectrometers at the FGCZ (some systems have gone out of service in the meantime). The original purpose of these injections is automated longitudinal system suitability monitoring and quality control. We re-use the resulting raw files to showcase *[rawrr](https://bioconductor.org/packages/3.22/rawrr)*’s functionality across different Orbitrap instrument models/generations. In order to find the highest-scoring MS2 scan for iRT peptides we now use a simple scoring function implemented in `R` (it counts the number of matching y-ions), instead of running an external search engine. The web page automatically updates every 30 minutes using the most recent two files per system as input data. Be aware that the code is executed in a full parallel fashion (each core processes one raw file) on a Linux server with network-attached storage.

The R script that renders the html page is also available as supplementary information. The correspoding [R markdown file](https://github.com/fgcz/rawrr/blob/master/vignettes/JPR_supplement.Rmd) is part of the *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* package and can be processed locally after downloading a snapshot of the above described input data from [MSV000086542](https://massive.ucsd.edu/ProteoSAFe/dataset.jsp?accession=MSV000086542) (Kockmann [2020](#ref-MSV000086542)). In summary, this shows how scalable analysis pipelines can be constructed starting from basic building blocks. It demonstrates that *[rawrr](https://bioconductor.org/packages/3.22/rawrr)*’s data access mechanism works for all types of Orbitrap instrument models.

## 3.4 Benchmark

```
set.seed(1)
seq(1, 4) |>
    lapply(FUN=function(x){rawrr::sampleFilePath() |>
        rawrr:::.benchmark()}) |>
    Reduce(f = rbind) -> S

boxplot(count / runTimeInSec ~ count,
  data = S,
  log ='y',
  sub = paste0("Overall runtime took ",
    round(sum(S$runTimeInSec), 3), " seconds."),
  xlab = 'number of random generated scan ids')
legend("topleft",  c(Sys.info()['nodename'], Sys.info()['sysname']), cex = 1)
```

![`rawrr:::.benchmark using rawrr::readSpectrum` spectra per second.](data:image/png;base64...)

Figure 9: `rawrr:::.benchmark using rawrr::readSpectrum` spectra per second

# 4 Conclusions

Our R package *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* provides direct access to spectral data stored in Thermo Fisher Scientific raw-formatted binary files, thereby eliminating the need for unfavorable conversion to exchange formats. Within the `R` environment, spectral data is presented by using only two non-standard objects representing data items well known to analytical scientists (mass spectrum and mass chromatogram). This design choice makes data handling relatively easy and intuitive and requires little knowledge about internal/technical details of the implementation. By using vendor API methods whenever possible, we nevertheless made sure that ease-of-use does not impair performance. We also emphasize that our implementation aligns well with common `R` conventions and styles.
Soon, we plan to align further efforts with the R for Mass Spectrometry initiative. We hope to extend *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* towards the concept of exchangeable *[Spectra](https://bioconductor.org/packages/3.22/Spectra)* backends, in particular, the *[MsBackendRawFileReader](https://bioconductor.org/packages/3.22/MsBackendRawFileReader)*, for data access and parallel computation. These would be necessary next steps towards big computational proteomics in `R`.

# 5 Acknowledgements

We thank Lilly van de Venn for designing the *[rawrr](https://bioconductor.org/packages/3.22/rawrr)* package logo. We are grateful to Jim Shofstahl (Thermo Fisher Scientific) for providing the `RawFileReader` .NET assembly, `C#` example code, and for answering questions during the development process of *[rawrr](https://bioconductor.org/packages/3.22/rawrr)*. We are grateful to Antje Dittmann for carefully reading our manuscript and suggesting corrections and improvements. TK would like to thank Hadley Wickham for his inspiring books on advanced `R` and package development, especially for keeping those freely accessible.
The package authors thank Hervé Pagès for very detailed and constructive feedback during the Bioconductor package review process.

# 6 Abbreviations

|  |  |
| --- | --- |
| API | application programming interface |
| BSA | Bovine Serum Albumin |
| CIL | C Intermediate Language |
| FTMS | Fourier-transformed mass spectrum |
| GUI | graphics user interface |
| HRAM | high-resolution accurate mass |
| iRT | indexed retention time |
| LC-MS | liquid chromatography followed by mass spectrometry |
| OOP | object-oriented programming |
| MS | mass spectrometry |
| NSI | nanospray ionization |
| PRM | parallel reaction monitoring |
| TIC | total ion chromatogram |
| USI | Universal spectrum identifier |
| XIC | extracted ion chromatogram |

# 7 FAQ

## 7.1 How to pronounce the package name the right way?

see <https://youtu.be/jBc2MniDBYw>

## 7.2 What would be the simplest way of extracting the base peak intensity and m/z value for a large batch of files at the MS1 level?

```
# use sample.raw file
f <- rawrr::sampleFilePath()
(rawrr::readIndex(f) |>
  subset(MSOrder == "Ms"))$scan |>
  sapply(FUN = rawrr::readSpectrum, rawfile=f) |>
  parallel::mclapply(FUN = function(x){
    idx <- x$intensity == max(x$intensity);
    data.frame(scan=x$scan,
               StartTime=x$StartTime,
               mZ=x$mZ[idx],
               intensity=x$intensity[idx]
               )}) |>
  base::Reduce(f=rbind)
```

```
##    scan   StartTime       mZ intensity
## 1     1 0.001619751 445.1181   5979308
## 2    23 0.031642766 445.1180   5902284
## 3    45 0.061663615 445.1182   5630335
## 4    67 0.091651065 445.1182   5857274
## 5    89 0.121640750 391.2826   5366674
## 6   111 0.151644970 445.1181   5926550
## 7   133 0.181667770 445.1182   5840996
## 8   155 0.211526280 445.1182   5989230
## 9   177 0.241284530 391.2826  16794288
## 10  199 0.271307600 445.1182   5756987
## 11  221 0.301222200 391.2826   6351876
## 12  243 0.331145000 445.1184   5810201
## 13  265 0.361147270 445.1184   5687840
## 14  287 0.391168050 445.1183   6016346
## 15  309 0.421057700 391.2827   7898428
## 16  331 0.450970250 445.1183   6577130
## 17  353 0.481045180 391.2826   6162342
## 18  375 0.510989030 391.2827   6502305
## 19  397 0.540955750 445.1182   5700832
## 20  419 0.570893130 391.2826   7186618
## 21  441 0.600724580 391.2825   6955724
## 22  463 0.630620300 445.1183   6123972
## 23  485 0.660428770 391.2827  16238321
## 24  507 0.690318400 391.2827   6862950
## 25  529 0.720320350 391.2826   5815317
## 26  551 0.750197620 445.1183   5746604
## 27  573 0.780105920 391.2824   7327204
```

## 7.3 mZ and intensity vectors have different lengths. What shall I do?

On Windows, the decimal symbol has to be configured as a ‘.’!
See also [#fgcz/rawDiag/issues/33](https://github.com/fgcz/rawDiag/issues/33).

## 7.4 Howto write the `rawrr::readFileHeader()` output into json file?

```
#R
.rawrrHeaderJson <- function(inputRawFile,
                             outputJsonFile = tempfile(fileext = ".json")){
  inputRawFile |>
  rawrr::readFileHeader() |>
    rjson::toJSON(indent = 1) |>
    cat(file = outputJsonFile)
}
```

# System and session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] tartare_1.23.0      ExperimentHub_3.0.0 AnnotationHub_4.0.0
## [4] BiocFileCache_3.0.0 dbplyr_2.5.1        BiocGenerics_0.56.0
## [7] generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.53            bslib_0.9.0
##  [4] httr2_1.2.1          Biobase_2.70.0       vctrs_0.6.5
##  [7] tools_4.5.1          parallel_4.5.1       stats4_4.5.1
## [10] curl_7.0.0           tibble_3.3.0         AnnotationDbi_1.72.0
## [13] RSQLite_2.4.3        rawrr_1.18.0         blob_1.2.4
## [16] pkgconfig_2.0.3      S4Vectors_0.48.0     lifecycle_1.0.4
## [19] compiler_4.5.1       Biostrings_2.78.0    tinytex_0.57
## [22] Seqinfo_1.0.0        codetools_0.2-20     htmltools_0.5.8.1
## [25] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
## [28] crayon_1.5.3         jquerylib_0.1.4      cachem_1.1.0
## [31] magick_2.9.0         tidyselect_1.2.1     digest_0.6.37
## [34] dplyr_1.1.4          purrr_1.1.0          bookdown_0.45
## [37] BiocVersion_3.22.0   fastmap_1.2.0        cli_3.6.5
## [40] magrittr_2.0.4       withr_3.0.2          filelock_1.0.3
## [43] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [46] XVector_0.50.0       httr_1.4.7           protViz_0.7.9
## [49] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [52] evaluate_1.0.5       knitr_1.50           IRanges_2.44.0
## [55] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
## [58] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [61] R6_2.6.1
```

# .NET information

```
dotnet --info
```

```
##
## Host:
##   Version:      9.0.8
##   Architecture: x64
##   Commit:       a1e39f97e5
##   RID:          ubuntu.24.04-x64
##
## .NET SDKs installed:
##   No SDKs were found.
##
## .NET runtimes installed:
##   Microsoft.AspNetCore.App 9.0.8 [/usr/lib/dotnet/shared/Microsoft.AspNetCore.App]
##   Microsoft.NETCore.App 9.0.8 [/usr/lib/dotnet/shared/Microsoft.NETCore.App]
##
## Other architectures found:
##   None
##
## Environment variables:
##   Not set
##
## global.json file:
##   Not found
##
## Learn more:
##   https://aka.ms/dotnet/info
##
## Download .NET:
##   https://aka.ms/dotnet/download
```

```
dotnet nuget list source
```

```
## The command could not be loaded, possibly because:
##   * You intended to execute a .NET application:
##       The application 'nuget' does not exist.
##   * You intended to execute a .NET SDK command:
##       No .NET SDKs were found.
##
## Download a .NET SDK:
## https://aka.ms/dotnet/download
##
## Learn about SDK resolution:
## https://aka.ms/dotnet/sdk-not-found
```

prints the `rawrr` assembly path

```
rawrr:::.rawrrAssembly()
```

```
## [1] "/home/biocbuild/.cache/R/rawrr/rawrrassembly/linux-x64/rawrr"
```

prints the `rawrr` assembly version

```
rawrr:::.getRawrrAssemblyVersion
```

```
## function ()
## {
##     system2(.rawrrAssembly(), args = c("version"), stdout = TRUE)
## }
## <bytecode: 0x648cc66d04e8>
## <environment: namespace:rawrr>
```

```
rawrr:::.getRawrrAssemblyVersion()
```

```
## [1] "1.17.2"
```

# References

Becker, Richard A., John M. Chambers, and Allan R. Wilks. 1988. *The New S Language*. London: Chapman & Hall.

Chambers, Matthew C, Brendan Maclean, Robert Burke, Dario Amodei, Daniel L Ruderman, Steffen Neumann, Laurent Gatto, et al. 2012. “A Cross-Platform Toolkit for Mass Spectrometry and Proteomics.” *Nature Biotechnology* 30 (10): 918–20. <https://doi.org/10.1038/nbt.2377>.

Choi, Meena, Ching-Yun Chang, Timothy Clough, Daniel Broudy, Trevor Killeen, Brendan MacLean, and Olga Vitek. 2014. “MSstats: An R Package for Statistical Analysis of Quantitative Mass Spectrometry-Based Proteomic Experiments.” *Bioinformatics* 30 (17): 2524–6. <https://doi.org/10.1093/bioinformatics/btu305>.

Cox, Jürgen, and Matthias Mann. 2008. “MaxQuant Enables High Peptide Identification Rates, Individualized P.p.b.-range Mass Accuracies and Proteome-Wide Protein Quantification.” *Nature Biotechnology* 26 (12): 1367–72. <https://doi.org/10.1038/nbt.1511>.

Deutsch, Eric W., Yasset Perez-Riverol, Jeremy Carver, Shin Kawano, Luis Mendoza, Tim Van Den Bossche, Ralf Gabriels, et al. 2020. “Universal Spectrum Identifier for Mass Spectra.” *bioRxiv*. <https://doi.org/10.1101/2020.12.07.415539>.

Escher, Claudia, Lukas Reiter, Brendan MacLean, Reto Ossola, Franz Herzog, John Chilton, Michael J. MacCoss, and Oliver Rinner. 2012. “Using iRT, a Normalized Retention Time for More Targeted Measurement of Peptides.” *PROTEOMICS* 12 (8): 1111–21. <https://doi.org/10.1002/pmic.201100463>.

Gallien, Sebastien, Elodie Duriez, Catharina Crone, Markus Kellmann, Thomas Moehring, and Bruno Domon. 2012. “Targeted Proteomic Quantification on Quadrupole-Orbitrap Mass Spectrometer.” *Molecular & Cellular Proteomics* 11 (12): 1709–23. <https://doi.org/10.1074/mcp.o112.019802>.

Gatto, Laurent, and Kathryn S. Lilley. 2011. “MSnbase-an R/Bioconductor Package for Isobaric Tagged Mass Spectrometry Data Visualization, Processing and Quantitation.” *Bioinformatics* 28 (2): 288–89. <https://doi.org/10.1093/bioinformatics/btr645>.

Gehrig, Peter M., Kathrin Nowak, Christian Panse, Mario Leutert, Jonas Grossmann, Ralph Schlapbach, and Michael O. Hottiger. 2020. “Gas-Phase Fragmentation of ADP-Ribosylated Peptides: Arginine-Specific Side-Chain Losses and Their Implication in Database Searches.” *Journal of the American Society for Mass Spectrometry*, November. <https://doi.org/10.1021/jasms.0c00040>.

Goeminne, Ludger J. E., Kris Gevaert, and Lieven Clement. 2015. “Peptide-Level Robust Ridge Regression Improves Estimation, Sensitivity, and Specificity in Data-Dependent Quantitative Label-Free Shotgun Proteomics.” *Molecular & Cellular Proteomics* 15 (2): 657–68. <https://doi.org/10.1074/mcp.m115.055897>.

Goloborodko, Anton A., Lev I. Levitsky, Mark V. Ivanov, and Mikhail V. Gorshkov. 2013. “Pyteomicsa Python Framework for Exploratory Data Analysis and Rapid Software Prototyping in Proteomics.” *Journal of the American Society for Mass Spectrometry* 24 (2): 301–4. <https://doi.org/10.1007/s13361-012-0516-6>.

Huber, Wolfgang, Vincent J Carey, Robert Gentleman, Simon Anders, Marc Carlson, Benilton S Carvalho, Hector Corrada Bravo, et al. 2015. “Orchestrating High-Throughput Genomic Analysis with Bioconductor.” *Nature Methods* 12 (2): 115–21. <https://doi.org/10.1038/nmeth.3252>.

Hulstaert, Niels, Jim Shofstahl, Timo Sachsenberg, Mathias Walzer, Harald Barsnes, Lennart Martens, and Yasset Perez-Riverol. 2019. “ThermoRawFileParser: Modular, Scalable, and Cross-Platform RAW File Conversion.” *Journal of Proteome Research* 19 (1): 537–42. <https://doi.org/10.1021/acs.jproteome.9b00328>.

Kelstrup, Christian D., Rosa R. Jersie-Christensen, Tanveer S. Batth, Tabiwang N. Arrey, Andreas Kuehn, Markus Kellmann, and Jesper V. Olsen. 2014. “Rapid and Deep Proteomes by Faster Sequencing on a Benchtop Quadrupole Ultra-High-Field Orbitrap Mass Spectrometer.” *Journal of Proteome Research* 13 (12): 6187–95. <https://doi.org/10.1021/pr500985w>.

Kockmann, Tobias. 2020. “MassIVE Msv000086542 - Automated Quality Control Sample 1 (autoQC01) Analyzed Across Different Thermo Scientific Mass Spectrometers.” MassIVE. 2020. <https://doi.org/10.25345/C5MZ14>.

Kockmann, Tobias, and Christian Panse. 2021. “The rawrr R Package: Direct Access to Orbitrap Data and Beyond.” *Journal of Proteome Research*. <https://doi.org/10.1021/acs.jproteome.0c00866>.

MacLean, Brendan, Daniela M. Tomazela, Nicholas Shulman, Matthew Chambers, Gregory L. Finney, Barbara Frewen, Randall Kern, David L. Tabb, Daniel C. Liebler, and Michael J. MacCoss. 2010. “Skyline: An Open Source Document Editor for Creating and Analyzing Targeted Proteomics Experiments.” *Bioinformatics* 26 (7): 966–68. <https://doi.org/10.1093/bioinformatics/btq054>.

Makarov, Alexander. 2000. “Electrostatic Axially Harmonic Orbital Trapping:  a High-Performance Technique of Mass Analysis.” *Analytical Chemistry* 72 (6): 1156–62. <https://doi.org/10.1021/ac991131p>.

Microsoft. 2024.“NET | Build. Test. Deploy.” 2024. <https://dotnet.microsoft.com/en-us/>.

Panse, Christian, and Jonas Grossmann. 2020. “ProtViz: Visualizing and Analyzing Mass Spectrometry Related Data in Proteomics.” Zurich, Switzerland. 2020. [https://CRAN.R-project.org/package=protViz](https://CRAN.R-project.org/package%3DprotViz).

Panse, Christian, and Tobias Kockmann. 2019. “Tartare.” Bioconductor. 2019. <https://doi.org/10.18129/B9.BIOC.TARTARE>.

Panse, Christian, Seema Sharma, Romain Huguet, Dennis Vughs, Jonas Grossmann, and Andrea Mizzi Brunner. 2020. “Ultraviolet Photodissociation for Non-Target Screening-Based Identification of Organic Micro-Pollutants in Water Samples.” *Molecules* 25 (18): 4189. <https://doi.org/10.3390/molecules25184189>.

Röst, Hannes L, Timo Sachsenberg, Stephan Aiche, Chris Bielow, Hendrik Weisser, Fabian Aicheler, Sandro Andreotti, et al. 2016. “OpenMS: A Flexible Open-Source Software Platform for Mass Spectrometry Data Analysis.” *Nature Methods* 13 (9): 741–48. <https://doi.org/10.1038/nmeth.3959>.

Shofstahl, Jim. 2015. “Reading Files Using C# File Reader.” 2015. <https://github.com/thermofisherlsms/RawFileReader>.