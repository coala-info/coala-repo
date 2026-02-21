# An Introduction to MMAPPR2

Kyle Johnsen1

1Brigham Young University, Provo, UT

#### 29 October 2019

#### Abstract

Instructions on mapping mutations from forward genetic screens using MMAPPR2.

#### Package

MMAPPR2 1.0.0

# 1 Getting Started

## 1.1 Data

You’ll need BAM file(s) for your wild-type pool, BAM file(s) for your mutant pool, and the
reference genome for your species in fasta format. We recommend that each pool contain at least
20 individuals to ensure a good number of recombinations to measure.

## 1.2 Installing Dependencies

MMAPPR2 depends on two system tools to function: Samtools and VEP. Both must be installed and in the PATH to be found by the appropriate functions.

### 1.2.1 Installing Samtools

Instructions to install samtools can be found at <https://github.com/samtools/samtools> and installation instructions are in the INSTALL file included with samtools.

### 1.2.2 Installing VEP

You’ll need Ensembl VEP, which you can install like this, replacing `my_species` with
your species (e.g., `danio_rerio`):

```
git clone https://github.com/Ensembl/ensembl-vep.git
cd ensembl-vep
perl INSTALL.pl -a ac -s {my_species}
```

This installs the most recent VEP and allows you to create a cache for your desired species, which is what MMAPPR2 expects by default.
If you depart from the installation shown here, or if things don’t go smoothly, see [Ensembl’s instructions](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#installer)
and make sure any differences are accounted for in the
[`VEPFlags`](#configure-vepflags-object) object.

*Note:* If you have any trouble installing VEP, using
[their Docker image](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#docker)
may save you a lot of hassle.

*Note:* We have found that R sometimes has issues finding VEP, especially when perlbrew is used. If you encounter errors at the path to your perl installation to the .Rprofile file. For example:

```
Sys.setenv(PATH=paste("/Path/to/Perlbrew", Sys.getenv("PATH"), sep=":"))
```

# 2 Basic Use

## 2.1 Setting Parameters

For our example, we will use just the golden gene from the GRCz11 zebrafish reference genome.

Here we also configure the VEPFlags object to use our example fasta and GTF files.
[See below for more info.](#configure-vepflags-object)

**Make sure your reference genome is the same you’ll use with VEP! This will be the most recent assembly available on Ensembl unless you customize. You should use the same genome in aligning your sequencing data as well.**

```
BiocParallel::register(BiocParallel::MulticoreParam())  ## see below for explanation of BiocParallel
library(MMAPPR2, quietly = TRUE)
library(MMAPPR2data, quietly = TRUE)
library(Rsamtools, quietly = TRUE)
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
##
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:MMAPPR2':
##
##     species, species<-
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, intersect,
##     is.unsorted, lapply, mapply, match, mget, order, paste, pmax,
##     pmax.int, pmin, pmin.int, rank, rbind, rownames, sapply,
##     setdiff, sort, table, tapply, union, unique, unsplit, which,
##     which.max, which.min
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:base':
##
##     expand.grid
```

```
##
## Attaching package: 'IRanges'
```

```
## The following object is masked from 'package:MMAPPR2':
##
##     distance
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
# This is normally configured automatically:
vepFlags <- ensemblVEP::VEPFlags(flags = list(
    format = 'vcf',  # <-- this is necessary
    vcf = FALSE,  # <-- as well as this
    species = 'danio_rerio',
    database = FALSE,  # <-- these three arguments allow us to run VEP offline,
    fasta = goldenFasta(),  # <-╯|  which you probably won't need
    gff = goldenGFF(),  # <------╯
    filter_common = TRUE,
    coding_only = TRUE  # assuming RNA-seq data
))

param <- MmapprParam(refFasta = goldenFasta(),
                     wtFiles = exampleWTbam(),
                     mutFiles = exampleMutBam(),
                     species = 'danio_rerio',
                     vepFlags = vepFlags,  ## optional
                     outputFolder = tempOutputFolder())  ## optional
```

```
## NOTE: genome 'danio_rerio' already exists, not overwriting
```

## 2.2 Running MMAPPR2

With parameters set, running the pipeline should be as simple as the following:

```
mmapprData <- mmappr(param)
```

```
## ------------------------------------
```

```
## -------- Welcome to MMAPPR2 --------
```

```
## ------------------------------------
```

```
## Start time: 2019-10-29 23:43:25
```

```
## Output folder: /tmp/RtmpOqOMfX/Rbuild6ebb5d879bd8/MMAPPR2/vignettes//tmp/RtmpbLFrPu/mmappr2_2019-10-29_23:43:25
```

```
## Reading BAM files and generating Euclidean distance data...
```

```
## Generating optimal Loess curves for each chromosome...
```

```
## Identifying chromosome(s) harboring linkage region...
```

```
## Peak regions succesfully identified
```

```
## Refining peak characterization using SNP resampling...
```

```
## Generating, analyzing, and ranking candidate variants...
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 1 out-of-bound range located on sequence 18.
##   Note that ranges located on a sequence whose length is unknown (NA)
##   or on a circular sequence are not considered out-of-bound (use
##   seqlengths() and isCircular() to get the lengths and circularity
##   flags of the underlying sequences). You can use trim() to trim these
##   ranges. See ?`trim,GenomicRanges-method` for more information.
```

```
## Writing output plots and tables...
```

```
##
## End time: 2019-10-29 23:43:41
```

```
## MMAPPR2 runtime: 16.11244 secs
```

The MMAPPR2 pipeline can also be run a step at a time:

```
md <- new('MmapprData', param = param) ## calculateDistance() takes a MmapprData object
postCalcDistMD <- calculateDistance(md)
postLoessMD <- loessFit(postCalcDistMD)
postPrePeakMD <- prePeak(postLoessMD)
postPeakRefMD <- peakRefinement(postPrePeakMD)
postCandidatesMD <- generateCandidates(postPeakRefMD)
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 1 out-of-bound range located on sequence 18.
##   Note that ranges located on a sequence whose length is unknown (NA)
##   or on a circular sequence are not considered out-of-bound (use
##   seqlengths() and isCircular() to get the lengths and circularity
##   flags of the underlying sequences). You can use trim() to trim these
##   ranges. See ?`trim,GenomicRanges-method` for more information.
```

```
outputMmapprData(postCandidatesMD)
```

If the pipeline fails midway, the `MmapprData` object is saved, which you can then load
and use for inspection and debugging:

```
## Contents of output folder:
cat(paste(system2('ls', outputFolder(param(mmapprData)), stdout = TRUE)), sep = '\n')
```

```
## 18.tsv
## genome_plots.pdf
## mmappr2.log
## mmappr_data.RDS
## peak_plots.pdf
```

```
mdFile <- file.path(outputFolder(param(mmapprData)), 'mmappr_data.RDS')
md <- readRDS(mdFile)
md
```

```
## MmapprData object with following slots:
## param:
##   MmapprParam object with following values:
##   Reference fasta file:
##      /home/biocbuild/bbs-3.10-bioc/R/library/MMAPPR2data/extdata/slc24a5.fa.gz
##   wtFiles:
##      BamFileList of length 1
##      names(1): wt.bam
##   mutFiles:
##      BamFileList of length 1
##      names(1): mut.bam
##   vepFlags:
##      class: VEPFlags
##      flags(6): format, species, ..., filter_common, coding_only
##      version: 98
##      scriptPath:
##   refGenome:
##      GmapGenome object
##      genome: danio_rerio
##      directory: /home/biocbuild/.local/share/gmap
##   Other parameters:
##                                       species
##                                   danio_rerio
##                                 distancePower
##                                             4
##                             peakIntervalWidth
##                                          0.95
##                                      minDepth
##                                            10
##                              homozygoteCutoff
##                                          0.95
##                                minBaseQuality
##                                            20
##                                 minMapQuality
##                                            30
##                            loessOptResolution
##                                         0.001
##                             loessOptCutFactor
##                                           0.1
##                                      naCutoff
##                                             0
##                                  outputFolder
##   /tmp/RtmpbLFrPu/mmappr2_2019-10-29_23:43:25
##                               fileAggregation
##                                           sum
## distance:
##   Contains Euclidian distance data for 1 sequence(s)
##   and Loess regression data for 1 of those
##   Memory usage = 1 MB
## peaks:
##   18: start = -174, end = 14119
##     Density function calculated
## candidates:
##   $`18`
##   GRanges object with 12 ranges and 30 metadata columns:
##                  seqnames    ranges strand |      Allele      Consequence
##                     <Rle> <IRanges>  <Rle> | <character>      <character>
##      18:5744_A/C       18      5744      * |           C missense_variant
```

## 2.3 Results

If everything goes well you should be able to track down your mutation using the `candidates` slot of your `MmapprData`
object or by looking at files in the output folder:

```
head(candidates(mmapprData)$`18`, n=2)
```

```
## GRanges object with 2 ranges and 30 metadata columns:
##               seqnames    ranges strand |      Allele      Consequence
##                  <Rle> <IRanges>  <Rle> | <character>      <character>
##   18:5744_A/C       18      5744      * |           C missense_variant
##   18:5736_T/C       18      5736      * |           C missense_variant
##                    IMPACT             SYMBOL               Gene Feature_type
##               <character>        <character>        <character>  <character>
##   18:5744_A/C    MODERATE ENSDARG00000024771 ENSDARG00000024771   Transcript
##   18:5736_T/C    MODERATE ENSDARG00000024771 ENSDARG00000024771   Transcript
##                          Feature        BIOTYPE        EXON      INTRON
##                      <character>    <character> <character> <character>
##   18:5744_A/C ENSDART00000033574 protein_coding         6/9        <NA>
##   18:5736_T/C ENSDART00000033574 protein_coding         6/9        <NA>
##                     HGVSc       HGVSp cDNA_position CDS_position
##               <character> <character>   <character>  <character>
##   18:5744_A/C        <NA>        <NA>           940          880
##   18:5736_T/C        <NA>        <NA>           932          872
##               Protein_position Amino_acids      Codons Existing_variation
##                    <character> <character> <character>        <character>
##   18:5744_A/C              294         S/R     Agc/Cgc               <NA>
##   18:5736_T/C              291         L/P     cTa/cCa               <NA>
##                  DISTANCE      STRAND       FLAGS SYMBOL_SOURCE     HGNC_ID
##               <character> <character> <character>   <character> <character>
##   18:5744_A/C        <NA>           1        <NA>          <NA>        <NA>
##   18:5736_T/C        <NA>           1        <NA>          <NA>        <NA>
##                       SOURCE       FREQS    CLIN_SIG     SOMATIC       PHENO
##                  <character> <character> <character> <character> <character>
##   18:5744_A/C slc24a5.gff.gz        <NA>        <NA>        <NA>        <NA>
##   18:5736_T/C slc24a5.gff.gz        <NA>        <NA>        <NA>        <NA>
##               slc24a5.gff.gz          peakDensity
##                  <character>            <numeric>
##   18:5744_A/C           <NA> 5.83745130464488e-05
##   18:5736_T/C           <NA> 5.79985104074123e-05
##   -------
##   seqinfo: 1 sequence from  genome
```

```
outputTsv <- file.path(outputFolder(param(mmapprData)), '18.tsv')
cat(paste(system2('head', outputTsv, stdout = TRUE)), sep = '\n')
```

```
## Position Symbol  Impact  Consequence DensityScore    Allele  AminoAcid   Feature
## 5706 ENSDARG00000024771  MODERATE    missense_variant    6.77553753338404e-05    C   I/T ENSDART00000033574
## 5736 ENSDARG00000024771  MODERATE    missense_variant    6.74330601633396e-05    C   L/P ENSDART00000033574
## 5744 ENSDARG00000024771  MODERATE    missense_variant    6.68558137575782e-05    C   S/R ENSDART00000033574
## 5601 ENSDARG00000024771  MODERATE    missense_variant    5.39726972322649e-05    C   C/S ENSDART00000033574
## 5494 ENSDARG00000024771  HIGH    stop_gained 4.23302003990551e-05    G   Y/* ENSDART00000033574
## 4117 ENSDARG00000024771  MODERATE    missense_variant    3.00911662652914e-05    C   V/L ENSDART00000033574
## 7197 ENSDARG00000024771  MODERATE    missense_variant    2.69066605237102e-05    C   M/I ENSDART00000033574
## 7244 ENSDARG00000024771  MODERATE    missense_variant    2.25449766180223e-05    C   V/A ENSDART00000033574
## 7336 ENSDARG00000024771  MODERATE    missense_variant    1.38913965686942e-05    C   I/L ENSDART00000033574
```

# 3 Advanced Configuration

## 3.1 Configure VEPFlags Object

MMAPPR2 uses the *[ensemblVEP](https://bioconductor.org/packages/3.10/ensemblVEP)* Bioconductor package to predict the effect of variants in the peak region.
To customize this process, you’ll need to configure a `VEPFlags` object. Look at [Ensembl’s website for script options](http://uswest.ensembl.org/info/docs/tools/vep/script/vep_options.html). You can configure the `VEPFlags` object like this:

```
library(ensemblVEP, quietly = TRUE)
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'matrixStats'
```

```
## The following objects are masked from 'package:Biobase':
##
##     anyMissing, rowMedians
```

```
##
## Attaching package: 'DelayedArray'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges
```

```
## The following objects are masked from 'package:base':
##
##     aperm, apply, rowsum
```

```
##
## Attaching package: 'VariantAnnotation'
```

```
## The following object is masked from 'package:base':
##
##     tabulate
```

```
##
## Attaching package: 'ensemblVEP'
```

```
## The following object is masked from 'package:Biobase':
##
##     cache
```

```
## The following object is masked from 'package:BiocStyle':
##
##     output
```

```
vepFlags <- VEPFlags(flags = list(
    ### DEFAULT SETTINGS
    format = 'vcf',  # <-- this is necessary
    vcf = FALSE,  # <-- as well as this
    species = 'danio_rerio',
    database = FALSE,
    cache = TRUE,
    filter_common = TRUE,
    coding_only = TRUE  # assuming RNA-seq data
    ### YOU MAY FIND THESE INTERESTING:
    # everything = TRUE  # enables many optional analyses, such as Polyphen and SIFT
    # per_gene = TRUE  # will output only the most severe variant per gene
    # pick = TRUE  # will output only one consequence per variant
))
```

## 3.2 BiocParallel Configuration

MMAPPR2 simply uses the default `bpparam` registered. You can change this (for example, if *[BiocParallel](https://bioconductor.org/packages/3.10/BiocParallel)* isn’t working correctly) with the `BiocParallel::register` command. For example:

```
library(BiocParallel, quietly = TRUE)
register(SerialParam())
register(MulticoreParam(progressbar=TRUE))
registered()
```

```
## $MulticoreParam
## class: MulticoreParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: 2592000; bpprogressbar: TRUE
##   bpexportglobals: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: FORK
##
## $SerialParam
## class: SerialParam
##   bpisup: FALSE; bpnworkers: 1; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: 2592000; bpprogressbar: FALSE
##   bpexportglobals: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##
## $SnowParam
## class: SnowParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: 2592000; bpprogressbar: FALSE
##   bpexportglobals: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: SOCK
```

The last param registered becomes the default.

## 3.3 Reference Genome

The variant calling step requires a `BiocStyle::Biocpkg("gmapR")` `GmapGenome`, which is normally automatically generated from the `refFasta` parameter. If for some reason you want to generate your own, the process is like this:

```
refGenome <- gmapR::GmapGenome(goldenFasta(), name='slc24a5', create=TRUE)
```

## 3.4 Whole-genome Sequencing (WGS)

MMAPPR2, like its predecessor, was designed for and tested using RNA-Seq data. However, the principles at work should still apply for WGS data.

---

# 4 Session Info

```
sessionInfo()
```

```
## R version 3.6.1 (2019-07-05)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.10-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.10-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ensemblVEP_1.28.0           VariantAnnotation_1.32.0
##  [3] SummarizedExperiment_1.16.0 DelayedArray_0.12.0
##  [5] BiocParallel_1.20.0         matrixStats_0.55.0
##  [7] Biobase_2.46.0              Rsamtools_2.2.0
##  [9] Biostrings_2.54.0           XVector_0.26.0
## [11] GenomicRanges_1.38.0        GenomeInfoDb_1.22.0
## [13] IRanges_2.20.0              S4Vectors_0.24.0
## [15] BiocGenerics_0.32.0         MMAPPR2data_0.99.21
## [17] MMAPPR2_1.0.0               BiocStyle_2.14.0
##
## loaded via a namespace (and not attached):
##  [1] httr_1.4.1               tidyr_1.0.0
##  [3] bit64_0.9-7              assertthat_0.2.1
##  [5] askpass_1.1              BiocManager_1.30.9
##  [7] VariantTools_1.28.0      BiocFileCache_1.10.0
##  [9] blob_1.2.0               BSgenome_1.54.0
## [11] GenomeInfoDbData_1.2.2   yaml_2.2.0
## [13] progress_1.2.2           pillar_1.4.2
## [15] RSQLite_2.1.2            backports_1.1.5
## [17] lattice_0.20-38          glue_1.3.1
## [19] digest_0.6.22            htmltools_0.4.0
## [21] Matrix_1.2-17            XML_3.98-1.20
## [23] pkgconfig_2.0.3          biomaRt_2.42.0
## [25] bookdown_0.14            zlibbioc_1.32.0
## [27] purrr_0.3.3              tibble_2.1.3
## [29] openssl_1.4.1            GenomicFeatures_1.38.0
## [31] gmapR_1.28.0             magrittr_1.5
## [33] crayon_1.3.4             memoise_1.1.0
## [35] evaluate_0.14            data.table_1.12.6
## [37] tools_3.6.1              prettyunits_1.0.2
## [39] hms_0.5.1                lifecycle_0.1.0
## [41] stringr_1.4.0            AnnotationDbi_1.48.0
## [43] compiler_3.6.1           rlang_0.4.1
## [45] grid_3.6.1               RCurl_1.95-4.12
## [47] rappdirs_0.3.1           bitops_1.0-6
## [49] rmarkdown_1.16           DBI_1.0.0
## [51] curl_4.2                 R6_2.4.0
## [53] GenomicAlignments_1.22.0 knitr_1.25
## [55] dplyr_0.8.3              rtracklayer_1.46.0
## [57] bit_1.1-14               zeallot_0.1.0
## [59] stringi_1.4.3            Rcpp_1.0.2
## [61] vctrs_0.2.0              dbplyr_1.4.2
## [63] tidyselect_0.2.5         xfun_0.10
```