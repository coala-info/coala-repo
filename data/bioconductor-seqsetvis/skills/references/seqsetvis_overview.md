# The **seqsetvis** package

Joseph R Boyd

#### 23 February 2026

# 1 Synopsis

seq - set - vis

*[seqsetvis](https://github.com/jrboyd/seqsetvis)* enables the visualization and analysis of
multiple genomic datasets. Although seqsetvis was designed for the comparison
of mulitple ChIP-seq datasets, this package is domain-agnostic and allows the
processing of multiple genomic coordinate files (bed-like files) and signal
files (bigwig files).

*seqsetvis* is ideal for the following tasks:

1. Feature assessment and comparison.
2. Differential enrichment or expression results assessment.
3. Replicate comparison and reproducibility analysis.
4. Chromatin state inspection.
5. Clustering of histone modification and/or transcription factor enrichment
   at features such as promoters or enhancers.

*seqsetvis* accepts and outputs the Bioconductor standard GRanges object while
leveraging the power and speed of the *data.table* package (an enhancement of
data.frame) with the flexibility of *ggplot2* to provide users with
visualizations that are simultaneously publication ready while still being
highly customizable. By default, *data.table* is used entirely internally so
users unfamiliar with its use can safely ignore it. That said, fans of
*data.table* can use seqsetvis in a *data.table* exclusive mode if they wish.

# 2 Features

* Mostly it “just works” with minimal assumed knowledge of R or other
  Bioconductor packages.
* All plots produced are *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* objects.
  + easily customized according to user preferences by appending *ggplot2*
    functions.
  + powerful plot arrangement with with *[cowplot](https://CRAN.R-project.org/package%3Dcowplot)*,
    *[gridExtra](https://CRAN.R-project.org/package%3DgridExtra)*, etc.
* Although various plots are implemented, the underlying data are simple in
  structure and easily accessible so **you** can do what **you** want with them.
  + membership table for feature overlaps is just a logical matrix.
  + signal data is stored in a tidy formatted *[data.table](https://CRAN.R-project.org/package%3Ddata.table)*, ideal
    for *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* visualization.

Although initially designed to focus on peak call sets, *seqsetvis* accepts any
data in *GRanges* format and is therefore flexible enough to
work dowstream of many genomics tools and packages. Indeed, set comparison
visualizations are genomics agnostic and also accept generic data types defining
sets.

# 3 Functions

* `ssv*` - most primary user facing functions are prefixed by ssv
  + `ssvOverlapIntervalSets` - derives sets from a list of GRanges
  + `ssvMakeMembTable` - coerces various ways of defining sets to a membership
    table
  + `ssvFactorizeMembTable` - converts a multi column membership table into
    a single factor.
  + `ssvFetch*` - retrieves properly formatted data from .bigwig and .bam
    files
  + `ssvFeature*` - visualizations of set counts and overlaps
  + `ssvSignal*` - visualizations of signal mapped to genomic coordinates in
    sets context
* utility functions
  + `easyLoad_*` - loads files into a list of GRanges for input into `ssv*`
    functions
  + miscellaneous functions such as wrappers for
    data.table functions.

# 4 Installation and Loading

## 4.1 From Bioconductor

```
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("seqsetvis")
```

## 4.2 Load the library

```
library(seqsetvis)
```

## 4.3 Load optional useful libraries

```
library(GenomicRanges)
library(data.table)
library(cowplot)
theme_set(cowplot::theme_cowplot())
```

## 4.4 Load data

```
data(CTCF_in_10a_narrowPeak_grs)
data(CTCF_in_10a_overlaps_gr)
data(CTCF_in_10a_profiles_gr)
data(chromHMM_demo_state_colors)
data(chromHMM_demo_bw_states_gr)
data(chromHMM_demo_overlaps_gr)
data(chromHMM_demo_state_total_widths)
```

# 5 Defining sets

*seqsetvis* has several ways of accepting set information. Since *seqsetvis*
was originally intended to focus on comparing sets of peak calls, a list of
*GRanges* or a *GRangesList* is directly supported but there are more
generic alternatives.

## 5.1 Overlapping a list of *GRanges*

Many functions in *seqsetvis* require some kind of sets definition
as input. Sets can be defined in one of several ways.
`ssvOverlapIntervalSets()` creates a single *GRanges* from a list of *GRanges*
with a logical membership table as metadata columns defining sets.

```
olaps = ssvOverlapIntervalSets(CTCF_in_10a_narrowPeak_grs)
## Loading required namespace: GenomeInfoDb
head(olaps)
## GRanges object with 6 ranges and 3 metadata columns:
##     seqnames            ranges strand | MCF10A_CTCF MCF10AT1_CTCF MCF10CA1_CTCF
##        <Rle>         <IRanges>  <Rle> |   <logical>     <logical>     <logical>
##   1     chr1 17507898-17508319      * |       FALSE          TRUE         FALSE
##   2     chr1 40855546-40855866      * |        TRUE         FALSE         FALSE
##   3     chr1 53444333-53445008      * |        TRUE          TRUE          TRUE
##   4     chr1 64137020-64137657      * |        TRUE          TRUE          TRUE
##   5     chr1 65075339-65076014      * |        TRUE          TRUE         FALSE
##   6     chr1 92818291-92818802      * |        TRUE          TRUE          TRUE
##   -------
##   seqinfo: 21 sequences from an unspecified genome; no seqlengths
```

`ssvOverlapIntervalSets()` also accepts a *GRangesList* if that’s more natural.

```
olaps_fromGRangesList = ssvOverlapIntervalSets(
    GenomicRanges::GRangesList(CTCF_in_10a_narrowPeak_grs))
```

The membership data contained in the metadata columns of `olaps` is
the data structure *seqsetvis* set overlap functions use internally.
The S4 method `ssvMakeMembTable()` handles the necessary conversions and
can be extended
to accept a new class of data as long as it converts to an already accepted
data type and calls ssvMakeMembTable again.

For instance, `ssvMakeMembTable(olaps)` extracts the membership table from
the mcols of a single *GRanges* object.

```
head(ssvMakeMembTable(olaps))
##   MCF10A_CTCF MCF10AT1_CTCF MCF10CA1_CTCF
## 1       FALSE          TRUE         FALSE
## 2        TRUE         FALSE         FALSE
## 3        TRUE          TRUE          TRUE
## 4        TRUE          TRUE          TRUE
## 5        TRUE          TRUE         FALSE
## 6        TRUE          TRUE          TRUE
```

## 5.2 Overlapping a list of more generic data

`ssvMakeMembTable()` can handle sets defined by a list of vectors.
These happen to be numeric but nearly anything that `as.character()` works on
should be acceptable.

```
my_set_list = list(1:3, 2:3, 3:6)
ssvMakeMembTable(my_set_list)
##   set_A set_B set_C
## 1  TRUE FALSE FALSE
## 2  TRUE  TRUE FALSE
## 3  TRUE  TRUE  TRUE
## 4 FALSE FALSE  TRUE
## 5 FALSE FALSE  TRUE
## 6 FALSE FALSE  TRUE
```

Supplying a named list is recommended

```
names(my_set_list) = c("first", "second", "third")
ssvMakeMembTable(my_set_list)
##   first second third
## 1  TRUE  FALSE FALSE
## 2  TRUE   TRUE FALSE
## 3  TRUE   TRUE  TRUE
## 4 FALSE  FALSE  TRUE
## 5 FALSE  FALSE  TRUE
## 6 FALSE  FALSE  TRUE
```

A list of character vectors works just as well.

```
my_set_list_char = lapply(my_set_list, function(x)letters[x])
ssvMakeMembTable(my_set_list_char)
##   first second third
## a  TRUE  FALSE FALSE
## b  TRUE   TRUE FALSE
## c  TRUE   TRUE  TRUE
## d FALSE  FALSE  TRUE
## e FALSE  FALSE  TRUE
## f FALSE  FALSE  TRUE
```

Notice the rownames changed as the items changed.

# 6 Visualization of set overlaps, ssvFeature\*

The ssvFeature\* family of functions all accept a valid set definition and output
a ggplot.

## 6.1 Barplot

Barplots are useful for for conveying the size of each set/group.

```
ssvFeatureBars(olaps)
```

![](data:image/png;base64...)

## 6.2 Pie chart

Pie charts are an alternative to barplots but are generally more difficult to
interpret.

```
ssvFeaturePie(olaps)
```

![](data:image/png;base64...)

## 6.3 Venn diagram

Venn diagrams show the number of items falling into each overlap category.
At release, *seqsetvis* is limited to displaying 3 sets via venn diagram. This
will be increased in a future update.

```
ssvFeatureVenn(olaps)
```

![](data:image/png;base64...)

## 6.4 Euler diagram

Often confused with Venn diagrams, Euler diagrams attempt to convey the size
of each set and the degree to which the overlap with circles or ellipses of
varying sizes. For data of any appreciable complexity, Euler diagrams are
approximations by neccessity.

There is no hard limit to the number of sets *seqsetvis* can show in an Euler
diagram but computation time increases rapidly along with the inaccuracy of
approximation.

```
ssvFeatureEuler(olaps)
```

![](data:image/png;base64...)

## 6.5 Binary Heatmap

An alternative to Venn/Euler diagrams, this “heatmap” contains one column per
set and one row per item with item membership per set mapped to color.
In this example black indicates TRUE for membership hence the top 2/3 is black
for all three sets.

```
ssvFeatureBinaryHeatmap(olaps)
```

![](data:image/png;base64...)

# 7 Visualization of genomic signal, ssvSignal\*

The ssvSignal\* family of functions all take as input continuous signal data
mapped to the genome. This type of data is generally stored in bedGraph,
wiggle, or bigWig format. At this time, *seqsetvis* directly supports the
bigwig format and creating pileups from indexed .bam files.
This is accomplished via the `ssvFetchBigwig()` and
`ssvFetchBam()` functions.

If you don’t have .bigWig (or .bigwig or .bw) files you should be able to
easily generate some using *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* `export.bw()`
alongside `import.bedGraph()`
or `import.wig()` as appropriate.

## 7.1 Loading bigwig data

```
bigwig_files = c(
    system.file("extdata", "MCF10A_CTCF_FE_random100.bw",
                package = "seqsetvis"),
    system.file("extdata", "MCF10AT1_CTCF_FE_random100.bw",
                package = "seqsetvis"),
    system.file("extdata", "MCF10CA1_CTCF_FE_random100.bw",
                package = "seqsetvis")
)
names(bigwig_files) = sub("_FE_random100.bw", "", basename(bigwig_files))
# names(bigwig_files) = letters[1:3]
olap_gr = CTCF_in_10a_overlaps_gr
target_size = quantile(width(olap_gr), .75)
window_size = 50
target_size = round(target_size / window_size) * window_size
olap_gr = resize(olap_gr, target_size, fix = "center")
bw_gr = ssvFetchBigwig(bigwig_files, olap_gr, win_size = window_size)

bw_gr
```

```
olap_gr = CTCF_in_10a_overlaps_gr
bw_gr = CTCF_in_10a_profiles_gr
```

Overlap information must be transformed into a factor tied to id to be useful.

```
olap_groups = ssvFactorizeMembTable(mcols(olap_gr))
```

## 7.2 Line plots

Line plots are perhaps the most natural and common type of visualization for
this type of continuous genomic data. Many genome browsers and other BioC
packages support
this type of visualization. These other approaches are very good at show
lot’s of different data of multiple types at single regions. In contrast,
*seqsetvis* is focused on bringing in data from multiple regions simultaneously.

### 7.2.1 Individual line plots

Basic line plot of a subset of regions

```
# facet labels will display better if split into multiple lines
bw_gr$facet_label = sub("_", "\n", bw_gr$sample)
ssvSignalLineplot(bw_data = subset(bw_gr, id %in% 1:12), facet_ = "facet_label")
```

![](data:image/png;base64...)

Facetting by region id is less overwhelming

```
ssvSignalLineplot(bw_data = subset(bw_gr, id %in% 1:4), facet_ = "id")
```

![](data:image/png;base64...)

### 7.2.2 Aggregated line plots

Aggregate regions by mean

```
ssvSignalLineplotAgg(bw_data = bw_gr)
```

![](data:image/png;base64...)

Apply spline of 10 to make a prettier plot

```
ssvSignalLineplotAgg(bw_data = bw_gr, spline_n = 10)
```

![](data:image/png;base64...)

By adding some info to `bw_gr`, tweaking the group\_ parameter, and adding a
facet call we can apply the aggregation function by peak call set and plot them
separately.

```
# append set info, modify aggregation group_ and add facet
olap_2groups = ssvFactorizeMembTable(ssvMakeMembTable(olap_gr)[, 1:2])
grouped_gr = GRanges(merge(bw_gr, olap_2groups))
grouped_gr = subset(grouped_gr, sample %in% c("MCF10A_CTCF", "MCF10AT1_CTCF"))
ssvSignalLineplotAgg(bw_data = grouped_gr, spline_n = 10,
                     group_ = c("sample", "group")) +
    facet_wrap("group", ncol = 2) +
    labs(title = "Aggregated by peak call set", y = "FE", x = "bp from center")
```

![](data:image/png;base64...)

## 7.3 Scatterplot

Scatterplots are a common way of viewing the relationship between two variables.
*seqsetvis* allows users to easily apply a summary function (mean by default) to
each region as measured in two samples and plot them on the x and y axis.

A basic scatterplot

```
ssvSignalScatterplot(bw_gr, x_name = "MCF10A_CTCF", y_name = "MCF10AT1_CTCF")
```

![](data:image/png;base64...)

Using the result of `olap_groups = ssvFactorizeMembTable(olap_gr)` to add color
based on our peak calls.

```
ssvSignalScatterplot(bw_gr, x_name = "MCF10A_CTCF", y_name = "MCF10AT1_CTCF",
                     color_table = olap_groups)
```

![](data:image/png;base64...)

More than a few colors gets confusing quickly. Let’s limit the color groups to
the samples being plotted.

```
# by subsetting the matrix returned by ssvMakeMembTable() we have a lot of
# control over the coloring.
olap_2groups = ssvFactorizeMembTable(ssvMakeMembTable(olap_gr)[, 1:2])
ssvSignalScatterplot(bw_gr, x_name = "MCF10A_CTCF", y_name = "MCF10AT1_CTCF",
                     color_table = olap_2groups)
```

![](data:image/png;base64...)

Coloring by the third sample’s peak call might be interesting.

```
olap_OutGroups = ssvFactorizeMembTable(
    ssvMakeMembTable(olap_gr)[, 3, drop = FALSE])
ssvSignalScatterplot(bw_gr,
                     x_name = "MCF10A_CTCF",
                     y_name = "MCF10AT1_CTCF",
                     color_table = olap_OutGroups)
```

![](data:image/png;base64...)

We can also get clever with *ggplot2*’s facetting.

```
#tweaking group description will clean up plot labels a lot
olap_groups$group = gsub("_CTCF", "", olap_groups$group)
olap_groups$group = gsub(" & ", "\n", olap_groups$group)
ssvSignalScatterplot(bw_gr, x_name = "MCF10A_CTCF", y_name = "MCF10AT1_CTCF",
                     color_table = olap_groups) +
    facet_wrap("group") + guides(color = "none") +
    theme_linedraw()
```

![](data:image/png;base64...)

## 7.4 Banded quantiles

These quantile bands are a more sophisticated way to aggregate the same data
shown in the line plots.

```
ssvSignalBandedQuantiles(bw_gr, by_ = "sample", hsv_grayscale = TRUE,
                         hsv_symmetric = TRUE,
                         hsv_reverse = TRUE)
```

![](data:image/png;base64...)

## 7.5 Heatmap

Heatmaps combined with clustering are a powerful way to find similarly marked
regions of the genome. Calling ssvSignalHeatmap will perform k-means clustering
automatically. k-means clusters sorted by similarity as determined by
hierarchical clustering.

```
ssvSignalHeatmap(bw_gr, nclust = 3, facet_ = "facet_label")
```

![](data:image/png;base64...)

Performing clustering manually allows for use of cluster info.

```
bw_clust = ssvSignalClustering(bw_gr, nclust = 3)
## clustering...
bw_clust
## GRanges object with 4200 ranges and 6 metadata columns:
##          seqnames              ranges strand |       id         y         x
##             <Rle>           <IRanges>  <Rle> | <factor> <numeric> <numeric>
##      [1]     chr1   17507759-17507808      * |        1   1.10252      -325
##      [2]     chr1   17507809-17507858      * |        1   1.16055      -275
##      [3]     chr1   17507859-17507908      * |        1   2.12024      -225
##      [4]     chr1   17507909-17507958      * |        1   3.03194      -175
##      [5]     chr1   17507959-17508008      * |        1   9.86468      -125
##      ...      ...                 ...    ... .      ...       ...       ...
##   [4196]     chrX 138128377-138128426      * |      100   3.79769       125
##   [4197]     chrX 138128427-138128476      * |      100   1.79891       175
##   [4198]     chrX 138128477-138128526      * |      100   1.59903       225
##   [4199]     chrX 138128527-138128576      * |      100   2.19866       275
##   [4200]     chrX 138128577-138128626      * |      100   1.99878       325
##                 sample    facet_label cluster_id
##            <character>    <character>   <factor>
##      [1]   MCF10A_CTCF   MCF10A\nCTCF          2
##      [2]   MCF10A_CTCF   MCF10A\nCTCF          2
##      [3]   MCF10A_CTCF   MCF10A\nCTCF          2
##      [4]   MCF10A_CTCF   MCF10A\nCTCF          2
##      [5]   MCF10A_CTCF   MCF10A\nCTCF          2
##      ...           ...            ...        ...
##   [4196] MCF10CA1_CTCF MCF10CA1\nCTCF          2
##   [4197] MCF10CA1_CTCF MCF10CA1\nCTCF          2
##   [4198] MCF10CA1_CTCF MCF10CA1\nCTCF          2
##   [4199] MCF10CA1_CTCF MCF10CA1\nCTCF          2
##   [4200] MCF10CA1_CTCF MCF10CA1\nCTCF          2
##   -------
##   seqinfo: 21 sequences from an unspecified genome; no seqlengths
```

Cluster selection:

```
subset(bw_clust, cluster_id == 3)
## GRanges object with 1050 ranges and 6 metadata columns:
##          seqnames            ranges strand |       id         y         x
##             <Rle>         <IRanges>  <Rle> | <factor> <numeric> <numeric>
##      [1]     chr1 64136989-64137038      * |        4   1.80401      -325
##      [2]     chr1 64137039-64137088      * |        4   2.31943      -275
##      [3]     chr1 64137089-64137138      * |        4   5.06261      -225
##      [4]     chr1 64137139-64137188      * |        4  23.78540      -175
##      [5]     chr1 64137189-64137238      * |        4  42.46965      -125
##      ...      ...               ...    ... .      ...       ...       ...
##   [1046]     chrX 22748818-22748867      * |       99   5.79648       125
##   [1047]     chrX 22748868-22748917      * |       99   3.39793       175
##   [1048]     chrX 22748918-22748967      * |       99   2.20247       225
##   [1049]     chrX 22748968-22749017      * |       99   1.79891       275
##   [1050]     chrX 22749018-22749067      * |       99   1.39915       325
##                 sample    facet_label cluster_id
##            <character>    <character>   <factor>
##      [1]   MCF10A_CTCF   MCF10A\nCTCF          3
##      [2]   MCF10A_CTCF   MCF10A\nCTCF          3
##      [3]   MCF10A_CTCF   MCF10A\nCTCF          3
##      [4]   MCF10A_CTCF   MCF10A\nCTCF          3
##      [5]   MCF10A_CTCF   MCF10A\nCTCF          3
##      ...           ...            ...        ...
##   [1046] MCF10CA1_CTCF MCF10CA1\nCTCF          3
##   [1047] MCF10CA1_CTCF MCF10CA1\nCTCF          3
##   [1048] MCF10CA1_CTCF MCF10CA1\nCTCF          3
##   [1049] MCF10CA1_CTCF MCF10CA1\nCTCF          3
##   [1050] MCF10CA1_CTCF MCF10CA1\nCTCF          3
##   -------
##   seqinfo: 21 sequences from an unspecified genome; no seqlengths
```

Plotting and pre-clustering (identical to just calling heatmap with same
parameters)

```
ssvSignalHeatmap(bw_clust, facet_ = "facet_label")
```

![](data:image/png;base64...)

# 8 Use case : CTCF in breast cancer

This vignette runs using a small subset of datasets that are publicly available
via [GEO](https://www.ncbi.nlm.nih.gov/geo/). These data are fully described
in [GSE98551](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE98551) and
the associated paper:
[Intranuclear and higher-order chromatin organization of the major histone gene cluster in breast cancer](https://www.ncbi.nlm.nih.gov/pubmed/28504305)

In brief, the three cell lines MCF10A, MCF10A-at1, and MCF10A-CA1a are used as
a model of breast cancer progression from normal-like MCF10A to
metastatic MCF10A-CA1a. The ChIP-seq target CTCF is both a transcriptional
regulator and an insulator frequently associated with the boundaries of genomic
structural domains.
Therefore, regions where CTCF changes are interesting for follow-up to see if
they are also associated wtih regulatory or structural changes and perhaps
important to breast cancer progression.

To download the full dataset see: [narrowPeak from GEO](#np_load) and
[bigwig from GEO](#bw_load)

We’ll use *[cowplot](https://CRAN.R-project.org/package%3Dcowplot)* to arrange our plots in this section.

## 8.1 Setup

Set paths to bigwig files and narrowPeak files. There is some extra code here
to download the complete datasets using *BiocFileCache* **IF** the package
*BiocFileCache* is installed and `cache_path` already exists. If enabled, this
downloads ~3 GB of data.

```
pkgdata_path = system.file("extdata",
                           package = "seqsetvis")
cache_path = paste0(pkgdata_path, "/.cache")
# the next line is enough to initialize the cache
# BiocFileCache(cache = cache_path)
use_full_data = dir.exists(cache_path) & require(BiocFileCache)
## Loading required package: BiocFileCache
## Loading required package: dbplyr
use_full_data = FALSE
if(use_full_data){
    library(BiocFileCache)
    ssv_bfc = BiocFileCache(cache = cache_path)
    bw_files = vapply(seq_along(CTCF_in_10a_bigWig_urls), function(i){
        rname = paste(names(CTCF_in_10a_bigWig_urls)[i],
                      "bigwig",
                      sep = ",")
        fpath = CTCF_in_10a_bigWig_urls[i]
        #bfcrpath calls bfcadd() if necessary and returns file path
        bfcrpath(ssv_bfc, rname = rname, fpath = fpath)
    }, "char")
    names(bw_files) = names(CTCF_in_10a_bigWig_urls)

    np_files = vapply(seq_along(CTCF_in_10a_narrowPeak_urls), function(i){
        rname = paste(names(CTCF_in_10a_narrowPeak_urls)[i],
                      "narrowPeak",
                      sep = ",")
        fpath = CTCF_in_10a_narrowPeak_urls[i]
        #bfcrpath calls bfcadd() if necessary and returns file path
        bfcrpath(ssv_bfc, rname = rname, fpath = fpath)
    }, "a")
    names(np_files) = names(CTCF_in_10a_narrowPeak_urls)
}else{
    bw_files = vapply(c("MCF10A_CTCF", "MCF10AT1_CTCF", "MCF10CA1_CTCF"),
    function(x){
        system.file("extdata", paste0(x, "_FE_random100.bw"),
                    package = "seqsetvis")
    }, "char")
    # set filepaths
    np_files = c(
        system.file("extdata", "MCF10A_CTCF_random100.narrowPeak",
                    package = "seqsetvis"),
        system.file("extdata", "MCF10AT1_CTCF_random100.narrowPeak",
                    package = "seqsetvis"),
        system.file("extdata", "MCF10CA1_CTCF_random100.narrowPeak",
                    package = "seqsetvis")
    )

    names(np_files) = sub("_random100.narrowPeak", "",
                          x = basename(np_files))
}
```

## 8.2 Loading narrowPeak files as *GRanges*

```
# load peak calls
np_grs = easyLoad_narrowPeak(np_files)
```

Perform overlapping

```
olaps = ssvOverlapIntervalSets(np_grs)
```

## 8.3 Peak set desciption

Here we use a barplot (A) to convey the total number of peaks in each
cell line. The Venn diagram (B) shows precisely how many peaks are in each
overlap set. The Euler diagram (C) lacks the numerical precision (who could
say how many peaks are only present in MCF10AT1?) but the basic trends are
more obvious (MCF10A has the most peaks and the majority of peaks are common to
all 3 cell lines).

```
p_bars = ssvFeatureBars(olaps, show_counts = FALSE) +
    theme(legend.position = "left")
p_bars = p_bars + theme(axis.text.x = element_blank(),
                axis.ticks.x = element_blank(),
                legend.justification = "center") +
    labs(fill = "cell line")
p_venn = ssvFeatureVenn(olaps, counts_txt_size = 4) +
    guides(fill = "none", color = "none")
p_euler = ssvFeatureEuler(olaps) +
    guides(fill = "none", color = "none")

cowplot::ggdraw() +
    cowplot::draw_plot(p_bars, x = 0, y = 0, width = .4, height = .7) +
    cowplot::draw_plot(p_venn, x = .4, y = .1, width = .3, height = .7) +
    cowplot::draw_plot(p_euler, x = 0.7, y = .1, width = 0.3, height = .7) +
    cowplot::draw_plot_label(c("CTCF binding in breast cancer cell lines",
                               "A", "B", "C"),
                             x = c(.04, .17, 0.4, .7),
                             y = c(.92, .75, .75, .75), size = 10, hjust = 0)
```

![](data:image/png;base64...)

Plot colors can be modified via the ggplot objects without recalling plot
functions. (These colors aren’t better per se.)

```
col_vals = c("MCF10A_CTCF" = 'red',
             "MCF10AT1_CTCF" = "blue",
             "MCF10CA1_CTCF" = "green")
sf = scale_fill_manual(values = col_vals)
sc = scale_color_manual(values = col_vals)
cowplot::ggdraw() +
    cowplot::draw_plot(p_bars + sf,
                       x = 0, y = 0,
                       width = .4, height = .7) +
    cowplot::draw_plot(p_venn + sf + sc,
                       x = .4, y = .1,
                       width = .3, height = .7) +
    cowplot::draw_plot(p_euler + sf + sc,
                       x = 0.7, y = .1,
                       width = 0.3, height = .7) +
    cowplot::draw_plot_label(c("CTCF binding in breast cancer cell lines",
                               "A", "B", "C"),
                             x = c(.04, .17, 0.4, .7),
                             y = c(.92, .75, .75, .75), size = 10, hjust = 0)
```

## 8.4 Annotation with *ChIPpeakAnno*

By using an annotation package like *[ChIPpeakAnno](https://bioconductor.org/packages/3.22/ChIPpeakAnno)* we can
assign some biology to each peak.

```
library(ChIPpeakAnno)
data(TSS.human.GRCh38)
macs.anno <- annotatePeakInBatch(olaps, AnnotationData=TSS.human.GRCh38)
```

This gets us to easily selectable “gene lists” that everyone wants.

Apply a limit of 10 kb to reduce non-specific associations.

```
macs.anno = subset(macs.anno, distancetoFeature < 1000)
```

Gene ids associated with peaks present in MCF10A and MCF10AT1 but not
MCF10CA1.

```
subset(macs.anno, MCF10AT1_CTCF & MCF10A_CTCF & !MCF10CA1_CTCF)$feature
## [1] "ENSG00000124835" "ENSG00000186676" "ENSG00000254540" "ENSG00000260910"
## [5] "ENSG00000261419" "ENSG00000211534" "ENSG00000252163"
```

Gene ids associated with the peaks present in MCF10A and neither MCF10AT1 or
MCF10CA1.

```
subset(macs.anno, MCF10A_CTCF & !MCF10AT1_CTCF & !MCF10CA1_CTCF)$feature
##  [1] "ENSG00000143515" "ENSG00000150722" "ENSG00000237732" "ENSG00000250012"
##  [5] "ENSG00000223784" "ENSG00000251226" "ENSG00000089127" "ENSG00000230157"
##  [9] "ENSG00000184939" "ENSG00000261567"
```

With a meaningfully chosen set of substantial size we could then move on
to gene ontology or a gene set enrichment type of analysis.

… if we’re confident that this peak call is picking up real biological
differences. Let’s take a closer look at these peak calls in the next section.

## 8.5 Peak call validation

Digging into a new set of peak calls can be time-consuming and arbitrary. It’s
easy to spend a lot of time with a genome browser checking genes of interest or
peaks at random and not come away with a clear idea how you well your peak call
is performing.

*seqsetvis* is ideal for systematically assessing just what qualifies as a peak
in each sample of an experiment.

## 8.6 Loading bigwig data

Before loading bigwigs, we need to decide on a uniform region size to retrieve.
In this case we’ll use the 75th quantile of merged peak widths and round up to
the nearest multiple of window size. This is a bit arbitrary but a good fit in
practice. We’ll fully capture 75% of peak regions
and not be influenced by outliers.

This is the same procedure `ssvFetchBigwig()` uses to automatically
set a fixed width.

```
window_size = 50
width_q75 = quantile(width(olaps), .75)
width_q75 = ceiling(width_q75 / window_size) * window_size
hist_res = hist(width(olaps))
lines(rep(width_q75, 2), c(0, max(hist_res$counts)), col = "red", lwd = 5)
text(width_q75, max(hist_res$counts), "fixedSize", adj = c(-.1, 1), col = "red")
```

![](data:image/png;base64...)

```
## apply width
olaps_fixedSize = centerFixedSizeGRanges(olaps, width_q75)
```

### 8.6.1 Fetch profiles

Reading bigWig formatted files will not work at all on Windows OS.
If you are able to read bigwigs on your system,
there are few options.

Loading from the subsetted bigwigs inlcuded with *seqsetvis*.
This code chunk results in identical data to that stored in the
`CTCF_in_10a_profiles_gr` data object.

```
if(use_full_data){
    bw_gr = ssvFetchBigwig(file_paths = bw_files,
                                    qgr = olaps_fixedSize,
                                    win_size = 50)
}
```

## 8.7 Inspecting peaks

1. This scatterplot makes it clear that the peaks that looked unique to MCF10A
   have comparable fold-enrichment in MCF10AT1. This suggests that there may not
   be a meaningful biological difference between peaks that are present in MCF10A
   but absent in MCF10AT1.
2. Likewise for the comparison of MCF10A and MCF10CA1. In this case, there is a
   systematic reduction in fold-enrichment in CA1 compared to 10A. While it’s
   possible there’s some biology at play, it’s far more likely that the
   ChIP procedure for CA1 simply wasn’t as successful.

```
# shortening colnames will make group names less cumbersome in plot legend
colnames(mcols(olaps_fixedSize)) = sub("_CTCF", "",
                                       colnames(mcols(olaps_fixedSize)))

all_groups = levels(ssvFactorizeMembTable(
    ssvMakeMembTable(olaps_fixedSize))$group)
all_colors = RColorBrewer::brewer.pal(length(all_groups), "Set1")
all_colors[5:7] = safeBrew(3, "Dark2")
names(all_colors) = all_groups
olap_groups_12 = ssvFactorizeMembTable(
    ssvMakeMembTable(olaps_fixedSize)[, 1:2])
p_12 = ssvSignalScatterplot(bw_gr,
                            x_name = "MCF10A_CTCF",
                            y_name = "MCF10AT1_CTCF",
                            color_table = olap_groups_12) +
    scale_color_manual(values = all_colors)

olap_groups_13 = ssvFactorizeMembTable(
    ssvMakeMembTable(olaps_fixedSize)[, c(1,3)])
p_13  = ssvSignalScatterplot(bw_gr,
                             x_name = "MCF10A_CTCF",
                             y_name = "MCF10CA1_CTCF",
                     color_table = olap_groups_13) +
    scale_color_manual(values = all_colors)

if(use_full_data){
    tp_12 = p_12 + scale_size_continuous(range = .1) +
        scale_alpha_continuous(range = .1) +
        geom_density2d(aes(color = group), h = 40, bins = 3)
    tp_13 = p_13 + scale_size_continuous(range = .1) +
        scale_alpha_continuous(range = .1) +
        geom_density2d(aes(color = group), h = 40, bins = 3)
    cowplot::plot_grid(tp_12 + labs(title = ""),
                       tp_13 + labs(title = ""),
                       label_y = .85, labels = "AUTO")
}else{
    cowplot::plot_grid(p_12 + labs(title = ""),
                       p_13 + labs(title = ""),
                       label_y = .85, labels = "AUTO")
}
```

![](data:image/png;base64...)

These observations are reinforced by the heatmap.

```
bw_gr$facet_label = sub("_", "\n", bw_gr$sample)
clust_gr = ssvSignalClustering(bw_gr, nclust = 3, facet_ = "facet_label")
ssvSignalHeatmap(clust_gr, facet_ = "facet_label") + labs(fill = "FE",
                                  y = "region",
                                  x = "bp from center")
```

![](data:image/png;base64...)

The heatmap can be improved by using `centerAtMax()` to allow each region to
be shifted such that the maximum signal is at the center. A couple parameter
notes:
+ `view_size` controls how far each region can be shifted.
Shifting will cause overhangs which are trimmed by default so the resulting
regions are smaller. You may need to extened the origial query GRanges
set and repeat the fetch if the resulting regions are too small.
+ The `by_` parameter is particularly tricky. Its default value of “id”
is probably what we want. This causes each region to be individually shifted
according to the maximum across samples. One alternative,
`by_ = c("id", "sample")` would have shifted each region in each sample.
Another alternative, `by_ = ""` or `by_ = NULL` would shift every region in
every sample identically.

```
center_gr = centerAtMax(clust_gr, view_size = 150,
                        by_ = "id", check_by_dupes = FALSE)

p_center_hmap = ssvSignalHeatmap(center_gr, facet_ = "facet_label") +
    labs(fill = "FE",
         y = "region",
         x = "bp from center")

## since center_gr still retains clustering information, clustering is not
## repeated by default, the following reclusters the data.
clust_center_gr = ssvSignalClustering(center_gr, nclust = 3)
p_center_hmap_reclust = ssvSignalHeatmap(clust_center_gr,
                                         facet_ = "facet_label") +
    labs(fill = "FE",
         y = "region",
         x = "bp from center")
cowplot::plot_grid(p_center_hmap + labs(title = "original clustering"),
                   p_center_hmap_reclust + labs(title = "reclustered"))
```

![](data:image/png;base64...)

Cluster 1 and 2 seem to have the most robust enrichment. Let’s extract them
and annotate.

```
clust_df = as.data.frame(mcols(clust_gr))
clust_df = unique(clust_df[,c("id", "cluster_id")])

olap_clust_annot = olap_gr
mcols(olap_clust_annot) = data.frame(id = seq_along(olap_clust_annot))
olap_clust_annot = GRanges(merge(olap_clust_annot, clust_df))

olap_clust_annot = subset(olap_clust_annot, cluster_id %in% 1:2)

olap_clust_annot <- annotatePeakInBatch(olap_clust_annot,
                                        AnnotationData=TSS.human.GRCh38)
olap_clust_annot$feature
##  [1] "ENSG00000236253" "ENSG00000223949" "ENSG00000235804" "ENSG00000122406"
##  [5] "ENSG00000233473" "ENSG00000213088" "ENSG00000217327" "ENSG00000223884"
##  [9] "ENSG00000199687" "ENSG00000078098" "ENSG00000224132" "ENSG00000231304"
## [13] "ENSG00000235424" "ENSG00000201288" "ENSG00000272620" "ENSG00000272239"
## [17] "ENSG00000279496" "ENSG00000274541" "ENSG00000164483" "ENSG00000270638"
## [21] "ENSG00000196275" "ENSG00000135164" "ENSG00000261451" "ENSG00000165060"
## [25] "ENSG00000236060" "ENSG00000233933" "ENSG00000267026" "ENSG00000227482"
## [29] "ENSG00000254957" "ENSG00000254542" "ENSG00000255320" "ENSG00000254975"
## [33] "ENSG00000137474" "ENSG00000201788" "ENSG00000140319" "ENSG00000104093"
## [37] "ENSG00000240874" "ENSG00000199448" "ENSG00000264695" "ENSG00000276174"
## [41] "ENSG00000267187" "ENSG00000176641" "ENSG00000212224" "ENSG00000201021"
## [45] "ENSG00000101203" "ENSG00000128159" "ENSG00000277735"
```

# 9 Use case: ChromHMM inspection

In this demonstration we’ll use the same CTCF dataset in breast cancer but
bring in a chromHMM state file from an other dataset. This is meant to
highlight the flexibility of *seqsetvis*.

## 9.1 Setup

If the previous CTCF in breast cancer **Use Case** made use of *BiocFileCache*,
we’ll continue caching external data sources. If not, we’ll skip to a
pre-cooked version of the same data.

The pre-cooked version is quite a narrow slice and there’s a significant
amount of data manipulation

```
target_data = "MCF10A_CTCF"
chmm_win = 200 #window size is an important chromHMM parameter.
# 200 is the default window size and matches the state segementation

if(use_full_data){
    # set all file paths
    chmm_bw_file = bfcrpath(ssv_bfc, rnames = paste(target_data, "bigwig",
                                                    sep = ","))
    chmm_np_file = bfcrpath(ssv_bfc, rnames = paste(target_data, "narrowPeak",
                                                    sep = ","))
    chmm_seg_file = bfcrpath(ssv_bfc, rnames = "MCF7,segmentation",
                             fpath = chromHMM_demo_segmentation_url)

    query_chain = bfcquery(ssv_bfc, "hg19ToHg38,chain")
    if(nrow(query_chain) == 0){
        chain_hg19ToHg38_gz = bfcrpath(ssv_bfc, rnames = "hg19ToHg38,gz",
                                       fpath = chromHMM_demo_chain_url)
        ch_raw = readLines(gzfile(chain_hg19ToHg38_gz))
        ch_file = bfcnew(ssv_bfc, rname = "hg19ToHg38,chain")
        writeLines(ch_raw, con = ch_file)

    }
    chmm_chain_file = bfcrpath(ssv_bfc, rnames = "hg19ToHg38,chain")
    ch = rtracklayer::import.chain(chmm_chain_file)
    # load segmentation data
    chmm_gr = rtracklayer::import.bed(chmm_seg_file)
    #cleanup state names.
    chmm_gr$name = gsub("\\+", " and ", chmm_gr$name)
    chmm_gr$name = gsub("_", " ", chmm_gr$name)
    #setup color to state mapping
    colDF = unique(mcols(chmm_gr)[c("name", "itemRgb")])
    state_colors = colDF$itemRgb
    names(state_colors) = colDF$name
    #liftover states from hg19 to hg38
    ch = rtracklayer::import.chain(chmm_chain_file)
    chmm_gr_hg38 = rtracklayer::liftOver(chmm_gr, ch)
    chmm_gr_hg38 = unlist(chmm_gr_hg38)
    chmm_grs_list = as.list(GenomicRanges::split(chmm_gr_hg38,
                                                 chmm_gr_hg38$name))
    #transform narrowPeak ranges to summit positions
    chmm_np_grs = easyLoad_narrowPeak(chmm_np_file, file_names = target_data)
    chmm_summit_grs = lapply(chmm_np_grs, function(x){
        start(x) = start(x) + x$relSummit
        end(x) = start(x)
        x
    })
    qlist = append(chmm_summit_grs[1], chmm_grs_list)
    chmm_olaps = ssvOverlapIntervalSets(qlist, use_first = TRUE)
    #discard the columns for peak call and no_hit, not informative here.
    mcols(chmm_olaps)[[1]] = NULL
    chmm_olaps$no_hit = NULL
    #total width of genome assigned each state
    state_total_widths = sapply(chmm_grs_list, function(my_gr){
        sum(as.numeric(width(my_gr)))
    })
    #Expand state regions into 200 bp windows.
    state_wingrs = lapply(chmm_grs_list, function(my_gr){
        st = my_gr$name[1]
        wgr = unlist(slidingWindows(my_gr, chmm_win, chmm_win))
        wgr$state = st
        wgr
    })
    state_wingrs = unlist(GRangesList(state_wingrs))
    # fetch bw data for each state
    # it probably isn't useful to grab every single window for each state
    # so we can cap the number of each state carried forward
    max_per_state = 5000
    # flank size zooms out a bit from each chromHMM window
    flank_size = 400

    state_split = split(state_wingrs, state_wingrs$state)
    state_split = lapply(state_split, function(my_gr){
        samp_gr = sample(my_gr, min(length(my_gr), max_per_state))
        samp_gr = sort(samp_gr)
        names(samp_gr) = seq_along(samp_gr)
        samp_gr
    })
    state_gr = unlist(GRangesList(state_split))
    state_gr = resize(state_gr, width = chmm_win + 2 * flank_size,
                      fix = "center")

    bw_states_gr = ssvFetchBigwig(file_paths = chmm_bw_file,
                                       qgr = state_gr,
                                       win_size = 50)
    bw_states_gr$grp = sub("\\..+", "", bw_states_gr$id)
    bw_states_gr$grp_id = sub(".+\\.", "", bw_states_gr$id)
}else{
    max_per_state = 20
    flank_size = 400
    state_colors = chromHMM_demo_state_colors
    bw_states_gr = chromHMM_demo_bw_states_gr
    chmm_olaps = chromHMM_demo_overlaps_gr
    state_total_widths = chromHMM_demo_state_total_widths
}
```

## 9.2 Peak overlaps with states, counts

Create barplot of raw count of peaks overlapping states.

```
olaps_df = as.data.frame(mcols(chmm_olaps))
colnames(olaps_df) = gsub("\\.", " ", colnames(olaps_df))

p_state_raw_count = ssvFeatureBars(olaps_df, show_counts = FALSE) +
    labs(fill = "state", x = "") +
    scale_fill_manual(values = state_colors) +
    theme_cowplot() + guides(fill = "none") +
    theme(axis.text.x = element_text(angle = 90, size = 8,
                                     hjust = 1, vjust = .5))
p_state_raw_count
```

![](data:image/png;base64...)

## 9.3 Peak overlaps with states, enrichment

Create barplot of enrichment of peaks overlapping states.

```
state_width_fraction = state_total_widths / sum(state_total_widths)

state_peak_hits =  colSums(olaps_df)
state_peak_fraction = state_peak_hits / sum(state_peak_hits)

enrichment = state_peak_fraction /
    state_width_fraction[names(state_peak_fraction)]
enrich_df = data.frame(state = names(enrichment), enrichment = enrichment)
p_state_enrichment =  ggplot(enrich_df) +
    geom_bar(aes(x = state, fill = state, y = enrichment), stat = "identity") +
    labs(x = "") +
    theme_cowplot() + guides(fill = "none") +
    scale_fill_manual(values = state_colors) +
    theme(axis.text.x = element_text(angle = 90, size = 8,
                                     hjust = 1, vjust = .5))
p_state_enrichment
```

![](data:image/png;base64...)

## 9.4 Aggregated line plots by state

Plot aggregated line plot by state

```
p_agg_tracks = ssvSignalLineplotAgg(bw_states_gr,
                                    sample_ = "grp",
                                    color_ = "grp")
gb = ggplot2::ggplot_build(p_agg_tracks)
yrng = range(gb$data[[1]]$y)
p_agg_tracks = p_agg_tracks +
    scale_color_manual(values = state_colors) +
    annotate("line", x = rep(-chmm_win/2, 2), y = yrng) +
    annotate("line", x = rep(chmm_win/2, 2), y = yrng) +
    labs(y = "FE", x = "bp", color = "state",
         title = paste("Average FE by state,", target_data),
         subtitle = paste("states sampled to",
                          max_per_state,
                          chmm_win,
                          "bp windows each\n",
                          flank_size,
                          "bp flanking each side")) +
    theme(plot.title = element_text(hjust = 0))
p_agg_tracks
```

![](data:image/png;base64...)

## 9.5 States heatmap

A heatmap using the same data from the aggregated line plot. Facetting is
done on state and regions are sorted in decreasing order of signal at center.

```
pdt = as.data.table(mcols(bw_states_gr))
pdt$grp_id = as.integer(pdt$grp_id)
# reassign grp_id to sort within each state set
dt_list = lapply(unique(pdt$grp), function(state){
    dt = pdt[grp == state]
    dtmax = dt[, .(ymax = y[which(x == x[order(abs(x))][1])]), by = grp_id]
    dtmax = dtmax[order(ymax, decreasing = TRUE)]
    dtmax[, grp_o := seq_len(.N)]
    dtmax$ymax = NULL
    dt = merge(dtmax, dt)
    dt[, grp_id := grp_o]
    dt$grp_o = NULL
    dt
})
# reassemble
pdt = rbindlist(dt_list)
# heatmap facetted by state and sorted in decreasing order
p_state_hmap = ggplot(pdt) +
    geom_raster(aes(x = x, y = grp_id, fill = y)) +
    scale_y_reverse() +
    facet_wrap("grp", nrow = 2) +
    theme(axis.text.y = element_blank(),
          axis.ticks.y = element_blank(),
          axis.line.y = element_blank(),
          axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5),
          strip.text = element_text(size= 8)) +
    scale_fill_gradientn(colors = c("white", "orange", "red")) +
    labs(y = "", fill = "FE",
         x = "bp from local summit",
         title = paste(max_per_state, "random regions per state"))
p_state_hmap
```

![](data:image/png;base64...)

## 9.6 Figure assembly

Tie it all together into one figure with cowplot.

```
bar_height = .25
line_height = .3
ggdraw() +
    draw_plot(p_state_raw_count + guides(fill = "none"),
              x = 0,
              y = 1 - bar_height,
              width = .5,
              height = bar_height) +
    draw_plot(p_state_enrichment + guides(fill = "none"),
              x = .5,
              y = 1 - bar_height,
              width = .5,
              height = bar_height) +
    draw_plot(p_agg_tracks,
              x = 0,
              y = 1 - bar_height - line_height,
              width = 1,
              height = line_height) +
    draw_plot(p_state_hmap,
              x = 0,
              y = 0,
              width = 1,
              height = 1 - bar_height - line_height) +
    draw_plot_label(LETTERS[1:4],
                    c(0, 0.48, 0, 0),
                    c(1, 1, 1 - bar_height, 1 - bar_height - line_height),
                    size = 15)
```

![](data:image/png;base64...)