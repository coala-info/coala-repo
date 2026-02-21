# *CardinalIO*: Parsing and writing imzML files

Kylie Ariel Bemis

#### Revised: August 12, 2023

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Structure of imzML files](#structure-of-imzml-files)
  + [3.1 XML](#xml)
  + [3.2 Binary](#binary)
  + [3.3 Continuous](#continuous)
  + [3.4 Processed](#processed)
  + [3.5 Additional notes](#additional-notes)
* [4 Parsing imzML files](#parsing-imzml-files)
  + [4.1 Experimental metadata](#experimental-metadata)
    - [4.1.1 File description](#file-description)
    - [4.1.2 Scan settings](#scan-settings)
    - [4.1.3 Software](#software)
    - [4.1.4 Instrument configuration](#instrument-configuration)
    - [4.1.5 Data processing](#data-processing)
  + [4.2 Spectrum metadata](#spectrum-metadata)
    - [4.2.1 Positions](#positions)
    - [4.2.2 m/z metadata](#mz-metadata)
    - [4.2.3 Intensity metadata](#intensity-metadata)
  + [4.3 Mass spectra](#mass-spectra)
* [5 Tracking experimental metadata](#tracking-experimental-metadata)
  + [5.1 The `ImzMeta` class](#the-imzmeta-class)
  + [5.2 Conversion between `ImzML` and `ImzMeta`](#conversion-between-imzml-and-imzmeta)
  + [5.3 Minimum reporting guidelines](#minimum-reporting-guidelines)
* [6 Writing imzML files](#writing-imzml-files)
  + [6.1 Writing a file from `ImzML` metadata](#writing-a-file-from-imzml-metadata)
  + [6.2 Writing a file from `ImzMeta` metadata](#writing-a-file-from-imzmeta-metadata)
* [7 Session information](#session-information)

# 1 Introduction

*CardinalIO* provides fast and efficient parsing and writing of imzML files for storage of mass spectrometry (MS) imaging experiments. It is intended to take over all file importing and exporting duties for the *Cardinal* package for MS imaging data analysis. Only the most basic methods are provided here. Support for higher-level objects (e.g., `MSImagingExperiment` from *Cardinal*) should provided in their respective packages.

The **imzML** format is an open standard for long-term storage of MS imaging experimental data. Each MS imaging dataset is composed of two files: **(1) an XML metadata file ending in “.imzML”** that contains experimental metadata and **(2) a binary data file ending in “.ibd”** that contains the actual m/z and intensity arrays. The files are linked by a UUID. ***Both files must be present to successfully import an MS imaging dataset.***

The imzML specification is described in detail [here](https://ms-imaging.org/imzml/) along with example data files (two of which are included in this package). Software tools for converting vendor formats to imzML can be found [here](https://ms-imaging.org/imzml/software-tools/). A Java-based imzML validator is available [here](https://gitlab.com/imzML/imzMLValidator/-/wikis/latest). A web-based imzML validator is available [here](https://imzml.github.io).

# 2 Installation

*CardinalIO* can be installed via the *BiocManager* package.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("CardinalIO")
```

The same function can be used to update *CardinalIO* and other Bioconductor packages.

Once installed, *CardinalIO* can be loaded with `library()`:

```
library(CardinalIO)
```

```
## Loading required package: BiocParallel
```

```
## Loading required package: matter
```

```
## Loading required package: Matrix
```

```
## Loading required package: ontologyIndex
```

# 3 Structure of imzML files

Valid imzML datasets are composed of two files (“.imzML” and “.ibd”) and come in two types: “continuous” and “processed”.

## 3.1 XML

The XML (“.imzML”) file contains only human-readable experimental metadata in a structured plain text format using a controlled vocabulary. It can include many experimental details including sample preparation, instrument configuration, scan settings, etc. Note that a imzML file is also a valid mzML file, with additional requirements and constraints to accomodate the imaging modality.

## 3.2 Binary

The binary data (“.ibd”) file contains the binary m/z and intensity arrays. The structure of these files is defined by metadata in the XML file. Two arrangements of the internal binary data arrays are possible depending on the type of imzML file (“continuous” or “processed”).

![](data:image/png;base64...)

A visualization of the imzML format as described below

## 3.3 Continuous

For “continuous” imzML files, all mass spectra share the same m/z values. Therefore, the m/z array is stored only once in the binary data file.

## 3.4 Processed

For “processed” imzML files, each mass spectrum has its own unique set of m/z values. Therefore, each m/z array is stored with its corresponding intensity array. This format is common for high mass resolution experiments where it would be prohibitive to store the complete profile spectrum, so the profile spectra are stored sparsely.

## 3.5 Additional notes

Note that *both* imzML types may contain *either* profile *or* centroided spectra. The spectrum representation should be specified in the imzML metadata file. Further note that despite the name, the “processed” type does *not* imply that any spectral processing has been performed beyond basic processing performed by the instrument.

# 4 Parsing imzML files

Parsing imzML files is performed with `parseImzML()`.

```
path <- exampleImzMLFile("continuous")
path
```

```
## [1] "/tmp/Rtmp25Tcvi/Rinst3786c720266420/CardinalIO/extdata/Example_Continuous_imzML1.1.1/Example_Continuous.imzML"
```

```
p <- parseImzML(path, ibd=TRUE)
p
```

```
## ImzML: /tmp/Rtmp25Tcvi/Rinst3786c720266420/CardinalIO/extdata/Example_Continuous_imzML1.1.1/Example_Continuous.imzML
##
## $fileDescription(3): fileContent sourceFileList contact
## $sampleList(1): sample1
## $scanSettingsList(1): scansettings1
## $softwareList(2): Xcalibur TMC
## $instrumentConfigurationList(1): LTQFTUltra0
## $dataProcessingList(2): XcaliburProcessing TMCConversion
## $run(1): spectrumList
## $ibd(3): uuid mz intensity
```

By default, only the “.imzML” metadata is parsed. Using `ibd=TRUE` will also attach the mass spectra (without loading them into memory).

The resulting `ImzML` object is like a list, and can be traversed in the same way using the standard `$`, `[` and `[[` operators.

## 4.1 Experimental metadata

The experimental metadata is stored in a recursive list structure that closely resembles the XML hierarchy.

### 4.1.1 File description

The `fileDescription` element contains basic information about the file’s contents and provenance.

```
p$fileDescription
```

```
## $fileContent
## Params list of length 5
##
##  MS:1000579  - MS1 spectrum
##  MS:1000128  - profile spectrum
##  IMS:1000080 - universally unique identifier = 554a27fa79d2...
##  IMS:1000091 - ibd SHA-1                     = a5be532d2599...
##  IMS:1000030 - continuous
##
## $sourceFileList
## $sourceFileList$sf1
## Params list of length 3
##                id          location              name
##               sf1 C:\\Users\\Tho...       Example.raw
##
##  MS:1000563 - Thermo RAW format
##  MS:1000768 - Thermo nativeID format
##  MS:1000569 - SHA-1                  = 7623BE263B25...
##
##
## $contact
## Params list of length 4
##
##  MS:1000586 - contact name        = Thorsten Sch...
##  MS:1000590 - contact affiliation = Institut für...
##  MS:1000587 - contact address     = Schubertstra...
##  MS:1000589 - contact email       = thorsten.sch...
```

For example, the cvParam tag below indicates that this imzML file has the “continuous” storage type.

```
p$fileDescription$fileContent[["IMS:1000030"]]
```

```
##            cv            id          name
##         "IMS" "IMS:1000030"  "continuous"
```

### 4.1.2 Scan settings

If available, the `scanSettingsList` element contains a list of scan settings that should include information about the image rastering.

```
p$scanSettingsList
```

```
## $scansettings1
## Params list of length 10
##              id
## scansettings...
##
##  IMS:1000401 - top down
##  IMS:1000413 - flyback
##  IMS:1000480 - horizontal line scan
##  IMS:1000491 - linescan left right
##  IMS:1000042 - max count of pixels x = 3
##  IMS:1000043 - max count of pixels y = 3
##  IMS:1000044 - max dimension x       = 300 micromet...
##  IMS:1000045 - max dimension y       = 300 micromet...
##  IMS:1000046 - pixel size (x)        = 100.0 microm...
##  IMS:1000047 - pixel size y          = 100.0 microm...
```

The “top down”, “flyback”, “horizontal line scan”, and “linescan left right” terms describe the raster pattern for how the spectra were acquired.

### 4.1.3 Software

The `softwareList` element contains information about any software that have been used with the data, including both software to control the acquisition of spectra and software to perform data processing.

```
p$softwareList
```

```
## $Xcalibur
## Params list of length 1
##       id  version
## Xcalibur      2.2
##
##  MS:1000532 - Xcalibur
##
## $TMC
## Params list of length 1
##       id  version
##      TMC 1.1 beta
##
##  MS:1000799 - custom unreleased software tool
```

### 4.1.4 Instrument configuration

The `instrumentConfigurationList` element contains information about the instrument(s) used to acquire the data.

```
p$instrumentConfigurationList
```

```
## $LTQFTUltra0
## Params list of length 4
##          id
## LTQFTUltra0
##
##  MS:1000557       - LTQ FT Ultra
##  MS:1000529       - instrument serial number = none
##  componentList(3) - ...
##  softwareRef      - Xcalibur
```

Each instrument configuration should include a component list that describes the ion source, mass analyzer, and detector type used.

```
p$instrumentConfigurationList$LTQFTUltra0$componentList
```

```
## $source
## Params list of length 11
## order
##     1
##
##  MS:1000073 - electrospray ionization
##  MS:1000485 - nanospray inlet
##  MS:1000844 - focus diameter x                       = 10.0
##  MS:1000845 - focus diameter y                       = 10.0
##  MS:1000846 - pulse energy                           = 10.0
##  MS:1000847 - pulse duration                         = 10.0
##  MS:1000848 - attenuation                            = 50.0
##  MS:1000850 - gas laser
##  MS:1000836 - dried droplet MALDI matrix preparation
##  MS:1000835 - matrix solution concentration          = 10.0
##  MS:1000834 - matrix solution                        = DHB
##
## $analyzer
## Params list of length 2
## order
##     2
##
##  MS:1000264 - ion trap
##  MS:1000014 - accuracy = 0.0 m/z
##
## $detector
## Params list of length 2
## order
##     3
##
##  MS:1000253 - electron multiplier
##  MS:1000120 - transient recorder
```

### 4.1.5 Data processing

The `dataProcessingList` element contains information about any data processing performed and a reference to the software used to do it.

```
p$dataProcessingList
```

```
## $XcaliburProcessing
## $XcaliburProcessing$Xcalibur
## Params list of length 1
## softwareRef       order
##    Xcalibur           1
##
##  MS:1000594 - low intensity data point removal
##
##
## $TMCConversion
## $TMCConversion$TMC
## Params list of length 1
## softwareRef       order
##         TMC           2
##
##  MS:1000544 - Conversion to mzML
```

## 4.2 Spectrum metadata

The spectrum metadata is the largest part of the imzML file, and therefore is not fully parsed. Many tags in this section are either repeated or unnecessary (and can be safely disregarded) or can be inferred from other tags.

Unlike the experimental metadata, the spectrum metadata are stored as data frames, with a row for each spectrum, rather than in a recursive structure like the original XML.

All data frames are stored in the `spectrumList` element inside the `run` element.

Specifically, data frames for `positions`, `mzArrays`, and `intensityArrays` are returned.

Note that no type coercion is performed for the parsed values (they are still strings), so numeric values must be coerced by the user.

### 4.2.1 Positions

```
p$run$spectrumList$positions
```

```
##        position x position y position z
## Scan=1          1          1       <NA>
## Scan=2          2          1       <NA>
## Scan=3          3          1       <NA>
## Scan=4          1          2       <NA>
## Scan=5          2          2       <NA>
## Scan=6          3          2       <NA>
## Scan=7          1          3       <NA>
## Scan=8          2          3       <NA>
## Scan=9          3          3       <NA>
```

The `positions` element gives the pixel x/y-coordinates for each spectrum. The z-coordinates are also available, but rarely used.

### 4.2.2 m/z metadata

```
p$run$spectrumList$mzArrays
```

```
##        external offset external array length external encoded length
## Scan=1              16                  8399                   33596
## Scan=2              16                  8399                   33596
## Scan=3              16                  8399                   33596
## Scan=4              16                  8399                   33596
## Scan=5              16                  8399                   33596
## Scan=6              16                  8399                   33596
## Scan=7              16                  8399                   33596
## Scan=8              16                  8399                   33596
## Scan=9              16                  8399                   33596
##        binary data type binary data compression type
## Scan=1     32-bit float               no compression
## Scan=2     32-bit float               no compression
## Scan=3     32-bit float               no compression
## Scan=4     32-bit float               no compression
## Scan=5     32-bit float               no compression
## Scan=6     32-bit float               no compression
## Scan=7     32-bit float               no compression
## Scan=8     32-bit float               no compression
## Scan=9     32-bit float               no compression
```

The `mzArrays` element gives information about the locations and storage format of the m/z arrays in the “.ibd” binary data file.

Note that for a “continuous” imzML file (like the one here), each of the rows actually points to the same m/z array. For a “processed” imzML file, each row would point to a different m/z array.

### 4.2.3 Intensity metadata

```
p$run$spectrumList$intensityArrays
```

```
##        external offset external array length external encoded length
## Scan=1           33612                  8399                   33596
## Scan=2           67208                  8399                   33596
## Scan=3          100804                  8399                   33596
## Scan=4          134400                  8399                   33596
## Scan=5          167996                  8399                   33596
## Scan=6          201592                  8399                   33596
## Scan=7          235188                  8399                   33596
## Scan=8          268784                  8399                   33596
## Scan=9          302380                  8399                   33596
##        binary data type binary data compression type
## Scan=1     32-bit float               no compression
## Scan=2     32-bit float               no compression
## Scan=3     32-bit float               no compression
## Scan=4     32-bit float               no compression
## Scan=5     32-bit float               no compression
## Scan=6     32-bit float               no compression
## Scan=7     32-bit float               no compression
## Scan=8     32-bit float               no compression
## Scan=9     32-bit float               no compression
```

The `intensityArrays` element gives information about the locations and storage format of the intensity arrays in the “.ibd” binary data file.

Note that for a “continuous” imzML file (like the one here), each of the binary data arrays has the same length. For a “processed” imzML file, each spectrum (and therefore the corresponding binary data arrays) could have a different length.

## 4.3 Mass spectra

If the option `ibd=TRUE` was used when parsing the imzML file, then the mass spectra data is attached (without loading the data into memory).

```
p$ibd$mz
```

```
## <9 length> matter_list :: out-of-core list
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=1 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=2 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=3 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=4 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=5 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=6 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
## ...
## (6.75 KB real | 0 bytes shared | 302.37 KB virtual)
```

```
p$ibd$intensity
```

```
## <9 length> matter_list :: out-of-core list
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=1   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=2   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=3   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=4   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=5   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=6   0   0   0   0   0   0 ...
## ...
## (6.75 KB real | 0 bytes shared | 302.37 KB virtual)
```

These out-of-memory lists can be subset like normal lists. They can alternatively be pulled fully into memory using `as.list()`.

```
mz1 <- p$ibd$mz[[1L]]
int1 <- p$ibd$intensity[[1L]]
plot(mz1, int1, type="l", xlab="m/z", ylab="Intensity")
```

![](data:image/png;base64...)

# 5 Tracking experimental metadata

The `ImzML` object should not generally be modified directly.

Instead, the `ImzMeta` class provides a simplified interface to the tags required for creating a valid imzML file.

## 5.1 The `ImzMeta` class

A new `ImzMeta` instance can be created with `ImzMeta()`:

```
e <- ImzMeta()
e
```

```
## ImzMeta: Mass spectrometry imaging experimental metadata
##
## $spectrumType(0):
## $spectrumRepresentation(0):
## $contactName(0):
## $contactAffiliation(0):
## $contactEmail(0):
## $instrumentModel(0):
## $ionSource(0):
## $analyzer(0):
## $detectorType(0):
## $dataProcessing(0):
## $lineScanSequence(0):
## $scanPattern(0):
## $scanType(0):
## $lineScanDirection(0):
## $pixelSize(0):
```

The tags can be assigned via the standard `$<-` and `[[<-` operators.

```
e$spectrumType <- "MS1 spectrum"
e$spectrumRepresentation <- "profile"
e
```

```
## ImzMeta: Mass spectrometry imaging experimental metadata
##
## $spectrumType(1): MS1 spectrum
## $spectrumRepresentation(1): profile spectrum
## $contactName(0):
## $contactAffiliation(0):
## $contactEmail(0):
## $instrumentModel(0):
## $ionSource(0):
## $analyzer(0):
## $detectorType(0):
## $dataProcessing(0):
## $lineScanSequence(0):
## $scanPattern(0):
## $scanType(0):
## $lineScanDirection(0):
## $pixelSize(0):
```

Note that the `"profile"` value was automatically expanded to `"profile spectrum"`. Assigning to an `ImzMeta` object will attempt to match your input the correct controlled vocabulary name, where appropriate.

Trying to assign a value that can’t be unambiguously matched to a valid controlled vocabulary name will yield an error message listing the allowed values.

```
e$spectrumType <- "spectrum"
```

```
## Error in validObject(x): invalid class "ImzMeta" object: spectrumType must be one of :'spectrum type', 'mass spectrum', 'PDA spectrum', 'electromagnetic radiation spectrum', 'emission spectrum', 'absorption spectrum', 'calibration spectrum', 'charge inversion mass spectrum', 'constant neutral gain spectrum', 'constant neutral loss spectrum', 'e/2 mass spectrum', 'precursor ion spectrum', 'product ion spectrum', 'MS1 spectrum', 'MSn spectrum', 'CRM spectrum', 'SIM spectrum', 'SRM spectrum', 'enhanced multiply charged spectrum', 'time-delayed fragmentation spectrum'
```

At a bare minimum, `spectrumType` and `spectrumRepresentation` must be present to create a valid imzML file (in combination with the mass spectra data and their raster positions). Other fields *should* be provided, but an imzML file can still be written without them.

## 5.2 Conversion between `ImzML` and `ImzMeta`

Conversion is supported between `ImzML` and `ImzMeta` objects.

Converting from `ImzMeta` to `ImzML` will keep all `ImzMeta` metadata. Sensible defaults will be assigned to required-but-missing elements.

```
p2 <- as(e, "ImzML")
p2
```

```
## ImzML:
##
## $fileDescription(1): fileContent
## $scanSettingsList(0):
## $softwareList(1): CardinalIO
## $instrumentConfigurationList(1): IC1
## $dataProcessingList(1): CardinalProcessing
## $run(0):
```

```
p2$fileDescription
```

```
## $fileContent
## Params list of length 2
##
##  MS:1000579 - MS1 spectrum
##  MS:1000128 - profile spectrum
```

Converting from `ImzML` to `ImzMeta` will lose any metadata that cannot be stored in the simplified `ImzMeta` object.

```
e2 <- as(p, "ImzMeta")
e2
```

```
## ImzMeta: Mass spectrometry imaging experimental metadata
##
## $spectrumType(1): MS1 spectrum
## $spectrumRepresentation(1): profile spectrum
## $contactName(1): Thorsten Schramm
## $contactAffiliation(1): Institut für Anorganische und Analytische Chemie
## $contactEmail(1): thorsten.schramm@anorg.chemie.uni-.giessen.de
## $instrumentModel(1): LTQ FT Ultra
## $ionSource(1): electrospray ionization
## $analyzer(1): ion trap
## $detectorType(1): electron multiplier
## $dataProcessing(0):
## $lineScanSequence(1): top down
## $scanPattern(1): flyback
## $scanType(1): horizontal line scan
## $lineScanDirection(1): linescan left right
## $pixelSize(1): 100.0
```

Support for additional tags may be added to `ImzMeta` in the future, but some metadata loss is unavoidable due to its simplified format.

As `ImzMeta` is most useful when constructing metadata from scratch, this should not pose a problem in practice.

## 5.3 Minimum reporting guidelines

Please note that `ImzMeta` does ***not*** meet minimum reporting guidelines for MS imaging experiments. Its primary purpose is to facilitate an easy interface for editing the required tags to create a valid imzML file.

For example, it does not currently support metadata for samples or sample preparation, as the `sampleList` tag is not strictly required by the imzML standard. Adding support for sample metadata would require additional ontologies that are currently outside of the scope of this package.

# 6 Writing imzML files

Writing imzML files is performed with `writeImzML()`. This is a generic function, so methods can be written to support new classes in other packages. *CardinalIO* provides methods for `ImzML` and `ImzMeta`.

## 6.1 Writing a file from `ImzML` metadata

In the simplest case, we can write a parsed imzML file back out.

```
p
```

```
## ImzML: /tmp/Rtmp25Tcvi/Rinst3786c720266420/CardinalIO/extdata/Example_Continuous_imzML1.1.1/Example_Continuous.imzML
##
## $fileDescription(3): fileContent sourceFileList contact
## $sampleList(1): sample1
## $scanSettingsList(1): scansettings1
## $softwareList(2): Xcalibur TMC
## $instrumentConfigurationList(1): LTQFTUltra0
## $dataProcessingList(2): XcaliburProcessing TMCConversion
## $run(1): spectrumList
## $ibd(3): uuid mz intensity
```

```
path2 <- tempfile(fileext=".imzML")
writeImzML(p, file=path2)
```

```
## [1] TRUE
## attr(,"outpath")
## [1] "/tmp/Rtmp2itCYS/file378c1f1b40d7cf.imzML"
```

In this case, only the “.imzML” file was written and not the “.ibd”, because we did not provide new mass spectra data, which will be demonstrated below.

## 6.2 Writing a file from `ImzMeta` metadata

Below, we demonstrate how to write a MS imaging dataset from scratch.

First, we create some simple simulated mass spectra.

```
set.seed(2023)
nx <- 3
ny <- 3
nmz <- 500
mz <- seq(500, 510, length.out=nmz)
intensity <- replicate(nx * ny, rlnorm(nmz))
positions <- expand.grid(x=seq_len(nx), y=seq_len(ny))
plot(mz, intensity[,1], type="l", xlab="m/z", ylab="Intensity")
```

![](data:image/png;base64...)

Next, we create some metadata.

```
meta <- ImzMeta(spectrumType="MS1 spectrum",
    spectrumRepresentation="profile",
    instrumentModel="LTQ FT Ultra",
    ionSource="electrospray ionization",
    analyzer="ion trap",
    detectorType="electron multiplier")
meta
```

```
## ImzMeta: Mass spectrometry imaging experimental metadata
##
## $spectrumType(1): MS1 spectrum
## $spectrumRepresentation(1): profile spectrum
## $contactName(0):
## $contactAffiliation(0):
## $contactEmail(0):
## $instrumentModel(1): LTQ FT Ultra
## $ionSource(1): electrospray ionization
## $analyzer(1): ion trap
## $detectorType(1): electron multiplier
## $dataProcessing(0):
## $lineScanSequence(0):
## $scanPattern(0):
## $scanType(0):
## $lineScanDirection(0):
## $pixelSize(0):
```

Now, we can write the file using `writeImzmL()`.

```
path3 <- tempfile(fileext=".imzML")
writeImzML(meta, file=path3, positions=positions, mz=mz, intensity=intensity)
```

```
## [1] TRUE
## attr(,"outpath")
## [1] "/tmp/Rtmp2itCYS/file378c1f5e41dbf9.imzML"
## [2] "/tmp/Rtmp2itCYS/file378c1f5e41dbf9.ibd"
## attr(,"outdata")
## List of length 3
## names(3): uuid mz intensity
```

# 7 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] CardinalIO_1.8.0    ontologyIndex_2.12  matter_2.12.0
## [4] Matrix_1.7-4        BiocParallel_1.44.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          magick_2.9.0
##  [4] rlang_1.1.6         xfun_0.53           ProtGenerics_1.42.0
##  [7] generics_0.1.4      jsonlite_2.0.0      S4Vectors_0.48.0
## [10] htmltools_0.5.8.1   tinytex_0.57        sass_0.4.10
## [13] stats4_4.5.1        rmarkdown_2.30      grid_4.5.1
## [16] evaluate_1.0.5      jquerylib_0.1.4     fastmap_1.2.0
## [19] yaml_2.3.10         lifecycle_1.0.4     bookdown_0.45
## [22] BiocManager_1.30.26 compiler_4.5.1      codetools_0.2-20
## [25] irlba_2.3.5.1       Rcpp_1.1.0          lattice_0.22-7
## [28] digest_0.6.37       R6_2.6.1            parallel_4.5.1
## [31] magrittr_2.0.4      bslib_0.9.0         tools_4.5.1
## [34] BiocGenerics_0.56.0 cachem_1.1.0
```