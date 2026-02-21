# A/B compartment inference from ATAC-seq and methylation arrays with compartmap

Ben Johnson

#### *4 January 2019*

#### Package

compartmap 1.0.3

# 1 Compartmap: Shrunken A/B compartment inference from ATAC-seq and methylation arrays

Compartmap extends methods to perform A/B compartment inference from (sc)ATAC-seq and methylation arrays originally proposed by Fortin and Hansen 2015, Genome Biology (<https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0741-y>). Originally, Fortin and Hansen demonstrated that chromatin conformation could be inferred from (sc)ATAC-seq, bisulfite sequencing, DNase-seq and methylation arrays, similar to the results provided by HiC. Thus, in addition to the base information provided by the aforementioned assays, chromatin state could also be inferred. However, these data were restricted to group level A/B compartment inference.

Here, we propose a method to infer sample-level chromatin state, thus enabling (un)supervised clustering of samples/cells based on A/B compartments. To accomplish this, we employ a shrinkage estimator towards a global or targeted mean, using either chromsome or genome-wide information from ATAC-seq and methylation arrays (e.g. Illumina 450k or EPIC arrays). The output from compartmap can then be embedded and visualized using your favorite clustering approach, such as UMAP/tSNE.

## 1.1 Quick Start

### 1.1.1 Input

The expected input for compartmap is either a RangedSummarizedExperiment object or GenomicRatioSet object. These can be built using packages like [ATACseeker](https://github.com/biobenkj/ATACseeker) or [SeSAMe](https://www.bioconductor.org/packages/devel/bioc/html/sesame.html).

```
library(compartmap)
```

```
## Loading required package: minfi
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
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
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colMeans, colSums, colnames,
##     dirname, do.call, duplicated, eval, evalq, get, grep, grepl,
##     intersect, is.unsorted, lapply, lengths, mapply, match, mget,
##     order, paste, pmax, pmax.int, pmin, pmin.int, rank, rbind,
##     rowMeans, rowSums, rownames, sapply, setdiff, sort, table,
##     tapply, union, unique, unsplit, which, which.max, which.min
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: S4Vectors
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
## Loading required package: IRanges
```

```
## Loading required package: GenomeInfoDb
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: DelayedArray
```

```
## Loading required package: matrixStats
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
## Loading required package: BiocParallel
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
##     aperm, apply
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:DelayedArray':
##
##     type
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
## Loading required package: bumphunter
```

```
## Loading required package: foreach
```

```
## Loading required package: iterators
```

```
## Loading required package: locfit
```

```
## locfit 1.5-9.1    2013-03-22
```

```
## Setting options('download.file.method.GEOquery'='auto')
```

```
## Setting options('GEOquery.inmemory.gpl'=FALSE)
```

```
## Loading required package: Homo.sapiens
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: OrganismDbi
```

```
## Loading required package: GenomicFeatures
```

```
## Loading required package: GO.db
```

```
##
```

```
## Loading required package: org.Hs.eg.db
```

```
##
```

```
## Loading required package: TxDb.Hsapiens.UCSC.hg19.knownGene
```

```
## Loading required package: mixOmics
```

```
## Loading required package: MASS
```

```
##
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:OrganismDbi':
##
##     select
```

```
## The following object is masked from 'package:AnnotationDbi':
##
##     select
```

```
## Loading required package: lattice
```

```
## Loading required package: ggplot2
```

```
##
## Loaded mixOmics 6.6.1
##
## Thank you for using mixOmics! Learn how to apply our methods with our tutorials on www.mixOmics.org, vignette and bookdown on  https://github.com/mixOmicsTeam/mixOmics
## Questions: email us at mixomics[at]math.univ-toulouse.fr
## Bugs, Issues? https://github.com/mixOmicsTeam/mixOmics/issues
## Cite us:  citation('mixOmics')
```

```
library(GenomicRanges)
library(Homo.sapiens)

#Load in some example methylation array data
#This data is derived from https://f1000research.com/articles/5-1281/v3
#data(meth_array_450k_chr14, package = "compartmap")

#Load in some example ATAC-seq data
data(bulkATAC_raw_filtered_chr14, package = "compartmap")
```

### 1.1.2 Processing data

To process the data (filter and perform compartment inference) a wrapper function is used for all data types.

```
#Process chr14 of the example array data
#Note: running this in parallel is memory hungry!

#array_compartments <- getCompartments(array.data.chr14, type = "array", parallel = FALSE, chrs = "chr14")

#Process chr14 of the example ATAC-seq data
atac_compartments <- getCompartments(filtered.data.chr14, type = "atac", parallel = FALSE, chrs = "chr14")
```

```
## Mapping chromosome 'chr14'
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient11_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient11_Romi_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient11_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient11_Vori_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient11_Vori_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient11_Vori_Day21...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient11_Vori_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1366_Romi_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1366_Romi_Day28...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1366_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1409_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1409_Romi_Day28...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Vori_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Vori_Day15...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Vori_Day21...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Vori_Day28...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Vori_Day35...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1424_Vori_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1461_Romi_Day0Post1Hour...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1461_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1461_Romi_Day28...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1461_Romi_Day35...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1461_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1482_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1482_Romi_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient1482_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient20_Vori_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient20_Vori_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient20_Vori_Day21...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient20_Vori_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient5_Vori_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient5_Vori_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient5_Vori_Day21...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkCTCL_Patient5_Vori_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkStage3_Patient30_Vori_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkStage3_Patient30_Vori_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkStage3_Patient30_Vori_Day21...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for BulkStage3_Patient30_Vori_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient11_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient11_Romi_Day14A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient11_Romi_Day14B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient1366_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient1424_Vori_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient1424_Vori_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient1424_Vori_Day21...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient1424_Vori_Day28...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient1424_Vori_Day35...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient1424_Vori_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient20_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient39_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient59_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient59_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient62_Romi_Day0A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Host_Patient62_Romi_Day0B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Naive_T_cellA...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Naive_T_cellB...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Naive_T_cellC...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Naive_T_cellD...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th17_cellA...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th17_cellB...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th17_cellC...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th1_cellA...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th1_cellB...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th1_cellC...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th2_cellA...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th2_cellB...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Th2_cellC...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Treg_cellA...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for human_Treg_cellB...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient11_Romi_Day0A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient11_Romi_Day0B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient11_Romi_Day14A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient11_Romi_Day14B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient11_Romi_Day7A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient11_Romi_Day7B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient1366_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient1424_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient1424_Romi_Day14...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient1424_Romi_Day21...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient1424_Romi_Day28...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient1424_Romi_Day35...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient1424_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient20_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient39_Romi_Day0A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient39_Romi_Day0B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient39_Romi_Day7A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient39_Romi_Day7B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient59_Romi_Day7A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient59_Romi_Day7B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient60_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient60_Romi_Day7...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient61_Romi_Day0...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient62_Romi_Day0A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Leukemic_Patient62_Romi_Day0B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor10_Day224A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor10_Day224B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor10_Day38...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day1A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day1B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day224A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day224B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day2A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day2B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day37A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day37B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day38A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day38B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor1_Day39...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor2_Day224A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor2_Day224B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor31_Day192A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor31_Day192B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor32_Day224A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor32_Day224B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor33_Day224A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor33_Day224B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor3_Day37...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor4_Day107A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor4_Day107B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor4_Day224A...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor4_Day224B...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor4_Day37...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor7_Day38...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

```
## Computing shrunken compartment eigenscores for Normal_Donor9_Day38...
```

```
## 108 bins created...
```

```
## Calculating correlations...
```

```
## Done...
```

```
## Calculating eigenvectors...
```

```
## Smoothing with a k of 2 for 2 iterations...
```

```
## Done smoothing...
```

### 1.1.3 Ouput and post-processing

Once the data have been processed, the object returned is a matrix of sample-level A/B compartments (samples as columns and compartments as rows). These are normalized to chromosome length and each compartment corresponds to a non-empty bin (based on the desired resolution - 1 Mb is the default). From here, the data can be visualized using something like plotAB for individual samples or your favorite clustering method. Additionally, these can be overlaid in something like IGV to see where compartments are changing between samples/conditions.

```
#Plotting individual samples
#For 7 samples
#Adjust ylim as necessary
par(mar=c(1,1,1,1))
par(mfrow=c(7,1))
plotAB(array_compartments[,1], ylim = c(-0.2, 0.2), unitarize = TRUE)
plotAB(array_compartments[,2], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "goldenrod")
plotAB(array_compartments[,3], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "darkblue")
plotAB(array_compartments[,4], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "red")
plotAB(array_compartments[,5], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "black")
plotAB(array_compartments[,6], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "cyan")
plotAB(array_compartments[,7], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "seagreen")

#Embed with UMAP for unsupervised clustering
library(uwot)
embed_compartments <- umap(t(array_compartments), n_neighbors = 3, metric = "manhattan", n_components = 5, n_trees = 100)

#Visualize embedding
library(vizier)
library(plotly)
embed_plotly(embed_compartments, tooltip = colnames(embed_compartments), show_legend = FALSE)
```