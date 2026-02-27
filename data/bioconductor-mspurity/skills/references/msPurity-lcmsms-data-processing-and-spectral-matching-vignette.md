# LC-MS/MS data processing and spectral matching workflow using msPurity and XCMS

Thomas N. Lawson

#### 2025-10-30

# 1 LC-MS/MS data processing and spectral matching workflow

## 1.1 Overview

The msPurity package can be used with XCMS as part of a data processing and annotation workflow for LC-MS/MS data

* Purity assessments
  + (mzML files) -> purityA -> (pa)
* XCMS processing
  + (mzML files) -> xcms.findChromPeaks -> (optionally) xcms.adjustRtime -> xcms.groupChromPeaks -> (xcmsObj)
  + — *Older versions of XCMS* — (mzML files) -> xcms.xcmsSet -> xcms.group -> xcms.retcor -> xcms.group -> (xcmsObj)
* Fragmentation processing
  + (xcmsObj, pa) -> frag4feature -> filterFragSpectra -> averageAllFragSpectra -> createDatabase -> spectralMatching -> (sqlite spectral database)

## 1.2 XCMS (versions < 3) processing workflow

We first need to run XCMS so that we can later link the spectral matching result back to XCMS feature.

(Please use the appropriate settings for your data)

```
library(msPurity)
library(xcms)
mzMLpths <- list.files(system.file("extdata", "lcms", "mzML", package="msPurityData"), full.names = TRUE)

#read in the data
xset = xcms::xcmsSet(mzMLpths, method = 'centWave', mslevel=1, snthresh = 3, noise = 100, ppm = 10, peakwidth = c(3, 30))

#for this example we will subset the data to focus on retention time range 30-90 seconds and scan range 100-200 m/z
xset@peaks = xset@peaks[xset@peaks[,4] >= 30 & xset@peaks[,4] <= 90,] #retention time filter
xset@peaks = xset@peaks[xset@peaks[,1] >= 100 & xset@peaks[,1] <= 200,] #m/z filter

#group features across samples
xset = xcms::group(xset, minfrac = 0, bw = 5, mzwid = 0.017)
xcmsObj = xset
```

## 1.3 XCMS (versions 3+) processing workflow

We first need to run XCMS so that we can later link the spectral matching result back to XCMS feature.

(Please use the appropriate settings for your data)

```
library(msPurity)
library(magrittr)
library(xcms)
library(MSnbase)
mzMLpths <- list.files(system.file("extdata", "lcms", "mzML", package="msPurityData"), full.names = TRUE)

#read in data and subset to use data between 30 and 90 seconds and 100 and 200 m/z
msdata = readMSData(mzMLpths, mode = 'onDisk', msLevel. = 1)
rtr = c(30, 90)
mzr = c(100, 200)
msdata = msdata %>%  MSnbase::filterRt(rt = rtr) %>%  MSnbase::filterMz(mz = mzr)

#perform feature detection in individual files
cwp <- CentWaveParam(snthresh = 3, noise = 100, ppm = 10, peakwidth = c(3, 30))
xcmsObj <- xcms::findChromPeaks(msdata, param = cwp)
#update metadata
xcmsObj@phenoData@data$class = c('blank', 'blank', 'sample', 'sample')
xcmsObj@phenoData@varMetadata = data.frame('labelDescription' = c('sampleNames', 'class'))
#group chromatographic peaks across samples (correspondence analysis)
pdp <- PeakDensityParam(sampleGroups = xcmsObj@phenoData@data$class, minFraction = 0, bw = 5, binSize = 0.017)
xcmsObj <- groupChromPeaks(xcmsObj, param = pdp)
```

## 1.4 Purity assesments and linking fragmentation to XCMS features

The `purityA` function is then called to calculate the precursor purity of the fragmentation results and the `frag4feature` function will link the
fragmentation data back to the XCMS feature.

```
pa  <- purityA(mzMLpths)
pa <- frag4feature(pa = pa, xcmsObj = xcmsObj)
```

## 1.5 Filtering and averaging

The fragmentation can be filtered prior to averaging using the “filterFragSpectra” function

```
pa <- filterFragSpectra(pa = pa)
```

Averaging of the fragmentation spectra can be done with either “averageAllFragSpectra” or with “averageIntraFragSpectra” and averageInterFragSpectra”. This will depend if the user wishes to treat the fragmentation spectra from within a file and between files. Another alternative is to ignore the averaging completely and just use the non-averaged fragmentation spectra for the spectral matching.

If the inter and intra fragmentation scans are to be treated differently the following should be followed:

```
pa <- averageIntraFragSpectra(pa = pa) # use parameters specific to intra spectra
pa <- averageInterFragSpectra(pa = pa) # use parameters specific to inter spectra
```

If the inter and intra fragmentation scans are to be treated the same the following workflow should be used.

```
pa <- averageAllFragSpectra(pa = pa)
```

## 1.6 Creating a spectral-database

An SQLite database is then created of the LC-MS/MS experiment. The SQLite schema of the spectral database can be detailed [here](https://bioconductor.org/packages/release/bioc/vignettes/msPurity/inst/doc/msPurity-spectral-database-vignette.html).

```
td <- tempdir()
q_dbPth <- createDatabase(pa = pa, xcmsObj = xcmsObj, outDir = td, dbName = 'lcmsms-processing.sqlite')
```

## 1.7 Spectral matching

The spectralMatching function allows users to perform spectral matching to be performed for **Query** SQLite spectral-database against a **Library** SQLite spectral-database.

The query spectral-database in most cases should contain be the “unknown” spectra database generated the msPurity function createDatabase as part of a msPurity-XCMS data processing workflow.

The library spectral-database in most cases should contain the “known” spectra from either public or user generated resources. The library SQLite database by default contains data from MoNA including Massbank, HMDB, LipidBlast and GNPS. A larger database can be downloaded from here. To create a user generated library SQLite database the following tool can be used to generate a SQLite database from a collection of MSP files: msp2db. It should be noted though, that as long as the schema of the spectral-database is as described here, then any database can be used for either the library or query - even allowing for the same database to be used.

The spectral matching functionality has four main components, **spectral filtering**, **spectral alignment**, **spectral matching** and finally summarising the results.

**Spectral filtering** is simply filtering both the library and query spectra to be search against (e.g. choosing the library source, instrument, retention time, precursor PPM tolerance, xcms features etc).

The **spectral alignment** stage involves aligning the query peaks to the library peaks. The approach used is similar to modified pMatch algorithm described in (Zhou et al. [2014](#ref-Zhou2014)).

The **spectral matching** of the aligned spectra is performed against a combined intensity and m/z weighted vector - created for both the query and library spectra (wq and wl). See below:

\[ \vec{w}=\vec{intensity}^x \cdot \vec{mz}^y\]

Where x and y represent weight factors, defaults to \(x=0.5\) and \(y=2\) as per MassBank recommendations for ESI based data (Horai, Arita, and Nishioka [2008](#ref-Horai2008)). These can be adjusted by the user though.

The aligned weighted vectors are then matched using dot product cosine, reverse dot product cosine and the composite dot product. See below for dot product cosine equation.

\[ F\_{dpc} = \frac{\sum \vec{w\_{Q} }\cdot \vec{w\_{L}}}{\sqrt{\sum \vec{w\_{Q}^{2}}} \cdot \sqrt{\sum \vec{w\_{L}^{2}}}} \]

The reverse dot product cosine (rpdc) uses the same algorithm as dpc but all peaks that do not match in the query spectra (based on the alignment) are omitted from the calculation. This will improve scores when the query spectra is noisy but should be used with caution as it might lead to more false positives.

The composite dot product cosine (cdpc) approach is also calculated - this approach is used in the NIST MS search tool and incorporates relative intensity of neighbouring peaks (see function \(F\_{rel}\) ), where \(N\)=number of peaks, \(Q\)=query, \(L\)=library, \(L\&Q\)= matching library and query peaks, \(w\) is the weighted value and \(n\) is either 1 (if the abundance ratio of the library, i.e. \(\frac{w\_{L,i}}{w\_{L,i-1}}\), is \(<\) than the abundance ratio of the query i.e. \(\frac{w\_{Q,i}}{w\_{Q,i-1}}\)) or -1 (if the abundance ratio of the library is \(>\) than the abundance ratio of the query). The approach was first described in (Stein and Scott [1994](#ref-stein1994optimization)).

\[ F\_{rel} = \Bigg( \frac{1}{N\_{L\&Q}-1} \Bigg) \cdot \sum\_{i=2}^{N\_{L\&Q}} \Bigg( \frac{w\_{L,i}}{w\_{L,i-1}} \Bigg)\_{}{^n} \cdot \Bigg( \frac{w\_{Q,i}}{w\_{Q,i-1}} \Bigg)\_{}{^{-n}}\]

\[ F\_{cpdc} = \frac{1000}{N\_{Q} + N\_{L\&Q}} \cdot (N\_{Q} \cdot F\_{dpc} + N\_{L\&Q} \cdot F\_{rel}) \]

The following example shows how to match one xcms group against library spectra filtered by their MoNA/MassBank accession id.

```
result <- spectralMatching(q_dbPth, q_xcmsGroups = c(432), l_accessions=c('CCMSLIB00003740033'))
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

```
print(result)
```

```
## $q_dbPth
## [1] "/tmp/Rtmp77Gkx8/lcmsms-processing.sqlite"
##
## $matchedResults
##    lpid qpid mid      dpc     rdpc      cdpc mcount allcount  mpercent
## 1 14082 1700   1 0.939585 0.939585 0.9007655      4       15 0.2666667
## 2 14082 1701   2 0.939585 0.939585 0.9007655      4       15 0.2666667
##   library_rt query_rt rtdiff library_precursor_mz query_precursor_mz
## 1       <NA> 59.83364     NA              150.058           150.0581
## 2       <NA> 59.83364     NA              150.058           150.0581
##   library_precursor_ion_purity query_precursor_ion_purity  library_accession
## 1                         <NA>                          1 CCMSLIB00003740033
## 2                         <NA>                          1 CCMSLIB00003740033
##   library_precursor_type library_entry_name                    inchikey
## 1                    M+H         Methionine FFEARJCKVFRZRR-UHFFFAOYSA-N
## 2                    M+H         Methionine FFEARJCKVFRZRR-UHFFFAOYSA-N
##   library_source_name library_compound_name
## 1                gnps            Methionine
## 2                gnps            Methionine
##
## $xcmsMatchedResults
##    pid grpid       mz   mzmin    mzmax       rt    rtmin    rtmax npeaks blank
## 1 1700   432 150.0581 150.058 150.0582 59.83364 57.10389 63.07817      4     2
## 2 1701   432 150.0581 150.058 150.0582 59.83364 57.10389 63.07817      4     2
##   sample              peakidx ms_level LCMSMS_1_mzML LCMSMS_2_mzML LCMS_1_mzML
## 1      2 401, 777, 1846, 2958        1     455365992     461585449   642676169
## 2      2 401, 777, 1846, 2958        1     455365992     461585449   642676169
##   LCMS_2_mzML grp_name  lpid mid      dpc     rdpc      cdpc mcount allcount
## 1   643826651   FT0432 14082   1 0.939585 0.939585 0.9007655      4       15
## 2   643826651   FT0432 14082   2 0.939585 0.939585 0.9007655      4       15
##    mpercent library_rt query_rt rtdiff library_precursor_mz query_precursor_mz
## 1 0.2666667       <NA> 59.83364     NA              150.058           150.0581
## 2 0.2666667       <NA> 59.83364     NA              150.058           150.0581
##   library_precursor_ion_purity query_precursor_ion_purity  library_accession
## 1                         <NA>                          1 CCMSLIB00003740033
## 2                         <NA>                          1 CCMSLIB00003740033
##   library_precursor_type library_entry_name                    inchikey
## 1                    M+H         Methionine FFEARJCKVFRZRR-UHFFFAOYSA-N
## 2                    M+H         Methionine FFEARJCKVFRZRR-UHFFFAOYSA-N
##   library_source_name library_compound_name
## 1                gnps            Methionine
## 2                gnps            Methionine
```

The output of spectralMatching returns a list containing the following elements:

**q\_dbPth**: Path of the query database (this will have been updated with the annotation results if updateDb argument used)

**xcmsMatchedResults**
If the qeury spectra had XCMS based chromotographic peaks tables (e.g c\_peak\_groups, c\_peaks) in the sqlite database - it will
be possible to summarise the matches for each XCMS grouped feature. The dataframe contains the following columns

* lpid - id in database of library spectra
* qpid - id in database of query spectra
* dpc - dot product cosine of the match
* rdpc - reverse dot product cosine of the match
* cdpc - composite dot product cosine of the match
* mcount - number of matching peaks
* allcount - total number of peaks across both query and library spectra
* mpercent - percentage of matching peaks across both query and library spectra
* library\_rt - retention time of library spectra
* query\_rt - retention time of query spectra
* rtdiff - difference between library and query retention time
* library\_precursor\_mz - library precursor mz
* query\_precursor\_mz - query precursor mz
* library\_precursor\_ion\_purity - library precursor ion purity
* query\_precursor\_ion\_purity - query precursor ion purity
* library\_accession - library accession value (unique string or number given to eith MoNA or Massbank data entires)
* library\_precursor\_type - library precursor type (i.e. adduct)
* library\_entry\_name - Name given to the library spectra
* inchikey - inchikey of the matched library spectra
* library\_source\_name - source of the spectra (e.g. massbank, gnps)
* library\_compound\_name - name of compound spectra was obtained from

**matchedResults**

All matched results from the query spectra to the library spectra. Contains the same columns as above
but without the XCMS details. This table is useful to observe spectral matching results
for all MS/MS spectra irrespective of if they are linked to XCMS MS1 features.

It should be noted that in a typical Data Dependent Acquisition (DDA) experiment not all the fragmentation scans collected can be linked backed to an associated XCMS features and in some cases the percentage of XCMS features with fragmentation spectra can sometimes be quite small.

# References

Horai, Hisayuki, Masanori Arita, and Takaaki Nishioka. 2008. “Comparison of ESI-MS spectra in MassBank database.” *BioMedical Engineering and Informatics: New Development and the Future - Proceedings of the 1st International Conference on BioMedical Engineering and Informatics, BMEI 2008* 2: 853–57. <https://doi.org/10.1109/BMEI.2008.339>.

Stein, Stephen E, and Donald R Scott. 1994. “Optimization and testing of mass spectral library search algorithms for compound identification.” *Journal of the American Society for Mass Spectrometry* 5 (9): 859–66.

Zhou, Jiarui, Ralf J M Weber, J William Allwood, Robert Mistrik, Zexuan Zhu, Zhen Ji, Siping Chen, Warwick B Dunn, Shan He, and Mark R Viant. 2014. “HAMMER: automated operation of mass frontier to construct in silico mass spectral fragmentation libraries.” *Bioinformatics (Oxford, England)* 30 (4): 581–3. <https://doi.org/10.1093/bioinformatics/btt711>.