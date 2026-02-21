# Code example from 'MPAC' vignette. See references/ for full tutorial.

## ----setup, include = FALSE--------------------------
knitr::opts_chunk$set( cache = TRUE, collapse = TRUE, echo = TRUE,
    message = FALSE, warning = FALSE, fig.align = 'center',
    dev.args=list(fix_text_size=FALSE ), comment = "#>")

options( htmltools.dir.version = FALSE, formatR.indent = 2,
    width = 55, digits = 4, warnPartialMatchAttr = FALSE,
    warnPartialMatchDollar = FALSE, tinytex.verbose=TRUE)

require(data.table)

require(MPAC)

## ----WorkflowJPG, fig.cap='MPAC workflow', out.width='800px', echo=FALSE----
knitr::include_graphics('workflow.jpg')

## ----pseudocode, eval=FALSE--------------------------
# FOR each sample:
#     ## Step 1
#     prepare CNA states from real data
# 
#     prepare RNA states from real data
# 
#     ## Step 2
#     compute IPLs by PARADIGM using CNA and RNA states from real data as well as
#     the input pathway definition
# 
#     ## Step 3
#     REPEAT 100 times:
#         randomly permute CNA and RNA states between genes
# 
#         compute IPLs by PARADIGM using CNA and RNA states from permuted data as
#         well as the input pathway definition
# 
#     ## Step 4
#     FOR each pathway entity:
#         filter entity’s IPL from real data by its 100 IPLs from permuted data
# 
#     ## Step 5
#     based on the input pathway definition, select the largest sub-pathway with
#     all of its entities with non-zero IPLs
# 
#     ## Step 6
#     FOR each GO term in GMT file collections:
#         do enrichment analysis using genes from the largest sub-pathway
# 
# cluster samples by their GO enrichment results
# 
# ## Step 7
# pick a sample group of interest
# 
# find submodules shared by the largest sub-pathways of all samples in this group
# 
# identify key pathway proteins from submodules
# 
# ## Step 8
# evaluate the correlation of key protein’s IPLs with patients’ clinical data

## ----installFromGitHub, eval=FALSE-------------------
# devtools::install_github('pliu55/MPAC')

## ----installFromBioconductor, eval=FALSE-------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # The following initializes usage of Bioc devel
# BiocManager::install(version='devel')
# 
# BiocManager::install("MPAC")

## ----requiredPkg-------------------------------------
require(SummarizedExperiment)
require(MPAC)

## ----ppCnInp-----------------------------------------
# a matrix of CN focal data with rows as genes and columns as samples
cn_tumor_mat <- system.file('extdata/TcgaInp/focal_tumor.rds',
                            package='MPAC') |> readRDS()

# to return a SummarizedExperiment object of CNA state for running PARADIGM
# activated, normal, or repressed state is represented by 1, 0, or -1
ppCnInp(cn_tumor_mat)

## ----ppRnaInp----------------------------------------
# a matrix of RNA-seq data with rows as genes and columns as tumor samples
rna_tumor_mat <- system.file('extdata/TcgaInp/log10fpkmP1_tumor.rds',
                            package='MPAC') |> readRDS()

# a matrix of RNA-seq data with rows as genes and columns as normal samples
rna_norm_mat  <- system.file('extdata/TcgaInp/log10fpkmP1_normal.rds',
                            package='MPAC') |> readRDS()

# to return a SummarizedExperiment object of RNA state for running PARADIGM
# activated, normal, or repressed state is represented by 1, 0, or -1
ppRnaInp(rna_tumor_mat, rna_norm_mat, threads=2)

## ----ppRealInp---------------------------------------
# to return a SummarizedExperiment object of CNA and RNA state 
real_se <- ppRealInp(cn_tumor_mat, rna_tumor_mat, rna_norm_mat, threads=2)

# CNA state is in assays(real_se)$CN_state
# RNA state is in assays(real_se)$RNA_state
real_se

## ----ppPermInp---------------------------------------
# to return a list of list
perml <- ppPermInp(real_se, n_perms=3)

# three objects under the first level
length(perml)

# permutation index
metadata(perml[[1]])$i

# permuted CNA state matrix, same as the one from `ppCnInp()`
assays(perml[[1]])$CN_state |> _[1:4, 1:3]

# permuted RNA state matrix, same as the one from `ppRnaInp()`
assays(perml[[1]])$RNA_state |> _[1:4, 1:3]

## ----echo=FALSE--------------------------------------
prd_paper_url='https://doi.org/10.1093/bioinformatics/btq182'
prd_exe_url = paste0('https://github.com/sng87/paradigm-scripts/tree/',
    'master/public/exe/')
prd_linux_url= paste0(prd_exe_url, 'LINUX')
prd_macos_url= paste0(prd_exe_url, 'MACOSX')

## ----runRealPrd--------------------------------------
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

## ----runPermPrd--------------------------------------
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

## ----colRealIPL--------------------------------------
# the folder saving PARADIGM result on real data
# it should be the `outdir` folder from `runPrd()`
indir <- system.file('/extdata/runPrd/', package='MPAC')

# to return a data.table with columns as entities and IPLs for each sample
colRealIPL(indir) |> head()

## ----colPermIPL--------------------------------------
# the folder saving PARADIGM result on permuted data
# it should be the `outdir` folder from `runPermPrd()`
indir <- system.file('/extdata/runPrd/', package='MPAC')

# number of permutated dataset results to collect
n_perms <- 3

# return a data.table with columns as entities, permutation index, and IPLs for
# each sample
colPermIPL(indir, n_perms) |> head()

## ----fltByPerm---------------------------------------
# collected real IPLs. It is the output from `colRealIPL()`
realdt <- system.file('extdata/fltByPerm/real.rds', package='MPAC') |> readRDS()

# collected permutation IPLs. It is the output from `colPermIPL()`
permdt <- system.file('extdata/fltByPerm/perm.rds', package='MPAC') |> readRDS()

# to return a matrix of filtered IPLs with rows as pathway entities and columns
# as samples. Entities with IPLs observed by chance are set to NA.
fltByPerm(realdt, permdt) |> head()

## ----subNtw------------------------------------------
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

## ----ovrGMT------------------------------------------
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

## ----clSamp------------------------------------------
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

## ----conMtf------------------------------------------
# a list of igraph objects from `subNtw()`
subntwl <- system.file('extdata/conMtf/subntwl.rds', package='MPAC') |>readRDS()

# (optional) genes that have CN and RNA data in the input files for PARADIGM
omic_gns <- system.file('extdata/TcgaInp/inp_focal.rds', package='MPAC') |>
            readRDS() |> rownames()

# to return a list of igraph objects representing consensus motifs
conMtf(subntwl, omic_gns, min_mtf_n_nodes=50)

## ----pltOvrHm----------------------------------------
# GO term adjusted p-values, which are the output of `ovrGMT()`
ovrmat <- system.file('extdata/pltOvrHm/ovr.rds',package='MPAC') |> readRDS()

# clustering information of samples, which is the output of `clSamp()`
cldt   <- system.file('extdata/pltOvrHm/cl.rds', package='MPAC') |> readRDS()

# to plot a heatmap on GO terms significantly over-represented in >= 80% of
# samples in a group
pltOvrHm(ovrmat, cldt, min_frc=0.8)

## ----pltConMtf---------------------------------------
# A list of consensus pathway submodules. It is the output of `conMtf()`
grphl <- system.file('extdata/pltMtfPrtIPL/grphl.rds',package='MPAC') |>
         readRDS()

# Proteins to highlight. Not required--no node in the graph will be highlighted
proteins <- c('CD28', 'CD86', 'LCP2', 'IL12RB1', 'TYK2', 'CD247', 'FASLG', 
              'CD3G')

# To plot consensus pathway submodules
pltConMtf(grphl, proteins)

## ----pltMtfPrtIPL------------------------------------
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

## ----pltSttKM----------------------------------------
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

## ----pltNeiStt---------------------------------------
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

## ----sessionInfo, echo=FALSE-------------------------
sessionInfo()

