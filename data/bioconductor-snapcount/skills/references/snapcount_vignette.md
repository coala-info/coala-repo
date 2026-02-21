Code

* Show All Code
* Hide All Code

# snapcount vignette

Christopher Wilks1\*

1Johns Hopkins University Computer Science

\*chris.wilks@jhu.edu

#### 30 October 2025

#### Package

snapcount 1.22.0

# 1 Why would you want to use Snapcount?

snapcount is directed at current and potential *[recount](https://bioconductor.org/packages/3.22/recount)* users who want the further ability to quickly filter RNA-seq derived coverage data to just the regions of the human genome and the samples they care about.

This avoids having to download a whole study’s worth of data across the entire genome.

While it offers the same datasets that *[recount](https://bioconductor.org/packages/3.22/recount)* contains, it enables querying via a particular gene or genomic coordinate range entered by the user and only downloading the results from that query.

It then builds a RangedSummarizedExperiment (RSE) object on the fly, based on just the rows/columns in those results.

This query functionality is supported for genes, exons, and exon-exon junctions.

In addition, a set of aggregation functions are available for exon-exon junction data to allow for further filtering and summarizing.

# 2 Basics

## 2.1 Install snapcount

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages.
`R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install snapcount
by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("snapcount")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 2.2 Required knowledge

snapcount is based on other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-seq data. That is, packages like *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* and *[recount](https://bioconductor.org/packages/3.22/recount)* that allow you to import the data. A snapcount user is not expected to deal with those packages directly but will need to be familiar with *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* to understand the results snapcount generates. This vignette is based partially on the [recount2 quick start guide](https://bioconductor.org/packages/recount).

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/).

## 2.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `snapcount` tag and check [the older posts](https://support.bioconductor.org/t/snapcount/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

snapcount is an interface to the Snaptron webservices and data.
For questions regarding Snaptron itself and/or its data, please use the [Gitter channel](https://gitter.im/snaptron/Lobby).

## 2.4 Citing snapcount

We hope that snapcount will be useful for your research. Please use the following information to cite the package specifically, thank you!

```
Christopher Wilks, Rone Charles, Ben Langmead (2019).
snapcount: R/Bioconductor Package for interfacing with Snaptron
for rapid quering of expression counts.
https://github.com/langmead-lab/snapcount
```

The Snaptron project itself is published separately and can be cited with the following:

```
Wilks, C, Gaddipati, P, Nellore, A, Langmead, B (2018).
Snaptron: querying splicing patterns across tens
of thousands of RNA-seq samples.
Bioinformatics, 34, 1:114-116.
```

# 3 Introduction

snapcount makes it easy to query the [Snaptron web services](http://snaptron.cs.jhu.edu/), with results presented as *[RangedSummarizedExperiment](https://bioconductor.org/packages/3.22/RangedSummarizedExperiment)* objects.
You can query measurements for **genes**, **exons**, **splice junctions** and **coverage vectors** from the RNA-seq samples indexed in Snaptron.
Samples are organized into compilations (e.g. `srav2`) that altogether contain the same studies and summaries in the *[recount](https://bioconductor.org/packages/3.22/recount)* resource. Queries can be filtered to narrow the focus to particular genes or genomic intervals, to events with certain prevalence, to events that do or don’t appear in gene annotation, or to samples with particular metadata.

snapcount complements the *[recount](https://bioconductor.org/packages/3.22/recount)* package, which also allows for searching by coordinates or by HUGO gene names.
In general, *[recount](https://bioconductor.org/packages/3.22/recount)* works best when you are interested in *all* the genes, exons, or splice junctions in a study, whereas snapcount is best for queries over a particular subset of genes or intervals across all or most of the samples in recount2/Snaptron. The more specific your query, the faster and easier it will be to use snapcount.

All the RNA-seq samples in the recount and Snaptron resources were analyzed using the [Rail-RNA](http://rail.bio) aligner. Rail produces spliced alignments that in turn produce coverage and junction-level summaries that are further processed to obtain the data in recount and Snaptron.

Similar to the *[recount](https://bioconductor.org/packages/3.22/recount)* all coverage counts in Snaptron/snapcount are stored/retrieved as raw, un-normalized counts.

# 4 Basic queries

A basic query returns a *RangedSummarizedExperiment* (RSE) object with one or more features (genes, exons, or splice junctions) as *rowRanges*.
Raw coverage counts are returned as the *counts* assay in the RSE Full sample metadata is returned as the *colData* of the RSE

Basic queries include:

* exon-exon splice junction counts: *query\_jx*
* exon-level quantifications: *query\_exon*
* genes-level quantifications: *query\_gene*

The Gencode v25 annotation defines what genes and exons can be queried (as in *[recount](https://bioconductor.org/packages/3.22/recount)*).
For splice junctions, both annotated and novel junctions are queried at the same time unless one is explicitly filtered.

Metadata columns will vary by compilation (e.g. TCGA vs. GTEx).
Please be cautious with metadata. We strive to make it as complete and usable as possible, but it can still be incomplete, incorrect or inconsistently formatted (e.g. “age” in the `srav2` compilation).

Start by querying for all junctions within the region of gene CD99:

```
##Query coverage for gene, exon, and annotated junctions across all
#in the region of the CD99 gene
#from GTEx v6 sample compilation
#CD99 is chosen for its size
sb <- QueryBuilder(compilation="gtex", regions="CD99")
cd99.gene <- query_gene(sb)
dim(cd99.gene)
```

```
## [1]    1 9662
```

```
head(cd99.gene)
```

```
## class: RangedSummarizedExperiment
## dim: 1 9662
## metadata(1): uri
## assays(1): counts
## rownames(1): 23
## rowData names(12): DataSource:Type snaptron_id ... coverage_median
##   compilation_id
## colnames(9662): rail_50099 rail_50100 ... rail_59759 rail_59760
## colData names(322): rail_id Run ... junction_coverage
##   junction_avg_coverage
```

Now query for junctions:

```
##Query all exon-exon splice junctions within the region of gene CD99
cd99.jx.all <- query_jx(sb)
dim(cd99.jx.all)
```

```
## [1] 3485 9662
```

```
cd99.jx.all
```

```
## class: RangedSummarizedExperiment
## dim: 3485 9662
## metadata(1): uri
## assays(1): counts
## rownames(3485): 28340058 28340273 ... 28352407 28352408
## rowData names(12): DataSource:Type snaptron_id ... coverage_median
##   source_dataset_id
## colnames(9662): rail_50099 rail_50100 ... rail_59759 rail_59760
## colData names(322): rail_id Run ... junction_coverage
##   junction_avg_coverage
```

Now query for junctions and filter by sample type: Brain:

```
#now subfilter by sample tissue
#GTEx samples that are labeled with tissue type "Brain"
sb <- set_column_filters(sb, SMTS == "Brain")
cd99.jx.all <- query_jx(sb)
dim(cd99.jx.all)
```

```
## [1]  637 1409
```

```
head(cd99.jx.all)
```

```
## class: RangedSummarizedExperiment
## dim: 6 1409
## metadata(1): uri
## assays(1): counts
## rownames(6): 28340058 28341126 ... 28341507 28341508
## rowData names(12): DataSource:Type snaptron_id ... coverage_median
##   source_dataset_id
## colnames(1409): rail_50099 rail_50105 ... rail_59748 rail_59753
## colData names(322): rail_id Run ... junction_coverage
##   junction_avg_coverage
```

Same query/filter again but for exons:

```
cd99.exon <- query_exon(sb)
dim(cd99.exon)
```

```
## [1]   32 1409
```

```
head(cd99.exon)
```

```
## class: RangedSummarizedExperiment
## dim: 6 1409
## metadata(1): uri
## assays(1): counts
## rownames(6): 691 692 ... 695 696
## rowData names(12): DataSource:Type snaptron_id ... coverage_median
##   compilation_id
## colnames(1409): rail_50099 rail_50105 ... rail_59748 rail_59753
## colData names(322): rail_id Run ... junction_coverage
##   junction_avg_coverage
```

Now query junctions but further filter for only those which are fully annotated:

```
###Only query junctions which are fully annotated---both left and
#right splice sites are found together in one or more of the
#Snaptron sourced annotations
sb <- set_row_filters(sb, annotated == 1)
cd99.jx <- query_jx(sb)
dim(cd99.jx)
```

```
## [1]   23 1409
```

```
head(cd99.jx)
```

```
## class: RangedSummarizedExperiment
## dim: 6 1409
## metadata(1): uri
## assays(1): counts
## rownames(6): 28350154 28350172 ... 28350658 28350686
## rowData names(12): DataSource:Type snaptron_id ... coverage_median
##   source_dataset_id
## colnames(1409): rail_50099 rail_50105 ... rail_59748 rail_59753
## colData names(322): rail_id Run ... junction_coverage
##   junction_avg_coverage
```

Now check an example of the metadata stored in the RSE, InsertSize:

```
##Metadata is stored directly in the RSE object.
#For example the library insert size can be retrieved
#across all runs  in the RSE
head(cd99.jx.all$InsertSize)
```

```
## [1] 162 302 163 150 223 150
```

# 5 High level queries

“High-level” queries answer more complex questions about splicing patterns. Results of high level queries are data frames unless otherwise specified.

## 5.1 Percent spliced in (PSI)

PSI measures how often an exon is included in the surrounding transcript.
This query considers only the common case
where a cassette exon has two inclusion junctions (junctions that join the exon to its up- and downstream neighbors) and one exclusion junction (that goes between the neighbors while skipping the exon).
Normal PSI values range from 0 (never included) to 1 (always included).
The value -1 is returned for a
sample where either one or the other inclusion groups had 0 coverage or the total raw coverage
across groups was less than a specified minimum count (`min_count` defaults to 20).

```
#Build new query against GTEx
#left inclusion query
lq <- QueryBuilder(compilation="gtex", regions="chr19:45297955-45298142")
lq <- set_row_filters(lq, strand == "+")
lq <- set_coordinate_modifier(lq, Coordinates$Exact)
#right inclusion query
rq <- QueryBuilder(compilation="gtex", regions="chr19:45298223-45299810")
rq <- set_row_filters(rq, strand == "+")
rq <- set_coordinate_modifier(rq, Coordinates$Exact)
#exclusion query
ex <- QueryBuilder(compilation="gtex", regions="chr19:45297955-45299810")
ex <- set_row_filters(ex, strand == "+")
ex <- set_coordinate_modifier(ex, Coordinates$Exact)

psi <- percent_spliced_in(list(lq), list(rq), list(ex))
#order by psi descending
psi <- psi[order(-psi),]
head(psi)
```

```
##    sample_id inclusion_group1_coverage inclusion_group2_coverage
##        <num>                     <num>                     <num>
## 1:     50398                        21                        23
## 2:     50706                        31                        24
## 3:     51027                        35                        21
## 4:     51198                        52                        37
## 5:     51490                        18                        23
## 6:     52153                        30                        24
##    exclusion_group_coverage   psi
##                       <num> <num>
## 1:                        0     1
## 2:                        0     1
## 3:                        0     1
## 4:                        0     1
## 5:                        0     1
## 6:                        0     1
```

## 5.2 Junction Inclusion Ratio (JIR)

Junction Inclusion Ratio (JIR) measures the relative prevalence of two splicing patterns. It is similar to, but more general than the PSI query.
The query defines two sets of junctions to be compared. The sets may or may not have some junctions in common.
JIR ranges from -1.0 to 1.0, where 0 says that the total number of reads supporting the junctions in set A equals the number of reads supporting set-B junctions. JIR approaches 1 when there are many more reads supporting the set-B junctions compared to the set-A junctions. JIR approaches -1 when set-A junctions have many more supporting reads than set-B junctions.
The list of results is presented in descending order by JIR.

```
#groupA
A <- QueryBuilder(compilation="srav2", regions="chr2:29446395-30142858")
A <- set_row_filters(A, strand == "-")
A <- set_coordinate_modifier(A, Coordinates$Within)

#groupB
B <- QueryBuilder(compilation="srav2", regions="chr2:29416789-29446394")
B <- set_row_filters(B, strand == "-")
B <- set_coordinate_modifier(B, Coordinates$Within)

jir <- junction_inclusion_ratio(list(A),
                              list(B),
                              group_names=c("groupA","groupB"))
head(jir)
```

```
##    sample_id groupA_coverage groupB_coverage       jir
##        <num>           <num>           <num>     <num>
## 1:     46981               1              23 0.8800000
## 2:     45163               0               3 0.7500000
## 3:      6934               0               2 0.6666667
## 4:     29768               0               2 0.6666667
## 5:     42111               0               2 0.6666667
## 6:      2045               0               1 0.5000000
```

## 5.3 Shared Sample Count (SSC)

SSC reports the number of samples where one or more sets of junctions co-occur. We say two junctions co-occur in a sample of they both have at least one supporting read in that sample. The junctions in the set might describe a particular alternative splicing event, but they do not have to. The sets of junctions are defined using basic queries.

```
## We define the left/right splice junction supports of 3
#cassette exons for the following 3 genes:

## "left"/"right" is relative to the forward strand,
#reference genome coordinates,
#we use this terminology instead of 5' or 3'
#since the gene may be on the reverse strand.

###GNB1
GNB1l <- QueryBuilder(compilation="gtex", regions="chr1:1879786-1879786")
GNB1l <- set_row_filters(GNB1l, strand == "-")
GNB1l <- set_coordinate_modifier(GNB1l, Coordinates$EndIsExactOrWithin)

GNB1r <- QueryBuilder(compilation="gtex", regions="chr1:1879903-1879903")
GNB1r <- set_row_filters(GNB1r, strand == "-")
GNB1r <- set_coordinate_modifier(GNB1r, Coordinates$StartIsExactOrWithin)

###PIK3CD
PIK3l <- QueryBuilder(compilation="gtex", regions="chr1:9664595-9664595")
PIK3l <- set_row_filters(PIK3l, strand == "+")
PIK3l <- set_coordinate_modifier(PIK3l, Coordinates$EndIsExactOrWithin)

PIK3r <- QueryBuilder(compilation="gtex", regions="chr1:9664759-9664759")
PIK3r <- set_row_filters(PIK3r, strand == "+")
PIK3r <- set_coordinate_modifier(PIK3r, Coordinates$StartIsExactOrWithin)

###TAP2
T2l <- QueryBuilder(compilation="gtex", regions="chr6:32831148-32831148")
T2l <- set_row_filters(T2l, strand == "-")
T2l <- set_coordinate_modifier(T2l, Coordinates$EndIsExactOrWithin)

T2r <- QueryBuilder(compilation="gtex", regions="chr6:32831182-32831182")
T2r <- set_row_filters(T2r, strand == "-")
T2r <- set_coordinate_modifier(T2r, Coordinates$StartIsExactOrWithin)

ssc_func <- shared_sample_counts
ssc <- ssc_func(list(GNB1l, GNB1r),
              list(PIK3l, PIK3r),
              list(T2l, T2r),
              group_names=c("validated","not validated","validated"))
ssc
```

```
##            group counts
##           <char>  <int>
## 1:     validated   6244
## 2: not validated    723
## 3:     validated   2722
```

## 5.4 Tissue Specificity (TS)

This query asks if a particular set of junctions seems to be associated with tissue type.
This query defaults to using the `gtex` compilation, but it could work with any compilation having a `tissue` metadata field (e.g. `tcga`).

The main output is a list of all the samples in the compilation with either a 0 or a 1 in the *shared* column.
1 indicates that a junction from the query occurs in that sample (tissue type).

This output can be passed to a statistical test such as an F-test to assess the significance of tissue enrichment.

```
A <- QueryBuilder(compilation="gtex", regions="chr4:20763023-20763023")
A <- set_row_filters(A, strand == "-")
A <- set_coordinate_modifier(A, Coordinates$EndIsExactOrWithin)

ts <- tissue_specificity(list(A))
head(ts)
```

```
##    sample_id shared tissue  group
##        <int> <lgcl> <char> <char>
## 1:     50099   TRUE  Brain     g1
## 2:     50100  FALSE Testis     g1
## 3:     50101  FALSE  Heart     g1
## 4:     50102  FALSE  Nerve     g1
## 5:     50103  FALSE   Lung     g1
## 6:     50104  FALSE   Skin     g1
```

The TS function also supports more than one set of junctions.

The main output is a list of all the samples in the compilation with either a 0 or a 1 in the *shared* column.
1 here indicates that at least one junction from all sets occurred in that sample, i.e. the sample is shared across the results of all the junction queries.

A use case of the 2-set TS function is to measure the significance of tissue enrichment across junctions which support a cassette exon.

```
A <- QueryBuilder(compilation="gtex", regions="chr4:20763023-20763023")
A <- set_row_filters(A, strand == "-")
A <- set_coordinate_modifier(A, Coordinates$EndIsExactOrWithin)

B <- QueryBuilder(compilation="gtex", regions="chr4:20763098-20763098")
B <- set_row_filters(B, strand == "-")
B <- set_coordinate_modifier(B, Coordinates$StartIsExactOrWithin)

ts <- tissue_specificity(list(A, B))
head(ts)
```

```
##    sample_id shared tissue  group
##        <int> <lgcl> <char> <char>
## 1:     50099   TRUE  Brain     g1
## 2:     50100  FALSE Testis     g1
## 3:     50101  FALSE  Heart     g1
## 4:     50102  FALSE  Nerve     g1
## 5:     50103  FALSE   Lung     g1
## 6:     50104  FALSE   Skin     g1
```

## 5.5 Junction Union (Merge) and Intersection

The junction union query provides the ability to get a single RSE object of non-redundant junctions across multiple compilations which share a common reference (e.g. HG38).
Junctions which are the same (have the same chromosome coordinates and strand) are merged into a single row.

An example would be search for the same junctions across the human HG38-based compilations, GTEx and TCGA.
This can be used to efficiently leverage GTEx as a substitute “normal” control, while searching for splicing phenomena specific to the tumor samples in TCGA.

In the following example we query for all junctions that have a specific 5’ (donor) coordinate in both compilations, merging the results.
Note, this query, due to the number of samples involved (approximately 18,000) takes several seconds to complete.

```
gtex <- QueryBuilder(compilation="gtex", regions="chr1:1879786-1879786")
gtex <- set_row_filters(gtex, strand == "-")
gtex <- set_coordinate_modifier(gtex, Coordinates$EndIsExactOrWithin)

tcga <- QueryBuilder(compilation="tcga", regions="chr1:1879786-1879786")
tcga <- set_row_filters(tcga, strand == "-")
tcga <- set_coordinate_modifier(tcga, Coordinates$EndIsExactOrWithin)

gtex_tcga_union <- junction_union(gtex,tcga)
dim(gtex_tcga_union)
```

```
## [1]   103 18755
```

```
head(gtex_tcga_union)
```

```
## class: RangedSummarizedExperiment
## dim: 6 18755
## metadata(1): uri
## assays(1): counts
## rownames(6): 93197,130886 ,150181 ... ,170050 ,171092
## rowData names(12): DataSource:Type snaptron_id ... coverage_median
##   source_dataset_id
## colnames(18755): rail_50099 rail_50100 ... rail_71109 rail_71110
## colData names(1182): rail_id Run ... junction_coverage.y
##   junction_avg_coverage.y
```

The junction intersection query provides similar functionality but restricting the output RSE object to only those junctions found in both compilations.

Using the same scenario as above, but this time the result set will be reduced.

```
gtex <- QueryBuilder(compilation="gtex", regions="chr1:1879786-1879786")
gtex <- set_row_filters(gtex, strand == "-")
gtex <- set_coordinate_modifier(gtex, Coordinates$EndIsExactOrWithin)

tcga <- QueryBuilder(compilation="tcga", regions="chr1:1879786-1879786")
tcga <- set_row_filters(tcga, strand == "-")
tcga <- set_coordinate_modifier(tcga, Coordinates$EndIsExactOrWithin)

gtex_tcga_intersection <- junction_intersection(gtex,tcga)
dim(gtex_tcga_intersection)
```

```
## [1]    53 18755
```

```
head(gtex_tcga_intersection)
```

```
## class: RangedSummarizedExperiment
## dim: 6 18755
## metadata(1): uri
## assays(1): counts
## rownames(6): 93197,130886 124413,178993 ... 127265,183493 127460,183776
## rowData names(12): DataSource:Type snaptron_id ... coverage_median
##   source_dataset_id
## colnames(18755): rail_50099 rail_50100 ... rail_71109 rail_71110
## colData names(1182): rail_id Run ... junction_coverage.y
##   junction_avg_coverage.y
```