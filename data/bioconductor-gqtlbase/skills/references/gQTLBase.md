# gQTLBase: infrastructure for storage and interrogation of eQTL, mQTL, dsQTL etc. archives

#### *Vincent J. Carey, stvjc at channing.harvard.edu*

#### *January 2015*

# Introduction

It is well-recognized that cis-eQTL searches with dense genotyping yields billions of test results. While many are consistent with no association, it is hard to draw an objective threshold, and targeted analysis may reveal signals of interest that do not deserve penalization for genome-wide search.

We recently performed a comprehensive cis-eQTL search with the GEUVADIS FPKM expression measures. The most prevalent transcript types in this dataset are

```
##
##       protein_coding           pseudogene            antisense
##                15280                 4853                 1450
##              lincRNA processed_transcript            IG_V_gene
##                 1153                  476                  114
```

*cis*-associated variation in abundance of these entities was assessed using 20 million 1000 genomes genotypes with radius 1 million bases around each transcribed region. There are 185 million SNP-transcript pairs in this analysis. This package (*[gQTLBase](https://bioconductor.org/packages/3.8/gQTLBase)*) aims to simplify interactive interrogation of this resource.

## Brief view of how the tests were done

The following function takes as argument ‘chunk’ a list with elements chr (character token for indexing chromosomes in genotype data in VCF) and genes (vector of gene identifiers). It implicitly uses a `TabixFile` reference to acquire genotypes on the samples managed in the *[geuvPack](https://bioconductor.org/packages/3.8/geuvPack)* package.

```
gettests = function( chunk, useS3=FALSE ) {
  library(VariantAnnotation)
  snpsp = gtpath( chunk$chr, useS3=useS3)
  tf = TabixFile( snpsp )
  library(geuvPack)
  if (!exists("geuFPKM")) data(geuFPKM)
  clipped = clipPCs(regressOut(geuFPKM, ~popcode), 1:10)
  set.seed(54321)
  ans = cisAssoc( clipped[ chunk$genes, ], tf, cisradius=1000000, lbmaf=0.01 )
  metadata(ans)$prepString = "clipPCs(regressOut(geuFPKM, ~popcode), 1:10)"
  ans
  }
```

`cisAssoc` returns a `GRanges` instance with fields relevant to computing FDR for cis association.

A *[BatchJobs](https://CRAN.R-project.org/package%3DBatchJobs)* registry is created as follows:

```
flatReg = makeRegistry("flatReg",  file.dir="flatStore",
        seed=123, packages=c("GenomicRanges",
            "GGtools", "VariantAnnotation", "Rsamtools",
            "geuvPack", "GenomeInfoDb"))
```

For any list ‘flatlist’ of pairs (chr, genes), the following code asks the scheduler to run gettests on every element, when it can. Using the Channing cumulus cloud, the job ran on 40 hosts at a cost of 170 USD.

```
batchMap(flatReg, gettests, flatlist)
submitJobs(flatReg)
```

This creates a ‘sharded’ archive of 7GB of results managed by a Registry object.

## Illustration on a subset

We have extracted 3 shards from the job for illustration with the *[gQTLBase](https://bioconductor.org/packages/3.8/gQTLBase)* package.

```
library(gQTLBase)
library(geuvStore2)
mm = makeGeuvStore2()
mm
```

```
## ciseStore instance with 160 completed jobs.
## excerpt from job  1 :
## GRanges object with 1 range and 14 metadata columns:
##       seqnames    ranges strand |      paramRangeID            REF
##          <Rle> <IRanges>  <Rle> |          <factor> <DNAStringSet>
##   [1]        1    526736      * | ENSG00000215915.5              C
##                   ALT            chisq      permScore_1       permScore_2
##       <CharacterList>        <numeric>        <numeric>         <numeric>
##   [1]               G 2.46382903511311 3.14566717550675 0.409225094116621
##             permScore_3        permScore_4       permScore_5
##               <numeric>          <numeric>         <numeric>
##   [1] 0.157174317815962 0.0298147140344611 0.164808833821082
##              permScore_6         snp                MAF           probeid
##                <numeric> <character>          <numeric>       <character>
##   [1] 0.0123114014465414  rs28863004 0.0910112359550562 ENSG00000215915.5
##         mindist
##       <numeric>
##   [1]    858333
##   -------
##   seqinfo: 86 sequences from hg19 genome
```

`mm` here is an instance of the `ciseStore` class. This is a BatchJobs `Registry` wrapped with additional information concerning the map from identifiers or ranges to jobs in the registry.

There are various approaches available to get results out of the store. At present we don’t want a full API for result-level operations, so work from BatchJobs directly:

```
loadResult(mm@reg, 1)[1:3]
```

```
## GRanges object with 3 ranges and 14 metadata columns:
##       seqnames    ranges strand |      paramRangeID            REF
##          <Rle> <IRanges>  <Rle> |          <factor> <DNAStringSet>
##   [1]        1    526736      * | ENSG00000215915.5              C
##   [2]        1    526840      * | ENSG00000215915.5              T
##   [3]        1    529782      * | ENSG00000215915.5              C
##                   ALT             chisq      permScore_1       permScore_2
##       <CharacterList>         <numeric>        <numeric>         <numeric>
##   [1]               G  2.46382903511311 3.14566717550675 0.409225094116621
##   [2]               C 0.976103777699146 1.78519714562405 0.364930526984022
##   [3]               T 0.120733654159376 3.39459789224459  0.93015473782783
##                permScore_3        permScore_4        permScore_5
##                  <numeric>          <numeric>          <numeric>
##   [1]    0.157174317815962 0.0298147140344611  0.164808833821082
##   [2] 4.12659268591985e-07  0.181807632802485   0.10896188401966
##   [3]    0.476262870594353  0.495743925156815 0.0165573671224115
##              permScore_6         snp                MAF           probeid
##                <numeric> <character>          <numeric>       <character>
##   [1] 0.0123114014465414  rs28863004 0.0910112359550562 ENSG00000215915.5
##   [2]   1.29337841084893  rs60396226  0.103370786516854 ENSG00000215915.5
##   [3]   1.38539981288919 rs144425991 0.0719101123595506 ENSG00000215915.5
##         mindist
##       <numeric>
##   [1]    858333
##   [2]    858229
##   [3]    855287
##   -------
##   seqinfo: 86 sequences from hg19 genome
```

On a multicore machine or cluster, we can visit job results in parallel. The `storeApply` function uses *[BatchJobs](https://CRAN.R-project.org/package%3DBatchJobs)* `reduceResultsList` to transform job results by a user-supplied function. The reduction events occur in parallel through *[BiocParallel](https://bioconductor.org/packages/3.8/BiocParallel)* `bplapply` over a set of job id chunks whose character can be controlled through the `n.chunks` parameter.

We’ll illustrate by taking the length of each result.

```
library(BiocParallel)
library(parallel)
mp = MulticoreParam(workers=max(c(1, detectCores()-4)))
register(mp)
```

```
lens = storeApply(mm, length)
```

```
## Warning: executing %dopar% sequentially: no parallel backend registered
```

```
summary(unlist(lens))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   19852   32987   37346   38645   42701  131671
```

It is possible to limit the scope of application by setting the `ids` parameter in `storeApply`.

## Interrogating by probe

For a known GEUVADIS Ensembl identifier (or vector thereof) we can acquire all cis association test results as follows.

```
pvec = mm@probemap[1:4,1]  # don't want API for map, just getting examples
litex = extractByProbes( mm, pvec )
length(litex)
```

```
## [1] 33107
```

```
litex[1:3]
```

```
## GRanges object with 3 ranges and 15 metadata columns:
##       seqnames    ranges strand |      paramRangeID            REF
##          <Rle> <IRanges>  <Rle> |          <factor> <DNAStringSet>
##   [1]        1    526736      * | ENSG00000215915.5              C
##   [2]        1    526840      * | ENSG00000215915.5              T
##   [3]        1    529782      * | ENSG00000215915.5              C
##                   ALT             chisq      permScore_1       permScore_2
##       <CharacterList>         <numeric>        <numeric>         <numeric>
##   [1]               G  2.46382903511311 3.14566717550675 0.409225094116621
##   [2]               C 0.976103777699146 1.78519714562405 0.364930526984022
##   [3]               T 0.120733654159376 3.39459789224459  0.93015473782783
##                permScore_3        permScore_4        permScore_5
##                  <numeric>          <numeric>          <numeric>
##   [1]    0.157174317815962 0.0298147140344611  0.164808833821082
##   [2] 4.12659268591985e-07  0.181807632802485   0.10896188401966
##   [3]    0.476262870594353  0.495743925156815 0.0165573671224115
##              permScore_6         snp                MAF           probeid
##                <numeric> <character>          <numeric>       <character>
##   [1] 0.0123114014465414  rs28863004 0.0910112359550562 ENSG00000215915.5
##   [2]   1.29337841084893  rs60396226  0.103370786516854 ENSG00000215915.5
##   [3]   1.38539981288919 rs144425991 0.0719101123595506 ENSG00000215915.5
##         mindist     jobid
##       <numeric> <integer>
##   [1]    858333         1
##   [2]    858229         1
##   [3]    855287         1
##   -------
##   seqinfo: 86 sequences from hg19 genome
```

We also have extractByRanges.

# Towards estimation of distributions relevant to FDR computation

## Small-footprint collection of association statistics

In the gQTLstats package, we will use the plug-in FDR algorithm of Hastie, Tibshirani and Friedman *Elements of Statistical Learning* ch. 18.7, algorithm 18.3. We will not handle hundreds of millions of scores directly in a holistic way, except for the estimation of quantiles of the observed association scores. This particular step is carried out using *[ff](https://CRAN.R-project.org/package%3Dff)* and *[ffbase](https://CRAN.R-project.org/package%3Dffbase)* packages. We illustrate with our subset of GEUVADIS scores.

```
allassoc = storeToFf(mm, "chisq")
length(allassoc)
```

```
## [1] 6183186
```

```
object.size(allassoc)
```

```
## 3312 bytes
```

```
allassoc[1:4]
```

```
## [1] 2.4638290 0.9761038 0.1207337 1.5093189
```

## Other statistical functions

Refer to the *[gQTLstats](https://bioconductor.org/packages/3.8/gQTLstats)* package for additional functions that generate quantile estimates, histograms, and FDR estimates based on `ciseStore` contents and various filtrations thereof.