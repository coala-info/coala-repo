# RadioGx: An R Package for Analysis of Large Radiogenomic Datasets

# Introduction

The RadioGx package implements a standardized data structure for storing highly
curated results from Radiogenomic experiments. Such experiments investigate the
relationship between different cancer cell lines and their response to various
doses and types of ionizing radiation. The package is intended for use in
conjunction with the PharmacoGx package which provides a similar data structure
and API for storing highly curated Pharmacogenomic experiments.

On top of the S4 RadioSet class, this package also provides a standard API
to access functions related to fitting dose response curves, calculating survival
fraction and fitting linear-quadratic models. Additional functions for calculating
the correlation between radiation dose and radiation response allow
for characterization of the radiation sensitivity of myriad cancer cell lines
representing a diverse set of cancer phenotypes.

It is our hope that this package can aid clinicians and fellow researchers in
treatment planning and radiation sensitivity discovery in existing cancer types
as well as prospectively in new **in vitro** and **in vivo** models of cancer.

# Creating a RadioSet

Documentation for creating a RadioSet object will be added to this package
in the coming months. In the mean time consult the ‘Creating A PharmacoSet’
vignette from the PharmacoGx Bioconductor package for an example of creating
a related data structure.

# Basic Functionalities of RadioGx

## Installing RadioGx

To install the *[RadioGx](https://bioconductor.org/packages/3.22/RadioGx)* package, run:

```
BiocManager::install('RadioGx', version='devel')
```

```
library(RadioGx)
```

## RadioSet

The RadioSet has a structure similar to the `PharmacoSet` and also inherits
from the CoreSet^[exported by *[CoreGx](https://bioconductor.org/packages/3.22/CoreGx)*] class . The radiation
slot is implemented in *[RadioGx](https://bioconductor.org/packages/3.22/RadioGx)* to hold relevant metadata
about the type(s) of radiation used in the dose-response experiment,
and is analogous to the drug slot in a `PharmacoSet`. The remainder of the slots
mirror the `PharmacoSet`.

![**RadioSet class diagram**. Objects comprising a `RadioSet` are enclosed in boxes. First box indicates type and name of each object. Second box indicates the structure of an object or class. Third box shows accessor methods from `RadioGx` for that specific object. '=>' represents return and specifies what is returned from that item or method.](data:image/png;base64...)

\*\*RadioSet class diagram\*\*. Objects comprising a `RadioSet` are enclosed in boxes. First box indicates type and name of each object. Second box indicates the structure of an object or class. Third box shows accessor methods from `RadioGx` for that specific object. '=>' represents return and specifies what is returned from that item or method.

## Downloading an RSet

*[RadioGx](https://bioconductor.org/packages/3.22/RadioGx)* provides an interface similar to *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)*
and *[Xeva](https://bioconductor.org/packages/3.22/Xeva)* for downloading our curated versions of published datasets.

To get a list of available `RadioSet`s, use:

```
RSets <- availableRSets()
```

As the *[RadioGx](https://bioconductor.org/packages/3.22/RadioGx)* package was only recently released, there is
currently only one dataset available. Let’s download the ‘Cleveland’ RSet, which contains
a highly curated version of the data from Yang *et al.*, 2016.

```
Cleveland <- downloadRSet('Cleveland', saveDir='.')
```

```
data(clevelandSmall)
clevelandSmall
```

```
## <RadioSet>
## Name: Cleveland
## Date Created: Thu Mar  2 20:14:42 2023
## Number of samples:  5
## Molecular profiles:
## RNA :
##   Dim: 20049, 5
## RNAseq :
##   Dim: 61958, 5
## mutation :
##   Dim: 19285, 0
## CNV :
##   Dim: 24960, 2
## Treatment response: Drug pertubation:
##    Please look at pertNumber(cSet) to determine number of experiments  for each drug-sample combination.
## Drug sensitivity:
##    Number of Experiments:  5
##    Please look at sensNumber(cSet) to determine number of  experiments for each drug-sample combination.
```

Similar to PharmacoGx and Xeva, a summary of the contents of the RadioSet is printed
when calling a RadioSet in the console. We can see that the clevelandSmall RSet contains
sensitivity information for 5 cell-lines treated with a single type of radiation.
The RSet also contains rna^[microarray], rna-seq and cnv molecular data for a subset of available
cell-lines.

## Accessing Data

RadioGx stores three major categories of data: metadata/annotations, molecular data and radiation response data.
These are demarcated in **Fig.** @ref(fig:radioset) using green, blue and red, respectively. Accessor methods are available
to retrieve all three kinds of data from an RSet; the accessor methods for each component are listed
in the bottom most cell of each object in the RadioGx class diagram. We will discuss a subset of these methods
now.

### Accessing metadata

Metadata in an RSet is stored in the same slots as in a `PharmacoSet`, and can be accessed using the same
generic accessor functions as in *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)*. A unique slot, `radiation` has additional
accessor methods to retrieve the radiation types used in a given sensitivity experiment.

```
# Get the radiation info data.frame from an RSet
radInf <- radiationInfo(clevelandSmall)
```

```
knitr::kable(radInf)
```

|  | treatmentid |
| --- | --- |
| radiation | radiation |

Currently, only one type of radiation has been used in an `RSet`. However, we hope to add new `RSet`s covering a wider range of radiation
sensitivity and perturbation experiments in the near future. The following method is also available to retrieve the radiation
types as a `character` vector instead of a `data.frame`.

```
radTypes <- radiationTypes(clevelandSmall)
radTypes
```

```
## [1] "radiation"
```

### Accessing molecular data

Molecular data in an `RSet` is contained in the `molecularProfiles` slot and can be accessed the same way it is for a `PSet`.

```
# Get the list (equivalent to @molecularProfiles, except that it is robust to changes in RSet structure
str(molecularProfilesSlot(clevelandSmall), max.level=2)
```

```
## List of 4
##  $ rna     :Formal class 'SummarizedExperiment' [package "SummarizedExperiment"] with 5 slots
##  $ rnaseq  :Formal class 'SummarizedExperiment' [package "SummarizedExperiment"] with 5 slots
##  $ mutation:Formal class 'SummarizedExperiment' [package "SummarizedExperiment"] with 5 slots
##  $ cnv     :Formal class 'SummarizedExperiment' [package "SummarizedExperiment"] with 5 slots
```

```
# Get the names from the list
mDataNames(clevelandSmall)
```

```
## [1] "rna"      "rnaseq"   "mutation" "cnv"
```

All molecular data in an RSet (any class inheriting from CoreSet, actually) is contained in a `SummarizedExperiment`
object. While *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* comes with it’s own set of accessors, we recommend using
available *[RadioGx](https://bioconductor.org/packages/3.22/RadioGx)* accessor methods as it allows your scripts to be robust to future changes
in the structure of a `RadioSet` object.

```
# Get sample metadata
phenoInf <- phenoInfo(clevelandSmall, 'cnv')
```

To keep the document formatted nicely, the following tables have been subset to the first three rows and columns.

| Sample\_title | Sample\_geo\_accession | Sample\_status | Sample\_submission\_date | Sample\_last\_update\_date |
| --- | --- | --- | --- | --- |
| MHH-NB-11 | GSM888395 | Public on Mar 20 2012 | Mar 06 2012 | Dec 21 2012 |
| CHP-212 | GSM887996 | Public on Mar 20 2012 | Mar 06 2012 | Dec 21 2012 |

```
# Get feature metadata
featInfo <- featureInfo(clevelandSmall, 'rna')
```

| Probe | EnsemblGeneId | EntrezGeneId | Symbol | GeneBioType |
| --- | --- | --- | --- | --- |
| ENSG00000000003\_at | ENSG00000000003 | 7105 | TSPAN6 | protein\_coding |
| ENSG00000000005\_at | ENSG00000000005 | 64102 | TNMD | protein\_coding |
| ENSG00000000419\_at | ENSG00000000419 | 8813 | DPM1 | protein\_coding |

```
# Access the moleclar feature data
mProf <- molecularProfiles(clevelandSmall, 'rnaseq')
```

|  | G20472.CHP-212.2 | G28026.KP-N-SI9s.1 | G28552.MHH-NB-11.1 | G28900.IMR-32.3 | G41744.NB-1.5 |
| --- | --- | --- | --- | --- | --- |
| ENSG00000000003 | 4.206 | 3.455 | 2.281 | 4.242 | 4.453 |
| ENSG00000000005 | 0.000 | 0.138 | 0.000 | 0.803 | 0.000 |
| ENSG00000000419 | 5.347 | 5.921 | 4.228 | 5.233 | 6.292 |

### Accessing response data

Data from radiation sensitivity and/or perturbation experiments is also retrieved the same way it is for a PSet. Currently,
only sensitivity experiments have been included in a `RadioSet`.

```
# Get sensitivity slot
sens <- treatmentResponse(clevelandSmall)
```

```
# Get sensitivity raw data
sensRaw <- sensitivityRaw(clevelandSmall)
```

```
# Get sensitivity profiles
sensProf <- sensitivityProfiles(clevelandSmall)
```

```
# Get sensitivity info
sensInfo <- sensitivityInfo(clevelandSmall)
```

## Fitting Linear Quadratic (LQ) Models

RadioGx provides a number of functions for analyzing dose response experiments.
To use these functions, we must first fit a statistical model to the dose
response data. This package exports a function for fitting linear-quadratic
models to dose response data. The function can be used with data contained in
a RadioSet or with raw dose-response data.

```
# Extract raw sensitvity data from the RadioSet
sensRaw <- sensitivityRaw(clevelandSmall)
```

```
str(sensRaw)
```

```
##  num [1:5, 1:9, 1:2] 1 1 1 1 1 1 1 1 1 1 ...
##  - attr(*, "dimnames")=List of 3
##   ..$ : chr [1:5] "IMR-32_radiation_2" "CHP-212_radiation_4" "KP-N-S19s_radiation_5" "MHH-NB-11_radiation_6" ...
##   ..$ : chr [1:9] "doses1" "doses2" "doses3" "doses4" ...
##   ..$ : chr [1:2] "Dose" "Viability"
```

The data returned by `sensitivityRaw(RSet)` is a three dimensional
array, but it can also be thought of as a set of experiment by treatment
matrices. We can see by the `dimnames` of the third dimensions that
the first matrix holds the radiation dose (in Gy) for each experiment,
while the second matrix holds the viability measurements for the cell-line
after each dose in the experimental series.

```
# Find a cancer cell-line of interest
head(sensitivityInfo(clevelandSmall)$sampleid)
```

```
## [1] "IMR-32"    "CHP-212"   "KP-N-S19s" "MHH-NB-11" "NB1"
```

```
cancerCellLine <- sensitivityInfo(clevelandSmall)$sampleid[1]
print(cancerCellLine)
```

```
## [1] "IMR-32"
```

```
# Get the radiation doses and associated survival data from clevelandSmall
radiationDoses <- sensRaw[1, , 'Dose']
survivalFractions <- sensRaw[1, , 'Viability']
```

```
LQmodel <- linearQuadraticModel(D=radiationDoses,
                                SF=survivalFractions)
LQmodel
```

```
##     alpha      beta
## 0.8098218 0.0000000
## attr(,"Rsquare")
## [1] 0.9199636
```

Above we see that LQmodel contains the alpha and beta coefficients for the dose
response curve fit to the dose and viability data for the IMR-32 cancer cell-line.
Based on the \(R^2\) attribute we can see that the model fit for this data is
good, with 92% of observed variance
explained by the model.

## Calculating Dose-Response Metrics

RadioGx provides a number of functions for calculating common dose response
metrics such as surviving fraction (SF), area under the curve (AUC) and dose at
which only 10% of cancer cells survive (D10).

Some of these functions require the alpha and beta coefficients, as calculated
above using the `linearQuadraticModel` function.

```
survFracAfter2Units <- computeSF2(pars=LQmodel)
print(survFracAfter2Units)
```

```
## [1] 0.1979692
```

```
dose10PercentSurv <- computeD10(pars=LQmodel)
print(dose10PercentSurv)
```

```
## [1] 2.843323
```

We see from the above code cell that after two units of radiation,
19.797% of cancer cells remain relative to the initial population.
Conversely, using `computeD10` we see that on average 2.843 units of radiation
need to be administered to result in 10% cell-line survival (i.e., 90% of cancer cells
are killed).

Other dose-response metrics can be computed directly using radiation dose
and cancer cell viability data.

```
areaUnderDoseRespCurve <- RadioGx::computeAUC(D=radiationDoses, pars=LQmodel, lower=0,
                                     upper=1)
print(areaUnderDoseRespCurve)
```

```
## [1] 0.6854133
```

In the above code block we compute the AUC for a dose-response curve between a
dose of 0 to 1 Gy. This area can be interpreted as the total proportion of cells
killed during the administration of 1 Gy of radiation.

### Dose-Response Curves

The `doseResponseCurve` function can be used to generate plots of surviving
fraction vs dose for radiation sensitivity experiments. In this example
we provide raw data values to create the plot. When the `plot.type` is set to
“Both”, a linear-quadratic model will also be fit to the supplied dose-response
values.

```
doseResponseCurve(
  Ds=list("Experiment 1" = c(0, 2, 4, 6)),
  SFs=list("Experiment 1" = c(1,.6,.4,.2)),
  plot.type="Both"
)
```

![plot of chunk plotting_rad_dose_resp](data:image/png;base64...)

Additionally, `doseResponseCurve` can be used to create dose response curves
directly from a curated RadioSet object. When utilizing this feature, a
cell-line must be selected from the RadioSet. This can be done by name
if you know which cell-line you are looking for. If you don’t know which
cell-line you want to visualize, the available
cell-lines can be explored using the `cellInfo` function.

```
doseResponseCurve(
  rSets=list(clevelandSmall),
  cellline=cellInfo(clevelandSmall)$sampleid[5]
)
```

![plot of chunk plotting_rad_dose_resp_rSet](data:image/png;base64...)

### Summarizing Sensitivity

To retrieve a radiation type by cell-line summary of a sensitivity experiment, we use the `summarizeSensitivityProfiles` function.
This will return a `matrix` where rows are radiation type^[Note there is currently only one radiation type available, but in the future there will be more], columns are cell-line and values are viability measurements summarized
using `summary.stat`^[Available options are ‘mean’, ‘median’, ‘first’, ‘last’]. The sensitivity measure to summarize can be
specified using `sensitivity.measure`^[See `sensitivityMeasures(RSet)` for available options].

```
sensSummary <- summarizeSensitivityProfiles(clevelandSmall)
```

```
sensSummary[, 1:3]
```

```
##   CHP-212    IMR-32 KP-N-S19s
## 1.3440925 0.5490508 2.3251731
```

### Summarizing Molecular Data

```
mprofSummary <- summarizeMolecularProfiles(clevelandSmall, mDataType='rna', summary.stat='median', fill.missing=FALSE)
```

```
mprofSummary
```

```
## class: SummarizedExperiment
## dim: 20049 5
## metadata(3): experimentData annotation protocolData
## assays(2): exprs se.exprs
## rownames(20049): ENSG00000000003 ENSG00000000005 ... ENSG00000280439
##   ENSG00000280448
## rowData names(7): Probe EnsemblGeneId ... BEST rownames
## colnames(5): CHP-212 IMR-32 KP-N-S19s MHH-NB-11 NB1
## colData names(25): samplename filename ... rownames tissueid
```

Due to a lack of replicates in the clevelandSmall `RSet`, the returned `SummarizedExperiment` object contains the same information as
the original. For other experiments with replicates, however, the result should contain one column per unique cell-line id. For
ease of interoperability with the response data contained in an `RSet`, if `fill.missing` is FALSE empty columns for the
cell-lines in the sensitivity experiment, but not in the molecular profile will be added to the `SummarizedExperiment` such
that the dimensions are equal.

### Molecular Signatures for Biomarker Discovery

The true usefulness of the `RadioGx` packages comes from the ability to determine gene signatures for a
cell-lines from a sensitivity experiment. Cell-lines of interest to a given researcher can be selected
and a molecular signature computed which correlates specific molecular features with a given sensitivity profile.
Using this method one could identify signatures associated with either radio-sensitivity or radio-resistance.
Combining this signature with drug response gene signatures from *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)*, as will
be done in the subsequent section, one can identify drugs which could augment the effectiveness of a
given radiation signature. Perhaps more powerfully, drugs which target features associated with radio-resistance
can be found, potentially synergistically increasing the overall effectiveness of the combined treatment.

```
radSensSig <- radSensitivitySig(clevelandSmall, mDataType='rna', features=fNames(clevelandSmall, 'rna')[2:5], nthread=1)
```

```
## Computing radiation sensitivity signatures...
```

```
radSensSig@.Data
```

```
## , , estimate
##
##                  radiation
## ENSG00000000005 -0.3794080
## ENSG00000000419  0.7569346
## ENSG00000000457  0.9303156
## ENSG00000000460  0.4064764
##
## , , se
##
##                 radiation
## ENSG00000000005 0.5341815
## ENSG00000000419 0.3772930
## ENSG00000000457 0.2117490
## ENSG00000000460 0.5275026
##
## , , n
##
##                 radiation
## ENSG00000000005         5
## ENSG00000000419         5
## ENSG00000000457         5
## ENSG00000000460         5
##
## , , tstat
##
##                  radiation
## ENSG00000000005 -0.7102606
## ENSG00000000419  2.0062252
## ENSG00000000457  4.3934837
## ENSG00000000460  0.7705675
##
## , , fstat
##
##                  radiation
## ENSG00000000005  0.5044701
## ENSG00000000419  4.0249395
## ENSG00000000457 19.3026988
## ENSG00000000460  0.5937743
##
## , , pvalue
##
##                  radiation
## ENSG00000000005 0.52877664
## ENSG00000000419 0.13848843
## ENSG00000000457 0.02184966
## ENSG00000000460 0.49708576
##
## , , df
##
##                 radiation
## ENSG00000000005         3
## ENSG00000000419         3
## ENSG00000000457         3
## ENSG00000000460         3
##
## , , fdr
##
##                  radiation
## ENSG00000000005 0.52877664
## ENSG00000000419 0.27697686
## ENSG00000000457 0.08739866
## ENSG00000000460 0.52877664
```