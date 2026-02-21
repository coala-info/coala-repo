# Getting Started with LOLA

Nathan Sheffield

#### 2026-01-08

# Contents

* [1 LOLA bioconductor package](#lola-bioconductor-package)
  + [1.1 Preparing analysis](#preparing-analysis)
  + [1.2 Run the analysis](#run-the-analysis)
  + [1.3 Exploring LOLA Results](#exploring-lola-results)
  + [1.4 Extracting certain region sets from a database](#extracting-certain-region-sets-from-a-database)

# 1 LOLA bioconductor package

Biological data is often compared to reference databases and searching for interesting patterns of enrichment and depletion. For example, gene set analysis has been pivotal for making connections between diverse types of genomic data. However, it suffers from one major limitation: it requires gene-centric data. This is becoming increasingly limiting as our understanding of gene regulation advances. It has become evident that gene expression and chromatin organization are controlled by hundreds of thousands of enhancers and other functional elements, which are often difficult to map to gene symbols. The increasing emphasis on genomic region sets has been propelled by next generation sequencing technology that produces data most naturally analyzed in the context of genomic regions – as peaks and segmentations. The research community has now established large catalogs of regulatory elements and other genomic features across many cell types. LOLA makes use of these catalogs to perform enrichment analysis of genomic ranges.

## 1.1 Preparing analysis

In this vignette, you’ll use small example datasets that come with the LOLA package to get a first look at the most common functions in a LOLA workflow.

You need 3 things to run a LOLA analysis:

1. A region database.
2. userSets: Regions of interest (at least 1 set of regions as a GRanges object, or multiple sets of regions of interest as a GRangesList object)
3. userUniverse: The set of regions tested for inclusion in your sets of regions of interest (a single GRanges object)

Let’s load an example regionDB with `loadRegionDB()`. Here’s a small example that comes with LOLA. The database location should point to a folder that contains collection subfolders:

```
library("LOLA")
dbPath = system.file("extdata", "hg19", package="LOLA")
regionDB = loadRegionDB(dbPath)
```

The regionDB is an R (list) object that has a few elements:

```
names(regionDB)
```

```
## [1] "dbLocation"     "regionAnno"     "collectionAnno" "regionGRL"
```

* dbLocation: A string recording the location of the database folder you passed to `loadRegionDB()`.
* collectionAnno: A `data.table` annotating the collections, with rows corresponding to the rows in your `collection` annotation files in the database.
* regionAnno: A `data.table` annotating each region set, with rows corresponding to bed files in the database (there is also a `collection` column recording which collection each region set belongs to).
* regionGRL: A `GRangesList` object holding the actual regions, with one list element per region set, ordered as in `regionAnno`.

Now with the database loaded, let’s load up some sample data (the regions of interest, and the tested universe):

```
data("sample_input", package="LOLA") # load userSets
data("sample_universe", package="LOLA") # load userUniverse
```

Now we have a GRanges object called `userSets` and a GRanges object called `userUniverse`. This is all we need to run the enrichment calculation.

## 1.2 Run the analysis

`runLOLA()` will test the overlap between your userSets, and each region set in the regionDB.

```
locResults = runLOLA(userSets, userUniverse, regionDB, cores=1)
```

`runLOLA` tests for pairwise overlap between each user set and each region set in regionDB. It then uses a Fisher’s exact test to assess significance of the overlap. The results are a `data.table` with several columns:

```
colnames(locResults)
head(locResults)
```

```
##  [1] "userSet"     "dbSet"       "collection"  "pValueLog"   "oddsRatio"
##  [6] "support"     "rnkPV"       "rnkOR"       "rnkSup"      "maxRnk"
## [11] "meanRnk"     "b"           "c"           "d"           "description"
## [16] "cellType"    "tissue"      "antibody"    "treatment"   "dataSource"
## [21] "filename"    "qValue"      "size"
##    userSet dbSet   collection   pValueLog oddsRatio support rnkPV rnkOR rnkSup
##     <char> <int>       <char>       <num>     <num>   <int> <int> <int>  <int>
## 1:    setB     2 ucsc_example 264.4863407 7.7578283     850     1     1      2
## 2:    setA     2 ucsc_example 254.6188080 8.6487312     632     1     1      2
## 3:    setB     1 ucsc_example  34.6073689 3.3494078    5747     2     2      1
## 4:    setA     4 ucsc_example   1.7169689 1.2377725     124     2     2      3
## 5:    setA     5 ucsc_example   1.7169689 1.2377725     124     2     2      3
## 6:    setA     3 ucsc_example   0.1877354 0.9135696       8     4     4      5
##    maxRnk meanRnk     b     c     d                      description cellType
##     <int>   <num> <int> <int> <int>                           <char>   <char>
## 1:      2    1.33   452  4981 20546                     ucsc_example     <NA>
## 2:      2    1.33   670  2510 23017                     ucsc_example     <NA>
## 3:      2    1.67 20018    84   980 CpG islands from UCSC annotation     <NA>
## 4:      3    2.33   761  3018 22926                     ucsc_example     <NA>
## 5:      3    2.33   761  3018 22926                     ucsc_example     <NA>
## 6:      5    4.33    66  3134 23621                     ucsc_example     <NA>
##    tissue antibody treatment dataSource                    filename
##    <char>   <char>    <char>     <char>                      <char>
## 1:   <NA>     <NA>      <NA>       <NA>             laminB1Lads.bed
## 2:   <NA>     <NA>      <NA>       <NA>             laminB1Lads.bed
## 3:   <NA>     <NA>      <NA>       <NA>            cpgIslandExt.bed
## 4:   <NA>     <NA>      <NA>       <NA>          vistaEnhancers.bed
## 5:   <NA>     <NA>      <NA>       <NA> vistaEnhancers_colNames.bed
## 6:   <NA>     <NA>      <NA>       <NA>          numtSAssembled.bed
##           qValue  size
##            <num> <num>
## 1: 3.263317e-264  1302
## 2: 1.202713e-254  1302
## 3:  8.232086e-35 28691
## 4:  3.837612e-02  1339
## 5:  3.837612e-02  1340
## 6:  1.000000e+00    78
```

If you’re not familiar with how `data.table` works in R, it’s worth reading some of the [documentation of this powerful package](https://CRAN.R-project.org/package%3Ddata.table).
Columns `userSet` and `dbSet` are indexes into the respective GRangeList objects, identifying each pairwise comparison. There are a series of columns describing the results of the statistical test, such as `pValueLog`, `logOdds`, and the actual values from the contingency table (`support` is the overlap, and `b`, `c`, and `d` complete the 2x2 table). Rank columns simply rank the tests by `pValueLog`, `logOdds`, or `support`; following these are a series of columns annotating the database regions, depending on how you populated the `index` table in the regionDB folder.

You can explore these results in R by, for example, ranking with different orders:

```
locResults[order(support, decreasing=TRUE),]
```

```
##     userSet dbSet   collection    pValueLog oddsRatio support rnkPV rnkOR
##      <char> <int>       <char>        <num>     <num>   <int> <int> <int>
##  1:    setB     1 ucsc_example 3.460737e+01 3.3494078    5747     2     2
##  2:    setA     1 ucsc_example 2.818334e-02 0.8704355    3002     5     5
##  3:    setB     2 ucsc_example 2.644863e+02 7.7578283     850     1     1
##  4:    setA     2 ucsc_example 2.546188e+02 8.6487312     632     1     1
##  5:    setA     4 ucsc_example 1.716969e+00 1.2377725     124     2     2
##  6:    setA     5 ucsc_example 1.716969e+00 1.2377725     124     2     2
##  7:    setB     4 ucsc_example 0.000000e+00 0.3489379      80     4     3
##  8:    setB     5 ucsc_example 0.000000e+00 0.3489379      80     4     3
##  9:    setA     3 ucsc_example 1.877354e-01 0.9135696       8     4     4
## 10:    setB     3 ucsc_example 9.184826e-06 0.2052377       4     3     5
##     rnkSup maxRnk meanRnk     b     c     d                      description
##      <int>  <int>   <num> <int> <int> <int>                           <char>
##  1:      1      2    1.67 20018    84   980 CpG islands from UCSC annotation
##  2:      1      5    3.67 22763   140   924 CpG islands from UCSC annotation
##  3:      2      2    1.33   452  4981 20546                     ucsc_example
##  4:      2      2    1.33   670  2510 23017                     ucsc_example
##  5:      3      3    2.33   761  3018 22926                     ucsc_example
##  6:      3      3    2.33   761  3018 22926                     ucsc_example
##  7:      3      4    3.33   805  5751 20193                     ucsc_example
##  8:      3      4    3.33   805  5751 20193                     ucsc_example
##  9:      5      5    4.33    66  3134 23621                     ucsc_example
## 10:      5      5    4.33    70  5827 20928                     ucsc_example
##     cellType tissue antibody treatment dataSource                    filename
##       <char> <char>   <char>    <char>     <char>                      <char>
##  1:     <NA>   <NA>     <NA>      <NA>       <NA>            cpgIslandExt.bed
##  2:     <NA>   <NA>     <NA>      <NA>       <NA>            cpgIslandExt.bed
##  3:     <NA>   <NA>     <NA>      <NA>       <NA>             laminB1Lads.bed
##  4:     <NA>   <NA>     <NA>      <NA>       <NA>             laminB1Lads.bed
##  5:     <NA>   <NA>     <NA>      <NA>       <NA>          vistaEnhancers.bed
##  6:     <NA>   <NA>     <NA>      <NA>       <NA> vistaEnhancers_colNames.bed
##  7:     <NA>   <NA>     <NA>      <NA>       <NA>          vistaEnhancers.bed
##  8:     <NA>   <NA>     <NA>      <NA>       <NA> vistaEnhancers_colNames.bed
##  9:     <NA>   <NA>     <NA>      <NA>       <NA>          numtSAssembled.bed
## 10:     <NA>   <NA>     <NA>      <NA>       <NA>          numtSAssembled.bed
##            qValue  size
##             <num> <num>
##  1:  8.232086e-35 28691
##  2:  1.000000e+00 28691
##  3: 3.263317e-264  1302
##  4: 1.202713e-254  1302
##  5:  3.837612e-02  1339
##  6:  3.837612e-02  1340
##  7:  1.000000e+00  1339
##  8:  1.000000e+00  1340
##  9:  1.000000e+00    78
## 10:  1.000000e+00    78
```

You can order by one of the rank columns:

```
locResults[order(maxRnk, decreasing=TRUE),]
```

```
##     userSet dbSet   collection    pValueLog oddsRatio support rnkPV rnkOR
##      <char> <int>       <char>        <num>     <num>   <int> <int> <int>
##  1:    setA     3 ucsc_example 1.877354e-01 0.9135696       8     4     4
##  2:    setA     1 ucsc_example 2.818334e-02 0.8704355    3002     5     5
##  3:    setB     3 ucsc_example 9.184826e-06 0.2052377       4     3     5
##  4:    setB     4 ucsc_example 0.000000e+00 0.3489379      80     4     3
##  5:    setB     5 ucsc_example 0.000000e+00 0.3489379      80     4     3
##  6:    setA     4 ucsc_example 1.716969e+00 1.2377725     124     2     2
##  7:    setA     5 ucsc_example 1.716969e+00 1.2377725     124     2     2
##  8:    setB     2 ucsc_example 2.644863e+02 7.7578283     850     1     1
##  9:    setA     2 ucsc_example 2.546188e+02 8.6487312     632     1     1
## 10:    setB     1 ucsc_example 3.460737e+01 3.3494078    5747     2     2
##     rnkSup maxRnk meanRnk     b     c     d                      description
##      <int>  <int>   <num> <int> <int> <int>                           <char>
##  1:      5      5    4.33    66  3134 23621                     ucsc_example
##  2:      1      5    3.67 22763   140   924 CpG islands from UCSC annotation
##  3:      5      5    4.33    70  5827 20928                     ucsc_example
##  4:      3      4    3.33   805  5751 20193                     ucsc_example
##  5:      3      4    3.33   805  5751 20193                     ucsc_example
##  6:      3      3    2.33   761  3018 22926                     ucsc_example
##  7:      3      3    2.33   761  3018 22926                     ucsc_example
##  8:      2      2    1.33   452  4981 20546                     ucsc_example
##  9:      2      2    1.33   670  2510 23017                     ucsc_example
## 10:      1      2    1.67 20018    84   980 CpG islands from UCSC annotation
##     cellType tissue antibody treatment dataSource                    filename
##       <char> <char>   <char>    <char>     <char>                      <char>
##  1:     <NA>   <NA>     <NA>      <NA>       <NA>          numtSAssembled.bed
##  2:     <NA>   <NA>     <NA>      <NA>       <NA>            cpgIslandExt.bed
##  3:     <NA>   <NA>     <NA>      <NA>       <NA>          numtSAssembled.bed
##  4:     <NA>   <NA>     <NA>      <NA>       <NA>          vistaEnhancers.bed
##  5:     <NA>   <NA>     <NA>      <NA>       <NA> vistaEnhancers_colNames.bed
##  6:     <NA>   <NA>     <NA>      <NA>       <NA>          vistaEnhancers.bed
##  7:     <NA>   <NA>     <NA>      <NA>       <NA> vistaEnhancers_colNames.bed
##  8:     <NA>   <NA>     <NA>      <NA>       <NA>             laminB1Lads.bed
##  9:     <NA>   <NA>     <NA>      <NA>       <NA>             laminB1Lads.bed
## 10:     <NA>   <NA>     <NA>      <NA>       <NA>            cpgIslandExt.bed
##            qValue  size
##             <num> <num>
##  1:  1.000000e+00    78
##  2:  1.000000e+00 28691
##  3:  1.000000e+00    78
##  4:  1.000000e+00  1339
##  5:  1.000000e+00  1340
##  6:  3.837612e-02  1339
##  7:  3.837612e-02  1340
##  8: 3.263317e-264  1302
##  9: 1.202713e-254  1302
## 10:  8.232086e-35 28691
```

And finally, record the results to file like this:

4. Write out results:

```
writeCombinedEnrichment(locResults, outFolder= "lolaResults")
```

By default, this function will write the entire table to a `tsv` file. I recommend using the includeSplits parameter, which tells the function to also print out additional tables that are subsetted by userSet, so that each region set you test has its own result table. It just makes it a little easier to explore the results.

```
writeCombinedEnrichment(locResults, outFolder= "lolaResults", includeSplits=TRUE)
```

## 1.3 Exploring LOLA Results

Say you’d like to know which regions are responsible for the enrichment we see; or, in other words, you’d like to extract the regions that are actually overlapping a particular database. For this, you can use the function `extractEnrichmentOverlaps()`:

```
oneResult = locResults[2,]
extractEnrichmentOverlaps(oneResult, userSets, regionDB)
```

```
## GRanges object with 632 ranges and 0 metadata columns:
##         seqnames              ranges strand
##            <Rle>           <IRanges>  <Rle>
##     [1]     chr1   18229570-19207602      *
##     [2]     chr1   35350878-35351854      *
##     [3]     chr1   38065507-38258622      *
##     [4]     chr1   38499473-39306315      *
##     [5]     chr1   42611485-42611691      *
##     ...      ...                 ...    ...
##   [628]     chrX 125299245-125300436      *
##   [629]     chrX 136032577-138821238      *
##   [630]     chrX 139018365-148549454      *
##   [631]     chrX 154066672-154251301      *
##   [632]     chrY     2880166-7112793      *
##   -------
##   seqinfo: 69 sequences from an unspecified genome; no seqlengths
```

## 1.4 Extracting certain region sets from a database

If you have a large database, you may be interested in using the LOLA database format for other projects, or for additional follow-up analysis. In this case, you may be interested in just a single region set within a database, or perhaps just a few of them. LOLA provides a function to extract certain region sets from either a loaded or an unloaded database.

Say you just want an object with regions from the “vistaEnhancers” region set. You can grab it from a loaded database like this:

```
getRegionSet(regionDB, collections="ucsc_example", filenames="vistaEnhancers.bed")
```

```
## GRangesList object of length 1:
## [[1]]
## GRanges object with 1339 ranges and 0 metadata columns:
##        seqnames              ranges strand
##           <Rle>           <IRanges>  <Rle>
##      1     chr1     3190582-3191428      *
##      2     chr1     8130440-8131887      *
##      3     chr1   10593124-10594209      *
##      4     chr1   10732071-10733118      *
##      5     chr1   10757665-10758631      *
##    ...      ...                 ...    ...
##   1335     chrX 139380917-139382199      *
##   1336     chrX 139593503-139594774      *
##   1337     chrX 139674500-139675403      *
##   1338     chrX 147829017-147830159      *
##   1339     chrX 150407693-150409052      *
##   -------
##   seqinfo: 69 sequences from an unspecified genome; no seqlengths
```

Or, if you haven’t already loaded the database, you can just give the path to the database and LOLA will only load the specific region set(s) you are interested in. This can take more than one filename or collection:

```
getRegionSet(dbPath, collections="ucsc_example", filenames="vistaEnhancers.bed")
```

```
## GRangesList object of length 1:
## [[1]]
## GRanges object with 1339 ranges and 0 metadata columns:
##        seqnames              ranges strand
##           <Rle>           <IRanges>  <Rle>
##      1     chr1     3190582-3191428      *
##      2     chr1     8130440-8131887      *
##      3     chr1   10593124-10594209      *
##      4     chr1   10732071-10733118      *
##      5     chr1   10757665-10758631      *
##    ...      ...                 ...    ...
##   1335     chrX 139380917-139382199      *
##   1336     chrX 139593503-139594774      *
##   1337     chrX 139674500-139675403      *
##   1338     chrX 147829017-147830159      *
##   1339     chrX 150407693-150409052      *
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

Now that you have a basic idea of what the functions are, you can follow some other vignettes, such as [Using LOLA Core](http://code.databio.org/LOLA/articles/usingLOLACore.html), to see how this works on a realistic dataset.