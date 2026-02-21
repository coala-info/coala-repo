# CNVfilteR: Remove false positives of CNV calling tools by using SNV calls

Jose Marcos Moreno-Cabrera  and Bernat Gel

#### 29 October 2025

#### Package

CNVfilteR 1.24.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Quick Start](#quick-start)
* [4 Loading Copy-Number Data](#loading-copy-number-data)
* [5 Loading Variants Data](#loading-variants-data)
  + [5.1 VCF free of artifacts](#vcf-free-of-artifacts)
    - [5.1.1 Minimun total depth](#minimun-total-depth)
    - [5.1.2 Regions to exclude](#regions-to-exclude)
    - [5.1.3 INDELs excluded by default](#indels-excluded-by-default)
  + [5.2 Other settings](#other-settings)
  + [5.3 Limitations](#limitations)
* [6 Identifying false positives](#identifying-false-positives)
  + [6.1 Scoring model for duplication CNVs](#scoring-model-for-duplication-cnvs)
  + [6.2 The margin.pct parameter](#the-margin.pct-parameter)
* [7 Plotting results](#plotting-results)
* [8 Session Info](#session-info)

# 1 Introduction

Many tools for germline copy number variant (CNV) detection from
NGS data have been developed. Usually, these tools were designed
for different input data like WGS, WES or
panel data, and their performance may depend on the CNV size. Available
benchmarks show that all these tools produce false positives, sometimes
reaching a very high number of them.

With the aim of reducing the number of false positives,
*[CNVfilteR](https://bioconductor.org/packages/3.22/CNVfilteR)* identifies those germline CNVs that can
be discarded. This task is performed by using the germline
single nucleotide variant (SNV) calls that are usually obtained in
common NGS pipelines. As VCF field interpretation is key when working
with these files, *[CNVfilteR](https://bioconductor.org/packages/3.22/CNVfilteR)* specifically supports
VCFs produced by VarScan2, Strelka/Strelka2, freeBayes, HaplotypeCaller (GATK),
UnifiedGenotyper (GATK) and Torrent Variant Caller. Additionally, results can be
plotted using the functions provided by the R/Bioconductor packages
[karyoploteR](http://bioconductor.org/packages/karyoploteR/) and
[CopyNumberPlots](http://bioconductor.org/packages/CopyNumberPlots/).

# 2 Installation

*[CNVfilteR](https://bioconductor.org/packages/3.22/CNVfilteR)* is a
[Bioconductor](http://bioconductor.org) package and to install it we have
to use *[BiocManager](https://bioconductor.org/packages/3.22/BiocManager)*.

```
  if (!requireNamespace("BiocManager", quietly = TRUE))
      install.packages("BiocManager")
  BiocManager::install("CNVfilteR")
```

We can also install the package from github to get the latest **devel version**.

```
  BiocManager::install("jpuntomarcos/CNVfilteR")
```

# 3 Quick Start

Below we show a full example that covers the usual steps: CNVs data loading,
SNVs loading, identifying false postives and plotting the results.

First, we can load some CNV tool results:

```
library(CNVfilteR)

cnvs.file <- system.file("extdata", "DECoN.CNVcalls.csv", package = "CNVfilteR", mustWork = TRUE)
cnvs.gr <- loadCNVcalls(cnvs.file = cnvs.file, chr.column = "Chromosome", start.column = "Start", end.column = "End", cnv.column = "CNV.type", sample.column = "Sample", genome = "hg19")
```

Then, we load the SNVs stored in a couple of VCF files.

```
vcf.files <- c(system.file("extdata", "variants.sample1.vcf.gz", package = "CNVfilteR", mustWork = TRUE),
               system.file("extdata", "variants.sample2.vcf.gz", package = "CNVfilteR", mustWork = TRUE))
vcfs <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr, genome = "hg19")
```

```
## Scanning file /tmp/Rtmp60q6d6/Rinst3ac2f82ab75f6c/CNVfilteR/extdata/variants.sample1.vcf.gz...
```

```
## VarScan2 was found as source in the VCF metadata, RD will be used as ref allele depth field, AD will be used as alt allele depth field.
```

```
## Scanning file /tmp/Rtmpjl4dM2/variants.sample2.vcf.gz...
```

```
## VarScan2 was found as source in the VCF metadata, RD will be used as ref allele depth field, AD will be used as alt allele depth field.
```

We observe that the function recognized VarScan2 as the source, so fields
were selected and allele frequency consequently. Now we can call
`filterCNVs()` to identify those CNVs that can be discarded.

```
results <- filterCNVs(cnvs.gr, vcfs)
names(results)
```

```
## [1] "cnvs"               "variantsForEachCNV" "filterParameters"
```

And we can check those CNVs that can be filtered out:

```
results$cnvs[results$cnvs$filter == TRUE]
```

```
## GRanges object with 3 ranges and 10 metadata columns:
##      seqnames            ranges strand |         cnv      sample      cnv.id
##         <Rle>         <IRanges>  <Rle> | <character> <character> <character>
##    3     chr2 48025751-48028294      * | duplication     sample1           3
##   16    chr17 41243453-41247939      * | duplication     sample1          16
##   19    chr13 32900637-32929425      * |    deletion     sample2          19
##           filter n.total.variants n.hm.variants n.ht.discard.CNV
##      <character>      <character>   <character>      <character>
##    3        TRUE                5             0                3
##   16        TRUE                2             0                2
##   19        TRUE               10             4                6
##      n.ht.confirm.CNV      ht.pct            score
##           <character> <character>      <character>
##    3                2               2.539241834223
##   16                0             1.99927691434002
##   19                           60
##   -------
##   seqinfo: 7 sequences from an unspecified genome; no seqlengths
```

As an example, we can observe that the CNV with `cnv.id`=3 contains 4 variants:
2 in favor of discarding it, two against discarding it. If we want
to know more about the variants falling in a certain CNV we can do:

```
results$variantsForEachCNV[["3"]]
```

```
##   seqnames    start      end width strand ref alt ref.support alt.support
## 1     chr2 48026019 48026019     1      *   G   C         516         521
## 2     chr2 48027019 48027019     1      *   G   C        1528         964
## 3     chr2 48027182 48027182     1      *   G   A        1506         971
## 4     chr2 48027434 48027434     1      *   A   T        1593        1462
## 5     chr2 48027763 48027763     1      *   G   A         900         863
##   alt.freq total.depth indel type      score
## 1  50.2411        1037 FALSE   ht  0.9999596
## 2  38.6838        2492 FALSE   ht -0.3169985
## 3  39.2006        2477 FALSE   ht -0.1417051
## 4  47.8560        3055 FALSE   ht  0.9981889
## 5  48.9507        1763 FALSE   ht  0.9997969
```

Two variants are close to the default expected heterozygous frequency,
0.5, so they obtain a positive score. The other two variants are not
so clearly close to the default expected duplication value, 0.33, so
they obtain a low negative score. All these default values and others can
be modified in the `filterCNVs()` function.

Finally, we may be interested in plotting the results. For example, we can
plot easily the duplication CNV with `cnv.id`=3 and all the variants falling in
it.

```
plotVariantsForCNV(results, "3")
```

![](data:image/png;base64...)

We can do the same to plot the deletion CNV with `cnv.id`=19, where all
variants discard the CNV except one homozygous variant that does not give us any
information for supporting or discarding the CNV:

```
plotVariantsForCNV(results, "19")
```

![](data:image/png;base64...)

On the opposite side, we can observe those CNVs that cannot be discarded:

```
results$cnvs[results$cnvs$filter != TRUE]
```

```
## GRanges object with 17 ranges and 10 metadata columns:
##      seqnames            ranges strand |         cnv      sample      cnv.id
##         <Rle>         <IRanges>  <Rle> | <character> <character> <character>
##    1     chr2 47641409-47641557      * | duplication     sample1           1
##    2     chr2 47698105-47698201      * | duplication     sample1           2
##    4     chr3 10091059-10091189      * | duplication     sample1           4
##    5     chr3 14219967-14220068      * | duplication     sample1           5
##    6     chr3 37042447-37042544      * | duplication     sample1           6
##   ..      ...               ...    ... .         ...         ...         ...
##   14    chr13 32953455-32969070      * | duplication     sample1          14
##   15    chr17 41209070-41215390      * | duplication     sample1          15
##   17    chr17 41251793-41256973      * | duplication     sample1          17
##   18    chr17 41267744-41276113      * | duplication     sample1          18
##   20    chr17 59870959-59938900      * |    deletion     sample2          20
##           filter n.total.variants n.hm.variants n.ht.discard.CNV
##      <character>      <character>   <character>      <character>
##    1                            0             0
##    2                            0             0
##    4                            0             0
##    5                            0             0
##    6                            1             0                1
##   ..         ...              ...           ...              ...
##   14                            0             0
##   15                            0             0
##   17                            0             0
##   18                            0             0
##   20                            0             0
##      n.ht.confirm.CNV      ht.pct             score
##           <character> <character>       <character>
##    1
##    2
##    4
##    5
##    6                0             0.372384685846936
##   ..              ...         ...               ...
##   14
##   15
##   17
##   18
##   20
##   -------
##   seqinfo: 7 sequences from an unspecified genome; no seqlengths
```

For example, the CNV with `cnv.id`=14 contains one variant. If we get
the variant info, we see that the variant has an allele frequency very close to
the default expected duplication value, 0.66.

```
results$variantsForEachCNV[["14"]]
```

```
## NULL
```

So, no evidence was found for discarding the CNV. We can also plot the CNV and
the variant:

```
plotVariantsForCNV(results, "3")
```

![](data:image/png;base64...)

# 4 Loading Copy-Number Data

*[CNVfilteR](https://bioconductor.org/packages/3.22/CNVfilteR)* functions expect germline CNVs calls to be a
`GRanges` object with a few specificic metadata columns:

* **cnv** for storing the CNV type: duplication or deletion.
* **sample** for storing the sample name of the CNV.

You can create this object yourself, but
*[CNVfilter](https://bioconductor.org/packages/3.22/CNVfilter)* provides the proper function to do this,
`loadCNVcalls()`. This function can interpret any tsv o csv file by indicating
which columns store the information. For example, in the following code, the
`chr.column` column is stored in the “Chromosome” column of the `cnvs.file`.

```
cnvs.file <- system.file("extdata", "DECoN.CNVcalls.csv", package = "CNVfilteR", mustWork = TRUE)
cnvs.gr <- loadCNVcalls(cnvs.file = cnvs.file, chr.column = "Chromosome", start.column = "Start", end.column = "End", cnv.column = "CNV.type", sample.column = "Sample", genome = "hg19")
```

`loadCNVcalls()` can interpret different types of CNVs. Among other options,
separator can be selected using the `sep` parameter (defaults to *\t*),
and first lines can be skipped using the `skip` parameter (defaults to 0). Also,
the value used in `cnv.column` to store the CNV type can be modified
using the `deletion` and `duplication` parameters (defaults to “deletion” and
“duplication”, respectively). If, for example, our `cnv.column` uses “CN1” and
“CN3” for deletion and duplication (respectively), we should indicate
the function to use these values:

```
cnvs.gr.2 <- loadCNVcalls(cnvs.file = cnvs.file.2, deletion = "CN1", duplication = "CN3", chr.column = "Chromosome", start.column = "Start", end.column = "End", cnv.column = "CNV.type", sample.column = "Sample")
```

Some CNV tools generate results where the CNV location is stored in a single
column with the format *chr:start-end* (i.e. *1:538001-540000*). In this
case, we can call `loadCNVcalls()` using the `coord.column` instead of the
`chr.column`, `start.column` and `end.column` columns.

# 5 Loading Variants Data

Common NGS pipelines produce germline variant calling (SNVs or INDELs)
in a VCF file. However, VCF interpretation is
challenging due to the flexibility provided by the VCF format definition.
It is not straightforward to interpret correctly the fields in the VCF file
and compute the allele frequency. `loadVCFs()` interprets automatically
VCFs produced by VarScan2, Strelka/Strelka2, freeBayes, HaplotypeCaller (GATK),
UnifiedGenotyper (GATK) and Torrent Variant Caller.

In the following example the function recognizes VarScan2 as the source.

```
vcf.files <- c(system.file("extdata", "variants.sample1.vcf.gz", package = "CNVfilteR", mustWork = TRUE),
               system.file("extdata", "variants.sample2.vcf.gz", package = "CNVfilteR", mustWork = TRUE))
vcfs <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr)
```

```
## Scanning file /tmp/Rtmp60q6d6/Rinst3ac2f82ab75f6c/CNVfilteR/extdata/variants.sample1.vcf.gz...
```

```
## VarScan2 was found as source in the VCF metadata, RD will be used as ref allele depth field, AD will be used as alt allele depth field.
```

```
## Scanning file /tmp/Rtmpjl4dM2/variants.sample2.vcf.gz...
```

```
## VarScan2 was found as source in the VCF metadata, RD will be used as ref allele depth field, AD will be used as alt allele depth field.
```

We can also load the VCF file spicifying how to interpret it, which can be
useful if the VCF was generated by a caller not supported by
*[CNVfilteR](https://bioconductor.org/packages/3.22/CNVfilteR)*. For example we can specify the ref/alt
fields:

```
vcfs <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr, vcf.source = "MyCaller", ref.support.field = "RD", alt.support.field = "AD")
```

```
## Scanning file /tmp/Rtmp60q6d6/Rinst3ac2f82ab75f6c/CNVfilteR/extdata/variants.sample1.vcf.gz...
```

```
## VCF source MyCaller is not supported, but ref.support.field/alt.support.field were provided.
```

```
## Scanning file /tmp/Rtmpjl4dM2/variants.sample2.vcf.gz...
```

```
## VCF source MyCaller is not supported, but ref.support.field/alt.support.field were provided.
```

Alternatively, we can set the `list.support.field` parameter so that field
will be loaded assuming that it is a list in this order: reference allele,
alternative allele. As an example:

```
vcf.file3 <- c(system.file("extdata", "variants.sample3.vcf", package = "CNVfilteR", mustWork = TRUE))
vcfs3 <- loadVCFs(vcf.file3, cnvs.gr = cnvs.gr, vcf.source = "MyCaller", list.support.field = "AD")
```

```
## Scanning file /tmp/Rtmpjl4dM2/variants.sample3.vcf.gz...
```

```
## VCF source MyCaller is not supported, but list.support.field was provided.
```

## 5.1 VCF free of artifacts

CNVfilteR uses SNVs to identify false-positive CNV calls. Therefore, its
performance depends on the SNV calls quality. **We recommend using VCF files
free of false-positive SNVs** (as possible) to improve CNVfilteR accuracy.
Some considerations can be followed in order to provide reliable SNVs to
CNVfilteR.

### 5.1.1 Minimun total depth

Use the `min.total.depth` parameter to discard SNVs with low depth coverage in
the `loadVCFs` function. The default
value is 10, which may be appropriate in many WGS samples, but
**this value should be adapted to your experiment conditions**. For
example, we used a `min.total.depth`
of 30 when using CNVfilteR on panel (targeted-enrinched) samples with high
coverage and VarScan2 as SNV caller.

### 5.1.2 Regions to exclude

Low complexity and repetitive regions are genome areas where SNV callers
(also CNV callers) perform poorly. If possible, ignore these regions when using
CNVfilteR. We can exclude
those complex regions that have already known alignement artifacts
with the parameter `regions.to.exclude`.
In this example, we exclude PMS2, PRSS1, and
FANCD2 genes because they are pseudogenes with alignments artifacts:

```
regions.to.exclude <- GRanges(seqnames = c("chr3","chr7", "chr7"), ranges = IRanges(c(10068098, 6012870, 142457319), c(10143614, 6048756, 142460923)))
vcfs4 <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr, regions.to.exclude = regions.to.exclude)
```

```
## Scanning file /tmp/Rtmp60q6d6/Rinst3ac2f82ab75f6c/CNVfilteR/extdata/variants.sample1.vcf.gz...
```

```
## VarScan2 was found as source in the VCF metadata, RD will be used as ref allele depth field, AD will be used as alt allele depth field.
```

```
## Scanning file /tmp/Rtmpjl4dM2/variants.sample2.vcf.gz...
```

```
## VarScan2 was found as source in the VCF metadata, RD will be used as ref allele depth field, AD will be used as alt allele depth field.
```

### 5.1.3 INDELs excluded by default

Also, the parameter `exclude.indels` indicates whether to exclude INDELs when
loading the variants. TRUE is the default and **recommended** value given
that INDELs allele frequency varies differently than SNVs. Including
INDELs may allow the algorithm to identify more CNVs to discard with a greater
risk of identifying them wrongly. Additionally, any SNV overlapping an INDEL
will be ignored because the SNV allele frequency may be affected in that region.

## 5.2 Other settings

The function `loadVCFs()` also adapts to different needs. If `sample.names` parameter is
not provided, the sample names included in the VCF itself will be used.
Both single-sample and multi-sample VCFs are accepted, but when
multi-sample VCFs are used, `sample.names` parameter must be NULL.

If VCF is not compressed with bgzip, the function compresses it and generates
the .gz file. If .tbi file does not exist for a given VCF file, the function
also generates it. All files are generated in a temporary folder.

See `loadVCFs()` documentation to see other parameters info.

## 5.3 Limitations

Currlently CNVfilteR does not support mutiallelic sites in VCF files,
such as `chr3 193372598 .;. TTA T,TTT`. As an easy work around,
mutiallelic sites can be split by using
[bcftools](https://samtools.github.io/bcftools/):
`bcftools norm -N -m -both yourSample.vcf > splitSample.vcf`

# 6 Identifying false positives

The task of identifying false positives is performed by the `filterCNVs()`
function. It checks all the variants (SNVs and optionally INDELs) falling in
each CNV present in `cnvs.gr` to identify those CNVs that can be filtered out. It
returns an S3 object with 3 elements: `cnvs`, `variantsForEachCNV` and
`filterParameters`:

```
results <- filterCNVs(cnvs.gr, vcfs)
```

```
## 3 out of 20 (15%) CNVs can be filtered
```

```
## 3 out of 5 (60%) CNVs with overlapping SNVs can be filtered
```

```
tail(results$cnvs)
```

```
## GRanges object with 6 ranges and 10 metadata columns:
##      seqnames            ranges strand |         cnv      sample      cnv.id
##         <Rle>         <IRanges>  <Rle> | <character> <character> <character>
##   15    chr17 41209070-41215390      * | duplication     sample1          15
##   16    chr17 41243453-41247939      * | duplication     sample1          16
##   17    chr17 41251793-41256973      * | duplication     sample1          17
##   18    chr17 41267744-41276113      * | duplication     sample1          18
##   19    chr13 32900637-32929425      * |    deletion     sample2          19
##   20    chr17 59870959-59938900      * |    deletion     sample2          20
##           filter n.total.variants n.hm.variants n.ht.discard.CNV
##      <character>      <character>   <character>      <character>
##   15                            0             0
##   16        TRUE                2             0                2
##   17                            0             0
##   18                            0             0
##   19        TRUE               10             4                6
##   20                            0             0
##      n.ht.confirm.CNV      ht.pct            score
##           <character> <character>      <character>
##   15
##   16                0             1.99927691434002
##   17
##   18
##   19                           60
##   20
##   -------
##   seqinfo: 7 sequences from an unspecified genome; no seqlengths
```

Observe that **those CNVs that can be filtered out have the value TRUE in the
column `filter`**. *[CNVfilteR](https://bioconductor.org/packages/3.22/CNVfilteR)* employs two
different strategies for identifying those CNVs:

* A **deletion CNV** can be filtered out if there is at least
  `ht.deletions.threshold`% of heterozygous variants in
  the CNV. Default `ht.deletions.threshold` value is 30, so 30% is required.
* A **duplication CNV** can be filtered out if the total `score` is >=
  `dup.threshold.score` after computing all
  heterozygous variants falling in that CNV. Default `dup.threshold.score` value
  is 0.5. How the score is computed for each variant is explained in
  the next section.

## 6.1 Scoring model for duplication CNVs

The scoring model for determining whether a certain duplication CNV can be
discarded
is based on the allele frequency for each heterozygous variant falling in
that CNV:

* In common conditions with no presence of a duplication CNV, the allele
  frequency of a heterozygous variant is expected to be close to 50%
  (`expected.ht.mean`). So, a variant with an allele frequency close to 50%
  gives us evidence of the non-existence of a duplication CNV, so the CNV could
  be discarded.
* On the opposite side, if the variant occurs in the same region of a
  certain duplication CNV, the allele frequency is expected to be close to 33.3%
  (`expected.dup.ht.mean1`) when the variant **is not** in the same allele
  than the duplication CNV, and 66.6% (`expected.dup.ht.mean2`) when the variant
  **is** in the same allele than
  the duplication CNV call. So, a variant with an allele frequency close to
  33.3% or 66.6% gives us evidence of the existence of duplication CNV.

Although we can expect that most of the variants are close to the expected means
(33.3%, 50%, and 66.6%), many of them can be far from any expected mean. The
scoring model implemented in the `filterCNVs()` function measures
the evidence - for discarding a certain CNV - using
a scoring model. The scoring model is based on the fuzzy logic, where elements
can have any value between 1 (True) and 0 (False). Following this idea,
**each variant will be scored with a value between 0 and 1 depending on
how close is the allele frequency to the nearest expected mean**.

* For those variants with an allele frequency close to the expected mean when
  no duplication CNV occurs (defaults 50%),
  the score will be positive in the interval [0, 1].
* For those variants with an allele frequency close to the expected mean when
  a duplication CNV occurs (defaults 33.3%, 66.6%), the score will be negative
  in the interval [-1, 0].

The total `score` is computed among all the variants falling in the CNV. If the
`score` is greater than the `dup.threshold.score`, the CNV can be discarded.

A common way of applying the fuzzy logic is using the sigmoid function.
CNVfilteR uses the sigmoid function implemented in the
[pracma](https://cran.r-project.org/web/packages/pracma/index.html) package,
which is defined as
\[
\begin{aligned}
y = 1/(1 + e^{-c1(x−c2)})
\end{aligned}
\]

The scoring model is built on 6 sigmoids defined on 6 different intervals. The
c1 parameter is 2 by default (`sigmoid.c1`), and the c2 parameter
is defined for the 6 sigmoids (`sigmoid.c2.vector`).

* First sigmoid: interval [20, `expected.dup.ht.mean1`], c2=28
* Second sigmoid: interval [`expected.dup.ht.mean1`, `sigmoid.int1`], c2=38.3
* Third sigmoid: interval [`sigmoid.int1`, `expected.ht.mean`], c2=44.7
* Fourth sigmoid: interval [`expected.ht.mean`, `sigmoid.int2`], c2=55.3
* Fifth sigmoid: interval [`sigmoid.int2`, `expected.dup.ht.mean2`], c`=61.3
* Sixth sigmoid: interval [`expected.dup.ht.mean2`, 80], c2=71.3

Where `sigmoid.int1` is the mean between `expected.dup.ht.mean1` and
`expected.ht.mean`, and `sigmoid.int2` is the mean between
`expected.dup.ht.mean2` and `expected.ht.mean`.

The scoring model can be plotted using the `plotScoringModel()` function.

```
p <- results$filterParameters
plotScoringModel(expected.ht.mean = p$expected.ht.mean,
                 expected.dup.ht.mean1 = p$expected.dup.ht.mean1,
                 expected.dup.ht.mean2 = p$expected.dup.ht.mean2,
                 sigmoid.c1 = p$sigmoid.c1,
                 sigmoid.c2.vector = p$sigmoid.c2.vector)
```

![](data:image/png;base64...)

And the scoring model can be modified when calling the `filterCNVs()` function.
Let’s see how the model changes when we modify the parameter `sigmoid.c1`
(1 instead of 2):

```
plotScoringModel(expected.ht.mean = p$expected.ht.mean,
                 expected.dup.ht.mean1 = p$expected.dup.ht.mean1,
                 expected.dup.ht.mean2 = p$expected.dup.ht.mean2,
                 sigmoid.c1 = 1,
                 sigmoid.c2.vector = p$sigmoid.c2.vector)
```

![](data:image/png;base64...)

We can also modify the `sigmoid.c2.vector` parameter for each sigmoid function. For example, to
make the central sigmoids narrower:

```
plotScoringModel(expected.ht.mean = p$expected.ht.mean,
                 expected.dup.ht.mean1 = p$expected.dup.ht.mean1,
                 expected.dup.ht.mean2 = p$expected.dup.ht.mean2,
                 sigmoid.c1 = p$sigmoid.c1,
                 sigmoid.c2.vector = c(28, 38.3, 46.7, 53.3, 61.3, 71.3))
```

![](data:image/png;base64...)

## 6.2 The margin.pct parameter

Many CNV callers produce inaccurate CNV calls. These inaccurate CNV calls are
more likely to be true (to overlap the real CNV) in the middle of the CNV than
in the extremes. So, the `margin.pct` parameter defines the percentage of CNV
(from each CNV limit) where SNVs will be ignored. By default, only 10% of SNVs
from each CNV extreme will be ignored. This `margin.pct` parameter can be
modified to better adapt it to your CNV caller. For example, we observed that
DECoN produced very accurate CNV calls in our genes panel dataset, so
`margin.pct` value was updated to 0 in this context.

Summarizing, variants in the CNV call but close to the ends of the CNV call will
be ignored. `margin.pct` defines the percentage of CNV length, located at
each CNV limit, where variants will be ignored. For example, for a CNV
chr1:1000-2000 and a `margin.pct` value of 10,
variants within chr1:1000-1100 and chr1:1900-2000 will be ignored.

# 7 Plotting results

We can plot easily a certain CNV and the variants in it. For example, the
duplication CNV with `cnv.id`=17 can be plotted as follows:

```
plotVariantsForCNV(results, "16")
```

![](data:image/png;base64...)

Some parameters can be customized, like `points.cex` and `points.pch`. It is
also possible to plot all CNVs in a global schema where all the chromosomes are
plotted:

```
cnvs.file <- system.file("extdata", "DECoN.CNVcalls.2.csv",
                         package = "CNVfilteR", mustWork = TRUE)
cnvs.gr.2 <- loadCNVcalls(cnvs.file = cnvs.file, chr.column = "Chromosome",
                          start.column = "Start", end.column = "End",
                          cnv.column = "CNV.type", sample.column = "Sample",
                          genome = "hg19")
plotAllCNVs(cnvs.gr.2)
```

![](data:image/png;base64...)

Note that if a CNV is too small, it will not be visible when calling
`plotAllCNVs()`.

# 8 Session Info

```
  sessionInfo()
```

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
##  [1] BSgenome.Hsapiens.UCSC.hg19.masked_1.3.993
##  [2] BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] BSgenome_1.78.0
##  [4] rtracklayer_1.70.0
##  [5] BiocIO_1.20.0
##  [6] Biostrings_2.78.0
##  [7] XVector_0.50.0
##  [8] GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0
## [10] IRanges_2.44.0
## [11] S4Vectors_0.48.0
## [12] BiocGenerics_0.56.0
## [13] generics_0.1.4
## [14] CNVfilteR_1.24.0
## [15] knitr_1.50
## [16] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] gridExtra_2.3               rlang_1.1.6
##   [5] magrittr_2.0.4              biovizBase_1.58.0
##   [7] matrixStats_1.5.0           compiler_4.5.1
##   [9] RSQLite_2.4.3               GenomicFeatures_1.62.0
##  [11] png_0.1-8                   vctrs_0.6.5
##  [13] ProtGenerics_1.42.0         stringr_1.5.2
##  [15] pkgconfig_2.0.3             crayon_1.5.3
##  [17] fastmap_1.2.0               magick_2.9.0
##  [19] CopyNumberPlots_1.26.0      backports_1.5.0
##  [21] Rsamtools_2.26.0            rmarkdown_2.30
##  [23] pracma_2.4.6                UCSC.utils_1.6.0
##  [25] tinytex_0.57                bit_4.6.0
##  [27] xfun_0.53                   cn.mops_1.56.0
##  [29] cachem_1.1.0                cigarillo_1.0.0
##  [31] GenomeInfoDb_1.46.0         jsonlite_2.0.0
##  [33] blob_1.2.4                  rhdf5filters_1.22.0
##  [35] DelayedArray_0.36.0         Rhdf5lib_1.32.0
##  [37] BiocParallel_1.44.0         parallel_4.5.1
##  [39] cluster_2.1.8.1             R6_2.6.1
##  [41] VariantAnnotation_1.56.0    bslib_0.9.0
##  [43] stringi_1.8.7               RColorBrewer_1.1-3
##  [45] bezier_1.1.2                rpart_4.1.24
##  [47] jquerylib_0.1.4             Rcpp_1.1.0
##  [49] bookdown_0.45               assertthat_0.2.1
##  [51] SummarizedExperiment_1.40.0 base64enc_0.1-3
##  [53] Matrix_1.7-4                nnet_7.3-20
##  [55] tidyselect_1.2.1            rstudioapi_0.17.1
##  [57] dichromat_2.0-0.1           abind_1.4-8
##  [59] yaml_2.3.10                 codetools_0.2-20
##  [61] curl_7.0.0                  lattice_0.22-7
##  [63] tibble_3.3.0                regioneR_1.42.0
##  [65] Biobase_2.70.0              KEGGREST_1.50.0
##  [67] S7_0.2.0                    evaluate_1.0.5
##  [69] foreign_0.8-90              karyoploteR_1.36.0
##  [71] pillar_1.11.1               BiocManager_1.30.26
##  [73] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [75] RCurl_1.98-1.17             ensembldb_2.34.0
##  [77] ggplot2_4.0.0               scales_1.4.0
##  [79] glue_1.8.0                  lazyeval_0.2.2
##  [81] Hmisc_5.2-4                 tools_4.5.1
##  [83] data.table_1.17.8           GenomicAlignments_1.46.0
##  [85] XML_3.99-0.19               rhdf5_2.54.0
##  [87] grid_4.5.1                  colorspace_2.1-2
##  [89] AnnotationDbi_1.72.0        htmlTable_2.4.3
##  [91] restfulr_0.0.16             Formula_1.2-5
##  [93] cli_3.6.5                   S4Arrays_1.10.0
##  [95] dplyr_1.1.4                 AnnotationFilter_1.34.0
##  [97] gtable_0.3.6                sass_0.4.10
##  [99] digest_0.6.37               SparseArray_1.10.0
## [101] rjson_0.2.23                htmlwidgets_1.6.4
## [103] farver_2.1.2                memoise_2.0.1
## [105] htmltools_0.5.8.1           lifecycle_1.0.4
## [107] httr_1.4.7                  bit64_4.6.0-1
## [109] bamsignals_1.42.0
```