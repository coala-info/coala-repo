# Exploring the GAlignmentPairs in alpineData

We first load the `alpineData` package:

```
library(alpineData)
```

```
## Loading required package: ExperimentHub
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
## Loading required package: AnnotationHub
```

```
## Loading required package: GenomicAlignments
```

```
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
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
## Loading required package: GenomicRanges
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
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:ExperimentHub':
##
##     cache
```

```
## The following object is masked from 'package:AnnotationHub':
##
##     cache
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
## Loading required package: Rsamtools
```

This package contains the following four *GAlignmentPairs* objects.
We can access these directly with named functions:

```
ERR188297()
```

```
## snapshotDate(): 2018-10-31
```

```
## see ?alpineData and browseVignettes('alpineData') for documentation
```

```
## downloading 0 resources
```

```
## loading from cache
##     '/home/biocbuild//.ExperimentHub/166'
```

```
## GAlignmentPairs object with 25531 pairs, strandMode=1, and 0 metadata columns:
##           seqnames strand   :              ranges  --              ranges
##              <Rle>  <Rle>   :           <IRanges>  --           <IRanges>
##       [1]        1      +   : 108560389-108560463  -- 108560454-108560528
##       [2]        1      -   : 108560454-108560528  -- 108560383-108560457
##       [3]        1      +   : 108560534-108600608  -- 108600626-108606236
##       [4]        1      -   : 108569920-108569994  -- 108569825-108569899
##       [5]        1      -   : 108587954-108588028  -- 108587881-108587955
##       ...      ...    ... ...                 ... ...                 ...
##   [25527]        X      +   : 119790596-119790670  -- 119790717-119790791
##   [25528]        X      +   : 119790988-119791062  -- 119791086-119791160
##   [25529]        X      +   : 119791037-119791111  -- 119791142-119791216
##   [25530]        X      +   : 119791348-119791422  -- 119791475-119791549
##   [25531]        X      +   : 119791376-119791450  -- 119791481-119791555
##   -------
##   seqinfo: 194 sequences from an unspecified genome
```

```
ERR188088()
```

```
## snapshotDate(): 2018-10-31
```

```
## see ?alpineData and browseVignettes('alpineData') for documentation
```

```
## downloading 0 resources
```

```
## loading from cache
##     '/home/biocbuild//.ExperimentHub/167'
```

```
## GAlignmentPairs object with 28576 pairs, strandMode=1, and 0 metadata columns:
##           seqnames strand   :              ranges  --              ranges
##              <Rle>  <Rle>   :           <IRanges>  --           <IRanges>
##       [1]        1      -   : 108565979-108566053  -- 108565846-108565920
##       [2]        1      -   : 108573341-108573415  -- 108573234-108573308
##       [3]        1      +   : 108581087-108581161  -- 108581239-108581313
##       [4]        1      +   : 108601105-108601179  -- 108601196-108601270
##       [5]        1      -   : 108603628-108603701  -- 108603540-108603614
##       ...      ...    ... ...                 ... ...                 ...
##   [28572]        X      -   : 119791266-119791340  -- 119791130-119791204
##   [28573]        X      -   : 119791431-119791505  -- 119791358-119791432
##   [28574]        X      -   : 119791593-119791667  -- 119786691-119789940
##   [28575]        X      -   : 119791629-119791703  -- 119789951-119791587
##   [28576]        X      -   : 119791637-119791711  -- 119789976-119791612
##   -------
##   seqinfo: 194 sequences from an unspecified genome
```

```
ERR188204()
```

```
## snapshotDate(): 2018-10-31
```

```
## see ?alpineData and browseVignettes('alpineData') for documentation
```

```
## downloading 0 resources
```

```
## loading from cache
##     '/home/biocbuild//.ExperimentHub/168'
```

```
## GAlignmentPairs object with 35079 pairs, strandMode=1, and 0 metadata columns:
##           seqnames strand   :              ranges  --              ranges
##              <Rle>  <Rle>   :           <IRanges>  --           <IRanges>
##       [1]        1      +   : 108560441-108560516  -- 108600607-108600682
##       [2]        1      +   : 108560442-108560517  -- 108560519-108600594
##       [3]        1      +   : 108560443-108560518  -- 108560485-108560560
##       [4]        1      +   : 108560447-108560522  -- 108560517-108600592
##       [5]        1      +   : 108560500-108600570  -- 108600586-108600660
##       ...      ...    ... ...                 ... ...                 ...
##   [35075]        X      -   : 119790855-119790930  -- 119790578-119790653
##   [35076]        X      -   : 119791108-119791183  -- 119791047-119791122
##   [35077]        X      -   : 119791575-119791650  -- 119786574-119786649
##   [35078]        X      -   : 119791593-119791668  -- 119789978-119791613
##   [35079]        X      -   : 119791627-119791702  -- 119791585-119791660
##   -------
##   seqinfo: 194 sequences from an unspecified genome
```

```
ERR188317()
```

```
## snapshotDate(): 2018-10-31
```

```
## see ?alpineData and browseVignettes('alpineData') for documentation
```

```
## downloading 0 resources
```

```
## loading from cache
##     '/home/biocbuild//.ExperimentHub/169'
```

```
## GAlignmentPairs object with 44535 pairs, strandMode=1, and 0 metadata columns:
##           seqnames strand   :              ranges  --              ranges
##              <Rle>  <Rle>   :           <IRanges>  --           <IRanges>
##       [1]        1      +   : 108560515-108600590  -- 108600611-108600686
##       [2]        1      -   : 108560530-108600605  -- 108560452-108560527
##       [3]        1      +   : 108560533-108600608  -- 108612199-108612274
##       [4]        1      +   : 108560552-108600627  -- 108606221-108612221
##       [5]        1      +   : 108575456-108575531  -- 108575548-108575623
##       ...      ...    ... ...                 ... ...                 ...
##   [44531]        X      -   : 119791460-119791535  -- 119791348-119791423
##   [44532]        X      -   : 119791574-119791649  -- 119786691-119789941
##   [44533]        X      -   : 119791574-119791649  -- 119789953-119791590
##   [44534]        X      -   : 119791585-119791660  -- 119789990-119791613
##   [44535]        X      -   : 119791620-119791695  -- 119789953-119791590
##   -------
##   seqinfo: 194 sequences from an unspecified genome
```

Or we can access them using the *ExperimentHub* interface:

```
eh <- ExperimentHub()
```

```
## snapshotDate(): 2018-10-31
```

```
query(eh, "ERR188")
```

```
## ExperimentHub with 4 records
## # snapshotDate(): 2018-10-31
## # $dataprovider: GEUVADIS
## # $species: Homo sapiens
## # $rdataclass: GAlignmentPairs
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass,
## #   tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH166"]]'
##
##           title
##   EH166 | ERR188297
##   EH167 | ERR188088
##   EH168 | ERR188204
##   EH169 | ERR188317
```

```
eh[["EH166"]]
```

```
## see ?alpineData and browseVignettes('alpineData') for documentation
```

```
## downloading 0 resources
```

```
## loading from cache
##     '/home/biocbuild//.ExperimentHub/166'
```

```
## GAlignmentPairs object with 25531 pairs, strandMode=1, and 0 metadata columns:
##           seqnames strand   :              ranges  --              ranges
##              <Rle>  <Rle>   :           <IRanges>  --           <IRanges>
##       [1]        1      +   : 108560389-108560463  -- 108560454-108560528
##       [2]        1      -   : 108560454-108560528  -- 108560383-108560457
##       [3]        1      +   : 108560534-108600608  -- 108600626-108606236
##       [4]        1      -   : 108569920-108569994  -- 108569825-108569899
##       [5]        1      -   : 108587954-108588028  -- 108587881-108587955
##       ...      ...    ... ...                 ... ...                 ...
##   [25527]        X      +   : 119790596-119790670  -- 119790717-119790791
##   [25528]        X      +   : 119790988-119791062  -- 119791086-119791160
##   [25529]        X      +   : 119791037-119791111  -- 119791142-119791216
##   [25530]        X      +   : 119791348-119791422  -- 119791475-119791549
##   [25531]        X      +   : 119791376-119791450  -- 119791481-119791555
##   -------
##   seqinfo: 194 sequences from an unspecified genome
```

For details on the source of these files, and on their construction
see `?alpineData` and the scripts:

* `inst/scripts/make-metadata.R`
* `inst/scripts/make-data.Rmd`

We can take a quick look at the paired alignments from one file.
For example their distribution on the different chromosomes:

```
library(GenomicAlignments)
gap <- ERR188297()
```

```
## snapshotDate(): 2018-10-31
```

```
## see ?alpineData and browseVignettes('alpineData') for documentation
```

```
## downloading 0 resources
```

```
## loading from cache
##     '/home/biocbuild//.ExperimentHub/166'
```

```
barplot(sort(table(seqnames(gap))[1:25], decreasing=TRUE),
        las=3, main="Distribution of reads")
```

![plot of chunk unnamed-chunk-4](data:image/png;base64...)

Histograms of read starts for the first read on chromosome 1:

```
gap1 <- gap[seqnames(gap) == "1"]
starts <- start(first(gap1))
par(mfrow=c(2,2))
hist(starts,col="grey")
```

```
## Warning in n * h: NAs produced by integer overflow
```

![plot of chunk unnamed-chunk-5](data:image/png;base64...)