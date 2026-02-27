# Introduction to MutationalPatterns

Freek Manders1\*, Francis Blokzijl2, Roel Janssen2, Rurika Oka1, Jurrian de Kanter1, Mark van Roosmalen1\*\*, Ruben van Boxtel1 and Edwin Cuppen2

1Princess Maxima Center, Utrecht, The Netherlands
2University Medical Center Utrecht, Utrecht, The Netherlands

\*F.M.Manders@prinsesmaximacentrum.nl
\*\*vanBoxtelBioinformatics@prinsesmaximacentrum.nl

#### 24 February 2026

#### Package

MutationalPatterns 3.20.1

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Data](#data)
  + [3.1 List reference genome](#list-reference-genome)
  + [3.2 Load example data SNVs](#load-example-data-snvs)
  + [3.3 Load example data indels, DBSs and MBSs](#load-example-data-indels-dbss-and-mbss)
* [4 Mutation characteristics](#mutation-characteristics)
  + [4.1 SNVs](#snvs)
    - [4.1.1 Base substitution types](#base-substitution-types)
    - [4.1.2 Mutation spectrum](#mutation-spectrum)
    - [4.1.3 96 mutational profile](#mutational-profile)
    - [4.1.4 Larger contexts](#larger-contexts)
  + [4.2 Indels](#indels)
  + [4.3 DBSs](#dbss)
  + [4.4 MBSs](#mbss)
  + [4.5 Pooling samples](#pooling-samples)
* [5 Mutational signatures](#mutational-signatures)
  + [5.1 *De novo* mutational signature extraction using NMF](#de-novo-mutational-signature-extraction-using-nmf)
    - [5.1.1 NMF](#nmf)
    - [5.1.2 Bayesian NMF](#bayesian-nmf)
    - [5.1.3 Changing the names of the extracted signatures](#changing-the-names-of-the-extracted-signatures)
    - [5.1.4 Visualizing NMF results](#visualizing-nmf-results)
  + [5.2 Signature refitting](#signature-refitting)
    - [5.2.1 Find mathematically optimal contribution of COSMIC signatures](#find-mathematically-optimal-contribution-of-cosmic-signatures)
    - [5.2.2 Stricter refitting](#stricter-refitting)
    - [5.2.3 Bootstrapped refitting.](#bootstrapped-refitting.)
  + [5.3 Similarity between mutational profiles and signatures](#similarity-between-mutational-profiles-and-signatures)
  + [5.4 Signature potential damage analysis](#signature-potential-damage-analysis)
  + [5.5 Using other signature matrixes](#using-other-signature-matrixes)
* [6 Strand bias analyses](#strand-bias-analyses)
  + [6.1 Transcriptional strand bias analysis](#transcriptional-strand-bias-analysis)
    - [6.1.1 Gene definitions](#gene-definitions)
    - [6.1.2 Strand bias profile](#strand-bias-profile)
    - [6.1.3 Strand bias test](#strand-bias-test)
  + [6.2 Replicative strand bias analysis](#replicative-strand-bias-analysis)
    - [6.2.1 Define replication direction](#define-replication-direction)
    - [6.2.2 Replication bias analysis](#replication-bias-analysis)
  + [6.3 Signatures with strand bias](#signatures-with-strand-bias)
* [7 Genomic distribution](#genomic-distribution)
  + [7.1 Rainfall plot](#rainfall-plot)
  + [7.2 Define genomic regions](#define-genomic-regions)
  + [7.3 Enrichment or depletion of mutations in genomic regions](#enrichment-or-depletion-of-mutations-in-genomic-regions)
  + [7.4 Mutational patterns of genomic regions](#mutational-patterns-of-genomic-regions)
    - [7.4.1 Split mutations based on genomic regions](#split-mutations-based-on-genomic-regions)
    - [7.4.2 Mutation Spectrum](#mutation-spectrum-1)
    - [7.4.3 Mutational profiles](#mutational-profiles)
    - [7.4.4 Mutation density](#mutation-density)
  + [7.5 Unsupervised local mutational patterns](#unsupervised-local-mutational-patterns)
* [8 Lesion segregation](#lesion-segregation)
  + [8.1 Visualizing lesion segregation](#visualizing-lesion-segregation)
  + [8.2 Calculating lesion segregation](#calculating-lesion-segregation)
* [9 A note on the graphics](#a-note-on-the-graphics)
* [10 Session Info](#session-info)
* [References](#references)

# 1 Introduction

Mutational processes leave characteristic footprints in genomic DNA. This
package provides a comprehensive set of flexible functions that allows
researchers to easily evaluate and visualize a multitude of mutational patterns
in base substitution catalogues of e.g. healthy samples, tumour samples, or
DNA-repair deficient cells. This is the second major version of the package.
Many new functions have been added and functions from the previous version have
been enhanced. The package covers a wide range of patterns including: mutational
signatures, transcriptional and replicative strand bias, lesion segregation,
genomic distribution and association with genomic features, which are
collectively meaningful for studying the activity of mutational processes. The
package works with single nucleotide variants (SNVs), insertions and deletions
(Indels), double base substitutions (DBSs) and larger multi base substitutions
(MBSs). The package provides functionalities for both extracting mutational
signatures *de novo* and determining the contribution of previously identified
mutational signatures on a single sample level. MutationalPatterns integrates
with common R genomic analysis workflows and allows easy association with
(publicly available) annotation data.

Background on the biological relevance of the different mutational patterns, a
practical illustration of the package functionalities, comparison with similar
tools and software packages and an elaborate discussion, are described in the
new MutationalPatterns article, which is in currently being written. The old article can be
found [here](https://doi.org/10.1186/s13073-018-0539-0).

This vignette shows some common ways in which the functions in this package can
be used. It is however not exhaustive and won’t show every argument of every
function. You can view the documentation of a function by adding a `?` in front
of it. Like: `?plot_spectrum`. The describes the functions and all their
arguments in more detail. It also contains more examples of how the functions in
this package can be used.

# 2 Installation

First you need to install the package from `Bioconductor`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MutationalPatterns")
```

You also need to load the package.
This needs to be repeated every time you restart `R`.

```
library(MutationalPatterns)
```

# 3 Data

To perform the mutational pattern analyses, you need to load one or multiple
VCF files with variant calls and the corresponding reference
genome.

## 3.1 List reference genome

You can list available genomes using *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)*:

```
library(BSgenome)
head(available.genomes())
```

```
## [1] "BSgenome.Alyrata.JGI.v1"                 "BSgenome.Amellifera.BeeBase.assembly4"
## [3] "BSgenome.Amellifera.NCBI.AmelHAv3.1"     "BSgenome.Amellifera.UCSC.apiMel2"
## [5] "BSgenome.Amellifera.UCSC.apiMel2.masked" "BSgenome.Aofficinalis.NCBI.V1"
```

Make sure to install the reference genome that matches your VCFs.
For the example data this is `BSgenome.Hsapiens.UCSC.hg19`.

Now you can load your reference genome:

```
ref_genome <- "BSgenome.Hsapiens.UCSC.hg19"
library(ref_genome, character.only = TRUE)
```

## 3.2 Load example data SNVs

We provided two example data sets with this package. One consists of a subset of
somatic SNV catalogues of 9 normal human adult stem cells from 3 different
tissues (Blokzijl et al. 2016), and the other contains somatic indels and DBSs
from 3 healthy human hematopoietic stem cells (Osorio et al. 2018). The MBS data
you will find in the latter dataset was manually included by us to demonstrate
some features of this package.

This is how you can locate the VCF files of the example data from the first set.

These will be used for the SNV examples:

```
vcf_files <- list.files(system.file("extdata", package = "MutationalPatterns"),
  pattern = "sample.vcf", full.names = TRUE
)
```

You also need to define corresponding sample names for the VCF files:

```
sample_names <- c(
  "colon1", "colon2", "colon3",
  "intestine1", "intestine2", "intestine3",
  "liver1", "liver2", "liver3"
)
```

Now you can load the VCF files into a `GRangesList`:

```
grl <- read_vcfs_as_granges(vcf_files, sample_names, ref_genome)
```

Here we define relevant metadata on the samples, such as tissue type.
This will be useful later.

```
tissue <- c(rep("colon", 3), rep("intestine", 3), rep("liver", 3))
```

## 3.3 Load example data indels, DBSs and MBSs

We will now locate the VCF files of the example data from the second set.
These will be used for the indels, DBS and MBS examples.

```
blood_vcf_fnames <- list.files(
  system.file("extdata", package = "MutationalPatterns"),
  pattern = "blood.*vcf", full.names = TRUE)
```

Set their sample names.

```
blood_sample_names <- c("blood1", "blood2", "blood3")
```

Read in the data, without filtering for any mutation type using the `type="all"`
argument.
(By default only SNVs are loaded for backwards compatibility.)

```
blood_grl <- read_vcfs_as_granges(blood_vcf_fnames, blood_sample_names,
                                  ref_genome, type = "all")
```

You can now retrieve different types of mutations from the `GrangesList`.

```
snv_grl <- get_mut_type(blood_grl, type = "snv")
```

```
## Any neighbouring SNVs will be merged into DBS/MBS variants.
## Set the 'predefined_dbs_mbs' to 'TRUE' if you don't want this.
```

```
indel_grl <- get_mut_type(blood_grl, type = "indel")
dbs_grl <- get_mut_type(blood_grl, type = "dbs")
```

```
## Any neighbouring SNVs will be merged into DBS/MBS variants.
## Set the 'predefined_dbs_mbs' to 'TRUE' if you don't want this.
```

```
mbs_grl <- get_mut_type(blood_grl, type = "mbs")
```

```
## Any neighbouring SNVs will be merged into DBS/MBS variants.
## Set the 'predefined_dbs_mbs' to 'TRUE' if you don't want this.
```

It’s also possible to directly select for a specific mutation type when reading
in the data. This can be a convenient shortcut, when you are only interested in
a single type of mutation.

```
indel_grl <- read_vcfs_as_granges(blood_vcf_fnames, blood_sample_names,
                                  ref_genome, type = "indel")
```

By default the package assumes that DBS and MBS variants are present in your
vcfs as separate neighbouring SNVs. MutationalPatterns merges these to get DBS
and MBS variants. If DBS and MBS variants have already been defined in your vcf
or if you don’t want any variants to be merged, then you can use the
`predefined_dbs_mbs` argument, when using `read_vcfs_as_granges` or
`get_mut_type`.
(In this example the result will be empty, because the DBS variants were not predefined)

```
predefined_dbs_grl <- read_vcfs_as_granges(blood_vcf_fnames, blood_sample_names,
                                  ref_genome, type = "dbs",
                                  predefined_dbs_mbs = TRUE)
```

# 4 Mutation characteristics

## 4.1 SNVs

### 4.1.1 Base substitution types

You can retrieve base substitution types from the VCF GRanges object as “REF>ALT”
using `mutations_from_vcf`:

```
muts <- mutations_from_vcf(grl[[1]])
head(muts, 12)
```

```
##  [1] "A>C" "A>G" "C>T" "A>G" "G>T" "T>A" "T>C" "G>A" "G>A" "C>A" "G>A" "G>T"
```

You can retrieve the base substitutions from the VCF GRanges object and convert
them to the 6 types of base substitution types that are distinguished by
convention: C>A, C>G, C>T, T>A, T>C, T>G. For example, when the reference
allele is G and the alternative allele is T (G>T), `mut_type`
returns the G:C>T:A mutation as a C>A mutation:

```
types <- mut_type(grl[[1]])
head(types, 12)
```

```
##  [1] "T>G" "T>C" "C>T" "T>C" "C>A" "T>A" "T>C" "C>T" "C>T" "C>A" "C>T" "C>A"
```

To retrieve the sequence context (one base upstream and one base downstream) of
the base substitutions in the VCF object from the reference genome, you can use
the `mut_context` function:

```
context <- mut_context(grl[[1]], ref_genome)
head(context, 12)
```

```
##  chr1  chr1  chr1  chr1  chr1  chr1  chr1  chr1  chr1  chr2  chr2  chr2
## "CAG" "AAC" "ACA" "AAG" "TGA" "GTT" "ATT" "CGC" "AGC" "ACA" "CGT" "GGA"
```

With`type_context`, you can retrieve the types and contexts
for all positions in the VCF GRanges object. For the base substitutions that are
converted to the conventional base substitution types, the reverse complement of
the sequence context is returned.

```
type_context <- type_context(grl[[1]], ref_genome)
lapply(type_context, head, 12)
```

```
## $types
##  [1] "T>G" "T>C" "C>T" "T>C" "C>A" "T>A" "T>C" "C>T" "C>T" "C>A" "C>T" "C>A"
##
## $context
##  chr1  chr1  chr1  chr1  chr1  chr1  chr1  chr1  chr1  chr2  chr2  chr2
## "CTG" "GTT" "ACA" "CTT" "TCA" "GTT" "ATT" "GCG" "GCT" "ACA" "ACG" "TCC"
```

With `mut_type_occurrences`, you can count mutation type
occurrences for all VCF objects in the `GRangesList`. For
C>T mutations, a distinction is made between C>T at CpG sites and other
sites, as deamination of methylated cytosine at CpG sites is a common mutational
process. For this reason, the reference genome is needed for this functionality.

```
type_occurrences <- mut_type_occurrences(grl, ref_genome)
type_occurrences
```

```
##            C>A C>G C>T T>A T>C T>G C>T at CpG C>T other
## colon1      28   5 109  12  30  12         59        50
## colon2      77  29 345  36  90  21        209       136
## colon3      79  19 243  25  61  23        165        78
## intestine1  19   8  74  19  26   4         33        41
## intestine2 118  49 423  57 126  27        258       165
## intestine3  54  27 298  32  67  22        192       106
## liver1      43  22  94  30  77  34         18        76
## liver2     144  93 274 103 209  73         48       226
## liver3      39  28  61  15  32  23          7        54
```

### 4.1.2 Mutation spectrum

A mutation spectrum shows the relative contribution of each mutation type in
the base substitution catalogs. The `plot_spectrum` function plots
the mean relative contribution of each of the 6 base substitution types over
all samples. Error bars indicate the 95% confidence interval over all samples.
The total number of mutations is indicated.

```
p1 <- plot_spectrum(type_occurrences)
```

You can also plot the mutation spectrum with distinction
between C>T at CpG sites and other sites:

```
p2 <- plot_spectrum(type_occurrences, CT = TRUE)
```

Other options include plotting the spectrum with the individual samples as
points and removing the legend to save space:

```
p3 <- plot_spectrum(type_occurrences, CT = TRUE,
                    indv_points = TRUE, legend = FALSE)
```

Here we use the *[gridExtra](https://CRAN.R-project.org/package%3DgridExtra)* package to combine the created plots,
so you can see them next to each other.

```
library("gridExtra")
grid.arrange(p1, p2, p3, ncol = 3, widths = c(3, 3, 1.75))
```

![](data:image/png;base64...)

It’s also possible to create a facet per sample group, e.g. plot the spectrum
for each tissue separately:

```
p4 <- plot_spectrum(type_occurrences, by = tissue, CT = TRUE, legend = TRUE)
```

Or you could use the standard deviation instead of a 95% confidence interval:

```
p5 <- plot_spectrum(type_occurrences, CT = TRUE,
                    legend = TRUE, error_bars = "stdev")
```

```
grid.arrange(p4, p5, ncol = 2, widths = c(4, 2.3))
```

![](data:image/png;base64...)

### 4.1.3 96 mutational profile

First you should make a 96 trinucleotide mutation count matrix.
(In contrast to previous versions this also works for single samples.)

```
mut_mat <- mut_matrix(vcf_list = grl, ref_genome = ref_genome)
head(mut_mat)
```

```
##         colon1 colon2 colon3 intestine1 intestine2 intestine3 liver1 liver2 liver3
## A[C>A]A      3     10     10          5         19          6      8     10      3
## A[C>A]C      0      3      3          1          8          4      1      8      2
## A[C>A]G      2      3      3          1          4          0      1      6      2
## A[C>A]T      0      2      9          0          9          2      2     12      2
## C[C>A]A      1      8      5          0          8          7      2     15      3
## C[C>A]C      2      5      3          1          3          2      1     15      2
```

Next, you can use this matrix to plot the 96 profile of samples.
In this example we do this for 2 samples:

```
plot_96_profile(mut_mat[, c(1, 7)])
```

```
## Warning in geom_bar(stat = "identity", colour = "black", size = 0.2): Ignoring unknown
## parameters: `size`
```

![](data:image/png;base64...)

### 4.1.4 Larger contexts

It’s also possible to look at larger mutational contexts.
However, this is only useful if you have a large number of mutations.

```
mut_mat_ext_context <- mut_matrix(grl, ref_genome, extension = 2)
head(mut_mat_ext_context)
```

```
##           colon1 colon2 colon3 intestine1 intestine2 intestine3 liver1 liver2 liver3
## AA[C>A]AA      0      4      1          2          9          4      0      4      0
## AA[C>A]AC      0      0      2          0          1          0      1      0      0
## AA[C>A]AG      0      0      1          0          2          0      1      0      0
## AA[C>A]AT      0      0      1          1          2          0      0      0      0
## AA[C>A]CA      0      0      0          0          0          0      0      2      1
## AA[C>A]CC      0      1      0          0          2          2      0      1      0
```

The `extension` argument also works for the `mut_context` and `type_context` functions.

You can visualize this matrix with a heatmap.

```
plot_profile_heatmap(mut_mat_ext_context, by = tissue)
```

![](data:image/png;base64...)

You can also visualize this with a riverplot.

```
plot_river(mut_mat_ext_context[,c(1,4)])
```

![](data:image/png;base64...)

## 4.2 Indels

First you should get the COSMIC indel contexts. This is done with
`get_indel_context`, which adds the columns `muttype` and `muttype_sub` to the
`GRangesList`.
The `muttype` column contains the main type of indel. The `muttype_sub` column
shows the number of repeat units. For microhomology (mh) deletions the mh length
is shown.

```
indel_grl <- get_indel_context(indel_grl, ref_genome)
head(indel_grl[[1]], n = 3)
```

```
## GRanges object with 3 ranges and 7 metadata columns:
##                      seqnames            ranges strand | paramRangeID            REF
##                         <Rle>         <IRanges>  <Rle> |     <factor> <DNAStringSet>
##   1:19535736_AAGTC/A     chr1 19535736-19535740      * |           NA          AAGTC
##      1:22065152_A/AT     chr1          22065152      * |           NA              A
##      1:28084487_CA/C     chr1 28084487-28084488      * |           NA             CA
##                                     ALT      QUAL      FILTER      muttype muttype_sub
##                      <DNAStringSetList> <numeric> <character>  <character>   <numeric>
##   1:19535736_AAGTC/A                  A    453.99        PASS 4bp_deletion           2
##      1:22065152_A/AT                 AT    303.13        PASS  T_insertion          12
##      1:28084487_CA/C                  C    342.69        PASS   T_deletion          14
##   -------
##   seqinfo: 24 sequences from hg19 genome
```

Next count the number of indels per type. This results in a matrix that is
similar to the `mut_mat` matrix.

```
indel_counts <- count_indel_contexts(indel_grl)
head(indel_counts)
```

```
##               blood1 blood2 blood3
## C_deletion_1      37     10      2
## C_deletion_2      14      4      1
## C_deletion_3       4      2      2
## C_deletion_4       1      1      0
## C_deletion_5       1      0      0
## C_deletion_6+      1      0      0
```

Now you can plot the indel spectra. The facets at the top show the indel types.
First the C and T deletions.
Then the C and T insertions. Next are the multi base deletions and insertions.
Finally the deletions with microhomology are shown.
The x-axis at the bottom shows the number of repeat units. For mh deletions the
microhomology length is shown.

```
plot_indel_contexts(indel_counts, condensed = TRUE)
```

![](data:image/png;base64...)

You can also choose to only plot the main contexts,
without taking the number of repeat units or microhomology length into account.

```
plot_main_indel_contexts(indel_counts)
```

![](data:image/png;base64...)

## 4.3 DBSs

First get the COSMIC DBS contexts. This is done by changing the `REF` and `ALT`
columns of the `GRangesList`.

```
head(dbs_grl[[1]])
```

```
## GRanges object with 6 ranges and 5 metadata columns:
##    seqnames    ranges strand | paramRangeID            REF                ALT      QUAL
##       <Rle> <IRanges>  <Rle> |     <factor> <DNAStringSet> <DNAStringSetList> <numeric>
##        chr2  42274270      * |           NA             TT                 GC    510.99
##        chr2 192488515      * |           NA             AT                 GG    424.54
##        chr4  23054021      * |           NA             TA                 GT    803.99
##        chr6 161534484      * |           NA             CA                 AT    956.99
##        chr7  52694068      * |           NA             CA                 AG    219.99
##        chr8  85636847      * |           NA             CC                 TT    528.99
##         FILTER
##    <character>
##           PASS
##           PASS
##           PASS
##           PASS
##           PASS
##           PASS
##   -------
##   seqinfo: 24 sequences from hg19 genome
```

```
dbs_grl <- get_dbs_context(dbs_grl)
head(dbs_grl[[1]])
```

```
## GRanges object with 6 ranges and 5 metadata columns:
##    seqnames    ranges strand | paramRangeID            REF                ALT      QUAL
##       <Rle> <IRanges>  <Rle> |     <factor> <DNAStringSet> <DNAStringSetList> <numeric>
##        chr2  42274270      * |           NA             TT                 GC    510.99
##        chr2 192488515      * |           NA             AT                 CC    424.54
##        chr4  23054021      * |           NA             TA                 GT    803.99
##        chr6 161534484      * |           NA             TG                 AT    956.99
##        chr7  52694068      * |           NA             TG                 CT    219.99
##        chr8  85636847      * |           NA             CC                 TT    528.99
##         FILTER
##    <character>
##           PASS
##           PASS
##           PASS
##           PASS
##           PASS
##           PASS
##   -------
##   seqinfo: 24 sequences from hg19 genome
```

Next count the number of DBSs per type.
This again results in a matrix that is similar to the `mut_mat` matrix.

```
dbs_counts <- count_dbs_contexts(dbs_grl)
```

Finally we can plot the DBS contexts.
The facets at the top show the reference bases.
The x-axis shows the alternative variants.

```
plot_dbs_contexts(dbs_counts, same_y = TRUE)
```

![](data:image/png;base64...)

We can also choose to plot based on only the reference bases.
Now the x-axis contains the reference bases.

```
plot_main_dbs_contexts(dbs_counts, same_y = TRUE)
```

![](data:image/png;base64...)

## 4.4 MBSs

No COSMIC MBS contexts existed when this vignette was written.
Therefore the length of the MBSs is used as its context.
First we can count the MBSs.
This again results in a matrix that is similar to the `mut_mat` matrix.

```
mbs_counts <- count_mbs_contexts(mbs_grl)
```

Next we can plot the contexts

```
plot_mbs_contexts(mbs_counts, same_y = TRUE)
```

![](data:image/png;base64...)

## 4.5 Pooling samples

Sometimes you have very few mutations per sample.
In these cases it might be useful to combine multiple samples.
This can be done with `pool_mut_mat`.
This works on the matrixes of SNVs, indels, DBSs and MBSs.

```
pooled_mut_mat <- pool_mut_mat(mut_mat, grouping = tissue)
head(pooled_mut_mat)
```

```
##         colon intestine liver
## A[C>A]A    23        30    21
## A[C>A]C     6        13    11
## A[C>A]G     8         5     9
## A[C>A]T    11        11    16
## C[C>A]A    14        15    20
## C[C>A]C    10         6    18
```

# 5 Mutational signatures

Mutational signatures are thought to represent mutational processes, and are
characterized by a specific contribution of mutation types with a
certain sequence context.
Mutational signatures can be extracted *de novo* from your
mutation count matrix, with non-negative matrix factorization (NMF).
It’s also possible to identify the exposure of your mutation count matrix to
previously defined mutational signatures.
This is often referred to as signature refitting.
NMF is most useful for large amounts of samples,
while signature refitting can also be used on single samples.
We will first discuss NMF and then signature refitting.
Finally we will discuss analyzing the similarity between a mutational profile
and signatures directly.

## 5.1 *De novo* mutational signature extraction using NMF

### 5.1.1 NMF

A critical parameter in NMF is the factorization rank, which is the number of
mutational signatures you extract. You can determine the optimal factorization
rank using the *[NMF](https://CRAN.R-project.org/package%3DNMF)* package (Gaujoux and Seoighe [2010](#ref-Gaujoux2010)). As described in
their paper:

``…a common
way of deciding on the rank is to try different values, compute some quality
measure of the results, and choose the best value according to this quality
criteria. The most common approach is to choose the smallest rank for which
cophenetic correlation coefficient starts decreasing. Another approach is to
choose the rank for which the plot of the residual sum of squares (RSS) between
the input matrix and its estimate shows an inflection point.’’

In general, larger datasets allow you to use a higher rank.
Here we will show NMF for SNVs. Performing NMF on other mutation types works the
same way.

First add a small pseudocount to your mutation count matrix:

```
mut_mat <- mut_mat + 0.0001
```

Use the NMF package to generate an estimate rank plot.
This can take a long time:

```
library("NMF")
estimate <- nmf(mut_mat, rank = 2:5, method = "brunet",
                nrun = 10, seed = 123456, .opt = "v-p")
```

```
## Compute NMF rank= 2  ... + measures ... OK
## Compute NMF rank= 3  ... + measures ... OK
## Compute NMF rank= 4  ... + measures ... OK
## Compute NMF rank= 5  ... + measures ... OK
```

And plot it:

```
plot(estimate)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the NMF package.
##   Please report the issue to the authors.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

![](data:image/png;base64...)

Extract mutational signatures from the mutation count matrix with
`extract_signatures`. In this example 2 signatures are extracted, because a rank
of 2 is used. (For larger datasets it is wise to perform more iterations by
changing the nrun parameter to achieve stability and avoid bad local minima):

```
nmf_res <- extract_signatures(mut_mat, rank = 2, nrun = 10, single_core = TRUE)
```

```
## NMF algorithm: 'brunet'
```

```
## Multiple runs: 10
```

```
## Mode: sequential [sapply]
```

```
## Runs: 1* 2 3 4 5* 6 7 8* 9 10 ... DONE
## System time:
##    user  system elapsed
##   9.956   0.027   9.984
```

NMF also works on other mutation types like indels and DBS. You can even combine
matrixes from different mutation types to, for example, extract combined
indel/DBS signatures.

```
combi_mat = rbind(indel_counts, dbs_counts)
nmf_res_combi <- extract_signatures(combi_mat, rank = 2, nrun = 10, single_core = TRUE)
```

```
## NMF algorithm: 'brunet'
```

```
## Multiple runs: 10
```

```
## Mode: sequential [sapply]
```

```
## Runs: 1* 2 3 4 5 6 7* 8 9 10 ... DONE
## System time:
##    user  system elapsed
##   9.819   0.056   9.875
```

### 5.1.2 Bayesian NMF

It’s also possible to use variational bayes NMF. This could make it easier to
determine, the correct rank. To do this you need to install the
*[ccfindR](https://bioconductor.org/packages/3.22/ccfindR)* package. You can then determine the optimal number of
signatures, which can again take a long time. Warnings will occur when you use
ranks that are too high. (In this example we avoid these warnings by
using `nrun=1`, combined with a set seed. In practice you shouldn’t use a rank
that’s too high and you should also use a higher number for nrun.) With a larger
dataset you could try higher ranks. The highest value in the plot is the
mathematically optimal number of signatures. (A note of warning: The
mathematically optimal number doesn’t necessarily make biological sense.)

```
# BiocManager::install("ccfindR")
library("ccfindR")
sc <- scNMFSet(count = mut_mat)
set.seed(4)
estimate_bayes <- vb_factorize(sc, ranks = 1:3, nrun = 1,
                               progress.bar = FALSE, verbose = 0)
plot(estimate_bayes)
```

![](data:image/png;base64...)

Extracting the signatures is then done by:

```
nmf_res_bayes <- extract_signatures(mut_mat, rank = 2, nrun = 10,
                                    nmf_type = "variational_bayes")
```

### 5.1.3 Changing the names of the extracted signatures

You can provide the extracted signatures with custom names:

```
colnames(nmf_res$signatures) <- c("Signature A", "Signature B")
rownames(nmf_res$contribution) <- c("Signature A", "Signature B")
```

It’s possible that some of the signatures extracted by NMF are very similar to
signatures that are already known. Therefore, it might be useful to change the
names of the NMF signatures to these already known signatures. This often makes
it easier to interpret your results.

To do this you first need to read in some already existing signatures. Here we
will use signatures from [COSMIC](https://cancer.sanger.ac.uk/signatures)
(v3.2) (Alexandrov et al. [2020](#ref-Alexandrov2020)). (We will discuss how to use other signature matrixes
later.)

```
signatures = get_known_signatures()
```

You can now change the names of the signatures extracted by NMF. In this example
the name of a signature is changed if it has a cosine similarity of more than
0.85 with an existing COSMIC signature.

```
nmf_res <- rename_nmf_signatures(nmf_res, signatures, cutoff = 0.85)
colnames(nmf_res$signatures)
```

```
## [1] "SBS5-like" "SBS1-like"
```

We now see that the signatures we extracted are very similar to COSMIC
signatures SBS1 and SBS5. This helps with the interpretation because the
aetiology of SBS1 is already known. This also tells us we didn’t identify any
completely novel processes.
An extracted signature that is not similar to any previously defined signatures,
is not proof of a “novel” signature. The extracted signature might be a
combination of known signatures, that could not be split by NMF. This can happen
when, for example, too few samples were used for the NMF.

### 5.1.4 Visualizing NMF results

You can plot the 96-profile of the signatures (When looking at SNVs):

```
plot_96_profile(nmf_res$signatures, condensed = TRUE)
```

```
## Warning in geom_bar(stat = "identity", colour = "black", size = 0.2): Ignoring unknown
## parameters: `size`
```

![](data:image/png;base64...)

You can visualize the contribution of the signatures in a barplot:

```
plot_contribution(nmf_res$contribution, nmf_res$signature,
  mode = "relative"
)
```

![](data:image/png;base64...)

The relative contribution of each signature for each sample can also be plotted
as a heatmap with `plot_contribution_heatmap`, which might be easier to
interpret and compare than stacked barplots. The signatures and samples can be
hierarchically clustered based on their euclidean distance. Clustering here is
based on the similarity between the contributions. (Signatures with a similar
contribution will thus be clustered together. The same applies for samples.)

Plot signature contribution as a heatmap with sample and signature clustering
dendrograms:

```
plot_contribution_heatmap(nmf_res$contribution,
                          cluster_samples = TRUE,
                          cluster_sigs = TRUE)
```

![](data:image/png;base64...)

It’s also possible to provide your own signature and sample order. This can be a
manual ordering, but in this example we use clustering. We can cluster the
signatures based on their cosine similarity and then retrieve the order:

```
hclust_signatures <- cluster_signatures(nmf_res$signatures, method = "average")
signatures_order <- colnames(nmf_res$signatures)[hclust_signatures$order]
signatures_order
```

```
## [1] "SBS5-like" "SBS1-like"
```

We can do the same thing for the samples:

```
hclust_samples <- cluster_signatures(mut_mat, method = "average")
samples_order <- colnames(mut_mat)[hclust_samples$order]
samples_order
```

```
## [1] "intestine1" "intestine3" "colon3"     "intestine2" "colon1"     "colon2"     "liver3"
## [8] "liver1"     "liver2"
```

Now we can use the signature and sample order in the contribution heatmap:

```
plot_contribution_heatmap(nmf_res$contribution,
  sig_order = signatures_order, sample_order = samples_order,
  cluster_sigs = FALSE, cluster_samples = FALSE
)
```

![](data:image/png;base64...)

A reconstructed mutational profile has been made for each sample by the NMF,
based on the signatures and their contribution. The better the NMF worked the
more similar the reconstructed profile will be to the original profile.

We can compare the reconstructed mutational profile with the original mutational
profile for a single sample like this:

```
plot_compare_profiles(mut_mat[, 1],
  nmf_res$reconstructed[, 1],
  profile_names = c("Original", "Reconstructed"),
  condensed = TRUE
)
```

```
## Warning in geom_bar(stat = "identity", position = "identity", colour = "black", : Ignoring
## unknown parameters: `size`
```

![](data:image/png;base64...)
This is the function for SNVs. For indels you would use `plot_compare_indels`,
for DBSs, `plot_compare_dbs` and for MBSs `plot_compare_mbs`.

We can also plot the cosine similarity between the original and reconstructed
matrix for all the samples. When a reconstructed profile has a cosine similarity
of more than 0.95 with the original, the reconstructed profile is considered
very good.

```
plot_original_vs_reconstructed(mut_mat, nmf_res$reconstructed,
                               y_intercept = 0.95)
```

![](data:image/png;base64...)

## 5.2 Signature refitting

### 5.2.1 Find mathematically optimal contribution of COSMIC signatures

Signature refitting quantifies the contribution of any set of signatures to the
mutational profile of a sample. This is specifically useful for mutational
signature analyses of small cohorts or individual samples, but also to relate
own findings to known signatures and published findings. The
`fit_to_signatures` function finds the optimal linear combination of mutational
signatures that most closely reconstructs the mutation matrix by solving a
non-negative least-squares constraints problem. It can work with a SNV, indel,
DBS or other type of count matrix.

Fit mutation matrix to the COSMIC mutational signatures:

```
fit_res <- fit_to_signatures(mut_mat, signatures)
```

The `fit_res` object can be visualized similarly to the `nmf_res` object. The
functions `plot_contribution`, `plot_contribution_heatmap`,
`plot_compare_profiles` and `plot_original_vs_reconstructed` will all work. As
an example we show the contribution of signatures as a barplot.

```
plot_contribution(fit_res$contribution,
  coord_flip = FALSE,
  mode = "absolute"
)
```

![](data:image/png;base64...)

We also show the cosine similarity with the reconstructed profiles, as this
gives a good idea of how well the signatures could explain the mutational
profiles.

```
plot_original_vs_reconstructed(mut_mat, fit_res$reconstructed,
                               y_intercept = 0.95)
```

![](data:image/png;base64...)

### 5.2.2 Stricter refitting

In the previous plots, many signatures were used to explain the mutational
profiles of the samples. It seems however unlikely that this many mutational
processes were really active in these samples. This problem, known as
[overfitting](https://en.wikipedia.org/wiki/Overfitting), occurs because
`fit_to_signatures` finds the optimal combination of signatures to reconstruct a
profile. It will use a signature, even if it improves the fit very little.

Another issue with signature refitting is signature misattribution. Mutations
will sometimes be attributed to different signatures in samples with a similar
mutational profile. This can give the impression that samples are very
different, when they actually aren’t. This is often the result of “flat”
signatures, which are harder to fit. Signatures that are similar to each other
can also cause this misattribution issue.

One way to deal with overfitting and the misattribution of signatures is by
selecting a limited number of signatures that will be used for the refitting.
When you are analyzing a liver sample you could for example only use signatures
that are known to occur in liver. This method is recommended by Degasperi et al. ([2020](#ref-Degasperi2020)).
Using prior knowledge like this will reduce overfitting, but can also introduce
bias. You won’t be able to identify signatures, if you removed them beforehand.
Another downside of this method is that you need prior knowledge of which
signatures could be present. We recommend using this method when possible.

Another way of dealing with overfitting is by starting with a standard refit
and then removing signatures that have little effect on how well a mutational
profile can be reconstructed. This works in an iterative fashion. In each
iteration the signature with the lowest contribution is removed and refitting is
repeated. Each time the cosine similarity between the original and reconstructed
profile is calculated. You stop removing signatures when the difference between
two iterations becomes bigger than a certain cutoff. This way only the
signatures that are really necessary to explain a mutational profile will be
used. This method is similar to a method used by Alexandrov et al. ([2020](#ref-Alexandrov2020)). In
MutationalPatterns it can be used with `fit_to_signatures_strict`.

A downside of this method is that the cutoff you should use is somewhat
subjective and depends on the data. Here we use a cutoff of 0.004. Decreasing
this number will make the refitting less strict, while increasing it will make
the refitting more strict. Trying out different values can sometimes be useful
to achieve the best results.

```
strict_refit <- fit_to_signatures_strict(mut_mat, signatures, max_delta = 0.004)
```

This function returns a list containing a `fit_res` object and a list of
figures, showing in what order signatures were removed during the refitting.

Here we show the figure for one sample. The x-axis shows the signature that was
removed during that iteration. The red bar indicates that the difference in
cosine similarity has become too large. The removal of signatures is stopped and
SBS1 is kept for the final refit.

```
fig_list <- strict_refit$sim_decay_fig
fig_list[[1]]
```

![](data:image/png;base64...)

The fit\_res can be visualized in the same way as other `fit_res` objects.

```
fit_res_strict <- strict_refit$fit_res
plot_contribution(fit_res_strict$contribution,
  coord_flip = FALSE,
  mode = "absolute"
)
```

![](data:image/png;base64...)

By default `fit_to_signatures_strict` uses the “backwards” selection approach
described above. However, it is also possible to use a “best subset” approach.
The benefit of this method is that it can be more accurate than the “backwards”
approach. However, it becomes computationally infeasible when using many
signatures. Therefore it should only be used on small signature sets (max 10-15
signatures), like tissue specific signatures.
The “best subset” approach works similarly to the “backwards” approach. This
approach again starts with a standard refit. The refitting is then repeated for
each combination of n-1 signatures, where n is the total number of signatures.
In other words, if you started with 10 signatures, the refitting is repeated 10
times, with a different signature being removed each time. The combination of
signatures that has the best cosine similarity between the original and
reconstructed profile is chosen. This is done in an iterative fashion for n-2,
n-3, ect. You stop removing signatures when the difference between two
iterations becomes bigger than a certain cutoff, just like with the backwards
method.

We randomly selected a few signatures for this example, to keep the runtime low.
In practice, signatures should be selected based on prior knowledge.

```
best_subset_refit <- fit_to_signatures_strict(mut_mat, signatures[,1:5], max_delta = 0.002, method = "best_subset")
```

A third method that can reduce overfitting and the misattribution of signatures
is to merge similar signatures. This works by merging signatures whose cosine
similarity is higher than a certain cutoff value. These merged signatures can
then be used for refitting. The benefit of this method is that you don’t need
prior knowledge. For most common use-cases, we don’t recommend this method,
because it is less conventional and can be harder to interpret. However, we
provide it here to give you the possibility to use it if you need it. You can
merge signatures like this:

```
merged_signatures <- merge_signatures(signatures, cos_sim_cutoff = 0.8)
```

```
## Combined the following two signatures: SBS26, SBS12
```

```
## Combined the following two signatures: SBS36, SBS18
```

```
## Combined the following two signatures: SBS92, SBS5
```

```
## Combined the following two signatures: SBS40, SBS3
```

```
## Combined the following two signatures: SBS10d, SBS10a
```

```
## Combined the following two signatures: SBS10d;SBS10a, SBS10c
```

```
## Combined the following two signatures: SBS15, SBS6
```

```
## Combined the following two signatures: SBS29, SBS24
```

```
## Combined the following two signatures: SBS94, SBS4
```

```
## Combined the following two signatures: SBS23, SBS19
```

```
## Combined the following two signatures: SBS26;SBS12, SBS37
```

```
## Combined the following two signatures: SBS86, SBS39
```

```
## Combined the following two signatures: SBS40;SBS3, SBS92;SBS5
```

```
## Combined the following two signatures: SBS94;SBS4, SBS8
```

```
## Combined the following two signatures: SBS23;SBS19, SBS31
```

The best refitting method will depend on your data and research question. A
single method can be used, but it’s also possible to combine several methods.

### 5.2.3 Bootstrapped refitting.

The stability of signature refitting can be suboptimal, because of the
previously mentioned signature misattribution. Bootstrapping can be used to
verify how stable the refitting is (Huang, Wojtowicz, and Przytycka [2018](#ref-Huang2018)). A more stable refit provides
more confidence in the results. It works by making small changes to the
mutational profile of a sample. These changes are made by resampling mutations
with replacement using the samples own mutational profile as weights. The number
of sampled mutations is the same as the number of mutations that was originally
in the profile. This process is by default repeated 1000 times. A signature
refit is performed for each iteration, resulting in an estimate of the refitting
stability. In MutationalPatterns bootstrapping can be done with
`fit_to_signatures_bootstrapped`.

This function can be used with the standard and strict refitting methods
described previously. Here we will use the “strict” method on two samples.
(We only use 50 bootstraps here to reduce the run time and figure size.)

```
contri_boots <- fit_to_signatures_bootstrapped(mut_mat[, c(3, 7)],
  signatures,
  n_boots = 50,
  method = "strict"
)
```

You can visualize the bootstrapped refitting like this. Each dot is one
bootstrap iteration.

```
plot_bootstrapped_contribution(contri_boots)
```

![](data:image/png;base64...)

You can also visualize this using the relative contribution and a dotplot.
Here, the color of the dot shows the percentage of iterations in which the signature is found (contribution > 0),
and the size of the dot represents the average contribution of that signature (in the iterations in which the contribution was higher than 0).

```
plot_bootstrapped_contribution(contri_boots,
                               mode = "relative",
                               plot_type = "dotplot")
```

![](data:image/png;base64...)

We can see that SBS1 is relatively stable in the first sample. However, SBS5 is
very unstable in the second sample. This instability is likely the result of
SBS5 being very flat.

You can also plot the correlation between signatures. A negative correlation
between two signatures means that their contributions were high in different
bootstrap iterations. Here we will visualize this correlation for one sample.

```
fig_list <- plot_correlation_bootstrap(contri_boots)
```

```
## Warning in fortify(data, ...): Arguments in `...` must be used.
## ✖ Problematic argument:
## • order = NULL
## ℹ Did you misspell an argument name?
```

```
## Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the MutationalPatterns package.
##   Please report the issue to the authors.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

```
## Warning in fortify(data, ...): Arguments in `...` must be used.
## ✖ Problematic argument:
## • order = NULL
## ℹ Did you misspell an argument name?
```

```
fig_list[[2]]
```

![](data:image/png;base64...)

Here we can see that SBS5 and SBS40 have a negative correlation. This makes
sense because they are both flat signatures that are very similar to each other.
As a result the refitting process has difficulty distinguishing them.

## 5.3 Similarity between mutational profiles and signatures

Instead of performing NMF or fitting signatures to a profile, you can also look
at their similarity. This circumvents the issues that exist with NMF and
signature refitting. However, looking at similarities doesn’t allow us to
separate the different signatures that have contributed to a mutational profile.
When multiple signatures have contributed to a profile, the similarities between
this profile and the individual signatures can also become diluted.

You can calculate the similarity between two mutational profiles / signatures
like this:

```
cos_sim(mut_mat[, 1], signatures[, 1])
```

```
## [1] 0.8342838
```

You can also calculate the similarity between multiple mutational profiles /
signatures:

```
cos_sim_samples_signatures <- cos_sim_matrix(mut_mat, signatures)
cos_sim_samples_signatures[1:3, 1:3]
```

```
##             SBS1       SBS2      SBS3
## colon1 0.8342838 0.16102824 0.4046278
## colon2 0.9015869 0.12143008 0.3628499
## colon3 0.9105690 0.07415949 0.3390180
```

You can visualize this with a heatmap using `plot_cosine_heatmap`. This function
has the same clustering options as `plot_contribution_heatmap`, which we
discussed earlier.

```
plot_cosine_heatmap(cos_sim_samples_signatures,
                    cluster_rows = TRUE, cluster_cols = TRUE)
```

![](data:image/png;base64...)

It’s also possible to look at the cosine similarities between samples.

```
cos_sim_samples <- cos_sim_matrix(mut_mat, mut_mat)
plot_cosine_heatmap(cos_sim_samples, cluster_rows = TRUE, cluster_cols = TRUE)
```

![](data:image/png;base64...)

## 5.4 Signature potential damage analysis

Some signatures are more likely than others to have functional effects, by
causing “stop gain” or “mismatch” mutations. With MutationalPatterns it’s
possible to analyze how likely it is for a signature to either cause “stop
gain”, “mismatch”, “synonymous” or “splice site” mutations for a set of genes of
interest. Please take into account that this is a relatively basic analysis,
that only looks at mutational contexts. Other features like open/closed
chromatin are not taken into account. This analysis is meant to give an
indication, not a definitive answer, of how damaging a signature might be.

First you need to load a transcription annotation database and make sure some
dependencies are installed.

```
# For example get known genes table from UCSC for hg19 using
# BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
# BiocManager::install("AnnotationDbi")
# BiocManager::install("GenomicFeatures")
library("TxDb.Hsapiens.UCSC.hg19.knownGene")
```

```
## Loading required package: GenomicFeatures
```

```
## Loading required package: AnnotationDbi
```

```
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
```

Next, you need to choose a set of genes and create a vector of Entrez gene ids.
In this example we used a small set to keep the runtime low, but in practice you
can use a larger list of genes, that you are interested in. (The genes used in
this example are: P53, KRAS, NRAS, BRAF, BRCA2, CDKN2A, ARID1A, PTEN and TERT.)
A useful list of cancer genes can be found here: <https://cancer.sanger.ac.uk/cosmic/census>.

```
gene_ids <- c(7157, 3845, 4893, 673, 675, 1029, 8289, 5728, 7015)
```

Now the ratio of “stop gain”, “mismatch”, “synonymous” and “splice site” mutations can be
determined per genomic context. The total number of possible mutations per
context is also given. Finally, a blosum62 score is given for the mismatches. A
lower score means that the amino acids in the mismatches are more dissimilar.
More dissimilar amino acids are more likely to have a detrimental effect.

```
contexts <- rownames(mut_mat)
context_mismatches <- context_potential_damage_analysis(contexts, txdb, ref_genome, gene_ids)
```

```
## Warning in .set_group_names(grl, use.names, txdb, by): some group names are NAs or duplicated
```

```
head(context_mismatches)
```

```
## # A tibble: 6 × 5
##   type        context     n   ratio blosum62
##   <fct>       <fct>   <dbl>   <dbl>    <dbl>
## 1 Stop_gain   A[C>A]A    46 0.0475   NA
## 2 Missense    A[C>A]A   889 0.917     0.0439
## 3 Synonymous  A[C>A]A    25 0.0258   NA
## 4 splice_site A[C>A]A     9 0.00929  NA
## 5 Stop_gain   A[C>G]A    46 0.0475   NA
## 6 Missense    A[C>G]A   889 0.917     0.376
```

The ratios per context can then be used to get the ratios per signature.
Normalized ratios are also given. These were calculated by dividing the ratios
in each signature, by the ratios of a completely “flat” signature. A normalized
ratio of 2 for “stop gain” mutations, means that a signature is twice as likely
to cause “stop gain” mutations, compared to a completely random “flat”
signature. The total number of possible mutations per context is multiplied with
the signature contribution per context and summed over all contexts. It thus
gives a measure of the amount of mutations that a signature could cause.

```
sig_damage <- signature_potential_damage_analysis(signatures, contexts, context_mismatches)
head(sig_damage)
```

```
## # A tibble: 6 × 7
##   type        sig     ratio ratio_by_background      n blosum62 blosum62_min_background
##   <fct>       <chr>   <dbl>               <dbl>  <dbl>    <dbl>                   <dbl>
## 1 Stop_gain   SBS1   0.0344               0.797  17.6    NA                      NA
## 2 Missense    SBS1   0.614                0.864 296.     -0.391                   0.109
## 3 Synonymous  SBS1   0.340                1.57  157.     NA                      NA
## 4 splice_site SBS1   0.0118               0.391   6.00   NA                      NA
## 5 Stop_gain   SBS10a 0.155                3.59  169.     NA                      NA
## 6 Missense    SBS10a 0.689                0.971 742.     -0.839                  -0.339
```

## 5.5 Using other signature matrixes

So far we have used the SNV signatures from COSMIC. For your convenience we have
also included indel, DBS and transcription strand bias signatures in this
package. Additionally, we included signatures from SIGNAL (Kucab et al. [2019](#ref-Kucab2019), @Degasperi2020).
These signature matrixes can all be loaded using the
`get_known_signature` function. If you use any of these signature matrixes,
please cite the associated paper. (The papers are listed in the functions
documentation.) A complete list of signature matrixes is shown in the
documentation.

You can choose the mutation type like this:

```
signatures_indel = get_known_signatures(muttype = "indel")
signatures_indel[1:5, 1:5]
```

```
##               ID1         ID2        ID3         ID4         ID5
## [1,] 1.598890e-04 0.004824116 0.12472711 0.007249717 0.022202108
## [2,] 7.735230e-04 0.000022100 0.20887617 0.002734869 0.028547215
## [3,] 3.310000e-18 0.000003110 0.17632422 0.002041063 0.026596927
## [4,] 1.907613e-03 0.002472076 0.06404276 0.001112283 0.014159122
## [5,] 7.059900e-04 0.003856976 0.04398981 0.001075684 0.002873422
```

It’s also possible to include signatures, that might be artifacts. Including
these signatures can lead to more overfitting. Therefore we recommend against
using them for most analyses. However, these signatures can be useful to see if
your data contains many sequencing artifacts, if you doubt the quality of your
data.

```
signatures_artifacts = get_known_signatures(incl_poss_artifacts = TRUE)
dim(signatures_artifacts)
```

```
## [1] 96 78
```

For the COSMIC signatures it is possible to use a version that is normalized to GRCh38 instead of GRCh37.

```
signatures_GRCh38 = get_known_signatures(genome = "GRCh38")
dim(signatures_GRCh38)
```

```
## [1] 96 60
```

You can load the SIGNAL reference signatures like this:

```
signatures_signal = get_known_signatures(source = "SIGNAL")
signatures_signal[1:5, 1:5]
```

```
##        Ref.Sig.1  Ref.Sig.18  Ref.Sig.17 Ref.Sig.MMR1   Ref.Sig.2
## [1,] 0.014424897 0.039663568 0.006372460  0.001284897 0.006002773
## [2,] 0.010360350 0.018544610 0.004075949  0.002134185 0.004070956
## [3,] 0.001777193 0.002808569 0.000710741  0.000391244 0.001034174
## [4,] 0.006919449 0.021455244 0.004336829  0.003651353 0.004913786
## [5,] 0.007878841 0.030676377 0.006800031  0.009041600 0.005428057
```

SIGNAL also contains signatures based on drug exposures:

```
signatures_exposure = get_known_signatures(source = "SIGNAL", sig_type = "exposure")
signatures_exposure[1:5, 1:5]
```

```
##      Potassium.bromate..875.uM. DBADE..0.109.uM. Formaldehyde..120.uM. Semustine..150.uM.
## [1,]                0.109398510       0.02403306          0.0181865590        0.000122421
## [2,]                0.003130658       0.01554442          0.0000874214        0.000127289
## [3,]                0.002110408       0.01541314          0.0084401850        0.019273820
## [4,]                0.030238329       0.02071597          0.0014273130        0.000152919
## [5,]                0.245576471       0.08990508          0.0064654200        0.013530190
##      Temozolomide..200.uM.
## [1,]          0.000000e+00
## [2,]          7.295480e-06
## [3,]          8.693270e-04
## [4,]          1.045737e-03
## [5,]          6.199382e-03
```

Finally, SIGNAL contains tissue specific signatures:

```
signatures_stomach = get_known_signatures(source = "SIGNAL", sig_type = "tissue", tissue_type = "Stomach")
signatures_stomach[1:5, 1:5]
```

```
##        Stomach_A   Stomach_B   Stomach_C   Stomach_D   Stomach_E
## [1,] 0.000008770 0.002630193 0.017265853 0.023105783 0.045357951
## [2,] 0.000726462 0.001121429 0.007534979 0.024512179 0.013957960
## [3,] 0.000073900 0.000170013 0.001975467 0.003365362 0.002963316
## [4,] 0.002985550 0.005906489 0.004073036 0.020820725 0.019572956
## [5,] 0.003812840 0.014949731 0.005183158 0.022986268 0.040598377
```

Using an incorrect `tissue_type` will result in an error. This is useful,
because it shows all possible tissue types. (Not run here, to prevent the
error.):

```
get_known_signatures(source = "SIGNAL", sig_type = "tissue", tissue_type = "?")
```

The contribution of tissue specific signatures can be converted back to SIGNAL
reference signatures. First fit the mutation matrix to tissue specific
signatures:

```
fit_res_tissue <- fit_to_signatures(mut_mat, signatures_stomach)
fit_res_tissue$contribution[1:5, 1:5]
```

```
##              colon1     colon2    colon3 intestine1 intestine2
## Stomach_A  0.000000   0.000000   0.00000   12.08489    0.00000
## Stomach_B  5.169529   3.596984   0.00000    0.00000    0.00000
## Stomach_C 97.671400 371.876056 302.62960   51.93184  451.00766
## Stomach_D  0.000000   0.000000  22.69611    0.00000   13.90384
## Stomach_E  5.778208   6.186979  38.50394   12.78566   36.01229
```

Then convert the contributions to reference signatures:

```
fit_res_tissue <- convert_sigs_to_ref(fit_res_tissue)
fit_res_tissue$contribution[1:5, 1:5]
```

```
##                colon1     colon2    colon3 intestine1 intestine2
## RefSig 1    97.671400 371.876056 302.62960  51.931845  451.00766
## RefSig 18    5.778208   6.186979  38.50394  12.785662   36.01229
## RefSig 17    0.000000   0.000000   0.00000   0.000000    0.00000
## RefSig MMR1 33.257448  72.168966  18.81792  12.084890   66.04738
## RefSig 2     8.110318  16.271659   0.00000   5.646223   12.10879
```

Instead of using a signature matrix included in this package, you can also download
your own signature matrixes. If you do this you have to make sure that the order
of the mutation types is the same as the MutationalPatterns standard. (You can
use the `match` function for this.)

# 6 Strand bias analyses

## 6.1 Transcriptional strand bias analysis

For the mutations within genes it can be determined whether the mutation is
on the transcribed or non-transcribed strand, which can be used to evaluate
the involvement of transcription-coupled repair. To this end, it is determined
whether the “C” or “T” base (since by convention we regard base substitutions
as C>X or T>X) are on the same strand as the gene definition. Base substitutions
on the same strand as the gene definitions are considered “untranscribed”, and
on the opposite strand of gene bodies as “transcribed”, since the gene
definitions report the coding or sense strand, which is untranscribed. No
strand information is reported for base substitution that overlap with more
than one gene body on different strands.

### 6.1.1 Gene definitions

Start by getting gene definitions for your reference genome:

```
genes_hg19 <- genes(TxDb.Hsapiens.UCSC.hg19.knownGene)
```

```
##   24 genes were dropped because they have exons located on both strands of the same reference
##   sequence or on more than one reference sequence, so cannot be represented by a single genomic
##   range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList object, or use
##   suppressMessages() to suppress this message.
```

```
genes_hg19
```

```
## GRanges object with 28622 ranges and 1 metadata column:
##         seqnames              ranges strand |     gene_id
##            <Rle>           <IRanges>  <Rle> | <character>
##       1    chr19   58856544-58874117      - |           1
##      10     chr8   18248792-18258728      + |          10
##     100    chr20   43213537-43280893      - |         100
##    1000    chr18   25512843-25757910      - |        1000
##   10000     chr1 243651535-244014381      - |       10000
##     ...      ...                 ...    ... .         ...
##    9991     chr9 114977351-115095933      - |        9991
##    9992    chr21   35553030-35743680      + |        9992
##    9993    chr22   19023795-19109967      - |        9993
##    9994     chr6   90539613-90584155      + |        9994
##    9997    chr22   50961997-50964890      - |        9997
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

### 6.1.2 Strand bias profile

You can get transcriptional strand information for all positions in the first
VCF object with `mut_strand`. This function returns “-” for positions outside
gene bodies, and positions that overlap with more than one gene on different
strands.

```
strand <- mut_strand(grl[[1]], genes_hg19)
head(strand, 10)
```

```
##  [1] transcribed   -             transcribed   -             untranscribed -
##  [7] -             -             untranscribed -
## Levels: untranscribed transcribed -
```

You can make a mutation count matrix with transcriptional strand information (96
trinucleotides \* 2 strands = 192 features). NB: only those mutations that are
located within gene bodies are counted.

```
mut_mat_s <- mut_matrix_stranded(grl, ref_genome, genes_hg19)
mut_mat_s[1:5, 1:5]
```

```
##                       colon1 colon2 colon3 intestine1 intestine2
## A[C>A]A-untranscribed      0      0      0          0          4
## A[C>A]A-transcribed        1      2      3          4          4
## A[C>A]C-untranscribed      0      0      1          1          1
## A[C>A]C-transcribed        0      1      0          0          2
## A[C>A]G-untranscribed      1      2      0          0          0
```

You can visualize samples from this matrix like this:

```
plot_192_profile(mut_mat_s[, 1:2])
```

```
## Warning in geom_bar(stat = "identity", colour = "black", size = 0.2): Ignoring unknown
## parameters: `size`
```

![](data:image/png;base64...)

### 6.1.3 Strand bias test

You can count the number of mutations on each strand, per tissue, per
mutation type:

```
strand_counts <- strand_occurrences(mut_mat_s, by = tissue)
head(strand_counts)
```

```
## # A tibble: 6 × 5
##   group type  strand        no_mutations relative_contribution
##   <fct> <chr> <chr>                <dbl>                 <dbl>
## 1 colon C>A   transcribed             37                0.0649
## 2 colon C>A   untranscribed           31                0.0544
## 3 colon C>G   transcribed             12                0.0211
## 4 colon C>G   untranscribed           15                0.0263
## 5 colon C>T   transcribed            184                0.323
## 6 colon C>T   untranscribed          147                0.258
```

Next, you can use these counts to perform a Poisson test for strand asymmetry.
Multiple testing correction is also performed.

```
strand_bias <- strand_bias_test(strand_counts)
head(strand_bias)
```

```
## # A tibble: 6 × 10
##   group type  transcribed untranscribed total ratio p_poisson significant   fdr significant_fdr
##   <fct> <chr>       <dbl>         <dbl> <dbl> <dbl>     <dbl> <chr>       <dbl> <chr>
## 1 colon C>A            37            31    68  1.19    0.545  ""          0.744 ""
## 2 colon C>G            12            15    27  0.8     0.701  ""          0.789 ""
## 3 colon C>T           184           147   331  1.25    0.0477 "*"         0.286 ""
## 4 colon T>A            18            12    30  1.5     0.362  ""          0.723 ""
## 5 colon T>C            50            38    88  1.32    0.241  ""          0.700 ""
## 6 colon T>G            18             8    26  2.25    0.0755 ""          0.340 ""
```

Plot the mutation spectrum with strand distinction:

```
ps1 <- plot_strand(strand_counts, mode = "relative")
```

```
## Warning in geom_bar(stat = "identity", position = "dodge", colour = "black", : Ignoring unknown
## parameters: `size`
```

Plot the effect size (log2(untranscribed/transcribed) of the strand bias.
Asteriks indicate significant strand bias. Here we use p-values to plot
asterisks. By default fdr is used.

```
ps2 <- plot_strand_bias(strand_bias, sig_type = "p")
```

Finally, combine the plots into one figure:

```
grid.arrange(ps1, ps2)
```

![](data:image/png;base64...)

You can change the significance cutoffs for the fdr and p-values. You can use up
to three cutoff levels for each, which changes the number of asteriks in the
`significant` and `significant_fdr` columns. These asteriks will be used in the
plot.

```
strand_bias_notstrict <- strand_bias_test(strand_counts,
  p_cutoffs = c(0.5, 0.1, 0.05),
  fdr_cutoffs = 0.5
)
plot_strand_bias(strand_bias_notstrict, sig_type = "p")
```

![](data:image/png;base64...)

## 6.2 Replicative strand bias analysis

The involvement of replication-associated mechanisms can be evaluated by
testing for a mutational bias between the leading and lagging strand. The
replication strand is dependent on the locations of replication origins from
which DNA replication is fired. However, replication timing is dynamic and
cell-type specific, which makes replication strand determination less
straightforward than transcriptional strand bias analysis. Replication timing
profiles can be generated with Repli-Seq experiments. Once the replication
direction is defined, a strand asymmetry analysis can be performed similarly as
the transcription strand bias analysis. The only difference is that you need
to use the `replication` mode for the `mut_strand` and `mut_strand_matrix`
functions.

### 6.2.1 Define replication direction

Here we read in an example bed file provided with the package containing
replication direction annotation:

```
repli_file <- system.file("extdata/ReplicationDirectionRegions.bed",
  package = "MutationalPatterns"
)
repli_strand <- read.table(repli_file, header = TRUE)
# Store in GRanges object
repli_strand_granges <- GRanges(
  seqnames = repli_strand$Chr,
  ranges = IRanges(
    start = repli_strand$Start + 1,
    end = repli_strand$Stop
  ),
  strand_info = repli_strand$Class
)
# UCSC seqlevelsstyle
library(GenomeInfoDb)
seqlevelsStyle(repli_strand_granges) <- "UCSC"
repli_strand_granges
```

```
## GRanges object with 1993 ranges and 1 metadata column:
##          seqnames            ranges strand | strand_info
##             <Rle>         <IRanges>  <Rle> | <character>
##      [1]     chr1   2133001-3089000      * |       right
##      [2]     chr1   3089001-3497000      * |        left
##      [3]     chr1   3497001-4722000      * |       right
##      [4]     chr1   5223001-6428000      * |        left
##      [5]     chr1   6428001-7324000      * |       right
##      ...      ...               ...    ... .         ...
##   [1989]     chrY 23997001-24424000      * |       right
##   [1990]     chrY 24424001-28636000      * |        left
##   [1991]     chrY 28636001-28686000      * |       right
##   [1992]     chrY 28686001-28760000      * |        left
##   [1993]     chrY 28760001-28842000      * |       right
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

This `GRanges` object should have a `strand_info` metadata column, which
contains only two different annotations, e.g. “left” and “right”, or
“leading” and “lagging”. The genomic ranges cannot overlap, to allow only
one annotation per location.

The levels of the `strand_info` metadata in the GRanges object determines the
order in which the strands are reported in the mutation matrix that is returned
by `mut_matrix_stranded`, so if you want to count right before left,
you can specify this, before you run `mut_matrix_stranded`:

```
repli_strand_granges$strand_info <- factor(repli_strand_granges$strand_info,
  levels = c("right", "left")
)
```

### 6.2.2 Replication bias analysis

Now that we defined the replication direction, the rest of the analysis is
similar to the transcription bias analysis:

You can calculate the strand matrix, counts and bias like this:

```
mut_mat_s_rep <- mut_matrix_stranded(grl, ref_genome, repli_strand_granges,
  mode = "replication"
)
strand_counts_rep <- strand_occurrences(mut_mat_s_rep, by = tissue)
strand_bias_rep <- strand_bias_test(strand_counts_rep)
```

And then visualize them:

```
ps1 <- plot_strand(strand_counts_rep, mode = "relative")
```

```
## Warning in geom_bar(stat = "identity", position = "dodge", colour = "black", : Ignoring unknown
## parameters: `size`
```

```
ps2 <- plot_strand_bias(strand_bias_rep)
grid.arrange(ps1, ps2)
```

![](data:image/png;base64...)

## 6.3 Signatures with strand bias

Strand bias can be included in signature analyses.
You can for example perform NMF on a mutation count matrix with strand features:

```
nmf_res_strand <- extract_signatures(mut_mat_s, rank = 2, single_core = TRUE)
```

```
## NMF algorithm: 'brunet'
```

```
## Multiple runs: 200
```

```
## Mode: sequential [sapply]
```

```
## Runs: 1* 2 3 4* 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50% 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89* 90 91 92 93 94 95 96 97 98 99 100% 101 102* 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150% 151 152 153 154 155 156 157* 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200% ... DONE
## System time:
##    user  system elapsed
## 226.516   0.646 227.165
```

```
colnames(nmf_res_strand$signatures) <- c("Signature A", "Signature B")
```

# 7 Genomic distribution

Mutations are not randomly distributed throughout the genome. With
`MutationalPatterns` you can visualize how mutations are distributed throughout
the genome. You can also look at specific genomic regions, such as promoters,
CTCF binding sites and transcription factor binding sites. Within these regions
you can look for enrichment/depletion of mutations and you can look for
differences in the mutational spectra between them.

## 7.1 Rainfall plot

A rainfall plot visualizes mutation types and intermutation distance. Rainfall
plots can be used to visualize the distribution of mutations along the genome or
a subset of chromosomes. The y-axis corresponds to the distance of a mutation
with the previous mutation and is log10 transformed. Drop-downs from the plots
indicate clusters or “hotspots” of mutations. Rainfall plots can be made for
SNVs, indels, DBSs and MBSs.

In this example we make a rainfall plot over the autosomal chromosomes for 1
sample:

```
# Define autosomal chromosomes
chromosomes <- seqnames(get(ref_genome))[1:22]

# Make a rainfall plot
plot_rainfall(grl[[1]],
  title = names(grl[1]),
  chromosomes = chromosomes, cex = 1.5, ylim = 1e+09
)
```

![](data:image/png;base64...)

## 7.2 Define genomic regions

To look at specific types of genomic regions you first need to define them in a
named `GRangesList`. You can use your own genomic region definitions (based on
e.g. ChipSeq experiments) or you can use publicly available genomic annotation
data, like in the example below.

The following example displays how to download promoter, CTCF binding sites and
transcription factor binding sites regions for
genome build hg19 from Ensembl using Biocpkg(“biomaRt”). For other datasets,
see the *[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)* documentation (Durinck et al. [2005](#ref-Durinck2005)).
(Remember to install this package before trying to use it.)

Load the Biocpkg(“biomaRt”) package.

```
library(biomaRt)
```

Download genomic regions. NB: Here we take some shortcuts by loading the results
from our example data. The corresponding code for downloading this data can be
found above the command we run:

```
# regulatory <- useEnsembl(biomart="regulation",
#                          dataset="hsapiens_regulatory_feature",
#                          GRCh = 37)

## Download the regulatory CTCF binding sites and convert them to
## a GRanges object.
# CTCF <- getBM(attributes = c('chromosome_name',
#                             'chromosome_start',
#                             'chromosome_end',
#                             'feature_type_name'),
#              filters = "regulatory_feature_type_name",
#              values = "CTCF Binding Site",
#              mart = regulatory)
#
# CTCF_g <- reduce(GRanges(CTCF$chromosome_name,
#                 IRanges(CTCF$chromosome_start,
#                 CTCF$chromosome_end)))

CTCF_g <- readRDS(system.file("states/CTCF_g_data.rds",
  package = "MutationalPatterns"
))

## Download the promoter regions and convert them to a GRanges object.

# promoter = getBM(attributes = c('chromosome_name', 'chromosome_start',
#                                 'chromosome_end', 'feature_type_name'),
#                  filters = "regulatory_feature_type_name",
#                  values = "Promoter",
#                  mart = regulatory)
# promoter_g = reduce(GRanges(promoter$chromosome_name,
#                     IRanges(promoter$chromosome_start,
#                             promoter$chromosome_end)))

promoter_g <- readRDS(system.file("states/promoter_g_data.rds",
  package = "MutationalPatterns"
))

## Download the promoter flanking regions and convert them to a GRanges object.

# flanking = getBM(attributes = c('chromosome_name',
#                                 'chromosome_start',
#                                 'chromosome_end',
#                                 'feature_type_name'),
#                  filters = "regulatory_feature_type_name",
#                  values = "Promoter Flanking Region",
#                  mart = regulatory)
# flanking_g = reduce(GRanges(
#                        flanking$chromosome_name,
#                        IRanges(flanking$chromosome_start,
#                        flanking$chromosome_end)))

flanking_g <- readRDS(system.file("states/promoter_flanking_g_data.rds",
  package = "MutationalPatterns"
))
```

Combine all genomic regions (`GRanges` objects) in a named `GrangesList`:

```
regions <- GRangesList(promoter_g, flanking_g, CTCF_g)

names(regions) <- c("Promoter", "Promoter flanking", "CTCF")
```

Make sure that these regions use the same chromosome naming convention as the
mutation data:

```
seqlevelsStyle(regions) <- "UCSC"
```

## 7.3 Enrichment or depletion of mutations in genomic regions

It is necessary to include a list with `GRanges` of regions that were surveyed
in your analysis for each sample, that is: positions in the genome at which
you have enough high quality reads to call a mutation. This can
be determined using e.g. CallableLoci by GATK. If you would not include the
surveyed area in your analysis, you might for example see a depletion of
mutations in a certain genomic region that is solely a result from a low
coverage in that region, and therefore does not represent an actual depletion
of mutations.

We provided an example surveyed region data file with the package. For
simplicity, here we use the same surveyed file for each sample. For a proper
analysis, determine the surveyed area per sample and use these in your analysis.

Load the example surveyed region data:

```
## Get the filename with surveyed/callable regions
surveyed_file <- system.file("extdata/callableloci-sample.bed",
  package = "MutationalPatterns"
)

## Import the file using rtracklayer and use the UCSC naming standard
library(rtracklayer)
surveyed <- import(surveyed_file)
seqlevelsStyle(surveyed) <- "UCSC"

## For this example we use the same surveyed file for each sample.
surveyed_list <- rep(list(surveyed), 9)
```

First you need to calculate the number of observed and the number of expected
mutations in each genomic region for each sample.

```
distr <- genomic_distribution(grl, surveyed_list, regions)
```

Next, you can test for enrichment or depletion of mutations in the defined
genomic regions using a two-sided binomial test. For this test, the chance of
observing a mutation is calculated as the total number of mutations, divided by
the total number of surveyed bases. Multiple testing correction is also
performed. The significance cutoffs for the fdr and p-values can be changed in
the same way as for `strand_bias_test`.
In this example we perform the enrichment/depletion test by tissue type.

```
distr_test <- enrichment_depletion_test(distr, by = tissue)
head(distr_test)
```

```
##              region        by n_muts surveyed_length surveyed_region_length observed
## 1          Promoter     colon   1244       305756400                4712490        2
## 2          Promoter intestine   1450       305756400                4712490        1
## 3          Promoter     liver   1394       305756400                4712490        0
## 4 Promoter flanking     colon   1244       305756400                7640280        2
## 5 Promoter flanking intestine   1450       305756400                7640280        0
## 6 Promoter flanking     liver   1394       305756400                7640280        0
##           prob expected    effect         pval significant          fdr significant_fdr
## 1 4.068598e-06 19.17323 depletion 1.922097e-06           * 2.883146e-06               *
## 2 4.742337e-06 22.34822 depletion 9.195073e-09           * 1.655113e-08               *
## 3 4.559185e-06 21.48511 depletion 9.335602e-10           * 2.100511e-09               *
## 4 4.068598e-06 31.08523 depletion 3.257344e-11           * 9.772032e-11               *
## 5 4.742337e-06 36.23279 depletion 3.675310e-16           * 3.307779e-15               *
## 6 4.559185e-06 34.83345 depletion 1.489431e-15           * 6.702438e-15               *
```

Finally, you can plot the results. Asteriks indicate significant
enrichment/depletion. Here we use p-values to plot asterisks. By default fdr is
used.

```
plot_enrichment_depletion(distr_test, sig_type = "p")
```

![](data:image/png;base64...)

## 7.4 Mutational patterns of genomic regions

### 7.4.1 Split mutations based on genomic regions

You can also look at the mutational patterns of genomic regions. However, keep
in mind that regions with very few mutations will lead to less reliable results.

First you can split the `GRangesList` containing the mutations based on the
defined genomic regions.

```
grl_region <- split_muts_region(grl, regions)
names(grl_region)
```

```
##  [1] "colon1.Promoter"              "colon1.Promoter flanking"
##  [3] "colon1.CTCF"                  "colon1.Other"
##  [5] "colon2.Promoter"              "colon2.Promoter flanking"
##  [7] "colon2.CTCF"                  "colon2.Other"
##  [9] "colon3.Promoter"              "colon3.Promoter flanking"
## [11] "colon3.CTCF"                  "colon3.Other"
## [13] "intestine1.Promoter"          "intestine1.Promoter flanking"
## [15] "intestine1.CTCF"              "intestine1.Other"
## [17] "intestine2.Promoter"          "intestine2.Promoter flanking"
## [19] "intestine2.CTCF"              "intestine2.Other"
## [21] "intestine3.Promoter"          "intestine3.Promoter flanking"
## [23] "intestine3.CTCF"              "intestine3.Other"
## [25] "liver1.Promoter"              "liver1.Promoter flanking"
## [27] "liver1.CTCF"                  "liver1.Other"
## [29] "liver2.Promoter"              "liver2.Promoter flanking"
## [31] "liver2.CTCF"                  "liver2.Other"
## [33] "liver3.Promoter"              "liver3.Promoter flanking"
## [35] "liver3.CTCF"                  "liver3.Other"
```

You could now treat these sample/region combinations as completely separate
samples. You could for example perform NMF on these, to try to identify
signatures that are specific to certain genomic regions.

```
mut_mat_region <- mut_matrix(grl_region, ref_genome)
nmf_res_region <- extract_signatures(mut_mat_region, rank = 2, nrun = 10, single_core = TRUE)
```

```
## NMF algorithm: 'brunet'
```

```
## Multiple runs: 10
```

```
## Mode: sequential [sapply]
```

```
## Runs: 1* 2 3* 4 5 6 7 8 9 10 ... DONE
## System time:
##    user  system elapsed
##  12.729   0.104  12.833
```

```
nmf_res_region <- rename_nmf_signatures(nmf_res_region,
                                        signatures,
                                        cutoff = 0.85)
plot_contribution_heatmap(nmf_res_region$contribution,
                          cluster_samples = TRUE,
                          cluster_sigs = TRUE)
```

![](data:image/png;base64...)

In this case there don’t seem to be any region specific signatures.

### 7.4.2 Mutation Spectrum

Instead of treating the sample/region combinations as separate samples, you can
also plot the spectra per genomic region using the `plot_spectrum_region`
function. The arguments of `plot_spectrum` can also be used with this function.
By default the y-axis shows the number of variants divided by the total number
of variants in that sample and genomic region. This way the spectra of regions
with very few mutations can be more easily compared to regions with many
mutations.

```
type_occurrences_region <- mut_type_occurrences(grl_region, ref_genome)
plot_spectrum_region(type_occurrences_region)
```

```
## Warning in geom_bar(stat = "identity", position = "dodge", colour = "black", : Ignoring unknown
## parameters: `size`
```

![](data:image/png;base64...)

You can also plot the number of variants divided by the total number of variants
in that sample on the y-axis. In this case you don’t normalize for the number of
variants per genomic region. As you can see below the vast majority of mutations
in this example occurred in the “other” region.

```
plot_spectrum_region(type_occurrences_region, mode = "relative_sample")
```

```
## Warning in geom_bar(stat = "identity", position = "dodge", colour = "black", : Ignoring unknown
## parameters: `size`
```

![](data:image/png;base64...)

### 7.4.3 Mutational profiles

In addition to plotting the spectra you can also plot a mutational profile. To
do this you first need to make a “long” mutation matrix. In this matrix the
different genomic regions are considered as different mutational types, instead
of as different samples like before.

```
mut_mat_region <- mut_matrix(grl_region, ref_genome)
mut_mat_long <- lengthen_mut_matrix(mut_mat_region)
mut_mat_long[1:5, 1:5]
```

```
##                  colon1 colon2 colon3 intestine1 intestine2
## A[C>A]A_Promoter      0      0      0          0          1
## A[C>A]C_Promoter      0      0      0          0          0
## A[C>A]G_Promoter      0      0      0          0          0
## A[C>A]T_Promoter      0      0      1          0          0
## C[C>A]A_Promoter      0      0      0          0          0
```

You can now plot this using `plot_profile_region`. The arguments of
`plot_96_profile` can also be used with this function. The options for the
y-axis are the same as for `plot_spectrum_region`. However, by default no
normalization is performed for the number of variants per genomic region,
because of the often limited number of mutations per mutation type.

```
plot_profile_region(mut_mat_long[, c(1, 4, 7)])
```

```
## Warning in geom_bar(stat = "identity", colour = "black", size = 0.2, width = bar_width):
## Ignoring unknown parameters: `size`
```

![](data:image/png;base64...)

NB: Since the “mut\_mat\_long” is a mutation matrix, you could perform NMF on it.
This would result in signatures, which will contain different mutation types in
different genomic regions.

### 7.4.4 Mutation density

In the examples above we used known features like promoters for the regions.
It’s also possible to define regions based on mutation density. You can divide
the genome into 3 bins with different mutation density like this:

```
regions_density <- bin_mutation_density(grl, ref_genome, nrbins = 3)
names(regions_density) <- c("Low", "Medium", "High")
```

These regions can then be used in the same way as the previous regions. This can
be useful to, for example, compare the spectrum of regions with kataegis with
that of the rest of the genome.

```
grl_region_dens <- split_muts_region(grl, regions_density, include_other = FALSE)
```

## 7.5 Unsupervised local mutational patterns

Regional mutational patterns can also be investigated using an unsupervised
approach with the `determine_regional_similarity` function. This function uses a
sliding window approach to calculate the cosine similarity between the global
mutation profile and the mutation profile of smaller genomic windows, allowing
for the unbiased identification of regions with a mutation profile, that differs
from the rest of the genome. Because of the unbiased approach of this function,
it works best on a large dataset containing at least 100,000 substitutions.

First we combine all our samples together. Normally, you would only do this for
samples from the same cancer type/tissue, but here we combine everything because of
the limited number of substitutions in our example data.

```
gr = unlist(grl)
```

Next, regions with a mutational pattern that is different from the rest of the
genome are identified. Here we use a small window size, because of the small
size of the example data. In practice a window size of 100 or more works better.

```
regional_sims <- determine_regional_similarity(gr,
                              ref_genome,
                              chromosomes = c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6"),
                              window_size = 40,
                              stepsize = 10,
                              max_window_size_gen = 40000000
)
```

The results of `determine_regional_similarity` can be visualized. Each dot shows
the cosine similarity between the mutation profiles of a single window and the
rest of the genome. A region with a different mutation profile will have a lower
cosine similarity. The dots are colored based on the sizes in mega bases of the
windows. This size is the distance between the first and last mutations in a
window.

```
plot_regional_similarity(regional_sims)
```

![](data:image/png;base64...)

# 8 Lesion segregation

Large Watson versus Crick strand asymmetries can sometimes be observed in
mutation spectra (Aitken et al. [2020](#ref-Aitken2020)). This can be the result of many DNA lesions
occurring during a single cell cycle. For example, many C>T lesions could occur.
If these lesions aren’t properly repaired before the next genome duplication,
then the resulting sister chromatids will contain the incorrect “T” nucleotides
only on their parental strand. Incorrect “A” nucleotides will be incorporated on
the newly synthesized strands. These sister chromatids will segregate into
different daughter cells, which will have the C>T variants on different strands.
The majority of mutations will be either on the Watson or the Crick strand. This
process is known as lesion segregation (Aitken et al. [2020](#ref-Aitken2020)).

Healthy human cells are 2n. Therefore, a daughter cell could inherit one copy of
a specific chromosome with mutations on the Watson strand and one copy with
mutations on the Crick strand. These will cancel each other out and no strand
bias will be visible. Because the chromosomes segregate independently from each
other, lesion segregation is expected to follow a mendelian inheritance pattern
of 1:2:1. 25% of the chromosomes will have mutations on the Watson strand, 25%
will have mutations on the Crick strand and 50% will show no Watson versus Crick
bias.

## 8.1 Visualizing lesion segregation

You can visualize possible lesion segregation for a single or multiple samples.
If lesion segregation is present, then it will generally be quite clear that the
mutations are not randomly distributed over the strands. In this example no
lesion segregation is present. (“+” and “-” are used instead of “Watson” and
“Crick” to save space.)

```
plot_lesion_segregation(grl[1:2])
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the MutationalPatterns package.
##   Please report the issue to the authors.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

![](data:image/png;base64...)

## 8.2 Calculating lesion segregation

You can also calculate whether lesion segregation is present instead of
visualizing it.

You can calculate whether lesion segregation is present using
`calculate_lesion_segregation`. This has the benefit that we can quantify the
amount of lesion segregation and generate p-values. However, the generated
p-values aren’t always 100% reliable as will be discussed below. Therefore, we
recommend you to always confirm any suspected lesion segregation by visualizing
it.

`calculate_lesion_segregation` has three different modes. The first mode is
based on how often two subsequent mutations occur on the same strand. The
function assumes that when no lesion segregation is present, there is a 50%
chance of two subsequent mutations occurring on the same strand. A two-sided
binomial test is used to calculate whether the strand between subsequent
mutations is switched more often than that. Multiple testing correction is also
performed.

```
lesion_segretation <- calculate_lesion_segregation(grl, sample_names)
head(lesion_segretation)
```

```
## # A tibble: 6 × 8
##   sample_name p.value fraction_strand_switches conf_low conf_high nr_strand_switches
##   <chr>         <dbl>                    <dbl>    <dbl>     <dbl>              <dbl>
## 1 colon1        0.197                    0.448    0.373     0.525                 78
## 2 colon2        0.708                    0.491    0.450     0.533                283
## 3 colon3        0.595                    0.486    0.438     0.534                208
## 4 intestine1    0.185                    0.562    0.472     0.650                 72
## 5 intestine2    0.452                    0.514    0.478     0.550                400
## 6 intestine3    0.156                    0.533    0.488     0.579                255
## # ℹ 2 more variables: max_possible_switches <dbl>, fdr <dbl>
```

This statistical test can be influenced by events such as kataegis and local
strand asymetries like replication-associated strand bias. As a result the
p-value can incorrectly suggest that lesion segregation is present. Therefore,
it can be useful to also look at the fraction of strand switches. In samples
with lesion segregation this is generally below 0.4.

By default this mode calculates the lesion segregation for all mutations
together. However, a mutational process might cause multiple types of base
substitutions, which aren’t necessarily considered to be on the same strand.
Therefore, it might be useful to calculate the number of strand switches per
mutation type and then sum up the results. In this case the reference genome
also needs to be set. We recommend using this when you have a sample with
suspected lesion segregation and multiple common types of base substitutions.

```
lesion_seg_type <- calculate_lesion_segregation(grl,
                                                sample_names,
                                                split_by_type = TRUE,
                                                ref_genome = ref_genome)
```

The second mode of `calculate_lesion_segregation` uses the Wald-Wolfowitz test,
which was used by Aitken et al. ([2020](#ref-Aitken2020)) This test checks whether the Watson and Crick
strands are randomly distributed. It’s results should generally be similar to
the first mode.

```
lesion_segretation_wald <- calculate_lesion_segregation(grl, sample_names,
                                                        test = "wald-wolfowitz")
head(lesion_segretation_wald)
```

```
## # A tibble: 6 × 5
##   sample_name p.value    sd nr_total_runs   fdr
##   <chr>         <dbl> <dbl>         <int> <dbl>
## 1 colon1        0.565  6.91            94 0.693
## 2 colon2        0.573 12.2            293 0.693
## 3 colon3        0.846 10.5            222 0.846
## 4 intestine1    0.350  6.05            81 0.693
## 5 intestine2    0.616 14.1            408 0.693
## 6 intestine3    0.197 11.2            265 0.693
```

This statistical test can also be influenced by events such as kataegis and
local strand asymetries like replication-associated strand bias.

The third mode of `calculate_lesion_segregation` can calculate the rl20 value
and the associated genomic span, which together are somewhat less sensitive to
events like kataegis.

A rl20 value of 6 means that at least 20% of mutations are
in a strand specific run of 6 or more consecutive mutations. The genomic span is
the part of the genome covered by these runs. If the rl20 is high and a decent
part of the genome is covered by the strand specific runs, then this provides
strong evidence of lesion segregation. A high rl20, combined with a low genomic
span (<5%) is indicative of local clustering events like kataegis
(Aitken et al. [2020](#ref-Aitken2020)). A downside of this method is that it doesn’t generate a
p-value. In general, we recommend you to use the first or second mode
of `calculate_lesion_segregation` to get a p-value and the third mode to check
if you are looking at a genome wide process or a local process like kataegis.

```
lesion_segretation_rl20 <- calculate_lesion_segregation(grl,
  sample_names,
  test = "rl20",
  ref_genome = ref_genome,
  chromosomes = chromosomes
)
head(lesion_segretation_rl20)
```

```
## # A tibble: 6 × 5
##   sample_name  rl20 genome_span genome_size fraction_span
##   <chr>       <int>       <int>       <dbl>         <dbl>
## 1 colon1          4   408989704  2881033286         0.142
## 2 colon2          5   493602023  2881033286         0.171
## 3 colon3          4   401259179  2881033286         0.139
## 4 intestine1      3   500172808  2881033286         0.174
## 5 intestine2      4   489528228  2881033286         0.170
## 6 intestine3      4   389813043  2881033286         0.135
```

# 9 A note on the graphics

The plots made with this package are all made using *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*
(Wickham [2016](#ref-Wickham2016)). This means that all the plots (except for the plots with
dendograms) are highly customizable. You can for example change the size and
text
orientation of the y-axis.

```
p <- plot_spectrum(type_occurrences, legend = FALSE)
p_axis <- p +
  theme(axis.text.y = element_text(size = 14, angle = 90))
```

You can also change the entire theme of the plot.

```
p_theme <- p +
  theme_classic()
```

```
grid.arrange(p, p_axis, p_theme, ncol = 3, widths = c(3, 3, 3))
```

![](data:image/png;base64...)

More information on *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* is available
[here](https://ggplot2.tidyverse.org/). A list of themes is available
[here](https://ggplot2.tidyverse.org/reference/ggtheme.html).

# 10 Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] biomaRt_2.66.1                           GenomeInfoDb_1.46.2
##  [3] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1 GenomicFeatures_1.62.0
##  [5] AnnotationDbi_1.72.0                     ccfindR_1.30.0
##  [7] gridExtra_2.3                            BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [9] BSgenome_1.78.0                          rtracklayer_1.70.1
## [11] BiocIO_1.20.0                            Biostrings_2.78.0
## [13] XVector_0.50.0                           MutationalPatterns_3.20.1
## [15] NMF_0.28                                 bigmemory_4.6.4
## [17] Biobase_2.70.0                           cluster_2.1.8.2
## [19] rngtools_1.5.2                           registry_0.5-1
## [21] GenomicRanges_1.62.1                     Seqinfo_1.0.0
## [23] IRanges_2.44.0                           S4Vectors_0.48.0
## [25] BiocGenerics_0.56.0                      generics_0.1.4
## [27] ggplot2_4.0.2                            BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          ggdendro_0.2.0              jsonlite_2.0.0
##   [4] magrittr_2.0.4              magick_2.9.0                farver_2.1.2
##   [7] rmarkdown_2.30              vctrs_0.7.1                 memoise_2.0.1
##  [10] Rsamtools_2.26.0            RCurl_1.98-1.17             tinytex_0.58
##  [13] progress_1.2.3              htmltools_0.5.9             S4Arrays_1.10.1
##  [16] curl_7.0.0                  SparseArray_1.10.8          sass_0.4.10
##  [19] pracma_2.4.6                bslib_0.10.0                httr2_1.2.2
##  [22] plyr_1.8.9                  cachem_1.1.0                uuid_1.2-2
##  [25] GenomicAlignments_1.46.0    lifecycle_1.0.5             iterators_1.0.14
##  [28] pkgconfig_2.0.3             Matrix_1.7-4                R6_2.6.1
##  [31] fastmap_1.2.0               rbibutils_2.4.1             MatrixGenerics_1.22.0
##  [34] digest_0.6.39               colorspace_2.1-2            RSQLite_2.4.6
##  [37] filelock_1.0.3              labeling_0.4.3              httr_1.4.8
##  [40] abind_1.4-8                 compiler_4.5.2              bit64_4.6.0-1
##  [43] withr_3.0.2                 doParallel_1.0.17           S7_0.2.1
##  [46] BiocParallel_1.44.0         DBI_1.2.3                   MASS_7.3-65
##  [49] rappdirs_0.3.4              DelayedArray_0.36.0         rjson_0.2.23
##  [52] tools_4.5.2                 otel_0.2.0                  glue_1.8.0
##  [55] restfulr_0.0.16             grid_4.5.2                  gridBase_0.4-7
##  [58] reshape2_1.4.5              gtable_0.3.6                tidyr_1.3.2
##  [61] hms_1.1.4                   utf8_1.2.6                  foreach_1.5.2
##  [64] pillar_1.11.1               stringr_1.6.0               dplyr_1.2.0
##  [67] BiocFileCache_3.0.0         lattice_0.22-9              bit_4.6.0
##  [70] tidyselect_1.2.1            SingleCellExperiment_1.32.0 knitr_1.51
##  [73] bigmemory.sri_0.1.8         bookdown_0.46               SummarizedExperiment_1.40.0
##  [76] xfun_0.56                   matrixStats_1.5.0           stringi_1.8.7
##  [79] UCSC.utils_1.6.1            yaml_2.3.12                 evaluate_1.0.5
##  [82] codetools_0.2-20            cigarillo_1.0.0             tibble_3.3.1
##  [85] BiocManager_1.30.27         cli_3.6.5                   Rdpack_2.6.6
##  [88] jquerylib_0.1.4             dichromat_2.0-0.1           Rcpp_1.1.1
##  [91] dbplyr_2.5.2                png_0.1-8                   XML_3.99-0.22
##  [94] parallel_4.5.2              blob_1.3.0                  prettyunits_1.2.0
##  [97] ggalluvial_0.12.6           bitops_1.0-9                VariantAnnotation_1.56.0
## [100] scales_1.4.0                purrr_1.2.1                 crayon_1.5.3
## [103] rlang_1.1.7                 cowplot_1.2.0               KEGGREST_1.50.0
```

# References

Aitken, Sarah J, Craig J Anderson, Frances Connor, Oriol Pich, Vasavi Sundaram, Christine Feig, Tim F Rayner, et al. 2020. “Pervasive lesion segregation shapes cancer genome evolution.” *Nature* 583 (7815): 265–70. <https://doi.org/10.1038/s41586-020-2435-1>.

Alexandrov, Ludmil B, Jaegil Kim, Nicholas J Haradhvala, Mi Ni Huang, Alvin Wei Tian Ng, Yang Wu, Arnoud Boot, et al. 2020. “The repertoire of mutational signatures in human cancer.” *Nature* 578 (7793): 94–101. <https://doi.org/10.1038/s41586-020-1943-3>.

Degasperi, Andrea, Tauanne Dias Amarante, Jan Czarnecki, Scott Shooter, Xueqing Zou, Dominik Glodzik, Sandro Morganella, et al. 2020. “A practical framework and online tool for mutational signature analyses show inter-tissue variation and driver dependencies.” *Nature Cancer* 1 (2): 249–63. <https://doi.org/10.1038/s43018-020-0027-5>.

Durinck, Steffen, Yves Moreau, Arek Kasprzyk, Sean Davis, Bart De Moor, Alvis Brazma, and Wolfgang Huber. 2005. “BioMart and Bioconductor: A Powerful Link Between Biological Databases and Microarray Data Analysis.” *Bioinformatics* 21 (16): 3439–40. <https://doi.org/10.1093/bioinformatics/bti525>.

Gaujoux, Renaud, and Cathal Seoighe. 2010. “A Flexible R Package for Nonnegative Matrix Factorization.” *BMC Bioinformatics* 11 (1): 367. <https://doi.org/10.1186/1471-2105-11-367>.

Huang, Xiaoqing, Damian Wojtowicz, and Teresa M Przytycka. 2018. “Detecting presence of mutational signatures in cancer with confidence.” *Bioinformatics (Oxford, England)* 34 (2): 330–37. <https://doi.org/10.1093/bioinformatics/btx604>.

Kucab, Jill E, Xueqing Zou, Sandro Morganella, Madeleine Joel, A Scott Nanda, Eszter Nagy, Celine Gomez, et al. 2019. “A Compendium of Mutational Signatures of Environmental Agents.” *Cell* 177 (4): 821–836.e16. <https://doi.org/10.1016/j.cell.2019.03.001>.

Wickham, Hadley. 2016. *Ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York. <https://ggplot2.tidyverse.org>.