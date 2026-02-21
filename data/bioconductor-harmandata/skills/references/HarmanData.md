# HarmanData: example and reference data to use with batch correction package Harman

#### Jason Ross and Yalchin Oytam

#### 4 November 2025

# Overview

This package provides data to be used with the package *[Harman](https://bioconductor.org/packages/3.22/Harman)*. It contains three microarray gene expression datasets which are worked examples for batch-effect correction. The gene expression data and its processing is described below. For usage of the data for batch correction analyses please refer to the *[Harman](https://bioconductor.org/packages/3.22/Harman)* vignette.

Harman can also be used to batch effect correction methylation data, but this data has particular caveats due to biologically relevant clustering. This data package also contains probe-wise summary statistics after batch-effect correction across 5 Infinium Methylation datasets.

The reference matrices comprise data from 1,214 450K and 1,094 EPIC arrays from regionally diverse and multi-ethic populations across Australia, the USA and Italy and spanning multiple commonly collected biosamples (blood, buccal cells and saliva). The reference allows investigators to identify erroneously corrected and batch-effect susceptible CpG probes in their study.

*The HarmanData package is available from Bioconductor (*[HarmanData](https://bioconductor.org/packages/3.22/HarmanData)*).*

Overview of the three gene expression datasets included in HarmanData:

| object | description |
| --- | --- |
| `IMR90` | cell-line data examining whether exposing mammalian cells to nitric oxide stabilizes mRNAs |
| `NPM` | mouse data testing the skin penetration of metal oxide nanoparticles following topical application of sunscreens |
| `OLF` | human olfactory stem cell line data on response to ZnO nanoparticle exposure |

## Example gene expression data

All example gene expression datasets in the package are represented in two `data.frame`’s. One containing the data, the other containing information on the phenotype and batch structure. These datasets are the example data sets used in the Harman vignette.

### IMR90

| data.frame | description |
| --- | --- |
| `imr90.data` | Affymetrix HG-U133A Arrays with 22,223 probesets (rows) and 12 biological samples (columns). |
| `imr90.info` | A description of the samples, with two columns, treatment and batch. |

Data used in the batch effect correction paper of Johnson, Li and Rabinovich. The data are from a cell-line experimental designed to reveal whether exposing mammalian cells to nitric oxide (NO) stabilizes mRNAs. The data comprises one treatment, one control and 2 time points (0 h and 7.5 h), resulting in 4 distinct (2 treatment x 2 time points) experimental conditions. There were 3 batches and a total of 12 samples, with each batch consisting of 1 replicate from each of the experimental conditions. Affymetrix HG-U133A Arrays were normalised and background adjusted as a whole using the RMA procedure in MATLAB.

### NPM

| data.frame | description |
| --- | --- |
| `npm.data` | Affymetrix MoGene 1.0 ST array data, with 35,512 probesets (rows) and 24 biological samples (columns). |
| `npm.info` | A description of the samples, with two columns, treatment and batch. |

An experiment to test skin penetration of metal oxide nanoparticles following topical application of sunscreens. The data comprises three treatment groups plus a control group, with six replicates in each group, making a total of 24 Affymetrix MoGene 1.0 ST arrays. There were a total of three processing batches of eight arrays, each consisting of 2 replicates per group. Arrays were normalised and background adjusted as a whole using the RMA procedure in MATLAB.

### OLF

| data.frame | description |
| --- | --- |
| `olf.data` | has 33,297 probesets (rows) and 28 biological samples (columns). |
| `olf.info` | A description of the samples, with two columns, treatment and batch. |

An experiment to gauge the response of human olfactory neurosphere-derived (hONS) cells established from adult donors to ZnO nanoparticles. The data comprises six treatment groups plus a control group, each consisting of four replicates, giving a total number of 28 Affymetrix HuGene 1.0 ST arrays. The arrays were broken up into four processing batches of seven arrays each, consisting of one replicate from each of the groups. Arrays were normalised and background adjusted as a whole using the RMA procedure in MATLAB.

### Usage

```
## load package
library(HarmanData)
data(IMR90)
data(NPM)
data(OLF)
data(Infinium5)
olf.data[1:5, 1:5]
```

```
##         c1      c2      c3      c4      c5
## p1 5.05866 4.58076 5.58438 2.90481 5.39752
## p2 4.23886 4.08143 3.21386 3.53045 4.18741
## p3 3.66121 2.79664 4.13699 2.86271 3.17795
## p4 8.61399 9.09654 9.16841 9.10928 8.94949
## p5 2.84004 2.66609 3.03612 3.26561 3.22945
```

```
dim(olf.data)
```

```
## [1] 33297    28
```

```
table(olf.info)
```

```
##          Batch
## Treatment 1 2 3 4
##         1 1 1 1 1
##         2 1 1 1 1
##         3 1 1 1 1
##         4 1 1 1 1
##         5 1 1 1 1
##         6 1 1 1 1
##         7 1 1 1 1
```

## Methylation reference data

The Infinium reference data contains probe-wise summary statistics after batch-effect correction across 5 Infinium Methylation datasets. This reference data is relevant to a particular use case of Harman - epigenome-wide association studies (EWAS).

The EWAS data arise from pediatric blood, buccal cell and saliva samples from studies exploring various epigenetic phenomena in the developmental origins of health and disease (DOHaD).

The reference data are the probe-wise summary statistics characterising the degree batch correction of the below datasets:

| dataset | description |
| --- | --- |
| EpiSCOPE | Epigenome Study Consortium for Obesity primed in the Perinatal Environment (EpiSCOPE), n=369, peripheral blood, 450K |
| EPIC-Italy | European Prospective Investigation into Cancer and Nutrition (EPIC-Italy), n=845, peripheral blood, 450K |
| BodyFatness | Body Fatness and Cardiovascular Health in Newborn Infants (BFiN), n=169, saliva, EPIC |
| NOVI | Neonatal Neurobehavior and Outcomes in Very Preterm Infants (NOVI), n=534, buccal swab, EPIC |
| URECA | Urban Environment and Childhood Asthma (URECA), n=391, cord and peripheral blood, EPIC |

### Infinium5

Post-correction log variance ratio (LVR) statistics and mean differences for ComBat and Harman across 5 datasets. There are 899255 rows in each matrix, one for each CpG site probe in 450K and EPIC designs. EPIC designs have far more probes than 450K designs and some of the 450K probes were retired and not present on EPIC designs. Therefore all datasets will have missing values in some of the rows. `NA` denotes the CpG site probes missing for that particular dataset.

| matrix | description |
| --- | --- |
| `lvr.combat` | LVR statistics for ComBat |
| `lvr.harman` | LVR statistics for Harman |
| `md.combat` | Mean differences for ComBat |
| `md.harman` | Mean differences for Harman |

### Usage

```
## load package
library(HarmanData)
data(Infinium5)
lvr.harman["cg01381374", ]
```

```
##    EpiSCOPE_var_ratio_harman  EPIC-Italy_var_ratio_harman
##                      -1.8059                      -1.7200
## BodyFatness_var_ratio_harman        NOVI_var_ratio_harman
##                      -0.8973                      -0.8842
##       URECA_var_ratio_harman
##                      -0.8127
```

```
md.harman["cg01381374", ]
```

```
##    EpiSCOPE_meandiffs_harman  EPIC-Italy_meandiffs_harman
##                       0.0612                       0.0608
## BodyFatness_meandiffs_harman        NOVI_meandiffs_harman
##                       0.0836                       0.0473
##       URECA_meandiffs_harman
##                       0.1268
```

### episcope

Example beta values from the EpiSCOPE study. A thin slice of reference data to use as an example for the beta clustering functions in Harman. The data contains beta values spanning 11 CpG probesets from the 369 arrays of the EpiSCOPE study (van Dijk, 2106). The 450K methylation data arises from neonate blood spots from children enrolled in the DOMInO (DHA to Optimise Mother Infant Outcome) cohort.

| list slot | description |
| --- | --- |
| `pd` | `Phenotypic descriptors for the 369 samples` |
| `original` | `Original uncorrected data from the study` |
| `harman` | `Harman corrected data` |
| `combat` | `ComBat corrected data` |
| `ref_lvr` | `Reference log2 variance ratios for the 11 probes` |
| `ref_md` | `Reference mean difference in beta for the 11 probes` |

### Usage

```
library(Harman)
data(episcope)
bad_batches <- c(1, 5, 9, 17, 25)
is_bad_sample <- episcope$pd$array_num %in% bad_batches
myK <- discoverClusteredMethylation(episcope$original[, !is_bad_sample])
mykClust = kClusterMethylation(episcope$original, row_ks=myK)
res = clusterStats(pre_betas=episcope$original,
                   post_betas=episcope$harman,
                   kClusters = mykClust)
all.equal(episcope$ref_md$meandiffs_harman, res$meandiffs)
```

```
## [1] TRUE
```

```
all.equal(episcope$ref_lvr$var_ratio_harman, res$log2_var_ratio)
```

```
## [1] TRUE
```

## References

1. Johnson et al. Biostatistics (2007). doi: 10.1093/biostatistics/kxj037.
2. Osmond-McLeod et al. Nanotoxicology (2014). doi: 10.3109/17435390.2013.855832.
3. Osmond-McLeod et al. Part Fibre Toxicol. (2013). doi: 10.1186/1743-8977-10-54.