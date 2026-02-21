# The epimutacions User’s Guide

Leire Abarrategui1,2,3,4\*, Carles Hernandez-Ferrer5,6\*\*, Carlos Ruiz-Arenas7,8\*\*\* and Juan R. Gonzalez2,9,10\*\*\*\*

1Bioinformatics Research Group in Epidemiology (BRGE)
2Barcelona Insitute for Global Health (ISGlobal)
3Faculty of Medical Sciences, Newcastle University
4Autonomous University of Barcelona (UAB)
5Centro Nacional de Análisis Genómico (CNAG-CRG), Center for Genomic Regulation
6Barcelona Institute of Science and Technology (BIST)
7Centro de Investigación Biomédica en Red de Enfermedades Raras (CIBERER)
8Universitat Pompeu Fabra (UPF)
9Bioinformatics Research Group in Epidemiology (BRGE),
10Department of Mathematics, Autonomous University of Barcelona (UAB)

\*leire.abarrategui-martinez@newcastle.ac.uk
\*\*carles.hernandez@cnag.crg.eu
\*\*\*carlos.ruiza@upf.edu
\*\*\*\*juanr.gonzalez@isglobal.org

#### 2025-10-29

#### Abstract

Epimutations are rare alterations in the methylation pattern at specific loci. Have been demonstrated that epimutations could be the causative factor of some genetic diseases. Nonetheless, no standard methods are available to detect and quantify these alterations.
This vignette provides an introductory guide to the `epimutacions` package. The package contains several outlier detection methods to identify epimutations in genome-wide DNA methylation microarrays data. The areas covered in this document are: (1) package installation; (2) data loading and preprocessing; and (3) epimutation identification, annotation and visualization.

#### Package

epimutacions 1.14.0

# 1 Introduction

## 1.1 Background

Epimutations are rare alterations in the methylation pattern at specific loci.
Have been demonstrated that epimutations could be the causative factor of
some genetic diseases.
For example, epimutations can lead to cancers,
such as Lynch syndrome, rare diseases such as Prader-Willi syndrome,
and are associated with common disorders, such as autism.
Nonetheless, no standard methods are available to detect and quantify
these alterations. Two methods for epimutations detection on methylation
microarray data have been reported:
(1) based on identifying CpGs with outlier values
and then cluster them in epimutations (Barbosa et al. [2018](#ref-barbosa2018identification));
(2) define candidate regions with bumphunter and test their statistical
significance with a MANOVA (Aref-Eshghi et al. [2019](#ref-aref2019)).
However, the implementation of these methods is not publicly available,
and these approaches have not been compared.

We have developed `epimutacions` R/Bioconductor package.
We have implemented those two methods
(called `quantile` and `manova`, respectively).
We implemented four additional approaches,
using a different distribution to detect CpG outliers (`beta`),
or a different model to
assess region significance (`mlm`, `mahdist`, and `iForest`).

The package `epimutacions` provides tools to raw DNA methylation microarray
intensities normalization and epimutations identification,
visualization and annotation.

The name of the package is `epimutacions`
(pronounced `ɛ pi mu ta 'sj ons`) which means epimutations in Catalan,
a language from the northeast of Spain.

## 1.2 Methodology

The `epimutacions` package computes a genome-wide DNA methylation analysis
to identify the epimutations to be considered as biomarkers
for case samples with a suspected genetic disease.
The function `epimutations()` infers epimutations on a case-control design.
It compares a case sample against a reference panel (healthy individuals).
The package also includes leave-one-out approach
(`epimutations_one_leave_out()`).
It compares individual methylation profiles of a single sample
(regardless if they are cases or controls) against all
other samples from the same cohort.

The `epimutacions` package includes 6 outlier detection approaches
(figure [1](#fig:implementation)):
(1) Multivariate Analysis of variance (`manova`),
(2) Multivariate Linear Model (`mlm`), (3) isolation forest (`iForest`),
(4) robust mahalanobis distance (`mahdist`) (5) `quantile` and (6) `beta`.

The approaches `manova`, `mlm`, `iForest` and `mahdist`
define the candidate regions (differentially methylated regions (DMRs))
using bumphunter method (Jaffe et al. [2012](#ref-jaffe2012bump)).
Then, those DMRs are tested to identify regions
with CpGs being outliers when comparing with the reference panel.
`quantile` uses the sliding window approach to
individually compare the methylation value in each proband
against the reference panel and then cluster them in epimutations.

We have defined an epimutation as a consecutive
window of a minimum of 3 outliers CpGs with a maximum
distance of 1kb between them (Barbosa et al. [2018](#ref-barbosa2018identification)).

![Implementation of each outlier detection method](data:image/png;base64...)

Figure 1: Implementation of each outlier detection method

# 2 Setup

## 2.1 Installing the packages

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("epimutacions")
```

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("epimutacionsData")
```

## 2.2 Loading libraries

```
library(epimutacions)
```

## 2.3 Quick start

The workflow in figure [2](#fig:workflow) explains the main analysis
in the `epimutacions` package.

The package allows two different types of inputs:

* 1. Case samples `IDAT` files (raw microarray intensities) together
     with `RGChannelSet` object as reference panel.
     The reference panel can be supplied by the user or can
     be selected through the example datasets
     that the package provides (section [3](#datasets)).
* 2. `GenomicRatioSet` object containing case and control samples.

The normalization (`epi_preprocess()`) converts the raw microarray
intensities into usable methylation measurement
(\(\beta\) values at CpG locus level).
As a result, we obtain a `GenomicRatioSet` object,
which can be used as `epimutations()` function input.
The data should contain information about values of CpG sites,
phenotype and feature data.

![Allowed data formats, normalization and input types](data:image/png;base64...)

Figure 2: Allowed data formats, normalization and input types

# 3 Datasets

The package contains 3 example datasets adapted from [Gene Expression Omnibus (GEO)](https://www.ncbi.nlm.nih.gov/geo/):

* 1. 4 case samples IDAT files [(GEO: GSE131350)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE131350)
* 2. `reference_panel`: a `RGChannelSet` class object containing
     22 healthy individuals
     [(GEO: GSE127824)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE12782)
* 3. `methy`: a `GenomicRatioSet` object which includes 49 controls [(GEO: GSE104812)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE104812)
     and 3 cases [(GEO: GSE97362)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi).

We also included a dataset specifying the 40,408 candidate regions
in Illumina 450K array which could
be epimutations (see section [3.2](#candreg)).

We created the `epimutacionsData` package in `ExperimentHub`.
It contains the reference panel, methy and the candidate epimutations datasets.
The package includes the IDAT files as external data.
To access the datasets we need to install the packages
by running the following commands:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ExperimentHub")
```

Then, we need to load the package and create an `ExperimentHub` object:

```
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, c("epimutacionsData"))
```

```
ExperimentHub with 3 records
# snapshotDate(): 2025-10-29
# $dataprovider: GEO, Illumina 450k array
# $species: Homo sapiens
# $rdataclass: RGChannelSet, GenomicRatioSet, GRanges
# additional mcols(): taxonomyid, genome, description,
#   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#   rdatapath, sourceurl, sourcetype
# retrieve records with, e.g., 'object[["EH6690"]]'

           title
  EH6690 | Control and case samples
  EH6691 | Reference panel
  EH6692 | Candidate epimutations
```

## 3.1 IDAT files and reference panel

IDAT files directory in `epimutacionsData` package:

```
baseDir <- system.file("extdata", package = "epimutacionsData")
```

The reference panel and `methy` dataset can be found in
`EH6691` and `EH6690` record of the `eh` object:

```
reference_panel <- eh[["EH6691"]]
methy <- eh[["EH6690"]]
```

## 3.2 Candidate regions

In Illumina 450K array, probes are unequally distributed along the genome,
limiting the number of regions that can fulfil the
requirements to be considered an epimutation.
Thus, we have computed a dataset containing all the regions
that could be candidates to become an epimutation.

We used the clustering approach from bumphunter to define
the candidate epimutations.
We defined a primary dataset with all the CpGs from the Illumina 450K array.
Then, we run bumphunter and selected those regions with at
least 3 CpGs and a maximum distance of 1kb between them.
As a result, we found 40,408 candidate epimutations.
The function `epimutation()` filters the identified
epimutations using these candidate regions.

The following is the code used to identify the candidate
epimutations in Illumina 450K array:

```
library(minfi)
# Regions 450K
library("IlluminaHumanMethylation450kanno.ilmn12.hg19")

data(Locations)

### Select CpGs (names starting by cg) in autosomic chromosomes
locs.450 <- subset(Locations, grepl("^cg", rownames(Locations)) & chr %in% paste0("chr", 1:22))
locs.450GR <- makeGRangesFromDataFrame(locs.450,
                                       start.field = "pos",
                                       end.field = "pos",
                                       strand = "*")
locs.450GR <- sort(locs.450GR)
mat <- matrix(0, nrow = length(locs.450GR), ncol = 2,
              dimnames = list(names(locs.450GR), c("A", "B")))

## Set sample B to all 1
mat[, 2] <- 1

## Define model matrix
pheno <- data.frame(var = c(0, 1))
model <- model.matrix(~ var, pheno)

## Run bumphunter
bumps <- bumphunter(mat, design = model, pos = start(locs.450GR),
                    chr = as.character(seqnames(locs.450GR)),
                    cutoff = 0.05)$table
bumps.fil <- subset(bumps, L >= 3)
```

The candidate regions can be found in `EH6692` record of the `eh` object:

```
candRegsGR <- eh[["EH6692"]]
```

# 4 Preprocessing

The `epi_preprocess()` function allows calling the
6 preprocessing methods from `minfi` package:

| Method | Function | Description |
| --- | --- | --- |
| `raw` | `preprocessRaw` | Converts the Red/Green channel for an Illumina methylation array into methylation signal, without using any normalization |
| `illumina` | `preprocessIllumina` | Implements preprocessing for Illumina methylation microarrays as used in Genome Studio |
| `swan` | `preprocessSWAN` | Subset-quantile Within Array Normalisation (SWAN). It allows Infinium I and II type probes on a single array to be normalized together |
| `quantile` | `preprocessQuantile` | Implements stratified quantile normalization preprocessing for Illumina methylation microarrays |
| `noob` | `preprocessNoob` | Noob (normal-exponential out-of-band) is a background correction method with dye-bias normalization for Illumina Infinium methylation arrays |
| `funnorm` | `preprocessFunnorm` | Functional normalization (FunNorm) is a between-array normalization method for the Illumina Infinium HumanMethylation450 platform |

Each normalization approach has some unique parameters
which can be modified through `norm_parameters()` function:

| parameters | Description |
| --- | --- |
| **illumina** | |
| bg.correct | Performs background correction |
| normalize | Performs controls normalization |
| reference | The reference array for control normalization |
| **quantile** | |
| fixOutliers | Low outlier Meth and Unmeth signals will be fixed |
| removeBadSamples | Remove bad samples |
| badSampleCutoff | The cutoff to label samples as ‘bad’ |
| quantileNormalize | Performs quantile normalization |
| stratified | Performs quantile normalization within region strata |
| mergeManifest | Merged to the output the information in the associated manifest package |
| sex | Sex of the samples |
| **noob** | |
| offset | Offset for the normexp background correct |
| dyeCorr | Performs dye normalization |
| dyeMethod | Dye bias correction to be done |
| **funnorm** | |
| nPCs | The number of principal components from the control probes |
| sex | Sex of the samples |
| bgCorr | Performs NOOB background correction before functional normalization |
| dyeCorr | Performs dye normalization |
| keepCN | Keeps copy number estimates |

We can obtain the default settings for each method by invoking
the function `norm_parameters()` with no arguments:

```
norm_parameters()
```

```
$illumina
$illumina$bg.correct
[1] TRUE

$illumina$normalize
[1] "controls" "no"

$illumina$reference
[1] 1

$quantile
$quantile$fixOutliers
[1] TRUE

$quantile$removeBadSamples
[1] FALSE

$quantile$badSampleCutoff
[1] 10.5

$quantile$quantileNormalize
[1] TRUE

$quantile$stratified
[1] TRUE

$quantile$mergeManifest
[1] FALSE

$quantile$sex
NULL

$noob
$noob$offset
[1] 15

$noob$dyeCorr
[1] TRUE

$noob$dyeMethod
[1] "single"    "reference"

$funnorm
$funnorm$nPCs
[1] 2

$funnorm$sex
NULL

$funnorm$bgCorr
[1] TRUE

$funnorm$dyeCorr
[1] TRUE

$funnorm$keepCN
[1] FALSE
```

However, we can modify the parameter(s)
as the following example for `illumina` approach:

```
parameters <- norm_parameters(illumina = list("bg.correct" = FALSE))
parameters$illumina$bg.correct
```

```
[1] FALSE
```

We are going to preprocess the IDAT files and
reference panel ([3](#datasets)).
We need to specify the IDAT files directory and the reference
panel in `RGChannelSet` format.
As a result, we will obtain a `GenomicRatioSet`
object containing the control and case samples:

```
GRset <- epi_preprocess(baseDir,
                        reference_panel,
                        pattern = "SampleSheet.csv")
```

# 5 Epimutations

## 5.1 Epimutations detection

The function `epimutations()` includes 6 methods for epimutation identification:
(1) Multivariate Analysis of variance (`manova`),
(2) Multivariate Linear Model (`mlm`),
(3) isolation forest (`iForest`),
(4) robust mahalanobis distance (`mahdist`)
(5) `quantile` and (6) `beta`.

To illustrate the following examples we are
going to use the dataset `methy` (section [3](#datasets)).
We need to separate the case and control samples:

```
case_samples <- methy[,methy$status == "case"]
control_samples <- methy[,methy$status == "control"]
```

We can specify the chromosome or region to
analyze which helps to reduce the execution time:

```
epi_mvo <- epimutations(case_samples,
                        control_samples,
                        method = "manova")
```

The function `epimutations_one_leave_out()`
compared individual methylation profiles of a single
sample (regardless if they are cases or controls)
against all other samples from the same cohort.
To use this function we do not need to split the dataset.
To ilustrate this example we are going to use
the `GRset` dataset available in `epimutacions` package:

```
#manova (default method)
data(GRset)
epi_mva_one_leave_out<- epimutations_one_leave_out(GRset)
```

## 5.2 Unique parameters

The `epi_parameters()` function is useful to set the individual
parameters for each outliers detection approach.
The following table describes the arguments:

| parameters | Description |
| --- | --- |
| **Manova, mlm** | |
| pvalue\_cutoff | The threshold p-value to select which CpG regions are outliers |
| **iso.forest** | |
| outlier\_score\_cutoff | The threshold to select which CpG regions are outliers |
| ntrees | The number of binary trees to build for the model |
| **mahdist.mcd** | |
| nsamp | The number of subsets used for initial estimates in the MCD |
| **quantile** | |
| window\_sz | The maximum distance between CpGs to be considered in the same DMR |
| offset\_mean/offset\_abs | The upper and lower threshold to consider a CpG an outlier |
| **beta** | |
| pvalue\_cutoff | The minimum p-value to consider a CpG an outlier |
| diff\_threshold | The minimum methylation difference between the CpG and the mean methylation to consider a position an outlier |

`epi_parameters()` with no arguments,
returns a list of the default settings for each method:

```
epi_parameters()
```

```
$manova
$manova$pvalue_cutoff
[1] 0.05

$mlm
$mlm$pvalue_cutoff
[1] 0.05

$iForest
$iForest$outlier_score_cutoff
[1] 0.7

$iForest$ntrees
[1] 100

$mahdist
$mahdist$nsamp
[1] "deterministic"

$quantile
$quantile$window_sz
[1] 1000

$quantile$offset_abs
[1] 0.15

$quantile$qsup
[1] 0.995

$quantile$qinf
[1] 0.005

$beta
$beta$pvalue_cutoff
[1] 1e-06

$beta$diff_threshold
[1] 0.1
```

The set up of any parameter can be done as the following example for `manova`:

```
parameters <- epi_parameters(manova = list("pvalue_cutoff" = 0.01))
parameters$manova$pvalue_cutoff
```

```
[1] 0.01
```

## 5.3 Results description

The `epimutations` function returns a data frame (tibble)
containing all the epimutations identified in the given case sample.
If no epimutation is found,
the function returns a row containing the case sample
information and missing values for all other arguments.
The following table describes each argument:

| Column name | Description |
| --- | --- |
| `epi_id` | systematic name for each epimutation identified |
| `sample` | The name of the sample containing that epimutation |
| `chromosome` `start` `end` | The location of the epimutation |
| `sz` | The window’s size of the event |
| `cpg_ids` | The number of CpGs in the epimutation |
| `cpg_n` | The names of CpGs in the epimutation |
| `outlier_score` | For method `manova` it provides the approximation to F-test and the Pillai score, separated by `/`  For method `mlm` it provides the approximation to F-test and the R2 of the model, separated by `/`  For method `iForest` it provides the magnitude of the outlier score.  For method `beta` it provides the mean p-value of all GpGs in that DMR  For methods `quantile` and `mahdist` it is filled with `NA`. |
| `pvalue` | For methods `manova` and `mlm` it provides the p-value obtained from the model.  For method `quantile`, `iForest`, `beta` and `mahdist` it is filled with `NA`. |
| `outlier_direction` | Indicates the direction of the outlier with “hypomethylation” and “hypermethylation”.  For `manova`, `mlm`, `iForest`, and `mahdist` it is computed from the values obtained from `bumphunter`.  For `beta` is computed from the p value for each CpG using `diff_threshold` and `pvalue_threshold` arguments.  For `quantile` it is computed from the location of the sample in the reference distribution (left vs. right outlier). |
| `adj_pvalue` | For methods `manova` and `mlm` it provides the adjusted p-value with Benjamini-Hochberg based on the total number of regions detected by Bumphunter.  For method `quantile`, `iForest`, `mahdist` and `beta` it is filled with `NA`. |
| `epi_region_id` | Name of the epimutation region as defined in `candRegsGR`. |
| `CRE` | cREs (cis-Regulatory Elements) as defined by ENCODE overlapping the epimutation region. |
| `CRE_type` | Type of cREs (cis-Regulatory Elements) as defined by ENCODE. |

If no outliers are detected in the region, valures for `sz`, `cpg_n`, `cpg_ids`,
`outlier_score`, `outlier_direction`, `pvalue`, `adj_pvalue` and `epi_region_id`
are set to `NA`

As an example we are going to visualize the obtained
results with MANOVA method (`epi_mvo`):

```
dim(epi_mvo)
```

```
[1] 51 16
```

```
class(epi_mvo)
```

```
[1] "tbl_df"     "tbl"        "data.frame"
```

```
head(as.data.frame(epi_mvo), 1)
```

```
        epi_id     sample chromosome    start      end  sz cpg_n
1 epi_manova_1 GSM2562699      chr19 12777736 12777903 167     7
                                                                       cpg_ids
1 cg20791841,cg25267526,cg03641858,cg25441478,cg14132016,cg23954461,cg03143365
                       outlier_score outlier_direction       pvalue
1 302.558383959446/0.981008923520812  hypermethylation 3.441085e-33
    adj_pvalue delta_beta  epi_region_id                                    CRE
1 2.236705e-31  0.2960902 chr19_12776725 EH38E1939817,EH38E1939818,EH38E1939819
                             CRE_type
1 pELS;pELS,CTCF-bound;PLS,CTCF-bound
```

## 5.4 Epimutations annotations

The `annotate_epimutations()` function enriches the
identified epimutations.
It includes information about GENECODE gene names,
description of the regulatory feature provided by
methylation consortium, the location of the
CpG relative to the CpG island, OMIM accession
and description number and Ensembl region id, coordinates, type and tissue:

```
rst_mvo <- annotate_epimutations(epi_mvo, omim = TRUE)
```

| Column name | Description |
| --- | --- |
| `GencodeBasicV12_NAME` | Gene names from the basic GENECODE build |
| `Regulatory_Feature_Group` | Description of the regulatory feature provided by the Methylation Consortium |
| `Relation_to_Island` | The location of the CpG relative to the CpG island |
| `OMIM_ACC` | OMIM accession and description number |
| `ensembl_reg_id` | The Ensembl region id, coordinates, type and tissue |

As an example we are going to visualize different annotations

```
kableExtra::kable(
    rst_mvo[ c(27,32) ,c("epi_id", "cpg_ids", "Relation_to_Island")],
    row.names = FALSE) %>%
  column_spec(1:3, width = "4cm")
```

| epi\_id | cpg\_ids | Relation\_to\_Island |
| --- | --- | --- |
| epi\_manova\_44 | cg19560927,cg02876326,cg16167052 | N\_Shore/N\_Shore/Island |
| epi\_manova\_51 | cg01396855,cg08684893,cg02386644 | N\_Shore/N\_Shore/N\_Shore |

```
kableExtra::kable(
    rst_mvo[ c(4,8,22) , c("epi_id", "OMIM_ACC", "OMIM_DESC")],
    row.names = FALSE ) %>%
  column_spec(1:3, width = "4cm")
```

| epi\_id | OMIM\_ACC | OMIM\_DESC |
| --- | --- | --- |
| epi\_manova\_4 | 248500 | MANNOSID…. |
| epi\_manova\_12 | 616689/6…. | DEHYDRAT…. |
| epi\_manova\_33 | 620332/6…. | OOCYTE/Z…. |

```
kableExtra::kable(
    rst_mvo[ c(1:5), c("epi_id", "ensembl_reg_id", "ensembl_reg_type")],
    row.names = FALSE ) %>%
  column_spec(1:3, width = "4cm")
```

| epi\_id | ensembl\_reg\_id | ensembl\_reg\_type |
| --- | --- | --- |
| epi\_manova\_1 | ENSR00001772947///ENSR19\_B4HTL | EMAR///Enhancer |
| epi\_manova\_2 | ENSR00001587341 | EMAR |
| epi\_manova\_3 | ENSR00001579471///ENSR7\_9DQXB | EMAR///Promoter |
| epi\_manova\_4 | ENSR00001772944///ENSR19\_54ZBR2 | EMAR///CTCF |
| epi\_manova\_5 | ENSR7\_9BZ///ENSR00001575398///ENSR7\_9C4///ENSR7\_57CT///ENSR7\_57D7 | Enhancer///EMAR///Promoter///CTCF///CTCF |

## 5.5 Epimutation visualization

The `plot_epimutations()` function locates
the epimutations along the genome.
It plots the methylation values of the case
sample in red, the control samples in dashed
black lines and population mean in blue:

```
plot_epimutations(as.data.frame(epi_mvo[1,]), methy)
```

![](data:image/png;base64...)

If we set the argument `gene_annot == TRUE` the plot includes the gene annotations:

```
p <- plot_epimutations(as.data.frame(epi_mvo[1,]),
                       methy = methy,
                       genes_annot = TRUE)
```

```
plot(p)
```

![](data:image/png;base64...)

To plot the chromatin marks H3K4me3,
H3K27me3 and H3K27ac we need to specify the argument `regulation = TRUE`:

* **H3K4me3**: commonly associated with the
  activation of transcription of nearby genes.
* **H3K27me3**: is used in
  epigenetics to look for inactive genes.
* **H3K27ac**: is associated with the higher
  activation of transcription and therefore defined as an active enhancer mark

```
p <- plot_epimutations(as.data.frame(epi_mvo[1,]),
                       methy =  methy,
                       regulation = TRUE)
```

```
plot(p)
```

![](data:image/png;base64...)

# 6 Acknowledgements

The authors would like to thank the team who collaborated
in the initial design of the package in the European BioHackathon 2020:
Lordstrong Akano, James Baye, Alejandro Caceres, Pavlo Hrab,
Raquel Manzano and Margherita Mutarelli.
The authors also want to thank the organization
of European BioHackathon 2020 for its support.

All the team members of *Project #5* for the contribution to this package:

| Name | Surname | ORCID | Affiliation | Team |
| --- | --- | --- | --- | --- |
| Leire | Abarrategui | 0000-0002-1175-038X | Faculty of Medical Sciences, Newcastle University, Newcastle-Upon-Tyne, UK; Autonomous University of Barcelona (UAB), Barcelona, Spain | Development |
| Lordstrong | Akano | 0000-0002-1404-0295 | College of Medicine, University of Ibadan | Development |
| James | Baye | 0000-0002-0078-3688 | Wellcome/MRC Cambridge Stem Cell Institute, University of Cambridge, Cambridge CB2 0AW, UK; Department of Physics, University of Cambridge, Cambridge CB2 3DY, UK | Development |
| Alejandro | Caceres | - | ISGlobal, Barcelona Institute for Global Health, Dr Aiguader 88, 08003 Barcelona, Spain; Centro de Investigación Biomédica en Red en Epidemiología y Salud Pública (CIBERESP), Madrid, Spain | Development |
| Carles | Hernandez-Ferrer | 0000-0002-8029-7160 | Centro Nacional de Análisis Genómico (CNAG-CRG), Center for Genomic, Regulation; Barcelona Institute of Science and Technology (BIST), Barcelona, Catalonia, Spain | Development |
| Pavlo | Hrab | 0000-0002-0742-8478 | Department of Genetics and Biotechnology, Biology faculty, Ivan Franko National University of Lviv | Validation |
| Raquel | Manzano | 0000-0002-5124-8992 | Cancer Research UK Cambridge Institute; University of Cambridge, Cambridge, United Kingdom | Reporting |
| Margherita | Mutarelli | 0000-0002-2168-5059 | Institute of Applied Sciences and Intelligent Systems (ISASI-CNR) | Validation |
| Carlos | Ruiz-Arenas | 0000-0002-6014-3498 | Centro de Investigación Biomédica en Red de Enfermedades Raras (CIBERER), Barcelona, Spain; Universitat Pompeu Fabra (UPF), Barcelona, Spain | Reporting |

# 7 Session Info

```
sessionInfo()
```

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] parallel  stats4    stats     graphics  grDevices utils     datasets
[8] methods   base

other attached packages:
 [1] IlluminaHumanMethylationEPICanno.ilm10b2.hg19_0.6.0
 [2] kableExtra_1.4.0
 [3] minfi_1.56.0
 [4] bumphunter_1.52.0
 [5] locfit_1.5-9.12
 [6] iterators_1.0.14
 [7] foreach_1.5.2
 [8] Biostrings_2.78.0
 [9] XVector_0.50.0
[10] SummarizedExperiment_1.40.0
[11] Biobase_2.70.0
[12] MatrixGenerics_1.22.0
[13] matrixStats_1.5.0
[14] GenomicRanges_1.62.0
[15] Seqinfo_1.0.0
[16] IRanges_2.44.0
[17] S4Vectors_0.48.0
[18] ExperimentHub_3.0.0
[19] AnnotationHub_4.0.0
[20] BiocFileCache_3.0.0
[21] dbplyr_2.5.1
[22] BiocGenerics_0.56.0
[23] generics_0.1.4
[24] epimutacions_1.14.0
[25] epimutacionsData_1.13.0
[26] BiocStyle_2.38.0

loaded via a namespace (and not attached):
  [1] ProtGenerics_1.42.0
  [2] bitops_1.0-9
  [3] isotree_0.6.1-4
  [4] httr_1.4.7
  [5] RColorBrewer_1.1-3
  [6] tools_4.5.1
  [7] doRNG_1.8.6.2
  [8] backports_1.5.0
  [9] R6_2.6.1
 [10] HDF5Array_1.38.0
 [11] lazyeval_0.2.2
 [12] Gviz_1.54.0
 [13] rhdf5filters_1.22.0
 [14] withr_3.0.2
 [15] prettyunits_1.2.0
 [16] gridExtra_2.3
 [17] base64_2.0.2
 [18] preprocessCore_1.72.0
 [19] cli_3.6.5
 [20] textshaping_1.0.4
 [21] labeling_0.4.3
 [22] sass_0.4.10
 [23] S7_0.2.0
 [24] robustbase_0.99-6
 [25] readr_2.1.5
 [26] genefilter_1.92.0
 [27] askpass_1.2.1
 [28] Rsamtools_2.26.0
 [29] systemfonts_1.3.1
 [30] foreign_0.8-90
 [31] siggenes_1.84.0
 [32] illuminaio_0.52.0
 [33] svglite_2.2.2
 [34] rentrez_1.2.4
 [35] dichromat_2.0-0.1
 [36] scrime_1.3.5
 [37] BSgenome_1.78.0
 [38] limma_3.66.0
 [39] rstudioapi_0.17.1
 [40] RSQLite_2.4.3
 [41] BiocIO_1.20.0
 [42] dplyr_1.1.4
 [43] Matrix_1.7-4
 [44] interp_1.1-6
 [45] abind_1.4-8
 [46] lifecycle_1.0.4
 [47] yaml_2.3.10
 [48] rhdf5_2.54.0
 [49] SparseArray_1.10.0
 [50] grid_4.5.1
 [51] blob_1.2.4
 [52] crayon_1.5.3
 [53] lattice_0.22-7
 [54] GenomicFeatures_1.62.0
 [55] cigarillo_1.0.0
 [56] annotate_1.88.0
 [57] KEGGREST_1.50.0
 [58] magick_2.9.0
 [59] pillar_1.11.1
 [60] knitr_1.50
 [61] beanplot_1.3.1
 [62] rjson_0.2.23
 [63] codetools_0.2-20
 [64] glue_1.8.0
 [65] data.table_1.17.8
 [66] vctrs_0.6.5
 [67] png_0.1-8
 [68] IlluminaHumanMethylationEPICmanifest_0.3.0
 [69] gtable_0.3.6
 [70] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
 [71] cachem_1.1.0
 [72] xfun_0.53
 [73] S4Arrays_1.10.0
 [74] survival_3.8-3
 [75] tinytex_0.57
 [76] statmod_1.5.1
 [77] nlme_3.1-168
 [78] bit64_4.6.0-1
 [79] progress_1.2.3
 [80] filelock_1.0.3
 [81] GenomeInfoDb_1.46.0
 [82] bslib_0.9.0
 [83] nor1mix_1.3-3
 [84] IlluminaHumanMethylation450kmanifest_0.4.0
 [85] rpart_4.1.24
 [86] colorspace_2.1-2
 [87] DBI_1.2.3
 [88] Hmisc_5.2-4
 [89] nnet_7.3-20
 [90] tidyselect_1.2.1
 [91] bit_4.6.0
 [92] compiler_4.5.1
 [93] curl_7.0.0
 [94] httr2_1.2.1
 [95] htmlTable_2.4.3
 [96] h5mread_1.2.0
 [97] xml2_1.4.1
 [98] DelayedArray_0.36.0
 [99] bookdown_0.45
[100] rtracklayer_1.70.0
[101] checkmate_2.3.3
[102] scales_1.4.0
[103] DEoptimR_1.1-4
[104] quadprog_1.5-8
[105] rappdirs_0.3.3
[106] stringr_1.5.2
[107] digest_0.6.37
[108] rmarkdown_2.30
[109] GEOquery_2.78.0
[110] htmltools_0.5.8.1
[111] pkgconfig_2.0.3
[112] jpeg_0.1-11
[113] base64enc_0.1-3
[114] sparseMatrixStats_1.22.0
[115] fastmap_1.2.0
[116] ensembldb_2.34.0
[117] rlang_1.1.6
[118] htmlwidgets_1.6.4
[119] UCSC.utils_1.6.0
[120] DelayedMatrixStats_1.32.0
[121] farver_2.1.2
[122] jquerylib_0.1.4
[123] jsonlite_2.0.0
[124] BiocParallel_1.44.0
[125] mclust_6.1.1
[126] VariantAnnotation_1.56.0
[127] RCurl_1.98-1.17
[128] magrittr_2.0.4
[129] Formula_1.2-5
[130] Rhdf5lib_1.32.0
[131] Rcpp_1.1.0
[132] stringi_1.8.7
[133] MASS_7.3-65
[134] plyr_1.8.9
[135] ggrepel_0.9.6
[136] deldir_2.0-4
[137] splines_4.5.1
[138] multtest_2.66.0
[139] hms_1.1.4
[140] rngtools_1.5.2
[141] reshape2_1.4.4
[142] biomaRt_2.66.0
[143] BiocVersion_3.22.0
[144] XML_3.99-0.19
[145] evaluate_1.0.5
[146] latticeExtra_0.6-31
[147] biovizBase_1.58.0
[148] BiocManager_1.30.26
[149] tzdb_0.5.0
[150] tidyr_1.3.1
[151] openssl_2.3.4
[152] purrr_1.1.0
[153] reshape_0.8.10
[154] ggplot2_4.0.0
[155] xtable_1.8-4
[156] restfulr_0.0.16
[157] AnnotationFilter_1.34.0
[158] viridisLite_0.4.2
[159] tibble_3.3.0
[160] memoise_2.0.1
[161] AnnotationDbi_1.72.0
[162] GenomicAlignments_1.46.0
[163] cluster_2.1.8.1
```

# References

Aref-Eshghi, Erfan, Eric G. Bend, Samantha Colaiacovo, Michelle Caudle, Rana Chakrabarti, Melanie Napier, Lauren Brick, et al. 2019. “Diagnostic Utility of Genome-Wide Dna Methylation Testing in Genetically Unsolved Individuals with Suspected Hereditary Conditions.” *The American Journal of Human Genetics*. [https://doi.org/https://doi.org/10.1016/j.ajhg.2019.03.008](https://doi.org/https%3A//doi.org/10.1016/j.ajhg.2019.03.008).

Barbosa, Mafalda, Ricky S Joshi, Paras Garg, Alejandro Martin-Trujillo, Nihir Patel, Bharati Jadhav, Corey T Watson, et al. 2018. “Identification of Rare de Novo Epigenetic Variations in Congenital Disorders.” *Nature Communications* 9 (1): 1–11.

Jaffe, Andrew E, Peter Murakami, Hwajin Lee, Jeffrey T Leek, M Daniele Fallin, Andrew P Feinberg, and Rafael A Irizarry. 2012. “Bump Hunting to Identify Differentially Methylated Regions in Epigenetic Epidemiology Studies.” *International Journal of Epidemiology* 41 (1): 200–209.