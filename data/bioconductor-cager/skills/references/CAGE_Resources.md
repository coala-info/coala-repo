# Use of CAGE resources with CAGEr

Vanja Haberle and Charles Plessy

#### 29 October 2025

#### Package

CAGEr 2.16.0

# Contents

* [1 Available CAGE data resources](#available-cage-data-resources)
  + [1.1 FANTOM5](#fantom5)
  + [1.2 FANTOM3 and 4](#fantom3-and-4)
  + [1.3 ENCODE cell lines](#encode-cell-lines)
  + [1.4 Zebrafish developmental timecourse](#zebrafish-developmental-timecourse)
* [2 Importing public TSS data for manipulation in *CAGEr*](#importing-public-tss-data-for-manipulation-in-cager)
  + [2.1 FANTOM5 human and mouse samples](#fantom5-human-and-mouse-samples)
  + [2.2 *FANTOM3and4CAGE* data package](#fantom3and4cage-data-package)
  + [2.3 *ENCODEprojectCAGE* data package](#encodeprojectcage-data-package)
  + [2.4 *ZebrafishDevelopmentalCAGE* data package](#zebrafishdevelopmentalcage-data-package)
* [Session info](#session-info)
* [References](#references)

# 1 Available CAGE data resources

There are several large collections of CAGE data available that provide single
base-pair resolution TSSs for numerous human and mouse primary cells, cell lines
and tissues. Together with several minor datasets for other model organisms
(*Drosophila melanogaster*, *Danio rerio*) they are a valuable resource that
provides cell/tissue type and developmental stage specific TSSs essential for
any type of promoter centred analysis. By enabling direct and user-friendly
import of TSSs for selected samples into R, *CAGEr* facilitates the integration
of these precise TSS data with other genomic data types. Each of the available
CAGE data resources accessible from within *CAGEr* is explained in more detail
further below.

## 1.1 FANTOM5

FANTOM consortium provides single base-pair resolution TSS data for numerous
human and mouse primary cells, cell lines and tissues. The main FANTOM5
publication (Consortium [2014](#ref-Consortium:2014hz)) released ~1000 human and ~400 mouse CAGE
samples that cover the vast majority of human primary cell types, mouse
developmental tissues and a large number of commonly used cell lines. These data
is available from FANTOM web resource <http://fantom.gsc.riken.jp/5/data/> in
the form of TSS files with genomic coordinates and number of tags mapping to
each TSS detected by CAGE. The list of all available samples for both human and
mouse (as presented in the Supplementary Table 1 of the publication) has been
included in *CAGEr* to facilitate browsing, searching and selecting samples
of interest. TSSs for selected samples are then fetched directly form the web
resource and imported into a `CAGEexp` object enabling their further
manipulation with *CAGEr*.

## 1.2 FANTOM3 and 4

Previous FANTOM projects (3 and 4) (Consortium [2005](#ref-Consortium:2005kp)) (Faulkner et al. [2009](#ref-Faulkner:2009fw)) (Suzuki et al. [2009](#ref-Suzuki:2009gy))
produced CAGE datasets for multiple human and mouse tissues as well as several
timecourses, including differentiation of a THP-1 human myeloid leukemia cell
line. All this TSS data has been grouped into datasets by the organism and
tissue of origin and has been collected into an R data package named
*FANTOM3and4CAGE*, which is available from Bioconductor <https://bioconductor.org/packages/FANTOM3and4CAGE>.
The vignette accompanying the package provides information on available datasets
and lists of samples. When the data package is installed, *CAGEr* can import the
TSSs for selected samples directly into a `CAGEexp` object for further
manipulation.

## 1.3 ENCODE cell lines

ENCODE consortium produced CAGE data for common human cell lines
(Djebali et al. [2012](#ref-Djebali:2012hc)), which were used by ENCODE for various other types of
genome-wide analyses. The advantage of this dataset is that it enables the
integration of precise TSSs from a specific cell line with many other
genome-wide data types provided by ENCODE for the same cell line. However, the
format of CAGE data provided by ENCODE at UCSC (<http://genome.ucsc.edu/ENCODE/dataMatrix/encodeDataMatrixHuman.html>)
includes only raw mapped CAGE tags and their coverage along the genome, and
coordinates of enriched genomic regions (peaks), which do not take advantage of
the single base-pair resolution provided by CAGE. To address this, we have used
the raw CAGE tags to derive single base-pair resolution TSSs and collected them
into an R data package named *ENCODEprojectCAGE*. This data package is
available for download from CAGEr web site at <http://promshift.genereg.net/CAGEr>
and includes TSSs for 36 different cell lines fractionated by cellular
compartment. The vignette accompanying the package provides information on
available datasets and lists of individual samples. Once the package has been
downloaded and installed, *CAGEr* can access it to import TSS data for
selected subset of samples for further manipulation and integration.

## 1.4 Zebrafish developmental timecourse

Precise TSSs are also available for zebrafish (*Danio Rerio*) from CAGE data
published by (Nepal et al. [2013](#ref-Nepal:2013)). The timecourse covering early
embryonic development of zebrafish includes 12 developmental stages. The TSS
data has been collected into an R data package named *ZebrafishDevelopmentalCAGE*,
which is available for download from CAGEr web site at <http://promshift.genereg.net/CAGEr>.
As with other data packages mentioned above, once the package is installed
*CAGEr* can use it to import stage-specific single base pair TSSs into a
`CAGEexp` object.

# 2 Importing public TSS data for manipulation in *CAGEr*

The data from above mentioned resources can be imported into a `CAGEexp` object
using the `importPublicData()` function. It function has four arguments: `source`,
`dataset`, `group` and `sample`. Argument `source` accepts one of the following
values: `"FANTOM5"`, `"FANTOM3and4"`, `"ENCODE"`, or `"ZebrafishDevelopment"`,
which refer to one of the four resources listed above. The following sections
explain how to utilize this function for each of the four currently supported
resources.

## 2.1 FANTOM5 human and mouse samples

Lists of all human and mouse CAGE samples produced within FANTOM5 project are
available in *CAGEr*. To load the information on human samples type:

```
library(CAGEr)
data(FANTOM5humanSamples)
head(FANTOM5humanSamples)
```

```
##                                                     sample      type
## 143      acantholytic_squamous_carcinoma_cell_line_HCC1806 cell line
## 46   acute_lymphoblastic_leukemia__B-ALL__cell_line_BALL-1 cell line
## 75   acute_lymphoblastic_leukemia__B-ALL__cell_line_NALM-6 cell line
## 24  acute_lymphoblastic_leukemia__T-ALL__cell_line_HPB-ALL cell line
## 48   acute_lymphoblastic_leukemia__T-ALL__cell_line_Jurkat cell line
## 250     acute_myeloid_leukemia__FAB_M0__cell_line_Kasumi-3 cell line
##                                                description library_id
## 143      acantholytic squamous carcinoma cell line:HCC1806  CNhs11844
## 46   acute lymphoblastic leukemia (B-ALL) cell line:BALL-1  CNhs11251
## 75   acute lymphoblastic leukemia (B-ALL) cell line:NALM-6  CNhs11282
## 24  acute lymphoblastic leukemia (T-ALL) cell line:HPB-ALL  CNhs10746
## 48   acute lymphoblastic leukemia (T-ALL) cell line:Jurkat  CNhs11253
## 250     acute myeloid leukemia (FAB M0) cell line:Kasumi-3  CNhs13241
##                                                                                                                                                                                                      data_url
## 143                    http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/acantholytic%2520squamous%2520carcinoma%2520cell%2520line%253aHCC1806.CNhs11844.10717-109I6.hg19.ctss.bed.gz
## 46     http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/acute%2520lymphoblastic%2520leukemia%2520%2528B-ALL%2529%2520cell%2520line%253aBALL-1.CNhs11251.10455-106G5.hg19.ctss.bed.gz
## 75     http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/acute%2520lymphoblastic%2520leukemia%2520%2528B-ALL%2529%2520cell%2520line%253aNALM-6.CNhs11282.10534-107G3.hg19.ctss.bed.gz
## 24    http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/acute%2520lymphoblastic%2520leukemia%2520%2528T-ALL%2529%2520cell%2520line%253aHPB-ALL.CNhs10746.10429-106D6.hg19.ctss.bed.gz
## 48     http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/acute%2520lymphoblastic%2520leukemia%2520%2528T-ALL%2529%2520cell%2520line%253aJurkat.CNhs11253.10464-106H5.hg19.ctss.bed.gz
## 250 http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.LQhCAGE/acute%2520myeloid%2520leukemia%2520%2528FAB%2520M0%2529%2520cell%2520line%253aKasumi-3.CNhs13241.10789-110H6.hg19.ctss.bed.gz
```

```
nrow(FANTOM5humanSamples)
```

```
## [1] 988
```

There are 988 human samples in total and for each the following information is provided:

* `sample`: a unique name/label of the sample which should be provided to
  `importPublicData()` function to retrieve given sample
* `type`: type of sample, which can be “cell line”, “primary cell” or “tissue”
* `description`: short description of the sample as provided in FANTOM5 main
  publication (Consortium [2014](#ref-Consortium:2014hz))
* `library_id`: unique ID of the CAGE library within FANTOM5
* `data_url`: URL to corresponding CTSS file at FANTOM5 web resource from which
  the data is fetched

Provided information facilitates searching for samples of interest, *e.g.* we
can search for astrocyte samples:

```
astrocyteSamples <-
  FANTOM5humanSamples[grep("Astrocyte", FANTOM5humanSamples[,"description"]),]
astrocyteSamples
```

```
##                                  sample         type
## 343      Astrocyte_-_cerebellum__donor1 primary cell
## 537      Astrocyte_-_cerebellum__donor2 primary cell
## 562      Astrocyte_-_cerebellum__donor3 primary cell
## 286 Astrocyte_-_cerebral_cortex__donor1 primary cell
## 429 Astrocyte_-_cerebral_cortex__donor2 primary cell
## 472 Astrocyte_-_cerebral_cortex__donor3 primary cell
##                             description library_id
## 343      Astrocyte - cerebellum, donor1  CNhs11321
## 537      Astrocyte - cerebellum, donor2  CNhs12081
## 562      Astrocyte - cerebellum, donor3  CNhs12117
## 286 Astrocyte - cerebral cortex, donor1  CNhs10864
## 429 Astrocyte - cerebral cortex, donor2  CNhs11960
## 472 Astrocyte - cerebral cortex, donor3  CNhs12005
##                                                                                                                                                                        data_url
## 343          http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.primary_cell.hCAGE/Astrocyte%2520-%2520cerebellum%252c%2520donor1.CNhs11321.11500-119F6.hg19.ctss.bed.gz
## 537          http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.primary_cell.hCAGE/Astrocyte%2520-%2520cerebellum%252c%2520donor2.CNhs12081.11580-120F5.hg19.ctss.bed.gz
## 562          http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.primary_cell.hCAGE/Astrocyte%2520-%2520cerebellum%252c%2520donor3.CNhs12117.11661-122F5.hg19.ctss.bed.gz
## 286 http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.primary_cell.hCAGE/Astrocyte%2520-%2520cerebral%2520cortex%252c%2520donor1.CNhs10864.11235-116D2.hg19.ctss.bed.gz
## 429 http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.primary_cell.hCAGE/Astrocyte%2520-%2520cerebral%2520cortex%252c%2520donor2.CNhs11960.11316-117D2.hg19.ctss.bed.gz
## 472 http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.primary_cell.hCAGE/Astrocyte%2520-%2520cerebral%2520cortex%252c%2520donor3.CNhs12005.11392-118C6.hg19.ctss.bed.gz
```

```
data(FANTOM5mouseSamples)
head(FANTOM5mouseSamples)
```

```
##                                                                           sample
## 144 J2E_erythroblastic_leukemia_response_to_erythropoietin__00hr00min__biol_rep1
## 145 J2E_erythroblastic_leukemia_response_to_erythropoietin__00hr00min__biol_rep2
## 146 J2E_erythroblastic_leukemia_response_to_erythropoietin__00hr00min__biol_rep3
## 91                           Atoh1+_Inner_ear_hair_cells_-_organ_of_corti__pool1
## 111       CD326+_enterocyte_isolated_from_mice__treated_with_RANKL__day03__pool1
## 109      CD326++_enterocyte_isolated_from_mice__treated_with_RANKL__day03__pool1
##             type
## 144    cell line
## 145    cell line
## 146    cell line
## 91  primary cell
## 111 primary cell
## 109 primary cell
##                                                                      description
## 144 J2E erythroblastic leukemia response to erythropoietin, 00hr00min, biol_rep1
## 145 J2E erythroblastic leukemia response to erythropoietin, 00hr00min, biol_rep2
## 146 J2E erythroblastic leukemia response to erythropoietin, 00hr00min, biol_rep3
## 91                           Atoh1+ Inner ear hair cells - organ of corti, pool1
## 111       CD326+ enterocyte isolated from mice, treated with RANKL, day03, pool1
## 109      CD326++ enterocyte isolated from mice, treated with RANKL, day03, pool1
##     library_id
## 144  CNhs12449
## 145  CNhs12668
## 146  CNhs12770
## 91   CNhs12533
## 111  CNhs13242
## 109  CNhs13236
##                                                                                                                                                                                                                                                 data_url
## 144                    http://fantom.gsc.riken.jp/5/datafiles/latest/basic/mouse.timecourse.hCAGE/J2E%2520erythroblastic%2520leukemia%2520response%2520to%2520erythropoietin%252c%252000hr00min%252c%2520biol_rep1.CNhs12449.13063-139I3.mm9.ctss.bed.gz
## 145                    http://fantom.gsc.riken.jp/5/datafiles/latest/basic/mouse.timecourse.hCAGE/J2E%2520erythroblastic%2520leukemia%2520response%2520to%2520erythropoietin%252c%252000hr00min%252c%2520biol_rep2.CNhs12668.13129-140G6.mm9.ctss.bed.gz
## 146                    http://fantom.gsc.riken.jp/5/datafiles/latest/basic/mouse.timecourse.hCAGE/J2E%2520erythroblastic%2520leukemia%2520response%2520to%2520erythropoietin%252c%252000hr00min%252c%2520biol_rep3.CNhs12770.13195-141E9.mm9.ctss.bed.gz
## 91                                  http://fantom.gsc.riken.jp/5/datafiles/latest/basic/mouse.primary_cell.LQhCAGE/Atoh1%252b%2520Inner%2520ear%2520hair%2520cells%2520-%2520organ%2520of%2520corti%252c%2520pool1.CNhs12533.12158-128G7.mm9.ctss.bed.gz
## 111      http://fantom.gsc.riken.jp/5/datafiles/latest/basic/mouse.primary_cell.LQhCAGE/CD326%252b%2520enterocyte%2520isolated%2520from%2520mice%252c%2520treated%2520with%2520RANKL%252c%2520day03%252c%2520pool1.CNhs13242.11850-124I5.mm9.ctss.bed.gz
## 109 http://fantom.gsc.riken.jp/5/datafiles/latest/basic/mouse.primary_cell.LQhCAGE/CD326%252b%252b%2520enterocyte%2520isolated%2520from%2520mice%252c%2520treated%2520with%2520RANKL%252c%2520day03%252c%2520pool1.CNhs13236.11852-124I7.mm9.ctss.bed.gz
```

```
nrow(FANTOM5mouseSamples)
```

```
## [1] 395
```

To import TSS data for samples of interest from FANTOM5 we use the `importPublicData()`
function and set the argument `source = "FANTOM5"`. The `dataset` argument can
be set to either `"human"` or `"mouse"`, and the `sample` argument is provided
by a vector of sample lables/names. For example, names of astrocyte samples from
above are:

```
astrocyteSamples[,"sample"]
```

```
## [1] "Astrocyte_-_cerebellum__donor1"      "Astrocyte_-_cerebellum__donor2"
## [3] "Astrocyte_-_cerebellum__donor3"      "Astrocyte_-_cerebral_cortex__donor1"
## [5] "Astrocyte_-_cerebral_cortex__donor2" "Astrocyte_-_cerebral_cortex__donor3"
```

and to import first three samples type:

```
astrocyteCAGEexp <- importPublicData(origin = "FANTOM5", dataset = "human",
                    sample = astrocyteSamples[1:3,"sample"])
```

The resulting `astrocyteCAGEexp` is a `CAGEexp` object that can be included in
the *CAGEr* workflow described above to perform normalisation, clustering,
visualisation, etc.

## 2.2 *FANTOM3and4CAGE* data package

To use TSS data from FANTOM3 and FANTOM4 projects, a data package
*FANTOM3and4CAGE* has to be installed and loaded. This package is available
from Bioconductor and can be installed by calling:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("FANTOM3and4CAGE")
```

For the list of available datasets with group and sample labels for specific human or mouse samples load the data package and get list of samples:

```
library(FANTOM3and4CAGE)
data(FANTOMhumanSamples)
head(FANTOMhumanSamples)
```

```
##                 dataset           group          sample
## 1 FANTOMtissueCAGEhuman        cerebrum        cerebrum
## 2 FANTOMtissueCAGEhuman    renal_artery    renal_artery
## 3 FANTOMtissueCAGEhuman          ureter          ureter
## 4 FANTOMtissueCAGEhuman urinary_bladder urinary_bladder
## 5 FANTOMtissueCAGEhuman          kidney      malignancy
## 6 FANTOMtissueCAGEhuman          kidney          kidney
```

```
data(FANTOMmouseSamples)
head(FANTOMmouseSamples)
```

```
##                 dataset           group
## 1 FANTOMtissueCAGEmouse           brain
## 2 FANTOMtissueCAGEmouse           brain
## 3 FANTOMtissueCAGEmouse           brain
## 4 FANTOMtissueCAGEmouse           brain
## 5 FANTOMtissueCAGEmouse cerebral_cortex
## 6 FANTOMtissueCAGEmouse     hippocampus
##                                          sample
## 1                                         brain
## 2                      CCL-131_Neuro-2a_control
## 3  CCL-131_Neuro-2a_treatment_for_6hr_with_MPP+
## 4 CCL-131_Neuro-2a_treatment_for_12hr_with_MPP+
## 5                               cerebral_cortex
## 6                                   hippocampus
```

In the above data frames, the columns `dataset`, `group` and `sample` provide
values that should be passed to corresponding arguments in `importPublicData()`
function. For example to import human kidney normal and malignancy samples call:

```
kidneyCAGEexp <- importPublicData(origin = "FANTOM3and4",
            dataset = "FANTOMtissueCAGEhuman",
            group = "kidney", sample = c("kidney", "malignancy"))
```

When the samples belong to different groups or different datasets, it is
necessary to provide the dataset and group assignment for each sample separately:

Note: this functionality is disable for the moment. Please open an issue if you
need it.

```
mixedCAGEexp <- importPublicData(origin = "FANTOM3and4",
        dataset = c("FANTOMtissueCAGEmouse", "FANTOMtissueCAGEmouse",
        "FANTOMtimecourseCAGEmouse"), group = c("liver", "liver",
        "liver_under_constant_darkness"),
        sample = c("cloned_mouse", "control_mouse", "4_hr"))
```

For more details about datasets available in the *FANTOM3and4CAGE* data package
please refer to the vignette accompanying the package.

## 2.3 *ENCODEprojectCAGE* data package

TSS data derived from ENCODE CAGE datasets has been collected into
*ENCODEprojectCAGE* data package, which is available for download from the
*CAGEr* web site (<http://promshift.genereg.net/CAGEr/>). Downloaded package can
be installed from local using `install.packages()` function from within R and
used with *CAGEr* as described below.
List of datasets available in this data package can be obtained like this:

```
library(ENCODEprojectCAGE)
data(ENCODEhumanCellLinesSamples)
```

The information provided in this data frame is analogous to the one in
previously discussed data package and provides values to be used with
`importPublicData()` function. The command to import whole cell CAGE samples for
three different cell lines would look like this:

Note: this functionality is disable for the moment. Please open an issue if you
need it.

```
ENCODEset <- importPublicData(origin = "ENCODE",
    dataset = c("A549", "H1-hESC", "IMR90"),
    group = c("cell", "cell", "cell"), sample = c("A549_cell_rep1",
    "H1-hESC_cell_rep1", "IMR90_cell_rep1"))
```

For more details about datasets available in the *ENCODEprojectCAGE* data
package please refer to the vignette accompanying the package.

## 2.4 *ZebrafishDevelopmentalCAGE* data package

The zebrafish TSS data for 12 developmental stages is collected in
*ZebrafishDevelopmentalCAGE* data package, which is also available for download
from the *CAGEr* web site (<http://promshift.genereg.net/CAGEr/>). It can be
installed from local using `install.packages()` function. To get a list of
samples within the package type:

```
library(ZebrafishDevelopmentalCAGE)
data(ZebrafishSamples)
```

In this package there is only one dataset called `ZebrafishCAGE` and all samples
belong to the same group called `development`. To import selected samples from
this dataset type:

```
zebrafishCAGEexp <- importPublicData(origin = "ZebrafishDevelopment",
            dataset = "ZebrafishCAGE", group = "development",
            sample = c("zf_64cells", "zf_prim6"))
```

For more details please refer to the vignette accompanying the data package.

Importing TSS data from any of the four above explained resources results in the
`CAGEexp` object that can be directly included into the workflow provided by
*CAGEr* to perform normalisation, clustering, promoter width analysis,
visualisation, *etc*. This high-resolution TSS data can then easily be
integrated with other genomic data types to perform various promoter-centred
analyses, which does not rely on annotation but uses precise and matched
cell/tissue type TSSs.

# Session info

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
##  [1] FANTOM3and4CAGE_1.45.0      CAGEr_2.16.0
##  [3] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       rstudioapi_0.17.1        jsonlite_2.0.0
##   [4] magrittr_2.0.4           GenomicFeatures_1.62.0   farver_2.1.2
##   [7] rmarkdown_2.30           BiocIO_1.20.0            vctrs_0.6.5
##  [10] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
##  [13] base64enc_0.1-3          htmltools_0.5.8.1        S4Arrays_1.10.0
##  [16] BiocBaseUtils_1.12.0     progress_1.2.3           curl_7.0.0
##  [19] SparseArray_1.10.0       Formula_1.2-5            sass_0.4.10
##  [22] KernSmooth_2.23-26       bslib_0.9.0              htmlwidgets_1.6.4
##  [25] plyr_1.8.9               Gviz_1.54.0              httr2_1.2.1
##  [28] cachem_1.1.0             GenomicAlignments_1.46.0 lifecycle_1.0.4
##  [31] pkgconfig_2.0.3          Matrix_1.7-4             R6_2.6.1
##  [34] fastmap_1.2.0            digest_0.6.37            colorspace_2.1-2
##  [37] AnnotationDbi_1.72.0     Hmisc_5.2-4              RSQLite_2.4.3
##  [40] vegan_2.7-2              filelock_1.0.3           mgcv_1.9-3
##  [43] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [46] bit64_4.6.0-1            htmlTable_2.4.3          S7_0.2.0
##  [49] backports_1.5.0          CAGEfightR_1.30.0        BiocParallel_1.44.0
##  [52] DBI_1.2.3                biomaRt_2.66.0           MASS_7.3-65
##  [55] rappdirs_0.3.3           DelayedArray_0.36.0      rjson_0.2.23
##  [58] permute_0.9-8            gtools_3.9.5             tools_4.5.1
##  [61] foreign_0.8-90           nnet_7.3-20              glue_1.8.0
##  [64] restfulr_0.0.16          nlme_3.1-168             stringdist_0.9.15
##  [67] grid_4.5.1               checkmate_2.3.3          reshape2_1.4.4
##  [70] cluster_2.1.8.1          operator.tools_1.6.3     gtable_0.3.6
##  [73] BSgenome_1.78.0          formula.tools_1.7.1      ensembldb_2.34.0
##  [76] data.table_1.17.8        hms_1.1.4                XVector_0.50.0
##  [79] pillar_1.11.1            stringr_1.5.2            splines_4.5.1
##  [82] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [85] rtracklayer_1.70.0       bit_4.6.0                deldir_2.0-4
##  [88] biovizBase_1.58.0        tidyselect_1.2.1         Biostrings_2.78.0
##  [91] knitr_1.50               gridExtra_2.3            bookdown_0.45
##  [94] ProtGenerics_1.42.0      xfun_0.53                VGAM_1.1-13
##  [97] stringi_1.8.7            UCSC.utils_1.6.0         lazyeval_0.2.2
## [100] yaml_2.3.10              som_0.3-5.2              evaluate_1.0.5
## [103] codetools_0.2-20         cigarillo_1.0.0          interp_1.1-6
## [106] tibble_3.3.0             BiocManager_1.30.26      cli_3.6.5
## [109] rpart_4.1.24             jquerylib_0.1.4          dichromat_2.0-0.1
## [112] Rcpp_1.1.0               GenomeInfoDb_1.46.0      dbplyr_2.5.1
## [115] png_0.1-8                XML_3.99-0.19            parallel_4.5.1
## [118] ggplot2_4.0.0            assertthat_0.2.1         blob_1.2.4
## [121] prettyunits_1.2.0        latticeExtra_0.6-31      jpeg_0.1-11
## [124] AnnotationFilter_1.34.0  bitops_1.0-9             VariantAnnotation_1.56.0
## [127] scales_1.4.0             crayon_1.5.3             rlang_1.1.6
## [130] KEGGREST_1.50.0
```

# References

Consortium, The FANTOM. 2005. “The Transcriptional Landscape of the Mammalian Genome.” *Science* 309 (5740): 1559–63.

———. 2014. “A promoter-level mammalian expression atlas.” *Nature* 507 (7493): 462–70.

Djebali, Sarah, Carrie A Davis, Angelika Merkel, Alex Dobin, Timo Lassmann, Ali Mortazavi, Andrea Tanzer, et al. 2012. “Landscape of transcription in human cells.” *Nature* 488 (7414): 101–8.

Faulkner, Geoffrey J, Yasumasa Kimura, Carsten O Daub, Shivangi Wani, Charles Plessy, Katharine M Irvine, Kate Schroder, et al. 2009. “The regulated retrotransposon transcriptome of mammalian cells.” *Nature Genetics* 41 (5): 563–71.

Nepal, Chirag, Yavor Hadzhiev, Christopher Previti, Vanja Haberle, Nan Li, Hazuki Takahashi, Ana Maria S. Suzuki, et al. 2013. “Dynamic regulation of coding and non-coding transcription initiation landscape at single nucleotide resolution during vertebrate embryogenesis.” *Genome Research* 23 (11): 1938–50.

Suzuki, Harukazu, Alistair R R Forrest, Erik van Nimwegen, Carsten O Daub, Piotr J Balwierz, Katharine M Irvine, Timo Lassmann, et al. 2009. “The transcriptional network that controls growth arrest and differentiation in a human myeloid leukemia cell line.” *Nature Genetics* 41 (5): 553–62.