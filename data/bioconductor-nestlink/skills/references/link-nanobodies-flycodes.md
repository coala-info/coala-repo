# Link high quality flycodes and nanobody sequences by NGS filtering

Lennart Opitz1\* and Christian Panse1\*\*

1Functional Genomics Center Zurich

\*lennart.opitz@fgcz.ethz.ch
\*\*cp@fgcz.ethz.ch

#### 2018-08-29, 2018-11-08

#### Abstract

This vignette demonstrates the processing of raw reads from NGS to generate the flycode to nanobody linkage used in the proteomics data analysis. The workflow includes several filtering steps to extract high quality nanobody and flycode amino acid sequences.

#### Package

NestLink 1.26.0

# Contents

* [1 Load Package](#load-package)
* [2 Load Data](#load-data)
* [3 Define Input & Output-Folder](#define-input-output-folder)
* [4 Load known nanobodies (NB) for QC Checks](#load-known-nanobodies-nb-for-qc-checks)
* [5 Set Example Parameters](#set-example-parameters)
* [6 Run NGS Workflow](#run-ngs-workflow)
* [7 Create Input FASTA File for Proteomics Analysis](#create-input-fasta-file-for-proteomics-analysis)
* [8 Session info](#session-info)

The following content is described in more detail in Egloff et al. ([2018](#ref-NestLink)), (under review NMETH-A35040).

# 1 Load Package

```
library(NestLink)
```

# 2 Load Data

```
library(ExperimentHub)

eh <- ExperimentHub()

query(eh, "NestLink")
```

```
## ExperimentHub with 8 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Functional Genomics Center Zurich (FGCZ)
## # $species: NA
## # $rdataclass: data.frame, DNAStringSet
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH2063"]]'
##
##            title
##   EH2063 | Sample NGS NB FC linkage data
##   EH2064 | Flycodes tryptic digested
##   EH2065 | Nanobodies tryptic digested
##   EH2066 | FASTA as ground-truth for unit testing
##   EH2067 | Known nanobodies
##   EH2068 | Quantitaive results for SMEG and COLI
##   EH2069 | F255744 Mascot Search result
##   EH2070 | WU160118 Mascot Search results
```

# 3 Define Input & Output-Folder

```
# dataFolder <- file.path(path.package(package = 'NestLink'), 'extdata')
# expFile <- list.files(dataFolder, pattern='*.fastq.gz', full.names = TRUE)

expFile <- query(eh, c("NestLink", "NL42_100K.fastq.gz"))[[1]]
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
scratchFolder <- tempdir()
setwd(scratchFolder)
```

# 4 Load known nanobodies (NB) for QC Checks

For data QC some known NB were spiked in.
Here, we load the NB DNA sequences and translate them to the corresponding AA sequences.

```
# knownNB_File <- list.files(dataFolder,
#      pattern='knownNB.txt', full.names = TRUE)
knownNB_File <- query(eh, c("NestLink", "knownNB.txt"))[[1]]
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
knownNB_data <- read.table(knownNB_File, sep='\t',
      header = TRUE, row.names = 1, stringsAsFactors = FALSE)

knownNB <- Biostrings::translate(DNAStringSet(knownNB_data$Sequence))
names(knownNB) <- rownames(knownNB_data)
knownNB <- sapply(knownNB, toString)
```

# 5 Set Example Parameters

The workflow uses the first 100 reads only for a rapid processing time.

```
param <- list()
param[['nReads']] <- 100 #Number of Reads from the start of fastq file to process
param[['maxMismatch']] <- 1 #Number of accepted mismatches for all pattern search steps
param[['NB_Linker1']] <- "GGCCggcggGGCC" #Linker Sequence left to nanobody
param[['NB_Linker2']] <- "GCAGGAGGA" #Linker Sequence right to nanobody
param[['ProteaseSite']] <- "TTAGTCCCAAGA" #Sequence next to flycode
param[['FC_Linker']] <- "GGCCaaggaggcCGG" #Linker Sequence next to flycode
param[['knownNB']] <- knownNB
param[['minRelBestHitFreq']] <- 0.8 #minimal fraction of the dominant nanobody for a specific flycode
param[['minConsensusScore']] <- 0.9 #minimal fraction per sequence position in nanabody consensus sequence calculation
param[['minNanobodyLength']] <- 348 #minimal nanobody length in [nt]
param[['minFlycodeLength']] <- 33  #minimal flycode length in [nt]
param[['FCminFreq']] <- 1 #minimal number of subreads for a specific flycode to keep it in the analysis
```

# 6 Run NGS Workflow

The following steps are included:

* read FASTQ
* filter
* extract
* translate into AA sequences

```
system.time(NB2FC <- runNGSAnalysis(file = expFile[1], param))
```

```
##    user  system elapsed
##   2.174   0.107   2.274
```

# 7 Create Input FASTA File for Proteomics Analysis

```
head(NB2FC, 2)
```

```
##                                                                                                                          NB
## 1 SQVQLVESGGGLVQAGGSLRLSCAASGFPVEAHRMYWYRQAPGKEREWVAAISSKGQQTWYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCNVKDYGWYYGDYDYWGQGTQVTVS
## 2 SQVQLVESGGGLVQAGGSLRLSCAASGFPVSWTKMYWYRQAPGKEREWVAAIWSTGSWTKYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCNVKDKGHQHAHYDYWGQGTQVTVS
##   FlycodeCount
## 1           29
## 2            3
##                                                                                                                                                                                                                                                                                                                                                                                                                AssociatedFlycodes
## 1 GSAAATAVTWR,GSADGQETDWR,GSADVPEAVWLTVR,GSAPTAPVSWQEGGR,GSAVDPVTVWLTVR,GSDAEGVAAWQSR,GSDAEYTTAWR,GSDDTDETDWR,GSDEAEEEGWQEGGR,GSDPGTDDEWQSR,GSDTEDWEEWQSR,GSDVWDTAVWLTVR,GSEGTDAVGWLTVR,GSEPASEVVWQEGGR,GSEPDVYTAWLTVR,GSEVLDGDEWR,GSFVASFAVWLTVR,GSGDVEGEAWQEGGR,GSGPDPPYGWLR,GSPAVDPPVWLTVR,GSPDEVEVVWLTVR,GSPDSPPAYWLTVR,GSPTVVTFLWR,GSQYTLTPTWLTVR,GSSDAASPSWLTVR,GSTGEDGVVWLTVR,GSTVVTSDPWLTVR,GSVDDQPDTWQEGGR,GSYTPGSTSWQSR
## 2                                                                                                                                                                                                                                                                                                                                                                                      GSADFPVVAWLR,GSAEVDEADWQEGGR,GSEPDVAAGWQSR
##   NB_Name
## 1
## 2
```

```
head(nanobodyFlycodeLinking.as.fasta(NB2FC))
```

```
## [1] ">NB0001 FC29 SQVQLVESGGGLVQAGGSLRLSCAASGFPVEAHRMYWYRQAPGKEREWVAAISSKGQQTWYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCNVKDYGWYYGDYDYWGQGTQVTVS\nGSAAATAVTWRGSADGQETDWRGSADVPEAVWLTVRGSAPTAPVSWQEGGRGSAVDPVTVWLTVRGSDAEGVAAWQSRGSDAEYTTAWRGSDDTDETDWRGSDEAEEEGWQEGGRGSDPGTDDEWQSRGSDTEDWEEWQSRGSDVWDTAVWLTVRGSEGTDAVGWLTVRGSEPASEVVWQEGGRGSEPDVYTAWLTVRGSEVLDGDEWRGSFVASFAVWLTVRGSGDVEGEAWQEGGRGSGPDPPYGWLRGSPAVDPPVWLTVRGSPDEVEVVWLTVRGSPDSPPAYWLTVRGSPTVVTFLWRGSQYTLTPTWLTVRGSSDAASPSWLTVRGSTGEDGVVWLTVRGSTVVTSDPWLTVRGSVDDQPDTWQEGGRGSYTPGSTSWQSR\n"
## [2] ">NB0002 FC3 SQVQLVESGGGLVQAGGSLRLSCAASGFPVSWTKMYWYRQAPGKEREWVAAIWSTGSWTKYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCNVKDKGHQHAHYDYWGQGTQVTVS\nGSADFPVVAWLRGSAEVDEADWQEGGRGSEPDVAAGWQSR\n"
## [3] ">NB0003 FC1 SQVQLVESGGGLVQAGGSLRLSCAASGFPVSWWKMYWYRQAPGKEREWVAAIWSEGWWTKYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCNVKDYGGENANYDYWGQGTQVTVS\nGSDGTTEDAWQEGGR\n"
## [4] ">NB0004 FC1 SQVQLVESGGGLVQAGGSLRLSCAASGFPVEWSWMYWYRQAPGKEREWVAAIYSQGRGTEYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCNVKDYGWWYGDYDYWGQGTQVTVS\nGSEEAADPAWR\n"
## [5] ">NB0005 FC1 SQVQLVESGGGLVQAGGSLRLSCAASGFPVEAHRMYWYRQAPGKEREWVAAISSKGQQTWYADSVKGRFTISRDNAKNTVYLQMNSLEPEDTAVYYCNVKDYGWYYGDYDYWGQGTQVTVS\nGSEEAEATWWR\n"
## [6] ">NB0006 FC2 SQVQLVESGGGLVQAGGSLRLSCAASGFPVEENFMYWYRQAPGKEREWVAAIYSHGYETEYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCNVKDQGYWWWEYDYWGQGTQVTVS\nGSGLPATPAWLRGSTDAEEGVWLTVR\n"
```

To analyze the expressed flycodes mass spectrometry is used.
the FASTA file containing the nanobody - flycode linkage can
be written to a file using functions such as `cat`.

The exec directory provides alternative shell scripts
using command line GNU tools and AWK.

# 8 Session info

Here is the output of the `sessionInfo()` command.

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
##  [1] scales_1.4.0                ggplot2_4.0.0
##  [3] NestLink_1.26.0             ShortRead_1.68.0
##  [5] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           Rsamtools_2.26.0
## [11] GenomicRanges_1.62.0        BiocParallel_1.44.0
## [13] protViz_0.7.9               gplots_3.2.0
## [15] Biostrings_2.78.0           Seqinfo_1.0.0
## [17] XVector_0.50.0              IRanges_2.44.0
## [19] S4Vectors_0.48.0            ExperimentHub_3.0.0
## [21] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [23] dbplyr_2.5.1                BiocGenerics_0.56.0
## [25] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            bitops_1.0-9         deldir_2.0-4
##  [4] httr2_1.2.1          rlang_1.1.6          magrittr_2.0.4
##  [7] compiler_4.5.1       RSQLite_2.4.3        mgcv_1.9-3
## [10] png_0.1-8            vctrs_0.6.5          pwalign_1.6.0
## [13] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
## [16] magick_2.9.0         labeling_0.4.3       caTools_1.18.3
## [19] rmarkdown_2.30       tinytex_0.57         purrr_1.1.0
## [22] bit_4.6.0            xfun_0.54            cachem_1.1.0
## [25] cigarillo_1.0.0      jsonlite_2.0.0       blob_1.2.4
## [28] DelayedArray_0.36.0  jpeg_0.1-11          parallel_4.5.1
## [31] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
## [34] jquerylib_0.1.4      Rcpp_1.1.0           bookdown_0.45
## [37] knitr_1.50           splines_4.5.1        Matrix_1.7-4
## [40] tidyselect_1.2.1     dichromat_2.0-0.1    abind_1.4-8
## [43] yaml_2.3.10          codetools_0.2-20     hwriter_1.3.2.1
## [46] curl_7.0.0           lattice_0.22-7       tibble_3.3.0
## [49] withr_3.0.2          KEGGREST_1.50.0      S7_0.2.0
## [52] evaluate_1.0.5       pillar_1.11.1        BiocManager_1.30.26
## [55] filelock_1.0.3       KernSmooth_2.23-26   BiocVersion_3.22.0
## [58] gtools_3.9.5         glue_1.8.0           tools_4.5.1
## [61] interp_1.1-6         grid_4.5.1           latticeExtra_0.6-31
## [64] AnnotationDbi_1.72.0 nlme_3.1-168         cli_3.6.5
## [67] rappdirs_0.3.3       S4Arrays_1.10.0      dplyr_1.1.4
## [70] gtable_0.3.6         sass_0.4.10          digest_0.6.37
## [73] SparseArray_1.10.1   farver_2.1.2         memoise_2.0.1
## [76] htmltools_0.5.8.1    lifecycle_1.0.4      httr_1.4.7
## [79] bit64_4.6.0-1
```

Egloff, Pascal, Iwan Zimmermann, Fabian M. Arnold, Cedric A. J. Hutter, Damien Damien Morger, Lennart Opitz, Lucy Poveda, et al. 2018. “Engineered Peptide Barcodes for In-Depth Analyses of Binding Protein Ensembles.” *bioRxiv*. <https://doi.org/10.1101/287813>.