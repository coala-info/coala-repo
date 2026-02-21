# Introduction to wiggleplotr

#### Kaur Alasoo

#### 2025-10-30

* [Plotting other types of data](#plotting-other-types-of-data)
* [Extract transcript annotations automatically from Ensembl and UCSC annotations objects](#extract-transcript-annotations-automatically-from-ensembl-and-ucsc-annotations-objects)

*wiggleplotr* is a tool to visualise RNA-seq read overage accross annotated exons. A key feature of *wiggleplotr* is that it is able rescale all introns of a gene to fixed length, making it easier to see differences in read coverage between neighbouring exons that can otherwise be too far away. Since *wiggleplotr* takes standard BigWig files as input, it can also be used to visualise read overage from other sequencing-based assays such as ATAC-seq and ChIP-seq.

##Getting started To install *wiggleplotr*, start R and enter:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("wiggleplotr")
```

To run the code examples shown in this vignette, we need to load the following packages:

```
library("wiggleplotr")
library("dplyr")
library("GenomicRanges")
library("GenomicFeatures")
library("biomaRt")
```

##Visualizing transcript annotations First, the *plotTranscripts* function allows you to visualise the structucte of all transcripts of a gene (or multiple genes). It takes the following three inputs, but only the first one is required:

* `exons` - list of GRanges objects containing the start and end coordinates of exons for each transcript.
* `cdss` - list of GRanges objects containing the start and end coordinates of coding sequence (cds) for each transcript (optional).
* `annotations` - a data frame with at least the following three columns: transcript\_id, gene\_name and strand (optional).

To get you started, the *wiggleplotr* package comes with example annotations for the nine protein coding transcripts of the NCOA7 gene pre-loaded. Please see below to learn how to download those annotations from Ensembl on your own or how to extract them automatically from the *EnsDb* and *TxDb* objects. This is what the annotations look like:

```
ncoa7_metadata
```

```
## # A tibble: 9 × 4
##   transcript_id   gene_id         gene_name strand
##   <chr>           <chr>           <chr>      <int>
## 1 ENST00000368357 ENSG00000111912 NCOA7          1
## 2 ENST00000453302 ENSG00000111912 NCOA7          1
## 3 ENST00000417494 ENSG00000111912 NCOA7          1
## 4 ENST00000229634 ENSG00000111912 NCOA7          1
## 5 ENST00000428318 ENSG00000111912 NCOA7          1
## 6 ENST00000419660 ENSG00000111912 NCOA7          1
## 7 ENST00000438495 ENSG00000111912 NCOA7          1
## 8 ENST00000444128 ENSG00000111912 NCOA7          1
## 9 ENST00000392477 ENSG00000111912 NCOA7          1
```

```
names(ncoa7_exons)
```

```
## [1] "ENST00000368357" "ENST00000453302" "ENST00000417494" "ENST00000229634"
## [5] "ENST00000428318" "ENST00000419660" "ENST00000438495" "ENST00000444128"
## [9] "ENST00000392477"
```

```
names(ncoa7_cdss)
```

```
## [1] "ENST00000368357" "ENST00000453302" "ENST00000417494" "ENST00000229634"
## [5] "ENST00000428318" "ENST00000419660" "ENST00000438495" "ENST00000444128"
## [9] "ENST00000392477"
```

Now, to plot these nine transcripts, we simply use the *plotTranscripts* function:

```
plotTranscripts(ncoa7_exons, ncoa7_cdss, ncoa7_metadata, rescale_introns = FALSE)
```

```
## Warning: `select_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `select()` instead.
## ℹ The deprecated feature was likely used in the wiggleplotr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `arrange_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `arrange()` instead.
## ℹ See vignette('programming') for more help
## ℹ The deprecated feature was likely used in the wiggleplotr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `filter_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `filter()` instead.
## ℹ See vignette('programming') for more help
## ℹ The deprecated feature was likely used in the wiggleplotr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `group_by_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `group_by()` instead.
## ℹ See vignette('programming') for more help
## ℹ The deprecated feature was likely used in the wiggleplotr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the wiggleplotr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

You might have noticed that since NCOA7 gene has relatively long introns, it can be quite hard to see where all of the exons are. To focus on the exons, we can rescale all introns to a fixed length (50 bp by default):

```
plotTranscripts(ncoa7_exons, ncoa7_cdss, ncoa7_metadata, rescale_introns = TRUE)
```

![](data:image/png;base64...)

It is now much easier to see, which of the exons can be alternatively spliced and which are shared by all transcripts.

If you are constructing your own transcript annotations, you only need to specify the `exons` GRanges list for the code to work. In this case, the names of the list will be used as transcript labels on the plot.

```
plotTranscripts(ncoa7_exons, rescale_introns = TRUE)
```

![](data:image/png;base64...)

##Visualising RNA-seq read coverage We used the NCOA7 example above, because we discovered recently that this gene undergoes alternative promoter usage in human macrophages in response to lipopolysaccharide (LPS) stimulation [1](#fn1). We’ll now show how the *plotCoverage* function can be used to visualise RNA-seq read coverage accross the exons of a gene. In addition the the `exons`, `cdss` and `transcript_annotations` paramteres required by *plotTranscripts*, *plotCoverage* also requires a `track_data` data frame containing RNA-seq sample metadata as well as path to the read coverage data in BigWig format.

First, you need to create a data frame containing sample metadata. In our case we have four samples, two from the naive condition and two after LPS stimulation:

```
sample_data = dplyr::data_frame(
  sample_id = c("aipt_A", "aipt_C", "bima_A", "bima_C"),
  condition = factor(c("Naive", "LPS", "Naive", "LPS"), levels = c("Naive", "LPS")),
  scaling_factor = 1)
```

```
## Warning: `data_frame()` was deprecated in tibble 1.1.0.
## ℹ Please use `tibble()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
sample_data = sample_data %>%
  dplyr::mutate(bigWig = system.file("extdata", paste0(sample_id, ".str2.bw"),
                                     package = "wiggleplotr"))
as.data.frame(sample_data)
```

```
##   sample_id condition scaling_factor
## 1    aipt_A     Naive              1
## 2    aipt_C       LPS              1
## 3    bima_A     Naive              1
## 4    bima_C       LPS              1
##                                                                   bigWig
## 1 /tmp/RtmpnmfQhw/Rinst3e249f250ccf24/wiggleplotr/extdata/aipt_A.str2.bw
## 2 /tmp/RtmpnmfQhw/Rinst3e249f250ccf24/wiggleplotr/extdata/aipt_C.str2.bw
## 3 /tmp/RtmpnmfQhw/Rinst3e249f250ccf24/wiggleplotr/extdata/bima_A.str2.bw
## 4 /tmp/RtmpnmfQhw/Rinst3e249f250ccf24/wiggleplotr/extdata/bima_C.str2.bw
```

Finally, we need to add the `track_id` and `colour_group` columns that define which sample belongs to which track and what their colour should be. For simplicity, we first set both of these values equal to the the experimental condition:

```
track_data = dplyr::mutate(sample_data, track_id = condition, colour_group = condition)
```

Now, we can make our first read coverage plot

```
selected_transcripts = c("ENST00000438495", "ENST00000392477") #Plot only two transcripts of the gens
plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts],
             ncoa7_metadata, track_data,
             heights = c(2,1), fill_palette = getGenotypePalette())
```

```
## Warning: `mutate_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `mutate()` instead.
## ℹ See vignette('programming') for more help
## ℹ The deprecated feature was likely used in the wiggleplotr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `summarise_()` was deprecated in dplyr 0.7.0.
## ℹ Please use `summarise()` instead.
## ℹ The deprecated feature was likely used in the wiggleplotr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 2 rows containing non-finite outside the scale range
## (`stat_align()`).
```

![](data:image/png;base64...)

By default, *plotCoverage* plots the mean read coverage across all of the samples in the same colour group. However, it is also possible to overlay all of the individual samples by setting `mean_only = FALSE` and `alpha < 1`.

```
plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts],
             ncoa7_metadata, track_data,
             heights = c(2,1), fill_palette = getGenotypePalette(), mean_only = FALSE, alpha = 0.5)
```

```
## Warning: Removed 4 rows containing non-finite outside the scale range
## (`stat_align()`).
```

![](data:image/png;base64...)

It is clear from both plots that the short transcript skipping the first 11 exons of the gene is only expressed after LPS stimulation.

### Overlaying multiple conditions

Finally, we can overlay the two conditions in different colours by assigning all of the samples to a single track. This approach can we very useful for visualising eQTLs and splice QTLs. Setting `coverage_type = "line"` allows us to see both signals even if one overlaps the other:

```
track_data = dplyr::mutate(sample_data, track_id = "RNA-seq", colour_group = condition)
plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts],
            ncoa7_metadata, track_data,
             heights = c(2,1), fill_palette = getGenotypePalette(), coverage_type = "line")
```

![](data:image/png;base64...)

Unfortunately, it is currently not possible to automatically add legends to the read coverage plots. This is because *plotTranscripts* uses the *cowplot::plot\_grid* function to align the read coverage and transcript annotations plots and *plot\_grid* does not support legends.

## Plotting other types of data

Although *wiggleplotr* was initially written with RNA-seq data in mind, it can be used equally well to visualise any other sequencing data that can be summarised as read coverage in BigWig format (ATAC-seq, DNAse-seq, ChIP-seq). All you need to do is specify your own `exons`, `cdss`, `transcript_annotations` and `track_data` parameters. Furthermore, setting `connect_exons = FALSE` and `transcript_label = FALSE` makes it easier to plot other types of genomic annotations.

```
track_data = dplyr::mutate(sample_data, track_id = "RNA-seq", colour_group = condition)
plotCoverage(ncoa7_exons[selected_transcripts], ncoa7_cdss[selected_transcripts],
            ncoa7_metadata, track_data,
             heights = c(2,1), fill_palette = getGenotypePalette(), coverage_type = "line",
             connect_exons = FALSE, transcript_label = FALSE, rescale_introns = FALSE)
```

## Extract transcript annotations automatically from Ensembl and UCSC annotations objects

In addition specifying your own transcript annotations, *wiggleplotr* also provides four additional wrapper functions that can extract transcript annotations directly from *ensembldb* and *TxDb* (UCSC) objects. For *ensembldb*, you can use the *plotTranscriptsFromEnsembldb* and *plotCoverageFromEnsembldb* functions:

```
library("ensembldb")
library("EnsDb.Hsapiens.v86")
plotTranscriptsFromEnsembldb(EnsDb.Hsapiens.v86, gene_names = "NCOA7",
                             transcript_ids = c("ENST00000438495", "ENST00000392477"))
```

![](data:image/png;base64...)

For UCSC transcript annotations in TxDb objects, you can use the corresponding *plotTranscriptsFromUCSC* and *plotCoverageFromUCSC* functions:

```
#Load OrgDb and TxDb objects with UCSC gene annotations
require("org.Hs.eg.db")
require("TxDb.Hsapiens.UCSC.hg38.knownGene")
plotTranscriptsFromUCSC(orgdb = org.Hs.eg.db, txdb = TxDb.Hsapiens.UCSC.hg38.knownGene,
                        gene_names = "NCOA7", transcript_ids = c("ENST00000438495.6", "ENST00000368357.7"))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

![](data:image/png;base64...)

---

1. Alasoo, Kaur, et al. [“Transcriptional profiling of macrophages derived from monocytes and iPS cells identifies a conserved response to LPS and novel alternative transcription.”](http://www.nature.com/articles/srep12524) Scientific reports 5 (2015): 12524.[↩︎](#fnref1)