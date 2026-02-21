# Using wrappper functions

Pascal Belleau, Astrid Deschênes and Alexander Krasnitz

#### 30 October 2025

# Contents

* [1 Main Steps](#main-steps)
  + [1.1 Main Step - Ancestry Inference](#main-step---ancestry-inference)
    - [1.1.1 DNA Data - Wrapper function to run ancestry inference on DNA data](#dna-data---wrapper-function-to-run-ancestry-inference-on-dna-data)
    - [1.1.2 RNA data - Wrapper function to run ancestry inference on RNA data](#rna-data---wrapper-function-to-run-ancestry-inference-on-rna-data)
  + [1.2 Format population reference dataset (optional)](#format-population-reference-dataset-optional)
* [2 Session info](#session-info)
* [References](#references)

**Package**: *RAIDS*
**Authors**: Pascal Belleau [cre, aut] (ORCID:
<https://orcid.org/0000-0002-0802-1071>),
Astrid Deschênes [aut] (ORCID: <https://orcid.org/0000-0001-7846-6749>),
David A. Tuveson [aut] (ORCID: <https://orcid.org/0000-0002-8017-2712>),
Alexander Krasnitz [aut]
**Version**: 1.8.0
**Compiled date**: 2025-10-30
**License**: Apache License (>= 2)

This vignette explains, in further details, the used of the wrapper functions
that were developed for a previous release of RAIDS.

While those functions are still
working, we recommend using the new functions as described in the main
vignette.

# 1 Main Steps

This is an overview of genetic ancestry inference from cancer-derived
molecular data:

![An overview of the genetic ancestry inference process.](data:image/png;base64...)

Figure 1: An overview of the genetic ancestry inference process

The main steps are:

**Step 1.** Format reference data from the population reference dataset (optional)

**Step 2.1** Optimize ancestry inference parameters

**Step 2.2** Infer ancestry for the subjects of the external study

These steps are described in detail in the following. Steps 2.1 and 2.2 can be
run together using one wrapper function.

## 1.1 Main Step - Ancestry Inference

A wrapper function encapsulates multiple steps of the workflow.

![Final step - The wrapper function encapsulates multiple steps of the workflow.](data:image/png;base64...)

Figure 2: Final step - The wrapper function encapsulates multiple steps of the workflow

In summary, the wrapper function generates the synthetic dataset and uses
it to selected the optimal parameters before calling the genetic ancestry
on the current profiles.

According to the type of input data (RNA or DNA), a specific wrapper function
is available.

### 1.1.1 DNA Data - Wrapper function to run ancestry inference on DNA data

The wrapper function, called *runExomeAncestry()*, requires 4 files as input:

* The **population reference GDS file**
* The **population reference SNV Annotation GDS file**
* The **Profile SNP file** (one per sample present in the study)
* The **Profile PED RDS file** (one file with information for all
  profiles in the study)

In addition, a *data.frame* containing the general information about the
study is also required. The *data.frame* must contain those 3 columns:

* *study.id*: The study identifier (example: TCGA-BRCA).
* *study.desc*: The description of the study.
* *study.platform*: The type of sequencing (example: RNA-seq).

#### 1.1.1.1 **Population reference files**

For demonstration purpose, a small
**population reference GDS file** (called *ex1\_good\_small\_1KG.gds*) and a small
**population reference SNV Annotation GDS file** (called
*ex1\_good\_small\_1KG\_Annot.gds*) are
included in this package. Beware that those two files should not be used to
run a real ancestry inference.The results obtained with those files won’t be
reliable.

The required **population reference GDS file** and
**population reference SNV Annotation GDS file** should be stored in the same
directory. In the example below, this directory is referred to
as **pathReference**.

#### 1.1.1.2 **Profile SNP file**

The **Profile SNP file** can be either in a VCF format or in a generic format.

The **Profile SNP VCF file** follows the VCF standard with at least
those genotype fields: *GT*, *AD* and *DP*. The identifier of the genotype
in the VCF file must correspond to the profile identifier *Name.ID*.
The SNVs must be germline variants and should include the genotype of the
wild-type homozygous at the selected positions in the reference. One file per
profile is need and the VCF file must be gzipped.

Note that the name assigned to the **Profile SNP VCF file** has to
correspond to the profile identifier *Name.ID* in the following analysis.
For example, a SNP file called “Sample.01.vcf.gz” would be
associated to the “Sample.01” profile.

A generic SNP file can replace the VCF file. The **Profile SNP Generic file**
format is coma separated and the mandatory columns are:

* *Chromosome*: The name of the chromosome
* *Position*: The position on the chromosome
* *Ref*: The reference nucleotide
* *Alt*: The aternative nucleotide
* *Count*: The total count
* *File1R*: The count for the reference nucleotide
* *File1A*: The count for the alternative nucleotide

Beware that the starting position in the **population reference GDS File** is
zero (like BED files). The **Profile SNP Generic file** should also start
at position zero.

Note that the name assigned to the **Profile SNP Generic file** has to
correspond to the profile identifier *Name.ID* in the following analysis.
For example, a SNP file called “Sample.01.generic.txt.gz” would be
associated to the “Sample.01” profile.

#### 1.1.1.3 **Profile PED RDS file**

The **Profile PED RDS file** must contain a *data.frame* describing all
the profiles to be analyzed. These 5 mandatory columns:

* *Name.ID*: The unique sample identifier. The associated **profile SNP file**
  should be called “Name.ID.txt.gz”.
* *Case.ID*: The patient identifier associated to the sample.
* *Sample.Type*: The information about the profile tissue source
  (primary tumor, metastatic tumor, normal, etc..).
* *Diagnosis*: The donor’s diagnosis.
* *Source*: The source of the profile sequence data (example: dbGAP\_XYZ).

Important: The row names of the *data.frame* must be the profiles *Name.ID*.

This file is referred to as the **Profile PED RDS file** (PED for pedigree).
Alternatively, the PED information can be saved in another type of
file (CVS, etc..) as long as the *data.frame* information can be regenerated
in R (with *read.csv()* or else).

#### 1.1.1.4 **Example**

This example run an ancestry inference on an exome sample. Both population
reference files are demonstration files and should not be
used for a real ancestry inference. Beware that running an ancestry inference
on real data will take longer to run.

```
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)
library(gdsfmt)

## Path to the demo 1KG GDS file is located in this package
dataDir <- system.file("extdata", package="RAIDS")

#############################################################################
## Load the information about the profile
#############################################################################
data(demoPedigreeEx1)
head(demoPedigreeEx1)
```

```
##     Name.ID Case.ID   Sample.Type Diagnosis     Source
## ex1     ex1     ex1 Primary Tumor    Cancer Databank B
```

```
#############################################################################
## The population reference GDS file and SNV Annotation GDS file
## need to be located in the same directory.
## Note that the population reference GDS file used for this example is a
## simplified version and CANNOT be used for any real analysis
#############################################################################
pathReference <- file.path(dataDir, "tests")

fileGDS <- file.path(pathReference, "ex1_good_small_1KG.gds")
fileAnnotGDS <- file.path(pathReference, "ex1_good_small_1KG_Annot.gds")

#############################################################################
## A data frame containing general information about the study
## is also required. The data frame must have
## those 3 columns: "study.id", "study.desc", "study.platform"
#############################################################################
studyDF <- data.frame(study.id="MYDATA",
                   study.desc="Description",
                   study.platform="PLATFORM",
                   stringsAsFactors=FALSE)

#############################################################################
## The Sample SNP VCF files (one per sample) need
## to be all located in the same directory.
#############################################################################
pathGeno <- file.path(dataDir, "example", "snpPileup")

#############################################################################
## Fix RNG seed to ensure reproducible results
#############################################################################
set.seed(3043)

#############################################################################
## Select the profiles from the population reference GDS file for
## the synthetic data.
## Here we select 2 profiles from the simplified 1KG GDS for each
## subcontinental-level.
## Normally, we use 30 profile for each
## subcontinental-level but it is too big for the example.
## The 1KG files in this example only have 6 profiles for each
## subcontinental-level (for demo purpose only).
#############################################################################
gds1KG <- snpgdsOpen(fileGDS)
dataRef <- select1KGPop(gds1KG, nbProfiles=2L)
closefn.gds(gds1KG)

## Seqinfo and BSgenome are required libraries to run this example
if (requireNamespace("Seqinfo", quietly=TRUE) &&
      requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly=TRUE)) {

    ## Chromosome length information
    ## chr23 is chrX, chr24 is chrY and chrM is 25
    chrInfo <- Seqinfo::seqlengths(BSgenome.Hsapiens.UCSC.hg38::Hsapiens)[1:25]

    ###########################################################################
    ## The path where the Sample GDS files (one per sample)
    ## will be created needs to be specified.
    ###########################################################################
    pathProfileGDS <- file.path(tempdir(), "exampleDNA", "out.tmp")

    ###########################################################################
    ## The path where the result files will be created needs to
    ## be specified
    ###########################################################################
    pathOut <- file.path(tempdir(), "exampleDNA", "res.out")

    ## Example can only be run if the current directory is in writing mode
    if (!dir.exists(file.path(tempdir(), "exampleDNA"))) {

        dir.create(file.path(tempdir(), "exampleDNA"))
        dir.create(pathProfileGDS)
        dir.create(pathOut)

        #########################################################################
        ## The wrapper function generates the synthetic dataset and uses it
        ## to selected the optimal parameters before calling the genetic
        ## ancestry on the current profiles.
        ## All important information, for each step, are saved in
        ## multiple output files.
        ## The 'genoSource' parameter has 2 options depending on how the
        ##   SNP files have been generated:
        ##   SNP VCF files have been generated:
        ##  "VCF" or "generic" (other software)
        ##
        #########################################################################
        runExomeAncestry(pedStudy=demoPedigreeEx1, studyDF=studyDF,
                 pathProfileGDS=pathProfileGDS,
                 pathGeno=pathGeno,
                 pathOut=pathOut,
                 fileReferenceGDS=fileGDS,
                 fileReferenceAnnotGDS=fileAnnotGDS,
                 chrInfo=chrInfo,
                 syntheticRefDF=dataRef,
                 genoSource="VCF")
        list.files(pathOut)
        list.files(file.path(pathOut, demoPedigreeEx1$Name.ID[1]))

        #######################################################################
        ## The file containing the ancestry inference (SuperPop column) and
        ## optimal number of PCA component (D column)
        ## optimal number of neighbours (K column)
        #######################################################################
        resAncestry <- read.csv(file.path(pathOut,
                        paste0(demoPedigreeEx1$Name.ID[1], ".Ancestry.csv")))
        print(resAncestry)

        ## Remove temporary files created for this demo
        unlink(pathProfileGDS, recursive=TRUE, force=TRUE)
        unlink(pathOut, recursive=TRUE, force=TRUE)
        unlink(file.path(tempdir(), "exampleDNA"), recursive=TRUE, force=TRUE)
    }
}
```

```
##   sample.id  D K SuperPop
## 1       ex1 14 4      AFR
```

The *runExomeAncestry()* function generates 3 types of files
in the *pathOut* directory.

* The ancestry inference CSV file (**“.Ancestry.csv”** file)
* The inference information RDS file (**“.infoCall.rds”** file)
* The parameter information RDS files from the synthetic inference
  (**"KNN.synt.**\***.rds"** files in a sub-directory)

In addition, a sub-directory (named using the *profile ID*) is
also created.

The inferred ancestry is stored in the ancestry inference CSV
file (**“.Ancestry.csv”** file) which also contains those columns:

* *sample.id*: The unique identifier of the sample
* *D*: The optimal PCA dimension value used to infer the ancestry
* *k*: The optimal number of neighbors value used to infer the ancestry
* *SuperPop*: The inferred ancestry

### 1.1.2 RNA data - Wrapper function to run ancestry inference on RNA data

The process is the same as for the DNA but use the wrapper function
called *runRNAAncestry()*. Internally the data is process differently.
It requires 4 files as input:

* The **population reference GDS file**
* The **population reference SNV Annotation GDS file**
* The **Profile SNP file** (one per sample present in the study)
* The **Profile PED RDS file** (one file with information for all
  profiles in the study)

A *data.frame* containing the general information about the study is
also required. The *data.frame* must contain those 3 columns:

* *study.id*: The study identifier (example: TCGA-BRCA).
* *study.desc*: The description of the study.
* *study.platform*: The type of sequencing (example: RNA-seq).

#### 1.1.2.1 **Population reference files**

For demonstration purpose, a small
**population reference GDS file** (called *ex1\_good\_small\_1KG.gds*) and a small
**population reference SNV Annotation GDS file** (called
*ex1\_good\_small\_1KG\_Annot.gds*) are
included in this package. Beware that those two files should not be used to
run a real ancestry inference.The results obtained with those files won’t be
reliable.

The required **population reference GDS file** and
**population reference SNV Annotation GDS file** should be stored in the same
directory. In the example below, this directory is referred to
as **pathReference**.

#### 1.1.2.2 **Profile SNP file**

The **Profile SNP file** can be either in a VCF format or in a generic format.

The **Profile SNP VCF file** follows the VCF standard with at least
those genotype fields: *GT*, *AD* and *DP*. The identifier of the genotype
in the VCF file must correspond to the profile identifier *Name.ID*.
The SNVs must be germline variants and should include the genotype of the
wild-type homozygous at the selected positions in the reference. One file per
profile is need and the VCF file must be gzipped.

Note that the name assigned to the **Profile SNP VCF file** has to
correspond to the profile identifier *Name.ID* in the following analysis.
For example, a SNP file called “Sample.01.vcf.gz” would be
associated to the “Sample.01” profile.

A generic SNP file can replace the VCF file. The **Profile SNP Generic file**
format is coma separated and the mandatory columns are:

* *Chromosome*: The name of the chromosome
* *Position*: The position on the chromosome
* *Ref*: The reference nucleotide
* *Alt*: The aternative nucleotide
* *Count*: The total count
* *File1R*: The count for the reference nucleotide
* *File1A*: The count for the alternative nucleotide

Beware that the starting position in the **population reference GDS File** is
zero (like BED files). The **Profile SNP Generic file** should also start
at position zero.

Note that the name assigned to the **Profile SNP Generic file** has to
correspond to the profile identifier *Name.ID* in the following analysis.
For example, a SNP file called “Sample.01.generic.txt.gz” would be
associated to the “Sample.01” profile.

#### 1.1.2.3 **Profile PED RDS file**

The **Profile PED RDS file** must contain a *data.frame* describing all
the profiles to be analyzed. These 5 mandatory columns:

* *Name.ID*: The unique sample identifier. The associated **profile SNP file**
* *Case.ID*: The patient identifier associated to the sample.
* *Sample.Type*: The information about the profile tissue source
  (primary tumor, metastatic tumor, normal, etc..).
* *Diagnosis*: The donor’s diagnosis.
* *Source*: The source of the profile sequence data (example: dbGAP\_XYZ).

Important: The row names of the *data.frame* must be the profiles *Name.ID*.

This file is referred to as the **Profile PED RDS file** (PED for pedigree).
Alternatively, the PED information can be saved in another type of
file (CVS, etc..) as long as the *data.frame* information can be regenerated
in R (with *read.csv()* or else).

#### 1.1.2.4 **Example**

This example run an ancestry inference on an RNA sample. Both population
reference files are demonstration files and should not be
used for a real ancestry inference. Beware that running an ancestry inference
on real data will take longer to run.

```
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)
library(gdsfmt)

## Path to the demo 1KG GDS file is located in this package
dataDir <- system.file("extdata", package="RAIDS")

#############################################################################
## Load the information about the profile
#############################################################################
data(demoPedigreeEx1)
head(demoPedigreeEx1)
```

```
##     Name.ID Case.ID   Sample.Type Diagnosis     Source
## ex1     ex1     ex1 Primary Tumor    Cancer Databank B
```

```
#############################################################################
## The population reference GDS file and SNV Annotation GDS file
## need to be located in the same directory.
## Note that the population reference GDS file used for this example is a
## simplified version and CANNOT be used for any real analysis
#############################################################################
pathReference <- file.path(dataDir, "tests")

fileGDS <- file.path(pathReference, "ex1_good_small_1KG.gds")
fileAnnotGDS <- file.path(pathReference, "ex1_good_small_1KG_Annot.gds")

#############################################################################
## A data frame containing general information about the study
## is also required. The data frame must have
## those 3 columns: "study.id", "study.desc", "study.platform"
#############################################################################
studyDF <- data.frame(study.id="MYDATA",
                   study.desc="Description",
                   study.platform="PLATFORM",
                   stringsAsFactors=FALSE)

#############################################################################
## The Sample SNP VCF files (one per sample) need
## to be all located in the same directory.
#############################################################################
pathGeno <- file.path(dataDir, "example", "snpPileupRNA")

#############################################################################
## Fix RNG seed to ensure reproducible results
#############################################################################
set.seed(3043)

#############################################################################
## Select the profiles from the population reference GDS file for
## the synthetic data.
## Here we select 2 profiles from the simplified 1KG GDS for each
## subcontinental-level.
## Normally, we use 30 profile for each
## subcontinental-level but it is too big for the example.
## The 1KG files in this example only have 6 profiles for each
## subcontinental-level (for demo purpose only).
#############################################################################
gds1KG <- snpgdsOpen(fileGDS)
dataRef <- select1KGPop(gds1KG, nbProfiles=2L)
closefn.gds(gds1KG)

## Seqinfo and BSgenome are required libraries to run this example
if (requireNamespace("Seqinfo", quietly=TRUE) &&
      requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly=TRUE)) {

  ## Chromosome length information
  ## chr23 is chrX, chr24 is chrY and chrM is 25
  chrInfo <- Seqinfo::seqlengths(BSgenome.Hsapiens.UCSC.hg38::Hsapiens)[1:25]

  #############################################################################
  ## The path where the Sample GDS files (one per sample)
  ## will be created needs to be specified.
  #############################################################################
  pathProfileGDS <- file.path(tempdir(), "exampleRNA", "outRNA.tmp")

  #############################################################################
  ## The path where the result files will be created needs to
  ## be specified
  #############################################################################
  pathOut <- file.path(tempdir(), "exampleRNA", "resRNA.out")

  ## Example can only be run if the current directory is in writing mode
  if (!dir.exists(file.path(tempdir(), "exampleRNA"))) {

      dir.create(file.path(tempdir(), "exampleRNA"))
      dir.create(pathProfileGDS)
      dir.create(pathOut)

      #########################################################################
      ## The wrapper function generates the synthetic dataset and uses it
      ## to selected the optimal parameters before calling the genetic
      ## ancestry on the current profiles.
      ## All important information, for each step, are saved in
      ## multiple output files.
      ## The 'genoSource' parameter has 2 options depending on how the
      ##   SNP files have been generated:
      ##   SNP VCF files have been generated:
      ##  "VCF" or "generic" (other software)
      #########################################################################
      runRNAAncestry(pedStudy=demoPedigreeEx1, studyDF=studyDF,
                    pathProfileGDS=pathProfileGDS,
                    pathGeno=pathGeno,
                    pathOut=pathOut,
                    fileReferenceGDS=fileGDS,
                    fileReferenceAnnotGDS=fileAnnotGDS,
                    chrInfo=chrInfo,
                    syntheticRefDF=dataRef,
                    blockTypeID="GeneS.Ensembl.Hsapiens.v86",
                    genoSource="VCF")

      list.files(pathOut)
      list.files(file.path(pathOut, demoPedigreeEx1$Name.ID[1]))

      #########################################################################
      ## The file containing the ancestry inference (SuperPop column) and
      ## optimal number of PCA component (D column)
      ## optimal number of neighbours (K column)
      #########################################################################
      resAncestry <- read.csv(file.path(pathOut,
                        paste0(demoPedigreeEx1$Name.ID[1], ".Ancestry.csv")))
      print(resAncestry)

      ## Remove temporary files created for this demo
      unlink(pathProfileGDS, recursive=TRUE, force=TRUE)
      unlink(pathOut, recursive=TRUE, force=TRUE)
      unlink(file.path(tempdir(), "example"), recursive=TRUE, force=TRUE)
  }
}
```

```
##   sample.id  D K SuperPop
## 1       ex1 14 4      AFR
```

The *runRNAAncestry()* function generates 3 types of files
in the *pathOut* directory.

* The ancestry inference CSV file (**“.Ancestry.csv”** file)
* The inference information RDS file (**“.infoCall.rds”** file)
* The parameter information RDS files from the synthetic inference
  (**"KNN.synt.**\***.rds"** files in a sub-directory)

In addition, a sub-directory (named using the *profile ID*) is
also created.

The inferred ancestry is stored in the ancestry inference CSV
file (**“.Ancestry.csv”** file) which also contains those columns:

* *sample.id*: The unique identifier of the sample
* *D*: The optimal PCA dimension value used to infer the ancestry
* *k*: The optimal number of neighbors value used to infer the ancestry
* *SuperPop*: The inferred ancestry

## 1.2 Format population reference dataset (optional)

![Step 1 - Formatting the information from the population reference dataset (optional)](data:image/png;base64...)

Figure 3: Step 1 - Formatting the information from the population reference dataset (optional)

A population reference dataset with known ancestry is required to infer
ancestry.

Three important reference files, containing formatted information about
the reference dataset, are required:

* The population reference GDS File
* The population reference SNV Annotation GDS file
* The population reference SNV Retained VCF file

The format of those files are described
the [Population reference dataset GDS files](Create_Reference_GDS_File.html)
vignette.

The reference files associated to
the Cancer Research associated paper are available. Note that these
pre-processed files are for 1000 Genomes (1KG), in hg38. The files are
available here:

<https://labshare.cshl.edu/shares/krasnitzlab/aicsPaper>

The size of the 1KG GDS file
is 15GB.

The 1KG GDS file is mapped on
hg38 (Lowy-Gallego et al. [2019](#ref-Lowy-Gallego2019a)).

This section can be skipped if
you choose to use the pre-processed files.

# 2 Session info

Here is the output of `sessionInfo()` in the environment in which this
document was compiled:

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
##  [1] Matrix_1.7-4         RAIDS_1.8.0          Rsamtools_2.26.0
##  [4] Biostrings_2.78.0    XVector_0.50.0       GenomicRanges_1.62.0
##  [7] IRanges_2.44.0       S4Vectors_0.48.0     Seqinfo_1.0.0
## [10] BiocGenerics_0.56.0  generics_0.1.4       dplyr_1.1.4
## [13] GENESIS_2.40.0       SNPRelate_1.44.0     gdsfmt_1.46.0
## [16] knitr_1.50           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3                jsonlite_2.0.0
##   [3] shape_1.4.6.1                     magrittr_2.0.4
##   [5] magick_2.9.0                      TH.data_1.1-4
##   [7] estimability_1.5.1                jomo_2.7-6
##   [9] GenomicFeatures_1.62.0            farver_2.1.2
##  [11] logistf_1.26.1                    nloptr_2.2.1
##  [13] rmarkdown_2.30                    BiocIO_1.20.0
##  [15] vctrs_0.6.5                       memoise_2.0.1
##  [17] minqa_1.2.8                       RCurl_1.98-1.17
##  [19] quantsmooth_1.76.0                tinytex_0.57
##  [21] htmltools_0.5.8.1                 S4Arrays_1.10.0
##  [23] curl_7.0.0                        broom_1.0.10
##  [25] pROC_1.19.0.1                     SparseArray_1.10.0
##  [27] mitml_0.4-5                       sass_0.4.10
##  [29] bslib_0.9.0                       sandwich_3.1-1
##  [31] emmeans_2.0.0                     zoo_1.8-14
##  [33] cachem_1.1.0                      GenomicAlignments_1.46.0
##  [35] lifecycle_1.0.4                   iterators_1.0.14
##  [37] pkgconfig_2.0.3                   R6_2.6.1
##  [39] fastmap_1.2.0                     rbibutils_2.3
##  [41] MatrixGenerics_1.22.0             digest_0.6.37
##  [43] GWASTools_1.56.0                  AnnotationDbi_1.72.0
##  [45] RSQLite_2.4.3                     labeling_0.4.3
##  [47] httr_1.4.7                        abind_1.4-8
##  [49] mgcv_1.9-3                        compiler_4.5.1
##  [51] withr_3.0.2                       bit64_4.6.0-1
##  [53] S7_0.2.0                          backports_1.5.0
##  [55] BiocParallel_1.44.0               DBI_1.2.3
##  [57] pan_1.9                           MASS_7.3-65
##  [59] quantreg_6.1                      DelayedArray_0.36.0
##  [61] rjson_0.2.23                      DNAcopy_1.84.0
##  [63] tools_4.5.1                       lmtest_0.9-40
##  [65] nnet_7.3-20                       glue_1.8.0
##  [67] restfulr_0.0.16                   nlme_3.1-168
##  [69] grid_4.5.1                        gtable_0.3.6
##  [71] operator.tools_1.6.3              BSgenome_1.78.0
##  [73] formula.tools_1.7.1               class_7.3-23
##  [75] tidyr_1.3.1                       ensembldb_2.34.0
##  [77] data.table_1.17.8                 GWASExactHW_1.2
##  [79] stringr_1.5.2                     foreach_1.5.2
##  [81] pillar_1.11.1                     splines_4.5.1
##  [83] lattice_0.22-7                    survival_3.8-3
##  [85] rtracklayer_1.70.0                bit_4.6.0
##  [87] SparseM_1.84-2                    BSgenome.Hsapiens.UCSC.hg38_1.4.5
##  [89] tidyselect_1.2.1                  SeqVarTools_1.48.0
##  [91] reformulas_0.4.2                  bookdown_0.45
##  [93] ProtGenerics_1.42.0               SummarizedExperiment_1.40.0
##  [95] RhpcBLASctl_0.23-42               xfun_0.53
##  [97] Biobase_2.70.0                    matrixStats_1.5.0
##  [99] stringi_1.8.7                     UCSC.utils_1.6.0
## [101] lazyeval_0.2.2                    yaml_2.3.10
## [103] boot_1.3-32                       evaluate_1.0.5
## [105] codetools_0.2-20                  cigarillo_1.0.0
## [107] tibble_3.3.0                      BiocManager_1.30.26
## [109] cli_3.6.5                         rpart_4.1.24
## [111] xtable_1.8-4                      Rdpack_2.6.4
## [113] jquerylib_0.1.4                   dichromat_2.0-0.1
## [115] GenomeInfoDb_1.46.0               Rcpp_1.1.0
## [117] coda_0.19-4.1                     png_0.1-8
## [119] XML_3.99-0.19                     parallel_4.5.1
## [121] MatrixModels_0.5-4                ggplot2_4.0.0
## [123] blob_1.2.4                        AnnotationFilter_1.34.0
## [125] bitops_1.0-9                      lme4_1.1-37
## [127] glmnet_4.1-10                     SeqArray_1.50.0
## [129] mvtnorm_1.3-3                     VariantAnnotation_1.56.0
## [131] scales_1.4.0                      purrr_1.1.0
## [133] crayon_1.5.3                      rlang_1.1.6
## [135] KEGGREST_1.50.0                   multcomp_1.4-29
## [137] mice_3.18.0
```

# References

Lowy-Gallego, Ernesto, Susan Fairley, Xiangqun Zheng-Bradley, Magali Ruffier, Laura Clarke, and Paul Flicek. 2019. “Variant calling on the grch38 assembly with the data from phase three of the 1000 genomes project [version 2; peer review: 1 approved, 1 not approved].” *Wellcome Open Research* 4: 1–42. <https://doi.org/10.12688/wellcomeopenres.15126.1>.