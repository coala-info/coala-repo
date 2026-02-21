# gQTLstats: computationally efficient analysis and interpretation of large eQTL, mQTL, etc. archives

#### Vincent J. Carey, stvjc at channing.harvard.edu

#### Jun 2015

# Introduction

The software in this package aims to support refinements and functional interpretation of members of a collection of association statistics on a family of feature \(\times\) genome hypotheses. provide a basis for refinement or functional interpretation.

We take for granted the use of the gQTL\* infrastructure for testing and management of test results. We use for examples elements of the *[geuvPack](https://bioconductor.org/packages/3.8/geuvPack)* and *[geuvStore2](https://bioconductor.org/packages/3.8/geuvStore2)* packages.

# Basic infrastructure for statistics on a distributed store of eQTL results

We work with a `ciseStore` instance based on a small subset of transcriptome-wide cis-eQTL tests for GEUVADIS FPKM data. The overall testing procedure was conducted for all SNP:probe pairs for which SNP minor allele frequency (MAF) is at least 1% and for which the minimum distance between SNP and either boundary of the gene coding region for the probe is at most 1 million bp.

```
library(geuvStore2)
library(gQTLBase)
library(gQTLstats)
library(parallel)
nco = detectCores()
library(doParallel)
```

```
## Loading required package: foreach
```

```
## Loading required package: iterators
```

```
registerDoSEQ()
if (.Platform$OS.type != "windows") {
  registerDoParallel(cores=max(c(1, floor(nco/2))))
}
prst = makeGeuvStore2()
```

## Estimation of quantiles of the distribution of observed associations

Quantile estimation is very memory-efficient, based on a temporary ff representation of the vector of all association test results.

```
qassoc = storeToQuantiles(prst, field="chisq",
    probs=c(seq(0,.999,.001), 1-(c(1e-4,1e-5,1e-6))))
tail(qassoc)
```

```
##     99.7%     99.8%     99.9%    99.99%   99.999%  99.9999%
##  20.82392  29.06245  54.93786 193.82782 220.55134 235.75722
```

## Estimation of histogram of the distribution of association scores under permutation

Because we compute fixed breaks, contributions to the overall histogram can be assembled in parallel, with small footprint. This is a tremendous reduction of data.

```
hh = storeToHist( prst, breaks= c(0,qassoc,1e9) )
tail(hh$counts)
```

```
## [1] 4333 1933  416    0    0    1
```

## Computing FDR from a gqtlStore

FDR computation is post-hoc relative to filtering that need not be specified prior to testing. For illustration, we survey the results in *[geuvStore2](https://bioconductor.org/packages/3.8/geuvStore2)* to obtain FDRs for each SNP:probe pair in two forms. First, we obtain FDR without any filtering. Second, we compute an a FDR for those SNP:probe pairs separated by at most 500kb, and for which the MAF for the SNP is at least 5 per cent.

```
rawFDR = storeToFDR(prst,
   xprobs=c(seq(.05,.95,.05),.975,.990,.995,.9975,.999,
   .9995, .9999, .99999) )
```

```
## counting tests...
```

```
## counting #NA...
```

```
## obtaining assoc quantiles...
```

```
## computing perm_assoc histogram....
```

```
dmfilt = function(x)  # define the filtering function
     x[ which(x$MAF >= 0.05 & x$mindist <= 500000) ]
```

```
filtFDR = storeToFDR(prst,
   xprobs=c(seq(.05,.95,.05),.975,.990,.995,.9975,.999,
   .9995, .9999, .99999), filter = dmfilt )
```

```
## counting tests...
```

```
## counting #NA...
```

```
## obtaining assoc quantiles...
```

```
## computing perm_assoc histogram....
```

```
rawFDR
```

```
## FDRsupp instance with 27 rows.
##           assoc       fdr  ncalls avg.false
## 5%  0.003666364 0.9503595 5874027   5582437
## 10% 0.014663963 0.9489049 5564867   5280530
## 15% 0.033307623 0.9466335 5255708   4975229
## ...
##            assoc          fdr     ncalls avg.false
## 99.95%  157.9120 5.390964e-05 3091.59300 0.1666667
## 99.99%  193.8278 2.695482e-04  618.31860 0.1666667
## 99.999% 220.5513 0.000000e+00   61.83186 0.0000000
## No interpolating function is available; use 'setFDRfunc'.
```

```
filtFDR
```

```
## FDRsupp instance with 27 rows.
##           assoc       fdr  ncalls avg.false
## 5%  0.004052362 0.9461793 2102872   1989694
## 10% 0.016469885 0.9415121 1992194   1875675
## 15% 0.037696938 0.9363941 1881517   1761841
## ...
##            assoc fdr     ncalls avg.false
## 99.95%  193.8278   0 1106.77450         0
## 99.99%  194.9828   0  221.35490         0
## 99.999% 228.3958   0   22.13549         0
## No interpolating function is available; use 'setFDRfunc'.
```

The filtering leads to a lower FDR for a given strength of association. This is an inspiration for sensitivity analysis. Even with 5 million observations there is an effect of histogram bin selection in summarizing the permutation distribution of association. This can be seen fairly clearly in the wiggliness of the trace over the unfiltered association score:FDR plot.

```
rawtab = getTab(rawFDR)
filttab = getTab(filtFDR)
 plot(rawtab[-(1:10),"assoc"],
      -log10(rawtab[-(1:10),"fdr"]+1e-6), log="x", axes=FALSE,
  xlab="Observed association", ylab="-log10 plugin FDR")
 axis(1, at=c(seq(0,10,1),100,200))
 axis(2)
 points(filttab[-(1:10),1], -log10(filttab[-(1:10),2]+1e-6), pch=2)
 legend(1, 5, pch=c(1,2), legend=c("all loci", "MAF >= 0.05 & dist <= 500k"))
```

![](data:image/png;base64...)

We’ll address this below by fitting smooth functions for the score:FDR relationship.

## Estimates of FDR at the probe level

The `storeToFDRByProbe` FDR function examines the maximal association score by gene, for observed and permuted measures.
Good performance of this procedure is obtained by using `group_by` and `summarize` utilities of *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)*. Iteration employs *[foreach](https://CRAN.R-project.org/package%3Dforeach)*.

```
fdbp = storeToFDRByProbe( prst, xprobs=c(seq(.025,.975,.025),.99))
tail(getTab(fdbp),5)
```

```
fdAtM05bp = storeToFDRByProbe( prst, filter=function(x) x[which(x$MAF > .05)],
   xprobs=c(seq(.025,.975,.025),.99))
tail(getTab(fdAtM05bp),5)
```

# Modeling the association-FDR relationship to support efficient variant selection and annotation

## Choosing a smooth model for the association:FDR relationship

We’ll focus here on all-pairs analysis, with and without filtering.

Especially in this small example there will be some wiggling or even non-monotonicity in the trace of empirical FDR against association. We want to be able to compute the approximate FDR quickly and with minimal assumptions and pathology. To accomplish this, we will bind an interpolating model to the FDR estimates that we have. Interpolation will be accomplished with scatterplot smoothing in the *[mgcv](https://CRAN.R-project.org/package%3Dmgcv)* framework.

The code that is used to fit the interpolating model is

```
 fdrmod = gam(-log10(fdr+fudge)~s(assoc,bs="tp"), data=...,
    subset=assoc<(1.1*maxch))
```

where fudge defaults to 1e-6 and maxch defaults to 30

```
library(mgcv)
```

```
## Loading required package: nlme
```

```
##
## Attaching package: 'nlme'
```

```
## The following object is masked from 'package:BBmisc':
##
##     collapse
```

```
## The following object is masked from 'package:IRanges':
##
##     collapse
```

```
## This is mgcv 1.8-27. For overview type 'help("mgcv-package")'.
```

```
rawFDR = setFDRfunc(rawFDR)
filtFDR = setFDRfunc(filtFDR)
par(mfrow=c(2,2))
txsPlot(rawFDR)
txsPlot(filtFDR)
directPlot(rawFDR)
directPlot(filtFDR)
```

![](data:image/png;base64...)

More work is needed on assessing tolerability of relative error in FDR interpolation.

# Enumerating significant cis-eQTL in a store

Recall that `dmfilt` is a function that obtains the SNP-probe pairs for which SNP has MAF at least five percent and SNP-probe distance at most 500kbp.

We use the `FDRsupp` instances with `ciseStore` to list the SNP-probe pairs with FDR lying beneath a given upper bound.

Unfiltered pairs:

```
rawEnum = enumerateByFDR(prst, rawFDR, threshold=.05)
rawEnum[order(rawEnum$chisq,decreasing=TRUE)[1:3]]
```

```
## GRanges object with 3 ranges and 15 metadata columns:
##      seqnames    ranges strand |      paramRangeID            REF
##         <Rle> <IRanges>  <Rle> |          <factor> <DNAStringSet>
##   55       14 106552724      * | ENSG00000211968.2              C
##   15        1  54683925      * | ENSG00000231581.1              G
##   15        1  54685855      * | ENSG00000231581.1              G
##                  ALT            chisq        permScore_1
##      <CharacterList>        <numeric>          <numeric>
##   55               T 244.346730323135 0.0501551797344801
##   15               A 242.442851501609   3.80053239982144
##   15               A 242.442851501609   3.80053239982144
##             permScore_2      permScore_3        permScore_4
##               <numeric>        <numeric>          <numeric>
##   55 0.0619204147569882 1.11876874094608 0.0128366406444263
##   15 0.0717419017391262 0.31365008680731 0.0787366494554582
##   15 0.0717419017391262 0.31365008680731 0.0787366494554582
##             permScore_5          permScore_6         snp
##               <numeric>            <numeric> <character>
##   55 0.0108658771551224 0.000311470838435044 rs587662269
##   15   4.98223624599178   0.0443687606859505      rs6621
##   15   4.98223624599178   0.0443687606859505  rs33988698
##                      MAF           probeid   mindist    estFDR
##                <numeric>       <character> <numeric> <numeric>
##   55 0.00449438202247188 ENSG00000211968.2    525649         0
##   15   0.125842696629213 ENSG00000231581.1      6256         0
##   15   0.125842696629213 ENSG00000231581.1      4326         0
##   -------
##   seqinfo: 86 sequences from hg19 genome
```

```
length(rawEnum)
```

```
## [1] 44750
```

A small quantity of metadata is bound into the resulting `GRanges` instance.

```
names(metadata(rawEnum))
```

```
##  [1] "sessInfo"           "init.Random.seed"   "dimSummex"
##  [4] "rowRangesSummex"    "vcf.tf"             "vcfHeader"
##  [7] "requestSize"        "nRequestsSatisfied" "dimliteGT"
## [10] "theCall"            "enumCall"           "enumSess"
## [13] "fdrCall"
```

Pairs meeting MAF and distance conditions are obtained with a `filter` setting to the enumerating function.

```
filtEnum = enumerateByFDR(prst, filtFDR, threshold=.05,
   filter=dmfilt)
filtEnum[order(filtEnum$chisq,decreasing=TRUE)[1:3]]
```

```
## GRanges object with 3 ranges and 15 metadata columns:
##      seqnames    ranges strand |      paramRangeID            REF
##         <Rle> <IRanges>  <Rle> |          <factor> <DNAStringSet>
##   15        1  54683925      * | ENSG00000231581.1              G
##   15        1  54685855      * | ENSG00000231581.1              G
##   15        1  54683014      * | ENSG00000231581.1              C
##                  ALT            chisq      permScore_1        permScore_2
##      <CharacterList>        <numeric>        <numeric>          <numeric>
##   15               A 242.442851501609 3.80053239982144 0.0717419017391262
##   15               A 242.442851501609 3.80053239982144 0.0717419017391262
##   15               G 241.973387965798 4.22500694740408 0.0223163896089443
##           permScore_3        permScore_4      permScore_5
##             <numeric>          <numeric>        <numeric>
##   15 0.31365008680731 0.0787366494554582 4.98223624599178
##   15 0.31365008680731 0.0787366494554582 4.98223624599178
##   15  0.2092431187409 0.0274453484263505 4.32653697478316
##             permScore_6         snp               MAF           probeid
##               <numeric> <character>         <numeric>       <character>
##   15 0.0443687606859505      rs6621 0.125842696629213 ENSG00000231581.1
##   15 0.0443687606859505  rs33988698 0.125842696629213 ENSG00000231581.1
##   15 0.0510412165472524   rs1410896  0.12247191011236 ENSG00000231581.1
##        mindist    estFDR
##      <numeric> <numeric>
##   15      6256         0
##   15      4326         0
##   15      7167         0
##   -------
##   seqinfo: 86 sequences from hg19 genome
```

```
length(filtEnum)
```

```
## [1] 81837
```

# Sensitivity analysis for eQTL enumeration

The yield of an enumeration procedure depends on filtering based on SNP-gene distance and SNP MAF. This can be illustrated as follows, with minimal computational effort owing to the retention of genome-scale permutations and the use of the plug-in FDR algorithm.

```
data(sensByProbe) # see example(senstab) for construction approach
tab = senstab( sensByProbe )
plot(tab)
```

![](data:image/png;base64...)

If we wish to maximize the yield of eQTL enumeration at FDR at most 0.05, we can apply a filter to the store.

```
flens = storeApply( prst, function(x) {
    length(x[ which(x$MAF >= .08 & x$mindist <= 25000), ] )
})
```

```
sum(unlist(flens))
```

```
## [1] 175988
```

This is a count of gene-snp pairs satisfying structural and genetic criteria.

# Visualizing and annotating significant loci

## Re-binding probe annotation from RangedSummarizedExperiment

In the case of `geuFPKM` there is some relevant metadata in the `rowRanges` element. We will bind that into the collection of significant findings.

```
library(geuvPack)
data(geuFPKM)
basic = mcols(rowRanges(geuFPKM))[, c("gene_id", "gene_status", "gene_type",
    "gene_name")]
rownames(basic) = basic$gene_id
extr = basic[ filtEnum$probeid, ]
mcols(filtEnum) = cbind(mcols(filtEnum), extr)
stopifnot(all.equal(filtEnum$probeid, filtEnum$gene_id))
filtEnum[1:3]
```

```
## GRanges object with 3 ranges and 19 metadata columns:
##     seqnames    ranges strand |      paramRangeID            REF
##        <Rle> <IRanges>  <Rle> |          <factor> <DNAStringSet>
##   1        1    940005      * | ENSG00000215915.5              A
##   1        1    941539      * | ENSG00000215915.5              C
##   1        1   1357992      * | ENSG00000215915.5              C
##                 ALT            chisq       permScore_1
##     <CharacterList>        <numeric>         <numeric>
##   1               G 6.01990563001041 0.108063757142114
##   1               T 6.41083597373239 0.093618841748847
##   1               T 6.10356749217993  1.37837091431928
##              permScore_2        permScore_3        permScore_4
##                <numeric>          <numeric>          <numeric>
##   1 0.000327623238955786 0.0865779231391698 0.0043721985657395
##   1  0.00724450676019109  0.075618930467589  0.393588577163205
##   1    0.184207534716266  0.671668320031548   3.37939127443165
##            permScore_5        permScore_6         snp                MAF
##              <numeric>          <numeric> <character>          <numeric>
##   1  0.076623218975422   0.35807524662699   rs2799056  0.414606741573034
##   1 0.0731399185861158  0.341263708305593   rs9778087  0.419101123595506
##   1   1.35579610700077 0.0174709087600756   rs3737716 0.0651685393258427
##               probeid   mindist             estFDR           gene_id
##           <character> <numeric>          <numeric>       <character>
##   1 ENSG00000215915.5    445064 0.0488083078551294 ENSG00000215915.5
##   1 ENSG00000215915.5    443530 0.0314624014606096 ENSG00000215915.5
##   1 ENSG00000215915.5     27077 0.0445582764335767 ENSG00000215915.5
##     gene_status      gene_type   gene_name
##     <character>    <character> <character>
##   1       KNOWN protein_coding      ATAD3C
##   1       KNOWN protein_coding      ATAD3C
##   1       KNOWN protein_coding      ATAD3C
##   -------
##   seqinfo: 86 sequences from hg19 genome
```

## Static visualization of FDR patterns

We have a utility to create an annotated Manhattan plot for a search cis to a gene. The basic ingredients are

* a `ciseStore` instance for basic location and association information
* a gene identifier that works for that store
* an `FDRsupp` instance that includes the function that maps from association scores to FDR, and the filter employed during FDR estimation
* an annotation resource; here we use ChromHMM labeling based on NA12878, in the `hmm878` GRanges instance in gQTLstats/data.

It is important to recognize that, given an `FDRsupp` instance we can compute the FDR for any association score, but validity of the FDR attribution requires that we refrain from computing it for any locus excluded by filtering. the `manhWngr` executes the `FDRsupp`-resident filter by default.

```
data(hmm878)
library(geuvStore2)
prst = makeGeuvStore2()
myg = "ENSG00000183814.10" # LIN9
data(filtFDR)
library(ggplot2)
manhWngr( store = prst, probeid = myg, sym="LIN9",
  fdrsupp=filtFDR, namedGR=hmm878 )
```

```
## assuming Homo.sapiens for gene models
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

![](data:image/png;base64...)

For a dynamic visualization procedure, see the vjcitn/gQTLbrowse github archive.

## Basic structural variant annotation

We can use *[VariantAnnotation](https://bioconductor.org/packages/3.8/VariantAnnotation)* to establish basic structural characteristics for all filtered variants.

```
suppressPackageStartupMessages({
library(VariantAnnotation)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
})
txdb = TxDb.Hsapiens.UCSC.hg19.knownGene
seqlevelsStyle(filtEnum) = "UCSC"
#seqinfo(filtEnum) = seqinfo(txdb)
seqlengths(filtEnum)[paste0("chr", c(1:22,"M"))] =
 seqlengths(txdb)[paste0("chr", c(1:22,"M"))]
filtEnum = keepStandardChromosomes(filtEnum)
suppressWarnings({
allv = locateVariants(filtEnum, txdb, AllVariants()) # multiple recs per eQTL
})
```

```
## 'select()' returned many:1 mapping between keys and columns
## 'select()' returned many:1 mapping between keys and columns
## 'select()' returned many:1 mapping between keys and columns
## 'select()' returned many:1 mapping between keys and columns
## 'select()' returned many:1 mapping between keys and columns
## 'select()' returned many:1 mapping between keys and columns
```

```
table(allv$LOCATION)
```

```
##
## spliceSite     intron    fiveUTR   threeUTR     coding intergenic
##         25     139426       1037       4000       3233      36111
##   promoter
##      11072
```

```
hits = findOverlaps( filtEnum, allv )
filtEex = filtEnum[ queryHits(hits) ]
mcols(filtEex) = cbind(mcols(filtEex), mcols(allv[subjectHits(hits)])[,1:7])
filtEex[1:3]
```

```
## GRanges object with 3 ranges and 26 metadata columns:
##     seqnames    ranges strand |      paramRangeID            REF
##        <Rle> <IRanges>  <Rle> |          <factor> <DNAStringSet>
##   1     chr1    940005      * | ENSG00000215915.5              A
##   1     chr1    941539      * | ENSG00000215915.5              C
##   1     chr1   1357992      * | ENSG00000215915.5              C
##                 ALT            chisq       permScore_1
##     <CharacterList>        <numeric>         <numeric>
##   1               G 6.01990563001041 0.108063757142114
##   1               T 6.41083597373239 0.093618841748847
##   1               T 6.10356749217993  1.37837091431928
##              permScore_2        permScore_3        permScore_4
##                <numeric>          <numeric>          <numeric>
##   1 0.000327623238955786 0.0865779231391698 0.0043721985657395
##   1  0.00724450676019109  0.075618930467589  0.393588577163205
##   1    0.184207534716266  0.671668320031548   3.37939127443165
##            permScore_5        permScore_6         snp                MAF
##              <numeric>          <numeric> <character>          <numeric>
##   1  0.076623218975422   0.35807524662699   rs2799056  0.414606741573034
##   1 0.0731399185861158  0.341263708305593   rs9778087  0.419101123595506
##   1   1.35579610700077 0.0174709087600756   rs3737716 0.0651685393258427
##               probeid   mindist             estFDR           gene_id
##           <character> <numeric>          <numeric>       <character>
##   1 ENSG00000215915.5    445064 0.0488083078551294 ENSG00000215915.5
##   1 ENSG00000215915.5    443530 0.0314624014606096 ENSG00000215915.5
##   1 ENSG00000215915.5     27077 0.0445582764335767 ENSG00000215915.5
##     gene_status      gene_type   gene_name   LOCATION  LOCSTART    LOCEND
##     <character>    <character> <character>   <factor> <integer> <integer>
##   1       KNOWN protein_coding      ATAD3C intergenic      <NA>      <NA>
##   1       KNOWN protein_coding      ATAD3C intergenic      <NA>      <NA>
##   1       KNOWN protein_coding      ATAD3C   promoter      <NA>      <NA>
##       QUERYID        TXID         CDSID      GENEID
##     <integer> <character> <IntegerList> <character>
##   1         1        <NA>          <NA>        <NA>
##   1         2        <NA>          <NA>        <NA>
##   1         3        4185          <NA>      441869
##   -------
##   seqinfo: 25 sequences from hg19 genome
```

The resulting table is SNP:transcript specific, and will likely need further processing.

# Statistical modeling of phenorelevance of variant contexts, based on a cis-eQTL store

The following tasks need to be addressed in the modeling of phenorelevance

* Definition of outcome for a variant. In this example we consider identification of a variant as an NHGRI GWAS catalog hit.
* Definition of variant context. In this example we use Broad Institute ChromHMM states for NA12878, along with other information assembled in the store on MAF and distance
* Definition of the statistical model. We consider logistic regression modeling of the probability that a variant is a GWAS hit, employing LD-pruned variants only.
* Identification of a tractable approach to fitting and evaluating the statistical model. We’ll use a test-train framework.

## Visiting variants and updating with the relevant context and outcomes

We will make a temporary reconstruction of geuvStore2 contents with the enhanced information.

# Support for trans-eQTL identification

The workhorse function is AllAssoc. The interface is

```
args(AllAssoc)
```

```
## function (summex, vcf.tf, variantRange, rhs = ~1, nperm = 3,
##     genome = "hg19", assayind = 1, lbmaf = 1e-06, lbgtf = 1e-06,
##     dropUnivHet = TRUE, infoFields = c("LDAF", "SVTYPE"))
## NULL
```

This differs from cisAssoc through the addition of a `variantRange` argument.

The basic operation will be as follows. For a given RangedSummarizedExperiment instance `summex`, all features will be tested for association with all SNP in the `variantRange` restriction of the VCF identified in `vcf.tf`. The basic iteration strategy is

1. tile the genome to obtain chunks of SNPs
2. decompose the SE into chunks of transcriptome (or other ’ome)
3. for each chunk of SNPs, for each chunk of transcriptome, seek associations and retain the top K in a buffering structure

Management of this buffering structure needs work.

```
require(GenomeInfoDb)
require(geuvPack)
require(Rsamtools)
data(geuFPKM)  # get a ranged summarized expt
lgeu = geuFPKM[ which(seqnames(geuFPKM)=="chr20"), ] # limit to chr20
seqlevelsStyle(lgeu) = "NCBI"
tf20 = TabixFile(system.file("vcf/c20exch.vcf.gz", package="gQTLstats"))
if (require(VariantAnnotation)) scanVcfHeader(tf20)
```

```
## class: VCFHeader
## samples(1092): HG00096 HG00097 ... NA20826 NA20828
## meta(2): fileformat reference
## fixed(1): ALT
## info(22): LDAF AVGPOST ... VT SNPSOURCE
## geno(3): GT DS GL
```

```
set.seed(1234)
mysr = GRanges("20", IRanges(33.099e6, 33.52e6))
lita = AllAssoc(geuFPKM[1:10,], tf20, mysr)
```

```
##
## Attaching package: 'Matrix'
```

```
## The following object is masked from 'package:VariantAnnotation':
##
##     expand
```

```
## The following object is masked from 'package:S4Vectors':
##
##     expand
```

```
## Warning in .local(x, ...): non-diploid variants are set to NA
```

```
## checking for universal heterozygous loci for exclusion (as dropUnivHet == TRUE) ...
```

```
## done checking.
```

```
## Warning in col.summary(gtdata[[1]]): 238 rows were empty - ignored when
## calculating call rates

## Warning in col.summary(gtdata[[1]]): non-diploid variants are set to NA
```

```
## Warning in col.summary(gtdata$genotypes): 238 rows were empty - ignored
## when calculating call rates
```

```
names(mcols(lita))
```

```
##  [1] "paramRangeID"                   "REF"
##  [3] "ALT"                            "ENSG00000152931.6_obs"
##  [5] "ENSG00000183696.9_obs"          "ENSG00000139269.2_obs"
##  [7] "ENSG00000169129.8_obs"          "ENSG00000134602.11_obs"
##  [9] "ENSG00000136237.12_obs"         "ENSG00000259425.1_obs"
## [11] "ENSG00000242284.2_obs"          "ENSG00000235027.1_obs"
## [13] "ENSG00000228169.3_obs"          "ENSG00000152931.6_permScore_1"
## [15] "ENSG00000183696.9_permScore_1"  "ENSG00000139269.2_permScore_1"
## [17] "ENSG00000169129.8_permScore_1"  "ENSG00000134602.11_permScore_1"
## [19] "ENSG00000136237.12_permScore_1" "ENSG00000259425.1_permScore_1"
## [21] "ENSG00000242284.2_permScore_1"  "ENSG00000235027.1_permScore_1"
## [23] "ENSG00000228169.3_permScore_1"  "ENSG00000152931.6_permScore_2"
## [25] "ENSG00000183696.9_permScore_2"  "ENSG00000139269.2_permScore_2"
## [27] "ENSG00000169129.8_permScore_2"  "ENSG00000134602.11_permScore_2"
## [29] "ENSG00000136237.12_permScore_2" "ENSG00000259425.1_permScore_2"
## [31] "ENSG00000242284.2_permScore_2"  "ENSG00000235027.1_permScore_2"
## [33] "ENSG00000228169.3_permScore_2"  "ENSG00000152931.6_permScore_3"
## [35] "ENSG00000183696.9_permScore_3"  "ENSG00000139269.2_permScore_3"
## [37] "ENSG00000169129.8_permScore_3"  "ENSG00000134602.11_permScore_3"
## [39] "ENSG00000136237.12_permScore_3" "ENSG00000259425.1_permScore_3"
## [41] "ENSG00000242284.2_permScore_3"  "ENSG00000235027.1_permScore_3"
## [43] "ENSG00000228169.3_permScore_3"  "snp"
## [45] "MAF"                            "z.HWE"
## [47] "probeid"
```

The trans search for this segment of chr20 proceeds by obtaining additional association scores for additional genes.

```
litb = AllAssoc(geuFPKM[11:20,], tf20, mysr)
```

```
## Warning in .local(x, ...): non-diploid variants are set to NA
```

```
## checking for universal heterozygous loci for exclusion (as dropUnivHet == TRUE) ...
```

```
## done checking.
```

```
## Warning in col.summary(gtdata[[1]]): 238 rows were empty - ignored when
## calculating call rates

## Warning in col.summary(gtdata[[1]]): non-diploid variants are set to NA
```

```
## Warning in col.summary(gtdata$genotypes): 238 rows were empty - ignored
## when calculating call rates
```

```
litc = AllAssoc(geuFPKM[21:30,], tf20, mysr)
```

```
## Warning in .local(x, ...): non-diploid variants are set to NA
```

```
## checking for universal heterozygous loci for exclusion (as dropUnivHet == TRUE) ...
## done checking.
```

```
## Warning in col.summary(gtdata[[1]]): 238 rows were empty - ignored when
## calculating call rates
```

```
## Warning in .local(x, ...): non-diploid variants are set to NA
```

```
## Warning in col.summary(gtdata$genotypes): 238 rows were empty - ignored
## when calculating call rates
```

Now we want to reduce this information by collecting the strongest associations over the 30 genes tested.

```
buf = gQTLstats:::collapseToBuf(lita, litb, frag="_obs")
buf
```

```
## GRanges object with 504 ranges and 7 metadata columns:
##             seqnames    ranges strand |            REF             ALT
##                <Rle> <IRanges>  <Rle> | <DNAStringSet> <CharacterList>
##   rs6120668       20  33099793      * |              A               G
##   rs6059887       20  33101102      * |              C               G
##   rs6059890       20  33101653      * |              G               C
##   rs6088514       20  33102835      * |              A               G
##   rs6058070       20  33103521      * |              G               C
##         ...      ...       ...    ... .            ...             ...
##   rs4911451       20  33512466      * |              T               G
##   rs6088650       20  33514465      * |              T               C
##    rs725521       20  33516071      * |              T               C
##   rs1801310       20  33517014      * |              A               G
##   rs6087651       20  33518353      * |              C               T
##                     snp                MAF              z.HWE
##             <character>          <numeric>          <numeric>
##   rs6120668   rs6120668  0.437158469945355   -1.2099455344043
##   rs6059887   rs6059887  0.437158469945355   -1.2099455344043
##   rs6059890   rs6059890  0.437158469945355   -1.2099455344043
##   rs6088514   rs6088514 0.0655737704918032 -0.257106345555684
##   rs6058070   rs6058070  0.434426229508197  -1.34278725207113
##         ...         ...                ...                ...
##   rs4911451   rs4911451  0.407103825136612  0.100831582942844
##   rs6088650   rs6088650  0.407103825136612  0.100831582942844
##    rs725521    rs725521  0.407103825136612  0.100831582942844
##   rs1801310   rs1801310  0.407103825136612  0.100831582942844
##   rs6087651   rs6087651  0.407103825136612  0.100831582942844
##                                                           scorebuf
##                                                           <matrix>
##   rs6120668 2.89733045594377:2.40489118680199:2.29747891159704:...
##   rs6059887 2.89733045594377:2.40489118680199:2.29747891159704:...
##   rs6059890 2.89733045594377:2.40489118680199:2.29747891159704:...
##   rs6088514 3.31124248124317:3.02916772942689:2.96208255309395:...
##   rs6058070  3.12022868135409:2.43881118487567:2.3666567871172:...
##         ...                                                    ...
##   rs4911451 6.54072794440188:4.08090039878774:3.05185711327841:...
##   rs6088650 6.54072794440188:4.08090039878774:3.05185711327841:...
##    rs725521 6.54072794440188:4.08090039878774:3.05185711327841:...
##   rs1801310 6.54072794440188:4.08090039878774:3.05185711327841:...
##   rs6087651 6.54072794440188:4.08090039878774:3.05185711327841:...
##                                                                elnames
##                                                               <matrix>
##   rs6120668  ENSG00000242284.2:ENSG00000259425.1:ENSG00000247157.2:...
##   rs6059887  ENSG00000242284.2:ENSG00000259425.1:ENSG00000247157.2:...
##   rs6059890  ENSG00000242284.2:ENSG00000259425.1:ENSG00000247157.2:...
##   rs6088514 ENSG00000247157.2:ENSG00000183696.9:ENSG00000136237.12:...
##   rs6058070  ENSG00000242284.2:ENSG00000205981.2:ENSG00000247157.2:...
##         ...                                                        ...
##   rs4911451  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   rs6088650  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##    rs725521  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   rs1801310  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   rs6087651  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   -------
##   seqinfo: 1 sequence from hg19 genome; no seqlengths
```

```
buf = gQTLstats:::collapseToBuf(buf, litc, frag="_obs")
buf
```

```
## GRanges object with 504 ranges and 7 metadata columns:
##             seqnames    ranges strand |            REF             ALT
##                <Rle> <IRanges>  <Rle> | <DNAStringSet> <CharacterList>
##   rs6120668       20  33099793      * |              A               G
##   rs6059887       20  33101102      * |              C               G
##   rs6059890       20  33101653      * |              G               C
##   rs6088514       20  33102835      * |              A               G
##   rs6058070       20  33103521      * |              G               C
##         ...      ...       ...    ... .            ...             ...
##   rs4911451       20  33512466      * |              T               G
##   rs6088650       20  33514465      * |              T               C
##    rs725521       20  33516071      * |              T               C
##   rs1801310       20  33517014      * |              A               G
##   rs6087651       20  33518353      * |              C               T
##                     snp                MAF              z.HWE
##             <character>          <numeric>          <numeric>
##   rs6120668   rs6120668  0.437158469945355   -1.2099455344043
##   rs6059887   rs6059887  0.437158469945355   -1.2099455344043
##   rs6059890   rs6059890  0.437158469945355   -1.2099455344043
##   rs6088514   rs6088514 0.0655737704918032 -0.257106345555684
##   rs6058070   rs6058070  0.434426229508197  -1.34278725207113
##         ...         ...                ...                ...
##   rs4911451   rs4911451  0.407103825136612  0.100831582942844
##   rs6088650   rs6088650  0.407103825136612  0.100831582942844
##    rs725521    rs725521  0.407103825136612  0.100831582942844
##   rs1801310   rs1801310  0.407103825136612  0.100831582942844
##   rs6087651   rs6087651  0.407103825136612  0.100831582942844
##                                                           scorebuf
##                                                           <matrix>
##   rs6120668 2.91721965453209:2.89733045594377:2.40489118680199:...
##   rs6059887 2.91721965453209:2.89733045594377:2.40489118680199:...
##   rs6059890 2.91721965453209:2.89733045594377:2.40489118680199:...
##   rs6088514 3.57588453629161:3.31124248124317:3.02916772942689:...
##   rs6058070  3.12022868135409:2.43881118487567:2.3666567871172:...
##         ...                                                    ...
##   rs4911451 6.54072794440188:4.08090039878774:3.05185711327841:...
##   rs6088650 6.54072794440188:4.08090039878774:3.05185711327841:...
##    rs725521 6.54072794440188:4.08090039878774:3.05185711327841:...
##   rs1801310 6.54072794440188:4.08090039878774:3.05185711327841:...
##   rs6087651 6.54072794440188:4.08090039878774:3.05185711327841:...
##                                                                elnames
##                                                               <matrix>
##   rs6120668  ENSG00000198632.7:ENSG00000242284.2:ENSG00000259425.1:...
##   rs6059887  ENSG00000198632.7:ENSG00000242284.2:ENSG00000259425.1:...
##   rs6059890  ENSG00000198632.7:ENSG00000242284.2:ENSG00000259425.1:...
##   rs6088514 ENSG00000017260.13:ENSG00000247157.2:ENSG00000183696.9:...
##   rs6058070  ENSG00000242284.2:ENSG00000205981.2:ENSG00000247157.2:...
##         ...                                                        ...
##   rs4911451  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   rs6088650  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##    rs725521  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   rs1801310  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   rs6087651  ENSG00000152931.6:ENSG00000158482.8:ENSG00000259425.1:...
##   -------
##   seqinfo: 1 sequence from hg19 genome; no seqlengths
```

Let’s do the same buffering process for the first permutation.

```
pbuf = gQTLstats:::collapseToBuf(lita, litb, frag="_permScore_1")
pbuf = gQTLstats:::collapseToBuf(pbuf, litc, frag="_permScore_1")
pbuf
```

```
## GRanges object with 504 ranges and 7 metadata columns:
##             seqnames    ranges strand |            REF             ALT
##                <Rle> <IRanges>  <Rle> | <DNAStringSet> <CharacterList>
##   rs6120668       20  33099793      * |              A               G
##   rs6059887       20  33101102      * |              C               G
##   rs6059890       20  33101653      * |              G               C
##   rs6088514       20  33102835      * |              A               G
##   rs6058070       20  33103521      * |              G               C
##         ...      ...       ...    ... .            ...             ...
##   rs4911451       20  33512466      * |              T               G
##   rs6088650       20  33514465      * |              T               C
##    rs725521       20  33516071      * |              T               C
##   rs1801310       20  33517014      * |              A               G
##   rs6087651       20  33518353      * |              C               T
##                     snp                MAF              z.HWE
##             <character>          <numeric>          <numeric>
##   rs6120668   rs6120668  0.437158469945355   -1.2099455344043
##   rs6059887   rs6059887  0.437158469945355   -1.2099455344043
##   rs6059890   rs6059890  0.437158469945355   -1.2099455344043
##   rs6088514   rs6088514 0.0655737704918032 -0.257106345555684
##   rs6058070   rs6058070  0.434426229508197  -1.34278725207113
##         ...         ...                ...                ...
##   rs4911451   rs4911451  0.407103825136612  0.100831582942844
##   rs6088650   rs6088650  0.407103825136612  0.100831582942844
##    rs725521    rs725521  0.407103825136612  0.100831582942844
##   rs1801310   rs1801310  0.407103825136612  0.100831582942844
##   rs6087651   rs6087651  0.407103825136612  0.100831582942844
##                                                           scorebuf
##                                                           <matrix>
##   rs6120668 2.16673619449758:1.77026137754041:1.20808029031616:...
##   rs6059887 2.16673619449758:1.77026137754041:1.20808029031616:...
##   rs6059890 2.16673619449758:1.77026137754041:1.20808029031616:...
##   rs6088514   8.86722548685928:3.8987040095705:2.3669480363973:...
##   rs6058070 2.02599295238024:1.71133493570342:1.25157667347903:...
##         ...                                                    ...
##   rs4911451 4.43421688475491:3.34398544119719:3.10578772077476:...
##   rs6088650 4.43421688475491:3.34398544119719:3.10578772077476:...
##    rs725521 4.43421688475491:3.34398544119719:3.10578772077476:...
##   rs1801310 4.43421688475491:3.34398544119719:3.10578772077476:...
##   rs6087651 4.43421688475491:3.34398544119719:3.10578772077476:...
##                                                                elnames
##                                                               <matrix>
##   rs6120668  ENSG00000228449.1:ENSG00000242284.2:ENSG00000139269.2:...
##   rs6059887  ENSG00000228449.1:ENSG00000242284.2:ENSG00000139269.2:...
##   rs6059890  ENSG00000228449.1:ENSG00000242284.2:ENSG00000139269.2:...
##   rs6088514  ENSG00000215093.3:ENSG00000228449.1:ENSG00000169129.8:...
##   rs6058070 ENSG00000228449.1:ENSG00000242284.2:ENSG00000017260.13:...
##         ...                                                        ...
##   rs4911451  ENSG00000259425.1:ENSG00000169129.8:ENSG00000215093.3:...
##   rs6088650  ENSG00000259425.1:ENSG00000169129.8:ENSG00000215093.3:...
##    rs725521  ENSG00000259425.1:ENSG00000169129.8:ENSG00000215093.3:...
##   rs1801310  ENSG00000259425.1:ENSG00000169129.8:ENSG00000215093.3:...
##   rs6087651  ENSG00000259425.1:ENSG00000169129.8:ENSG00000215093.3:...
##   -------
##   seqinfo: 1 sequence from hg19 genome; no seqlengths
```

We can compare the distributions of maximal association per SNP as observed or under permutation.

```
plot(density(buf$scorebuf[,1]))
lines(density(pbuf$scorebuf[,1]), lty=2)
```

![](data:image/png;base64...)