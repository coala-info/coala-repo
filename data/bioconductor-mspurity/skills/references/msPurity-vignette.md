# Using msPurity for Precursor Ion Purity Assessments, Data Processing and Metabolite Annotation of Mass Spectrometry Fragmentation Data

Thomas N. Lawson

#### 2025-10-30

# 1 Introduction

The msPurity R package was originally developed to assess the contribution of the targeted precursor in a fragmentation isolation window using a metric called “precursor ion purity”. See associated paper (Lawson et al. [2017](#ref-Lawson2017)).

A number of updates have been made since the original paper and the full functionality of msPurity now includes the following:

* Assess the contribution of the targeted precursor of acquired fragmentation spectra by checking isolation windows using a metric called “precursor ion purity” (Works for both LC-MS(/MS) and DIMS(/MS) data)
* Assess the anticipated precursor ion purity of XCMS LC-MS features and DIMS features where no fragmentation has been acquired
* Map fragmentation spectra to XCMS LC-MS features
* Filter and average MS/MS spectra from an LC-MS/MS dataset
* Create a spectral-database of LC-MS(/MS) data and associated annotations
* Perform spectral matching of query MS/MS spectra against library MS/MS spectra
* Export fragmentation spectra to MSP format
* Basic processing of DIMS data. Note that these functionalities are not actively developed anymore - see DIMSpy (<https://github.com/computational-metabolomics/dimspy>) for recommended alternative for DIMS data processing

What we call “Precursor ion purity” is a measure of the contribution of a selected precursor peak in an isolation window used for fragmentation. The simple calculation involves dividing the intensity of the selected precursor peak by the total intensity of the isolation window. When assessing MS/MS spectra this calculation is done before and after the MS/MS scan of interest and the purity is interpolated at the time of the MS/MS acquisition. The calculation is similar to the “Precursor Ion Fraction”" (PIF) metric described by (Michalski, Cox, and Mann [2011](#ref-Michalski2011)) for proteomics with the exception that purity here is interpolated at the recorded point of MS/MS acquisition using bordering full-scan spectra. Additionally, low abundance ions that are remove that are thought to have limited contribution to the resulting MS/MS spectra and the isolation efficiency of the mass spectrometer can be used to normalise the contributing ions.

There are 3 main classes used in msPurity

* **purityA**
  + Assessing precursor purity of previously acquired MS/MS spectra: A user has acquired either LC-MS/MS or DIMS/MS spectra and an assessment is made of the precursor purity for each MS/MS scan
  + Further processing of the purityA object include - fragmentation spectra filtering, averaging, MSP creation, spectral-database creation and spectral matching
* **purityX**
  + Assessing precursor purity of anticipated isolation windows for LC-MS/MS spectra. i.e. a user has acquired from an LC-MS full scan (MS1) data and an assessment is to be made of the precursor purity of detected features using anticipated or theoretical isolation windows. This information can then be used to guide further targeted MS/MS experiments.
* **purityD**
  + Assessing precursor purity of anticipated isolation windows for DIMS/MS spectra.
  + Also provides some basic functionality to process DIMS spectra

# 2 purityA

## 2.1 Assessing precursor purity of previously acquired MS/MS spectra

Given a vector of LC-MS/MS or DIMS/MS mzML file paths the precursor ion purity of each MS/MS scan can be calculated and stored in the purityA S4 class object where a dataframe of the purity results can be accessed using the appropriate slot (`pa@puritydf`).

The calculation involves dividing the intensity of the selected precursor peak by the total intensity of the isolation window and is performed before and after the MS/MS scan of interest and interpolated at the recorded time of the MS/MS acquisition. See below

![](data:image/jpeg;base64...)

Assessment of acquired MS/MS precursor ion purity for a standard DDA-based experiment (from figure 1 of Lawson et al 2017) )

Additionally, isotopic peaks can estimated and omitted from the calculation, low abundance peaks are removed that are thought to have limited contribution to the resulting MS/MS spectra and the isolation efficiency of the mass spectrometer can be used to normalise the intensities used for the calculation.

The purity dataframe (`pa@puritydf`) consists of the following columns:

* **pid**: unique id for MS/MS scan
* **fileid**: unique id for file
* **seqNum**: scan number
* **precursorIntensity**: precursor intensity value as defined from mzML file
* **precursorMZ**: precursor m/z value as defined from mzML file
* **precursorRT**: precursor RT value as defined from mzML file
* **precursorScanNum**: precursor scan number value as defined from mzML file
* **id**: unique id (redundant)
* **filename**: mzML filename
* **precursorNearest**: MS1 scan nearest to this MS/MS scan
* **aMz**: The m/z value in the precursorNearest scan which most closely matches the precursorMZ value provided from the mzML file
* **aPurity**: The purity score for **aMz**
* **apkNm**: The number of peaks in the isolation window for **aMz**
* **iMz**: The m/z value in the precursorNearest scan that is the most intense within the isolation window.
* **iPurity**: The purity score for **iMz**
* **ipkNm**: The number of peaks in the isolation window for **iMz**
* **inPurity**: The interpolated purity score
* **inpkNm**: The interpolated number of peaks in the isolation window

The remaining slots for purityA class include

* **cores**: The number of CPUs to be used for any further processing with this purityA object
* **fileList**: list of the files that have been processed
* **mzRback**: The backend library used by mzR to extract information from the mzML file (e.g. pwiz)
* **grped\_df**: If frag4feature has been performed, a dataframe of the grouped XCMS features linked to the associated fragmentation spectra precursor \* details is recorded here
* **grped\_MS/MS**: If frag4feature has been performed, a list of fragmentation spectra assoicated with each grouped XCMS feature is recorded here
* **f4f\_link\_type**: If frag4feature has been performed, the linking method is recorded here
* **av\_spectra**: if averageIntraFragSpectra, averageInterFragSpectra, or averageAllFragSpectra have been performed, the average spectra is recorded here
* **av\_intra\_params**: If averageIntraFragSpectra has been performed, the parameters are recorded here
* **av\_inter\_params**: if averageInterFragSpectra has been performed, the parameters are recorded here
* **av\_all\_params**: If averageAllFragSpectra has been performed, the parameters are recorded here
* **db\_path**: If create\_database has been performed, the resulting database path is recorded here

```
library(msPurity)
msPths <- list.files(system.file("extdata", "lcms", "mzML", package="msPurityData"), full.names = TRUE)
```

Note that if there are any mzML files that do not have MS/MS scans - then an ID is saved of the file but no assessments will be made.

```
pa <- purityA(msPths)
```

```
## only MS1 data
```

```
## No MS/MS spectra for file:  /home/biocbuild/bbs-3.22-bioc/R/site-library/msPurityData/extdata/lcms/mzML/LCMS_1.mzML
```

```
## only MS1 data
```

```
## No MS/MS spectra for file:  /home/biocbuild/bbs-3.22-bioc/R/site-library/msPurityData/extdata/lcms/mzML/LCMS_2.mzML
```

```
print(pa@puritydf[1:3,])
```

```
##   pid fileid seqNum acquisitionNum precursorIntensity precursorMZ precursorRT
## 1   1      1      7              7            2338044    391.2838    2.707016
## 2   2      1      8              8            1415940    149.0232    2.707016
## 3   3      1      9              9            1319700    135.1015    2.707016
##   precursorScanNum id      filename retentionTime precursorNearest      aMz
## 1                6  7 LCMSMS_1.mzML      2.977597                6 391.2838
## 2                6  8 LCMSMS_1.mzML      3.070549                6 149.0233
## 3                6  9 LCMSMS_1.mzML      3.163231                6 135.1015
##     aPurity apkNm      iMz   iPurity ipkNm inPkNm  inPurity
## 1 1.0000000     1 391.2838 1.0000000     1      1 1.0000000
## 2 0.8535700     2 149.0233 0.8535700     2      2 0.8475240
## 3 0.7616688     4 135.1015 0.7616688     4      4 0.7558731
```

## 2.2 Isolation efficiency

We define here “isolation efficiency”" as the effect of the position of an ion within an isolation window on its relative intensity in corresponding fragmentation spectra. When the isolation efficiency of an instrument is known, the peak intensities within an isolation window can be normalised for the precursor purity calculation. In the example in beloq, an R-Cosine isolation efficiency curve is used, the red peak (the targeted precursor ion peak) would not change following normalisation - as the contribution is at 1 (i.e. 100%) - however the the black peak (a contaminating ion) would be normalised by approximately 0.1 (i.e. 10%) and the normalised intensity would be calculated as 1000 (i.e. original intensity of 10000 x 0.1)

![](data:image/png;base64...)

isolation window example

The isolation efficiency can be estimated by looking at a single precursor with a sliding window - see below for an example demonstrating a sliding window around a target m/z of 200.

![](data:image/png;base64...)

sliding window example

A sliding window experiment has been performed to assess Thermo Fisher Q-Exactive Mass spectrometer using 0.5 Da windows and can be set within msPurity by using msPurity::iwNormQE.5() as the input to the iwNormFunc argument. See below:

![](data:image/jpeg;base64...)

Isolation efficiency of Thermo Fisher Q-Exactive Mass spectrometer using 0.5 Da windows (from figure 3 of Lawson et al 2017) )

Other available options are to use gaussian isolation window msPurity::iwNormGauss(minOff=-0.5, maxOff = 0.5) or a R-Cosine window msPurity::iwNormRCosine(minOff=-0.5, maxOff=0.5). Where the minOff and maxOff can be changed depending on the isolation window.

A user can also create their own normalisation function. The only requirement of the function is that given a value between the minOff and maxOff a normalisation value between 0-1 is returned.

See below for example of using one of the default provided normalisation functions.

```
pa_norm <- purityA(msPths[3], iwNorm=TRUE, iwNormFun=iwNormGauss(sdlim=3, minOff=-0.5, maxOff=0.5))
```

If the isolation efficiency of the instrument is not known, by default iwNorm is set to FALSE and no normalisation will occur.

## 2.3 frag4feature - mapping XCMS features to fragmentation spectra

First an xcmsSet object of the same files is required

```
##for xcms version 3+
suppressPackageStartupMessages(library(xcms))
suppressPackageStartupMessages(library(MSnbase))
suppressPackageStartupMessages(library(magrittr))

#read in data and subset to use data between 30 and 90 seconds and 100 and 200 m/z
msdata = MSnbase::readMSData(msPths, mode = 'onDisk', msLevel. = 1)
rtr = c(30, 90)
mzr = c(100, 200)
msdata = msdata %>%  MSnbase::filterRt(rt = rtr) %>%  MSnbase::filterMz(mz = mzr)

#perform feature detection in individual files
cwp <- CentWaveParam(snthresh = 3, noise = 100, ppm = 10, peakwidth = c(3, 30))
xcmsObj <- xcms::findChromPeaks(msdata, param = cwp)
#update metadata
#for(i in 1:length(msPths)){
#  xcmsObj@processingData@files[i] <- msPths[i]
#}

xcmsObj@phenoData@data$class = c('blank', 'blank', 'sample', 'sample')
xcmsObj@phenoData@varMetadata = data.frame('labelDescription' = c('sampleNames', 'class'))
#group chromatographic peaks across samples (correspondence analysis)
pdp <- PeakDensityParam(sampleGroups = xcmsObj@phenoData@data$class, minFraction = 0, bw = 5, binSize = 0.017)
xcmsObj <- groupChromPeaks(xcmsObj, param = pdp)
```

Then the MS/MS spectra can be assigned to an XCMS grouped feature using the `frag4feature` function.

```
pa <- frag4feature(pa = pa, xcmsObj = xcmsObj)
```

The slot `grped_df` is a dataframe of the grouped XCMS features linked to a reference to any associated MS/MS scans in the region of the full width of the XCMS feature in each file. The dataframe contains the following columns.

* **grpid**: XCMS grouped feature id
* **mz**: derived from XCMS peaklist
* **mzmin**: derived from XCMS peaklist
* **mzmax**: derived from XCMS peaklist
* **rt**: derived from XCMS peaklist
* **rtmin**: derived from XCMS peaklist
* **rtmax**: derived from XCMS peaklist
* **into**: derived from XCMS peaklist
* **intb**: derived from XCMS peaklist
* **maxo**: derived from XCMS peaklist
* **sn**: derived from XCMS peaklist
* **sample**: derived from XCMS peaklist
* **id**: unique id of MS/MS scan
* **precurMtchID**: Associated nearest precursor scan id (file specific)
* **precurMtchRT**: Associated precursor scan RT
* **precurMtchMZ**: Associated precursor *m/z*
* **precurMtchPPM**: Associated precursor *m/z* parts per million (ppm) tolerance to XCMS feauture *m/z*
* **inPurity**: The interpolated purity score

```
print(pa@grped_df[c(48,49),])
```

```
##    grpid       mz    mzmin    mzmax       rt    rtmin    rtmax      into
## 48   432 150.0582 150.0581 150.0582 63.07817 59.25115 66.86591 455365992
## 49   432 150.0581 150.0581 150.0582 62.15329 59.11391 66.71042 461585449
##         intb      maxo sn sample      filename cid rtminCorrected
## 48 398560857 110502712  6      1 LCMSMS_1.mzML 401             NA
## 49 405518401 111902200  6      2 LCMSMS_2.mzML 777             NA
##    rtmaxCorrected inPurity  pid precurMtchID precurMtchScan precurMtchRT
## 48             NA        1  366          445            444     62.30978
## 49             NA        1 1190          439            438     61.39704
##    precurMtchMZ precurMtchPPM retentionTime fileid seqNum
## 48     150.0581     0.1293991      62.58027      1    445
## 49     150.0582     0.1370548      61.66767      2    439
```

The slot `grped_MS2` is a list of the associated fragmentation spectra for the grouped features.

```
print(pa@grped_ms2[[18]])  # fragmentation associated with the first XCMS grouped feature (i.e. xcmsObj@groups[432,] for xcms versions < 3 and featureDefinitions(xcmsObj)[432,] for xcms v3+)
```

```
## [[1]]
##            mz   intensity
## [1,] 102.0554  4631614.50
## [2,] 104.0532 16147574.00
## [3,] 105.0009   196574.16
## [4,] 105.0372   273244.06
## [5,] 133.0318 10814390.00
## [6,] 137.4163    30549.83
## [7,] 150.0583  1973325.50
##
## [[2]]
##             mz   intensity
##  [1,] 101.5791    20766.21
##  [2,] 102.0554  4154222.25
##  [3,] 104.0533 13982832.00
##  [4,] 105.0010   131116.56
##  [5,] 105.0372   266003.91
##  [6,] 133.0319  9440187.00
##  [7,] 150.0387    92384.07
##  [8,] 150.0583  1694299.12
##  [9,] 155.0976    22783.27
```

## 2.4 filterFragSpectra - filter the fragmentation spectra

Flag and filter features based on signal-to-noise ratio, relative abundance, intensity threshold and precursor ion purity of the precursor.

```
pa <- filterFragSpectra(pa)
```

## 2.5 averageAllFragSpectra - average all fragmentation spectra

Average and filter fragmentation spectra for each XCMS feature within and across MS data files (ignoring intra and inter relationships).

```
pa <- averageAllFragSpectra(pa)
```

## 2.6 averageIntraFragSpectra - average all fragmentation spectra

Average and filter fragmentation spectra for each XCMS feature within a MS data file.

```
pa <- averageIntraFragSpectra(pa)
```

## 2.7 averageInterFragSpectra - average all fragmentation spectra

Average and filter fragmentation spectra for each XCMS feature across MS data files. This can only be run after averageIntraFragSpectra has been used.

```
pa <- averageInterFragSpectra(pa)
```

## 2.8 createMSP - create an MSP file of the fragmentation spectra

Create an MSP file for all the fragmentation spectra that has been linked to an XCMS feature via frag4feature. Can export all the associated scans individually or the averaged fragmentation spectra can be exported.

Additional metadata can be included in a dataframe (each column will be added to metadata of the MSP spectra). The dataframe must contain the column “grpid” corresponding to the XCMS grouped feature.

```
td <- tempdir()
createMSP(pa, msp_file_pth = file.path(td, 'out.msp'))
```

## 2.9 createDatabase - create a spectral database

A database can be made of the LC-MS/MS dataset - this can then be udpated with the spectral matching data (from spectralMatching function). The full schema of the database is found [here](https://bioconductor.org/packages/release/bioc/vignettes/msPurity/inst/doc/msPurity-spectral-database-vignette.html). This replaces the old schema used by the deprecated function spectral\_matching.

```
q_dbPth <- createDatabase(pa = pa, xcmsObj = xcmsObj, outDir = td, dbName = 'test-mspurity-vignette.sqlite')
```

## 2.10 spectralMatching - perfroming spectral matching to a spectral library

A query SQLite database can be matched against a library SQLite database with the spectralMatching function. The library spectral-database in most cases should contain the “known” spectra from either public or user generated resources. The library SQLite database by default contains data from MoNA including Massbank, HMDB, LipidBlast and GNPS. A larger database can be downloaded from [here](https://github.com/computational-metabolomics/msp2db/releases).

```
result <- spectralMatching(q_dbPth, q_xcmsGroups = c(432), cores=1, l_accessions=c('CCMSLIB00003740033'))
```

```
## Running msPurity spectral matching function for LC-MS(/MS) data
```

```
## Filter query dataset
```

```
## Filter library dataset
```

```
## aligning and matching
```

```
## Summarising LC feature annotations
```

# 3 purityX

## 3.1 Assessing anticipated purity of XCMS features from an LC-MS run

A processed xcmsSet object is required to determine the anticipated (predicted) precursor purity score from an LC-MS dataset. The offsets chosen in the parameters should reflect what settings would be used in a hypothetical fragmentation experiment.

![](data:image/jpeg;base64...)

Assessing precursor purity of anticipated isolation windows for two XCMS features derived from a MS/MS data set (from figure 2 of Lawson et al 2017) )

The slot `predictions` provides the anticipated (predicted) purity scores for each feature. The dataframe contains the following columns:

* **grpid**: XCMS grouped feature id
* **mean**: Mean predicted purity of the feature
* **median**: Median predicted purity of the feature
* **sd**: Standard deviation of the predicted purity of the feature
* **stde**: Standard error of the predicted purity of the feature
* **pknm**: Median peak number in isolation window
* **RSD**: Relative standard deviation of the predicted purity of the feature
* **i**: Median intensity of the grouped feature. Uses XCMS “into” intensity value.
* **mz**: *m/z* of the XCMS grouped feature

*XCMS run on an LC-MS dataset*

```
msPths <- list.files(system.file("extdata", "lcms", "mzML", package="msPurityData"), full.names = TRUE, pattern = "LCMS_")

## run xcms (version 3+)
# suppressPackageStartupMessages(library(xcms))
# suppressPackageStartupMessages(library(MSnbase))
# suppressPackageStartupMessages(library(magrittr))
#
# #read in data and subset to use data between 30 and 90 seconds and 100 and 200 m/z
# msdata = readMSData(msPths, mode = 'onDisk', msLevel. = 1)
# rtr = c(30, 90)
# mzr = c(100, 200)
# msdata = msdata %>%  MSnbase::filterRt(rt = rtr) %>%  MSnbase::filterMz(mz = mzr)
#
# #perform feature detection in individual files
# cwp <- CentWaveParam(snthresh = 3, noise = 100, ppm = 10, peakwidth = c(3, 30))
# xcmsObj <- xcms::findChromPeaks(msdata, param = cwp)
# #update metadata
# for(i in 1:length(msPths)){
#   xcmsObj@processingData@files[i] <- msPths[i]
# }
#
# xcmsObj@phenoData@data$class = c('sample', 'sample')
# xcmsObj@phenoData@varMetadata = data.frame('labelDescription' = c('sampleNames', 'class'))
# #group chromatographic peaks across samples (correspondence analysis)
# pdp <- PeakDensityParam(sampleGroups = xcmsObj@phenoData@data$class, minFraction = 0, bw = 5, binSize = 0.017)
# xcmsObj <- groupChromPeaks(xcmsObj, param = pdp)

## Or load an XCMS xcmsSet object saved earlier
xcmsObj <- readRDS(system.file("extdata", "tests", "xcms", "ms_only_xcmsnexp.rds", package="msPurity"))

## Make sure the file paths are correct
xcmsObj@processingData@files[1] = msPths[basename(msPths)=="LCMS_1.mzML"]
xcmsObj@processingData@files[2] = msPths[basename(msPths)=="LCMS_2.mzML"]
```

*Perform purity calculations*

```
px <- purityX(xset =  as(xcmsObj, 'xcmsSet'), cores = 1, xgroups = c(1, 2), ilim=0)
```

```
## Note: you might want to set/adjust the 'sampclass' of the returned xcmSet object before proceeding with the analysis.
```

# 4 purityD

## 4.1 Assessing anticipated purity from a DIMS run

The anticipated/predicted purity for a DIMS experiment can be performed on any DIMS dataset consisting of multiple MS1 scans of the same mass range, i.e. it has **not** been developed to be used with any SIM stitching approach.

A number of simple data processing steps are performed on the mzML files to provide a DIMS peak list (features) to perform the purity predictions on.

These data processing steps consist of:

* Averaging peaks across multiple scans
* Removing peaks below a signal to noise threshold [optional]
* Removing peaks less than an intensity threshold [optional]
* Removing peaks above a RSD threshold for intensity [optional]
* Where there is a blank, subtracting blank peaks [optional]

The averaged peaks before and after filtering are stored in the `avPeaks` slot of purityPD S4 object.

**Get file dataframe**:
The purityD constructor requires a dataframe consisting of the following columns:

* filepth
* name
* sampleType [either sample or blank]
* class [for grouping samples together]
* polarity [optional]

```
datapth <- system.file("extdata", "dims", "mzML", package="msPurityData")
inDF <- Getfiles(datapth, pattern=".mzML", check = FALSE)
ppDIMS <- purityD(inDF, mzML=TRUE)
```

**Average spectra**:
The default averaging will use a Hierarchical clustering approach. Noise filtering is also performed here.

```
ppDIMS <- averageSpectra(ppDIMS, snMeth = "median", snthr = 5)
```

**Filter by RSD and Intensity**

```
ppDIMS <- filterp(ppDIMS, thr=5000, rsd = 10)
```

**Subtract blank**
Be aware that the package `magrittr` can not be loaded when performing subtract.

```
detach("package:magrittr", unload=TRUE)
ppDIMS <- subtract(ppDIMS)
```

**Predict purity**

```
ppDIMS <- dimsPredictPurity(ppDIMS)

print(head(ppDIMS@avPeaks$processed$B02_Daph_TEST_pos))
```

```
##    peakID       mz          i        snr      rsd        inorm count total
## 5       5 173.0806 11272447.0 216.506319 9.006126 0.0108585920     5     4
## 7       7 179.1177   606983.2  11.425825 6.019861 0.0005729283     5     4
## 10     10 217.1067 17770220.0 343.292914 8.602331 0.0171178067     5     4
## 15     15 235.1173  4950841.5  95.991762 6.302825 0.0047694791     5     4
## 16     16 236.1206   486912.0   9.270517 8.811437 0.0004638254     5     4
## 17     17 239.1485  2533134.5  48.892062 5.781277 0.0024401334     5     4
##    medianPurity meanPurity   sdPurity cvPurity   sdePurity medianPeakNum
## 5     1.0000000  1.0000000 0.00000000 0.000000 0.000000000             1
## 7     1.0000000  1.0000000 0.00000000 0.000000 0.000000000             1
## 10    0.7797864  0.7808917 0.01261501 1.615462 0.005641605             2
## 15    1.0000000  1.0000000 0.00000000 0.000000 0.000000000             1
## 16    0.8818313  0.8755873 0.01056807 1.206969 0.004726184             2
## 17    0.8123950  0.8229505 0.04384595 5.327896 0.019608505             2
```

## 4.2 Calculating the anticipated (predicted) purity from a known *m/z* target list for DIMS

The data processing steps carried out through purityD can be bypassed if the peaks (*m/z* values) of interest are already known. The function `dimsPredictPuritySingle()` can be used to predict the purity of a list of *m/z* values in a chosen mzML file.

```
mzpth <- system.file("extdata", "dims", "mzML", "B02_Daph_TEST_pos.mzML", package="msPurityData")
predicted <- dimsPredictPuritySingle(filepth = mzpth, mztargets = c(111.0436, 113.1069))
print(predicted)
```

# References

Lawson, Thomas Nigel, Ralf J. M. Weber, Martin R. Jones, Andrew J. Chetwynd, Giovanny Alejandro Rodriguez Blanco, Riccardo Di Guida, Mark R. Viant, and Warwick B Dunn. 2017. “msPurity: Automated Evaluation of Precursor Ion Purity for Mass Spectrometry Based Fragmentation in Metabolomics.” *Analytical Chemistry*, acs.analchem.6b04358. <https://doi.org/10.1021/acs.analchem.6b04358>.

Michalski, Annette, Juergen Cox, and Matthias Mann. 2011. “More than 100,000 detectable peptide species elute in single shotgun proteomics runs but the majority is inaccessible to data-dependent LC-MS/MS.” *Journal of Proteome Research* 10 (4): 1785–93. <https://doi.org/10.1021/pr101060v>.