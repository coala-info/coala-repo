# MPAC: Multi-omic Pathway Analysis of Cells

#### Peng Liu, David Page, Paul Ahlquist, Irene M. Ong, and Anthony Gitter

#### 2025-10-30

# 1 Introduction

From copy-number alteration (CNA), RNA-seq data, and pre-defined biological
pathway network, MPAC computes Inferred Pathway Levels (IPLs) for pathway
entities, clusters patient samples by their enriched GO terms, and identifies
key pathway proteins for each patient cluster.

## 1.1 Workflow

![MPAC workflow](data:image/jpeg;base64...)

Figure 1.1: MPAC workflow

## 1.2 Pseudocode

```
FOR each sample:
    ## Step 1
    prepare CNA states from real data

    prepare RNA states from real data

    ## Step 2
    compute IPLs by PARADIGM using CNA and RNA states from real data as well as
    the input pathway definition

    ## Step 3
    REPEAT 100 times:
        randomly permute CNA and RNA states between genes

        compute IPLs by PARADIGM using CNA and RNA states from permuted data as
        well as the input pathway definition

    ## Step 4
    FOR each pathway entity:
        filter entity’s IPL from real data by its 100 IPLs from permuted data

    ## Step 5
    based on the input pathway definition, select the largest sub-pathway with
    all of its entities with non-zero IPLs

    ## Step 6
    FOR each GO term in GMT file collections:
        do enrichment analysis using genes from the largest sub-pathway

cluster samples by their GO enrichment results

## Step 7
pick a sample group of interest

find submodules shared by the largest sub-pathways of all samples in this group

identify key pathway proteins from submodules

## Step 8
evaluate the correlation of key protein’s IPLs with patients’ clinical data
```

# 2 Installation

## 2.1 From GitHub

Start R and enter:

```
devtools::install_github('pliu55/MPAC')
```

## 2.2 From Bioconductor

Start R and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# The following initializes usage of Bioc devel
BiocManager::install(version='devel')

BiocManager::install("MPAC")
```

For different versions of R, please refer to the appropriate
[Bioconductor release](https://bioconductor.org/about/release-announcements/).

# 3 Required R packages for this vignette

Please use the following code to load required packages for running this
vignette. Many intermediate objects in this vignette are SummarizedExperiment
objects.

```
require(SummarizedExperiment)
require(MPAC)
```

# 4 Main functions

* `ppCnInp()`: prepare CNA states from real CNA data
* `ppRnaInp()`: prepare RNA states from read RNA-seq data
* `ppRealInp()`: prepare CNA and RNA states from read CNA and RNA-seq data
* `ppPermInp():` prepare permuted CNA and RNA states
* `runPrd()`: run PARADIGM to compute IPLs from real CNA and RNA states
* `runPermPrd()`: run PARADIGM to compute IPLs from permuted CNA and RNA states
* `colRealIPL()`: collect IPLs from real data
* `colPermIPL()`: collect IPLs from permuted data
* `fltByPerm()`: filter IPLs from real data by IPLs from permuted data
* `subNtw()`: find the largest pathway network subset by filtered IPLs
* `ovrGMT()`: do gene set over-representation on a sample’s largest pathway
  subset
* `clSamp()`: cluster samples by their gene set over-representation results
* `conMtf()`: find consensus pathway submoduless within a cluster
* `pltConMtf()`: plot consensus pathway submodules
* `pltMtfPrtIPL()`: plot a heatmap of IPLs for proteins from consensus pathway
  submodule(s)
* `pltSttKM()`: plot a Kaplan-Meier curve to find correlation between
  protein(s)’ pathway states and patient survival
* `pltNeiStt()`: plot a heatmap to identify a protein’s pathway determinants
* `pltOvrHm()`: plot a heatmap to identify over-represented GO terms for each
  sample groups

# 5 Preparing input

## 5.1 Requirements

MPAC accepts two types of genomic data:

* copy-number alteration (CNA): recommend using data from
  [focal-level](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/CNV_Pipeline/#data-processing-steps_2).
* RNA-seq: both tumor and normal sample data are required. Recommend using
  normalized gene expression data, e.g. FPKM.

## 5.2 Real data

This section describes preparing PARADIGM input using data from real samples,
which can be downloaded from TCGA or taken from sequencing experiments.

### 5.2.1 Copy-number alteration

```
# a matrix of CN focal data with rows as genes and columns as samples
cn_tumor_mat <- system.file('extdata/TcgaInp/focal_tumor.rds',
                            package='MPAC') |> readRDS()

# to return a SummarizedExperiment object of CNA state for running PARADIGM
# activated, normal, or repressed state is represented by 1, 0, or -1
ppCnInp(cn_tumor_mat)
#> class: SummarizedExperiment
#> dim: 7 71
#> metadata(0):
#> assays(1): CN_state
#> rownames(7): CD28 CD86 ... CD247 FASLG
#> rowData names(0):
#> colnames(71): TCGA-BA-4077 TCGA-BA-5152 ...
#>   TCGA-T2-A6X0 TCGA-UP-A6WW
#> colData names(0):
```

### 5.2.2 RNA-seq

Note that data from normal samples are required here to evaluate if a gene
in tumor samples has activated, repressed, or normal states.

```
# a matrix of RNA-seq data with rows as genes and columns as tumor samples
rna_tumor_mat <- system.file('extdata/TcgaInp/log10fpkmP1_tumor.rds',
                            package='MPAC') |> readRDS()

# a matrix of RNA-seq data with rows as genes and columns as normal samples
rna_norm_mat  <- system.file('extdata/TcgaInp/log10fpkmP1_normal.rds',
                            package='MPAC') |> readRDS()

# to return a SummarizedExperiment object of RNA state for running PARADIGM
# activated, normal, or repressed state is represented by 1, 0, or -1
ppRnaInp(rna_tumor_mat, rna_norm_mat, threads=2)
#> class: SummarizedExperiment
#> dim: 7 71
#> metadata(0):
#> assays(1): RNA_state
#> rownames(7): CD28 CD86 ... CD247 FASLG
#> rowData names(0):
#> colnames(71): TCGA-BA-4077 TCGA-BA-5152 ...
#>   TCGA-T2-A6X0 TCGA-UP-A6WW
#> colData names(0):
```

### 5.2.3 Copy-number alteration and RNA-seq

Simply use a wrapper function below to prepare input together for both CNA
and RNA data

```
# to return a SummarizedExperiment object of CNA and RNA state
real_se <- ppRealInp(cn_tumor_mat, rna_tumor_mat, rna_norm_mat, threads=2)

# CNA state is in assays(real_se)$CN_state
# RNA state is in assays(real_se)$RNA_state
real_se
#> class: SummarizedExperiment
#> dim: 7 71
#> metadata(0):
#> assays(2): CN_state RNA_state
#> rownames(7): CD28 CD86 ... CD247 FASLG
#> rowData names(0):
#> colnames(71): TCGA-BA-4077 TCGA-BA-5152 ...
#>   TCGA-T2-A6X0 TCGA-UP-A6WW
#> colData names(0):
```

## 5.3 Permuted data

Pathway activities from permuted data will be used to build a background
distribution to filter those from real data. The idea is to remove those that
could be observed by chance. Permuted data were from real CNA and RNA data as
shown in the example below.

```
# to return a list of list
perml <- ppPermInp(real_se, n_perms=3)

# three objects under the first level
length(perml)
#> [1] 3

# permutation index
metadata(perml[[1]])$i
#> [1] 1

# permuted CNA state matrix, same as the one from `ppCnInp()`
assays(perml[[1]])$CN_state |> _[1:4, 1:3]
#>         TCGA-BA-4077 TCGA-BA-5152 TCGA-BA-5153
#> CD28               0            0            0
#> CD86               1            0            0
#> LCP2               0            0            0
#> IL12RB1            0            0            0

# permuted RNA state matrix, same as the one from `ppRnaInp()`
assays(perml[[1]])$RNA_state |> _[1:4, 1:3]
#>         TCGA-BA-4077 TCGA-BA-5152 TCGA-BA-5153
#> CD28               1            1            1
#> CD86               0            1            1
#> LCP2               1            0            1
#> IL12RB1            1            1            0
```

# 6 Inferred pathway levels

## 6.1 PARADIGM binary

MPAC uses PARADIGM developed by [Vaske et al.](https://doi.org/10.1093/bioinformatics/btq182) to predict
pathway levels. PARADIGM Binary is available to download at Github for
[Linux](https://github.com/sng87/paradigm-scripts/tree/master/public/exe/LINUX) and [MacOS](https://github.com/sng87/paradigm-scripts/tree/master/public/exe/MACOSX).

## 6.2 IPLs from real data

Example below shows input and output files for running PARADIGM on data from
real samples.

PARADIGM will generate multiple output files. All the file names will start with
the sample ID and a suffix indicating their types:

* Inferred pathway levles (IPLs): file with a suffix `ipl.txt`
* Output log: file with a suffix `run.out`
* Error log: file with a suffix `run.err`
* Other auxiliary files, which can be skipped under common usage

```
# CNA and RNA state from `ppRealInp()`
real_se <- system.file('extdata/TcgaInp/inp_real.rds', package='MPAC') |>
    readRDS()

# Pathway file
fpth <- system.file('extdata/Pth/tiny_pth.txt', package='MPAC')

# folder to save all the output files
outdir <- tempdir()

# PARADIGM binary location. Replace the one below with a true location.
paradigm_bin <- '/path/to/PARADIGM'

### code below depends on external PARADIGM binary
runPrd(real_se, fpth, outdir, paradigm_bin, sampleids=c('TCGA-CV-7100'))
#> PARADIGM binary not found:/path/to/PARADIGM
```

## 6.3 PARADIGM on permuted data

For permuted input, PARADIGM will generate output in the same fashion as on
real data above, except that one permutation corresponds to one output folder
named as `p$(index)`, where `$index` is the index of that permutation. For
example, three permutations will generate folders `p1`, `p2`, and `p3`.

```
# a list of list from `ppPermInp()`
permll <- system.file('extdata/TcgaInp/inp_perm.rds', package='MPAC') |>
    readRDS()

# Pathway file
fpth <- system.file('extdata/Pth/tiny_pth.txt', package='MPAC')

# folder to save all the output files
outdir <- tempdir()

# PARADIGM binary location. Replace the one below with a true location.
paradigm_bin <- '/path/to/PARADIGM'

# (optional) sample IDs to run PARADIGM on
pat <- 'TCGA-CV-7100'

### code below depends on external PARADIGM binary
runPermPrd(permll, fpth, outdir, paradigm_bin, sampleids=c(pat))
#> PARADIGM binary not found:/path/to/PARADIGM
#> PARADIGM binary not found:/path/to/PARADIGM
#> PARADIGM binary not found:/path/to/PARADIGM
```

# 7 Collecting IPLs

MPAC has PARADIGM run on individual sample in parallel to speed up calculation.
For the convenience of downstream analysis, PARADIGM results will be collected
and put together for all samples.

## 7.1 From PARADIGM on real data

```
# the folder saving PARADIGM result on real data
# it should be the `outdir` folder from `runPrd()`
indir <- system.file('/extdata/runPrd/', package='MPAC')

# to return a data.table with columns as entities and IPLs for each sample
colRealIPL(indir) |> head()
#> Key: <entity>
#>                                 entity TCGA-CV-7100
#>                                 <char>        <num>
#> 1: Activated_JAK1__JAK2__TYK2_(family)            0
#> 2:                               CD247            0
#> 3:                                CD28            0
#> 4:                 CD28/CD86_(complex)            0
#> 5:                 CD28_B7-2_(complex)            0
#> 6:  CD28_bound_to_B7_ligands_(complex)            0
```

## 7.2 From PARADIGM on permuted data

```
# the folder saving PARADIGM result on permuted data
# it should be the `outdir` folder from `runPermPrd()`
indir <- system.file('/extdata/runPrd/', package='MPAC')

# number of permutated dataset results to collect
n_perms <- 3

# return a data.table with columns as entities, permutation index, and IPLs for
# each sample
colPermIPL(indir, n_perms) |> head()
#>                                 entity iperm
#>                                 <char> <int>
#> 1: Activated_JAK1__JAK2__TYK2_(family)     1
#> 2:                               CD247     1
#> 3:                                CD28     1
#> 4:                 CD28/CD86_(complex)     1
#> 5:                 CD28_B7-2_(complex)     1
#> 6:  CD28_bound_to_B7_ligands_(complex)     1
#>    TCGA-CV-7100
#>           <num>
#> 1:      0.00000
#> 2:     -0.09873
#> 3:     -0.08027
#> 4:     -0.01183
#> 5:     -0.01175
#> 6:     -0.01175
```

# 8 Filtering IPLs

MPAC uses PARADIGM runs on permuted data to generate a background distribution
of IPLs. This distribution is used to filter IPLs from real data to remove
those could be observed by chance.

```
# collected real IPLs. It is the output from `colRealIPL()`
realdt <- system.file('extdata/fltByPerm/real.rds', package='MPAC') |> readRDS()

# collected permutation IPLs. It is the output from `colPermIPL()`
permdt <- system.file('extdata/fltByPerm/perm.rds', package='MPAC') |> readRDS()

# to return a matrix of filtered IPLs with rows as pathway entities and columns
# as samples. Entities with IPLs observed by chance are set to NA.
fltByPerm(realdt, permdt) |> head()
#>                                     TCGA-BA-5152
#> Activated_JAK1__JAK2__TYK2_(family)           NA
#> CD247                                     0.4511
#> CD28                                      0.4506
#> CD28/CD86_(complex)                       0.6188
#> CD28_B7-2_(complex)                       0.6184
#> CD28_bound_to_B7_ligands_(complex)        0.7762
#>                                     TCGA-CV-7100
#> Activated_JAK1__JAK2__TYK2_(family)           NA
#> CD247                                         NA
#> CD28                                          NA
#> CD28/CD86_(complex)                           NA
#> CD28_B7-2_(complex)                           NA
#> CD28_bound_to_B7_ligands_(complex)            NA
```

# 9 Find the largest pathway subset

MPAC decomposes the original pathway and identify the largest pathway subset
with all of its entities having filtered IPLs. This sub-pathway allows the user
to focus on the most altered pathway network. Note that, because the set of
entities having filtered IPLs are often different between samples, the
pathway subset will be different between samples as well and represent
sample-specific features.

```
# a matrix generated by `fltByPerm()`
fltmat <- system.file('extdata/fltByPerm/flt_real.rds', package='MPAC') |>
        readRDS()

# a pathway file
fpth <- system.file('extdata/Pth/tiny_pth.txt', package='MPAC')

# a gene set file in MSigDB's GMT format. It should be the same file that will
# be used in the over-representation analysis below.
fgmt <- system.file('extdata/ovrGMT/fake.gmt', package='MPAC')

# to return a list of igraph objects representing the larget sub-pathway for
# each sample
subNtw(fltmat, fpth, fgmt, min_n_gmt_gns=1)
#> $`TCGA-BA-5152`
#> IGRAPH 0e012d1 DN-B 11 12 --
#> + attr: name (v/c), type (v/c), ipl (v/n), title
#> | (e/c)
#> + edges from 0e012d1 (vertex names):
#> [1] CD28                    ->CD28/CD86_(complex)
#> [2] CD28                    ->CD28_homodimer_(complex)
#> [3] CD28                    ->Nef_CD28_Complex_(complex)
#> [4] CD28                    ->Phospho_CD28_homodimer_(complex)
#> [5] CD28_homodimer_(complex)->CD28_B7-2_(complex)
#> + ... omitted several edges
#>
#> $`TCGA-CV-7100`
#> IGRAPH ba0d945 DN-B 5 4 --
#> + attr: name (v/c), type (v/c), ipl (v/n), title
#> | (e/c)
#> + edges from ba0d945 (vertex names):
#> [1] LCP2->LAT/PLCgamma1/GRB2/SLP76/GADs_(complex)
#> [2] LCP2->NTAL/PLCgamma1/GRB2/SLP76/GADs_(complex)
#> [3] LCP2->p-SLP-76_VAV_(complex)
#> [4] LCP2->phosphorylated_SLP-76_Gads__LAT_(complex)
```

# 10 Gene set over-representation

To understand the biological functions of a sample’s largest sub-pathway, MPAC
performs gene set over-representation analysis on genes with non-zero IPLs in
the sub-pathway.

```
# a list of igraph objects from `subNtw()`
subntwl <- system.file('extdata/subNtw/subntwl.rds', package='MPAC') |>readRDS()

# a gene set file that has been used in `subNtw()`
fgmt <- system.file('extdata/ovrGMT/fake.gmt',       package='MPAC')

# (optional) genes that have CN and RNA data in the input files for PARADIGM
omic_gns <- system.file('extdata/TcgaInp/inp_focal.rds', package='MPAC') |>
            readRDS() |> rownames()

# to return a matrix of over-representation adjusted p-values with rows as gene
# set and columns as samples
ovrGMT(subntwl, fgmt, omic_gns)
#>         TCGA-BA-5152 TCGA-CV-7100
#> CD_fake       0.6667           NA
#> MI_fake       1.0000            1
```

# 11 Cluster samples by pathway over-representation

With gene set over-representation adjusted p-values, MPAC can cluster samples
as a way to investigate shared features between samples in the same cluster.

Note that, due to randomness introduced in the louvain clustering in igraph R
package version 1.3 (reported in its
[Github issue #539](https://github.com/igraph/rigraph/issues/539)), it is
recommended to run clustering multiple times to evaluate its variation. The
`clSamp()` function has an argument, `n_random_runs`, to specify the number of
random clustering jobs to run.

```
# a matrix of gene set over-representation adjusted p-values from `ovrGMT()`
ovrmat <- system.file('extdata/clSamp/ovrmat.rds', package='MPAC') |> readRDS()

# to return a data.table of clustering result by 5 random runs:
#
# - each row represents a clustering result
# - the first column, `nreps`, indicates the number of occurrences of a
#   clustering result in the 5 random runs
# - the other columns represents each sample's clustering membership
#
clSamp(ovrmat, n_random_runs=5)
#>    nreps TCGA-BA-A4IH TCGA-CN-4741 TCGA-CN-5365
#>    <int>        <int>        <int>        <int>
#> 1:     4            1            1            1
#> 2:     1            1            2            2
#>    TCGA-CN-5374 TCGA-CN-A499 TCGA-CN-A49C TCGA-CQ-5323
#>           <int>        <int>        <int>        <int>
#> 1:            2            1            1            1
#> 2:            1            2            2            2
#>    TCGA-CR-5248 TCGA-CR-6470 TCGA-CR-6480 TCGA-CR-6484
#>           <int>        <int>        <int>        <int>
#> 1:            1            2            1            2
#> 2:            1            1            2            1
#>    TCGA-CR-6491 TCGA-CR-7379 TCGA-CV-7102 TCGA-MZ-A6I9
#>           <int>        <int>        <int>        <int>
#> 1:            2            1            1            1
#> 2:            1            2            1            2
#>    TCGA-P3-A5QE TCGA-TN-A7HI TCGA-TN-A7HL
#>           <int>        <int>        <int>
#> 1:            1            2            2
#> 2:            1            1            1
```

# 12 Find consensus pathway motifs within a cluster

From the clustering results, MPAC can find consensus pathway motifs from samples
within the same clusters. These motifs will represent cluster-specific pathway
features. They often contain key proteins for further analysis.

```
# a list of igraph objects from `subNtw()`
subntwl <- system.file('extdata/conMtf/subntwl.rds', package='MPAC') |>readRDS()

# (optional) genes that have CN and RNA data in the input files for PARADIGM
omic_gns <- system.file('extdata/TcgaInp/inp_focal.rds', package='MPAC') |>
            readRDS() |> rownames()

# to return a list of igraph objects representing consensus motifs
conMtf(subntwl, omic_gns, min_mtf_n_nodes=50)
#> [[1]]
#> IGRAPH 8f21938 DN-- 240 309 --
#> + attr: name (v/c)
#> + edges from 8f21938 (vertex names):
#> [1] ARHGEF7                 ->CBL_Cool-Pix_(complex)
#> [2] ARHGEF7                 ->CDC42/GTP_(complex)
#> [3] B7_family/CD28_(complex)->ITK
#> [4] B7_family/CD28_(complex)->PRF1
#> [5] BTK                     ->BTK-ITK_(family)
#> [6] BTK                     ->CD19_Signalosome_(complex)
#> + ... omitted several edges
```

# 13 Diagnostic plots

## 13.1 Clustered samples by their altered pathways

MPAC provides a function to plot a heatmap of samples clustered by their
significantly over-represented GO terms

```
# GO term adjusted p-values, which are the output of `ovrGMT()`
ovrmat <- system.file('extdata/pltOvrHm/ovr.rds',package='MPAC') |> readRDS()

# clustering information of samples, which is the output of `clSamp()`
cldt   <- system.file('extdata/pltOvrHm/cl.rds', package='MPAC') |> readRDS()

# to plot a heatmap on GO terms significantly over-represented in >= 80% of
# samples in a group
pltOvrHm(ovrmat, cldt, min_frc=0.8)
```

![A heatmap of samples clustered by their altered pathways](data:image/svg+xml;base64...)

Figure 13.1: A heatmap of samples clustered by their altered pathways

## 13.2 Visualize consensus pathway submodules with proteins highlighted

MPAC provides a function to visualize consensus pathway submodules and highlight
the proteins user-supplied.

```
# A list of consensus pathway submodules. It is the output of `conMtf()`
grphl <- system.file('extdata/pltMtfPrtIPL/grphl.rds',package='MPAC') |>
         readRDS()

# Proteins to highlight. Not required--no node in the graph will be highlighted
proteins <- c('CD28', 'CD86', 'LCP2', 'IL12RB1', 'TYK2', 'CD247', 'FASLG',
              'CD3G')

# To plot consensus pathway submodules
pltConMtf(grphl, proteins)
```

![Consensus pathway submodules.](data:image/svg+xml;base64...)

Figure 13.2: Consensus pathway submodules.

## 13.3 Heatmap of IPLs on proteins from consensus pathway submodule(s)

MPAC provides a function to plot heatmap of IPLs on proteins from consensus
pathway submodules. This help to identify proteins with consistent activated,
normal, or repressed pathway states in a cluster of samples.

```
# A matrix of filtered IPL, which is the output of `fltByPerm()`
fltmat <- system.file('extdata/pltSttKM/ipl.rds', package='MPAC') |> readRDS()

# A data.table of sample clustering results. It is the output of `clSamp()`
cldt <- system.file('extdata/pltMtfPrtIPL/cl.rds',package='MPAC')|> readRDS()

# A list of consensus pathway submodules. It is the output of `conMtf()`
grphl <- system.file('extdata/pltMtfPrtIPL/grphl.rds',package='MPAC') |>
         readRDS()

# Proteins to plot
proteins=c('CD28', 'CD86', 'LCP2', 'IL12RB1', 'TYK2', 'CD247', 'FASLG', 'CD3G')

# To plot a heatmap of IPLs on specified proteins
pltMtfPrtIPL(fltmat, cldt, grphl, proteins)
```

![Heatmap of IPLs on proteins from consensus pathway submodules.](data:image/svg+xml;base64...)

Figure 13.3: Heatmap of IPLs on proteins from consensus pathway submodules.

## 13.4 Correlation between protein(s) pathway states and patient survival

MPAC provides a function to plot Kaplan-Meier curve on patient samples
stratified by pathway states of one or multiple proteins.

```
# A matrix containing patient survival information
cdrmat <- system.file('extdata/pltSttKM/cdr.rds', package='MPAC') |> readRDS()

# A matrix of filtered IPL, which is the output of `fltByPerm()`
fltmat <- system.file('extdata/pltSttKM/ipl.rds', package='MPAC') |> readRDS()

# To plot Kaplan-Meier curve using overall survival (OS) event and days from
# `cdrmat` and pathway states of CD247 and FASLG from `fltmat`. Samples are
# stratified by whether having both CD247 and FASLG in activated states, i.e.,
# IPL>0 for both proteins.
pltSttKM(cdrmat, fltmat, event='OS', time='OS_days',
         proteins=c('CD247', 'FASLG'), strat_func='>0')
```

![Kaplan-Meier curve of patient samples stratified by whether             IPLs of CD247 and FASLG are both > 0.](data:image/svg+xml;base64...)

Figure 13.4: Kaplan-Meier curve of patient samples stratified by whether
IPLs of CD247 and FASLG are both > 0.

## 13.5 Display omic and pathway states of a protein and its neighbors

MPAC implemented a diagnostic function to plot a heatmap of the omic and
pathway states of a protein as well as the pathway states of this protein’s
pathway neighbors. This heatmap facilitates the identification of pathway
determinants of this protein.

```
# protein of focus
protein <- 'CD86'

# input pathway file
fpth <- system.file('extdata/Pth/tiny_pth.txt', package='MPAC')

# CNA and RNA state matrix from `ppRealInp()`
real_se <- system.file('extdata/pltNeiStt/inp_real.rds', package='MPAC') |>
    readRDS()

# filtered IPL matrix from `fltByPerm()`
fltmat <- system.file('extdata/pltNeiStt/fltmat.rds', package='MPAC') |>
            readRDS()

# to plot a heatmap
pltNeiStt(real_se, fltmat, fpth, protein)
```

![A heatmap of CD86's omic and pathway state as well as its pathway            neighbor's states.](data:image/svg+xml;base64...)

Figure 13.5: A heatmap of CD86’s omic and pathway state as well as its pathway
neighbor’s states.

# 14 Session Info

Below is the output of `sessionInfo()` on the system on which this document
was compiled.

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8
#>  [2] LC_NUMERIC=C
#>  [3] LC_TIME=en_GB
#>  [4] LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8
#>  [6] LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8
#>  [8] LC_NAME=C
#>  [9] LC_ADDRESS=C
#> [10] LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8
#> [12] LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils
#> [6] datasets  methods   base
#>
#> other attached packages:
#>  [1] SummarizedExperiment_1.40.0
#>  [2] Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0
#>  [4] Seqinfo_1.0.0
#>  [5] IRanges_2.44.0
#>  [6] S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0
#>  [8] generics_0.1.4
#>  [9] MatrixGenerics_1.22.0
#> [10] matrixStats_1.5.0
#> [11] MPAC_1.4.0
#> [12] data.table_1.17.8
#>
#> loaded via a namespace (and not attached):
#>   [1] gridExtra_2.3
#>   [2] rlang_1.1.6
#>   [3] magrittr_2.0.4
#>   [4] clue_0.3-66
#>   [5] GetoptLong_1.0.5
#>   [6] compiler_4.5.1
#>   [7] png_0.1-8
#>   [8] systemfonts_1.3.1
#>   [9] vctrs_0.6.5
#>  [10] stringr_1.5.2
#>  [11] pkgconfig_2.0.3
#>  [12] shape_1.4.6.1
#>  [13] crayon_1.5.3
#>  [14] fastmap_1.2.0
#>  [15] magick_2.9.0
#>  [16] backports_1.5.0
#>  [17] XVector_0.50.0
#>  [18] labeling_0.4.3
#>  [19] scuttle_1.20.0
#>  [20] ggraph_2.2.2
#>  [21] KMsurv_0.1-6
#>  [22] rmarkdown_2.30
#>  [23] purrr_1.1.0
#>  [24] xfun_0.53
#>  [25] bluster_1.20.0
#>  [26] cachem_1.1.0
#>  [27] beachmat_2.26.0
#>  [28] jsonlite_2.0.0
#>  [29] DelayedArray_0.36.0
#>  [30] BiocParallel_1.44.0
#>  [31] tweenr_2.0.3
#>  [32] broom_1.0.10
#>  [33] irlba_2.3.5.1
#>  [34] parallel_4.5.1
#>  [35] cluster_2.1.8.1
#>  [36] R6_2.6.1
#>  [37] stringi_1.8.7
#>  [38] bslib_0.9.0
#>  [39] RColorBrewer_1.1-3
#>  [40] limma_3.66.0
#>  [41] car_3.1-3
#>  [42] jquerylib_0.1.4
#>  [43] Rcpp_1.1.0
#>  [44] bookdown_0.45
#>  [45] iterators_1.0.14
#>  [46] knitr_1.50
#>  [47] zoo_1.8-14
#>  [48] splines_4.5.1
#>  [49] Matrix_1.7-4
#>  [50] igraph_2.2.1
#>  [51] tidyselect_1.2.1
#>  [52] dichromat_2.0-0.1
#>  [53] abind_1.4-8
#>  [54] yaml_2.3.10
#>  [55] viridis_0.6.5
#>  [56] doParallel_1.0.17
#>  [57] codetools_0.2-20
#>  [58] lattice_0.22-7
#>  [59] tibble_3.3.0
#>  [60] withr_3.0.2
#>  [61] S7_0.2.0
#>  [62] evaluate_1.0.5
#>  [63] survival_3.8-3
#>  [64] polyclip_1.10-7
#>  [65] fitdistrplus_1.2-4
#>  [66] survMisc_0.5.6
#>  [67] circlize_0.4.16
#>  [68] ggpubr_0.6.2
#>  [69] pillar_1.11.1
#>  [70] carData_3.0-5
#>  [71] foreach_1.5.2
#>  [72] ggplot2_4.0.0
#>  [73] scales_1.4.0
#>  [74] xtable_1.8-4
#>  [75] glue_1.8.0
#>  [76] metapod_1.18.0
#>  [77] survminer_0.5.1
#>  [78] tools_4.5.1
#>  [79] BiocNeighbors_2.4.0
#>  [80] ScaledMatrix_1.18.0
#>  [81] ggsignif_0.6.4
#>  [82] locfit_1.5-9.12
#>  [83] fgsea_1.36.0
#>  [84] scran_1.38.0
#>  [85] graphlayouts_1.2.2
#>  [86] Cairo_1.7-0
#>  [87] fastmatch_1.1-6
#>  [88] tidygraph_1.3.1
#>  [89] cowplot_1.2.0
#>  [90] grid_4.5.1
#>  [91] tidyr_1.3.1
#>  [92] edgeR_4.8.0
#>  [93] colorspace_2.1-2
#>  [94] SingleCellExperiment_1.32.0
#>  [95] BiocSingular_1.26.0
#>  [96] ggforce_0.5.0
#>  [97] Formula_1.2-5
#>  [98] cli_3.6.5
#>  [99] rsvd_1.0.5
#> [100] km.ci_0.5-6
#> [101] textshaping_1.0.4
#> [102] S4Arrays_1.10.0
#> [103] viridisLite_0.4.2
#> [104] svglite_2.2.2
#> [105] ComplexHeatmap_2.26.0
#> [106] dplyr_1.1.4
#> [107] gtable_0.3.6
#> [108] rstatix_0.7.3
#> [109] sass_0.4.10
#> [110] digest_0.6.37
#> [111] dqrng_0.4.1
#> [112] SparseArray_1.10.0
#> [113] ggrepel_0.9.6
#> [114] rjson_0.2.23
#> [115] farver_2.1.2
#> [116] memoise_2.0.1
#> [117] htmltools_0.5.8.1
#> [118] lifecycle_1.0.4
#> [119] statmod_1.5.1
#> [120] GlobalOptions_0.1.2
#> [121] MASS_7.3-65
```