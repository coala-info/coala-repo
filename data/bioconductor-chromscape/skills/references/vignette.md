# ChromSCape

Pacome Prompsy, Pia Kirchmeier, Céline Vallot

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Quick Start](#quick-start)
* [3 ChromSCape step by step](#chromscape-step-by-step)
  + [3.1 Input files (before launching ChromSCape)](#input-files-before-launching-chromscape)
    - [3.1.1 Count matrices files](#count-matrices-files)
    - [3.1.2 Peak-Index-Barcode files](#peak-index-barcode-files)
    - [3.1.3 Single-cell BAM or BED files](#single-cell-bam-or-bed-files)
    - [3.1.4 Alignment BAM files for Peak Calling (**optional**)](#alignment-bam-files-for-peak-calling-optional)
  + [3.2 Create & import a dataset](#create-import-a-dataset)
    - [3.2.1 Summarizing features](#summarizing-features)
    - [3.2.2 Recognition of samples](#recognition-of-samples)
    - [3.2.3 Inputing BAM files](#inputing-bam-files)
  + [3.3 2. Filter, Normalize & Reduce Dimensionality](#filter-normalize-reduce-dimensionality)
  + [3.4 Visualize cells in reduced dimensions](#visualize-cells-in-reduced-dimensions)
  + [3.5 Cluster cells](#cluster-cells)
  + [3.6 Peak Calling to refine bins to gene annotation](#peak-calling-to-refine-bins-to-gene-annotation)
  + [3.7 Differential Analysis](#differential-analysis)
  + [3.8 Gene Sets Analysis](#gene-sets-analysis)
* [4 Datasets](#datasets)
* [5 Session information](#session-information)

# 1 Introduction

Chromatin modifications orchestrate the dynamic regulation of gene expression
during development and in disease. Bulk approaches have characterized the wide
repertoire of histone modifications across cell types, detailing their role in
shaping cell identity. However, these population-based methods do not capture
**cell-to-cell heterogeneity** of chromatin landscapes, limiting our
appreciation of the role of chromatin in dynamic biological processes. Recent
technological developments enable the mapping of histone marks at single-cell
resolution, opening up perspectives to characterize the heterogeneity of
chromatin marks in complex biological systems over time. Yet, existing tools
used to analyze bulk histone modifications profiles are not fit for the low
coverage and sparsity of single-cell epigenomic datasets.

![](data:image/png;base64...)

**ChromSCape Overview:**  The application takes as input various single-cell format and let the user filter & cluster cells, run differential analysis & gene set enrichment analysis between epigenomic subpopulations, in an unsupervised manner.

**ChromSCape** is a user-friendly interactive **Shiny/R application** that
processes single-cell epigenomic data to assist the biological interpretation of
chromatin landscapes within cell populations. **ChromSCape** analyses the
distribution of repressive and active histone modifications as well as chromatin
accessibility landscapes from single-cell datasets (*scATAC-seq, scChIP-seq,
scCUT&TAG…*).

The goal of **ChromSCape** is to provide user a interactive interface to explore
and run a **complete analyse** (*QC, preprocessing, analysis, interpretation*)
on various single-cell epigenomic data. The application has multiple advantages:

* No R knowledge is required
* Analyses persist on the user’s computer, allowing for fast reloading of the analysis
* Parameters are highly customizable
* Vizualisation at all steps
* Meant for multiple single cell epigenomic data
* Acceptance of raw files (BED, BAMs, .txt, …) for feature counting
* Linking epigenomics with biological interpretation with Gene Set Analysis

# 2 Quick Start

To launch the application simply run:

```
if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
}
BiocManager::install("ChromSCape")
```

Load **ChromSCape**

```
print("Loading ChromSCape")
```

```
## [1] "Loading ChromSCape"
```

```
library(ChromSCape)
```

Launch the shiny application

```
launchApp()
```

A browser should open with the application. If the browser doesn’t open
automatically, navigate to the displayed url, e.g. “*Listening on
<http://127.0.0.1:5139>*”. The first time you’ll open the application, you will be
guided through a small tour of the application, that you can come back to any
time you like by clicking the **Help** button on the upper right corner.

# 3 ChromSCape step by step

The user interface is organized by ‘Tab’ corresponding to specific ‘step’ of the
analysis. In order to be able to access to each Tab you need to complete the
previous steps. For example, before accessing the ‘Filter & Normalize’ Tab, you
need to first complete the ‘Select & Import’ Tab.

> ChromSCape\_analyses/

The raw data is stored at the root of the folder, and at each main step
(‘Filtering & Normalization’, ‘Correlation Clustering’ and ‘Differential
Analysis’) the objects are saved. This enable you to close the application and
later re-load your analysis without the need of re-doing all those steps. This
also enable you to share your analysis with colleagues simply by copying your
Analysis folder.
*Note:* The (…) in the saved objects contained the values of the parameters
for an Analysis. If you try multiple parameter, each results will be saved this
way and all trials will accessible in the future.

## 3.1 Input files (before launching ChromSCape)

Various existing technologies allow to produce single-cell genome-wide epigenomic
datasets :

* scChIP-seq (Grosselin et al., 2019) scCUT&Tag (Kaya-Okur et al., 2019),
  scChIL-seq (Harada et al., 2019), scChIC-seq (Ku et al.,) reveal the
  distribution of histone marks (H3K27me3, H3K4me3) or transcription factors (RNA
  Polymerase 2,…) with single-cell resolution.
* scATAC-seq (Buenorostro et al., 2015) or sciATAC-seq (Cusanovitch et al.,

2016. assess regions of open chromatin in single-cells

* scDNA methylation profiling, scRRBS, scWGBS …

After sequencing a single-cell epigenomic experiment, the raw sequencing files
(.fastq) are demultiplexed, aligned against a reference genome to output
different kind of data depending on the technology. ChromSCape allows user to
input a variety of different format. Depending on the output of the
data-engineering/pre-processing pipeline used, the signal can be already
*summarized into features* (**Count matrix**, **Peak-Index-Barcode** files) or
stored directly in *raw format* (**single-cell BAM** or **single-cell BED**
files).

Anyhow the format, ChromSCape needs signal to be summarized into features.
If inputting *raw signal* (**scBAM** or **scBED**), the application lets user
summarize signal of each cells into various features:

* **Genomic features** (extended region around TSS of genes, enhancers)
* **Peaks** called on bulk or single-cell signal (BED file must be provided by
  the user)
* **Genomic bins** (windows of constant length, e.g. 100kbp, 50kbp, 5kbp…)

Note that summarizing will take longer if using BAM files than BED files, and
if the number of features is important (e.g. 5kbp bins, enhancers…).

### 3.1.1 Count matrices files

Each sample should be contained into single-cell count matrix (features x cells)
in tab-separated format (extension .txt or .tsv) or comma-separated format
(.csv). The first column is genomic location in standard format (chr:start-end)
and the next columns are reads counted in each cells in the corresponding
genomic feature. Note that the first entry (row 1, column 1) must be empty. All
files should be placed in the same folder.

An example of such dataset is availablefor H3K27me3 mouse scChIP-seq of paired
PDX samples at: [PDX mouse cells H3K27me3 scChIP-seq matrices](https://ndownloader.figshare.com/files/22629317).

> BC969404 BC893525 BC239068 BC073314
> chr10:0-50000 0 0 0 0
> chr10:50000-100000 0 0 0 0
> chr10:100000-150000 0 0 0 0
> …

### 3.1.2 Peak-Index-Barcode files

This format regroups three files containing signal of all samples of one or
multiple experiment:

* The **barcode file** contains one cell barcode per line and finish by
  ’\_barcode.txt’ :

> HBCx95\_BC969404
> HBCx95\_BC893525
> HBCx22\_BC239068
> HBCx22\_BC073314
> …

* The **peak file** contains feature location (usually peaks) must be in BED
  format and finish by ’\_peaks.bed’:

> chr3 197959001 197961500
> chr3 198080001 198081500
> chr4 53001 55500
> …

* The **index file** contains indexes of non-zero signal and finish by
  ’\_indexes.txt’, the first column is the index of peaks, the second column
  contains barcode index, the last column contains the signal:

> 459 1 1
> 461 1 1
> 556 1 2

### 3.1.3 Single-cell BAM or BED files

Each BAM or BED (.bed or .bed.gz) file must be grouping signal of a single-cell,
and all files must be placed in the same folder. The signal will be summarized
into either bins, peaks, or around gene TSS depending on user choice.

An example of such dataset is publicly available for H3K27me3 single-cell CUT&TAG
(Kaya-Okur et al., 2019) K562 and H1 cells at: [K562 H3K27me3 cells](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE124680&format=file)
and [K562 + H1 H3K27me3 cells](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE129119&format=file).
All files need to be placed in the same folders, the BED files do not need to be
unzipped.

### 3.1.4 Alignment BAM files for Peak Calling (**optional**)

For the optional step of Peak Calling on cluster of cells found de novo, users
have to input one BAM file per sample, placed in the same folder. The barcode
information of each read should be contained in a specific tag (XB, CB..) and
correspond to the column names of the corresponding count matrix.

> samtools view example\_matrix.bam | head
> NS500388:436:HNG5VAFXX:2:21311:26430:3816 89 chr10 3102405 255 51M \* 0 0 CTTGGTGTCTAGTGGATCTGCTGCAGTCTTCTGTTGTCAGTGCTAAATCAC EEEEE/E6EEEAEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEAAAAA NH:i:1 HI:i:1 AS:i:50 nM:i:0 XS:i:2147483647 XD:Z:GATGACAAAG XB:Z:BC969404
> …

## 3.2 Create & import a dataset

Once you have launched the application, you arrive on the “**Select & Import**”.
Here you can selet an output directory, where your analyses will be saved.
ChromSCape will automatically save the folder’s location so that you don’t have
to select it each time you connect.

You must then name your analysis. The name shouldn’t contain special characters
(except ’\_‘). Choose either the Human (hg38) or Mouse (mm10) genome. This is
used to annotate your features with the closest genes TSS for the Gene Set
Analysis. Browse your computer for one or multiple matrices that will be
analyzed together. To select multiple matrices, they must be placed in the same
folder and then the user can select multiples matrices with (Shift + Click) or
(Ctrl + Click). Finally, clicking on ’Create Analysis’ will create an analysis
& import the count matrices in this analysis. This will create a folder named
‘*ChromSCape\_analyses*’ in the output directory you specified, inside which
another folder ‘Your\_analysis\_name’ is nested. If you create another analysis,
it will also be created under ‘*ChromSCape\_analyses*’. If you already created an
analysis in a previous section, selecting the same output directory as you chose
in the previous session will enable you to load your analysis.

![](data:image/png;base64...)

**Select & Import Tab:**  Select an output directory, Create an analysis or load previous analyses, import count matrix into your new analysis.

![](data:image/png;base64...)

Select an type of format input, and eventually a type of feature to summarize signal.

### 3.2.1 Summarizing features

Depending on what kind of data you are analyzing, you might want to summarized
your data on different features. For open/active chromatin measures, such as
ATAC or ChIP against H3K4me3, we recommand to summarize signal into small bins
of 5kbp to 10kbp or to count aroung gene TSS. When counting around gene TSS, the
default is to take overlapping regions of 2,500bp around the gene TSS, but you
might want to increase this value for scATAC-seq if looking to retrieve
enhancers open regions. For repressive marks such as H3K27me3, we recommand
summarizing into large bins of 50kbp to 100kbp, as those mark are known to
accumulate into large domains.

### 3.2.2 Recognition of samples

ChromSCape will recognize automatically to which sample/condition each cell
belongs. In order to do so, the names of the cells (e.g. names of the files for
scBED/scBAM or barcodes names for combined Index-Peaks-Barcode/count matrix)
should explicitely contains name of the samples/conditions.

Example: if inputing two cell types, e.g. Jurkat and Ramos, names of the
files/cells should be something like : Jurkat\_cell1.BED, Jurkat\_cell2.BED, …,
Ramos\_cell1.BED, Ramos\_cell2.BED.

The more different the names of the samples/conditions are, the more easily
ChromSCape will classify correctly each cell. If having two samples with a
similar name, users should manually change the names of the label. For example
if having ‘CMP’ (common myeloid progenitors) and ‘GMP’ (granulocytes myeloid
progenitors) samples, change the name manually to ‘commonMP’ and
‘granulocytesMP’ respectively.

### 3.2.3 Inputing BAM files

Inputting BAM files is the most demanding task in terms of ressource in the
application, despite the fact that the summarizing of features will take place
in parallel. To give an example, for 1,287 single-cell BAM files, summarizing
into 50kbp bins takes 9 minutes to finish. Counting from BED files is way
faster, therefore if analyzing lots of cells in BAM format, users might consider
running ‘bamToBed’ command from BEDTools on each file beforehand.

## 3.3 2. Filter, Normalize & Reduce Dimensionality

In order to efficiently remove outlier cells from the analysis, e.g. cells with
excessively high or low coverage, the user sets a threshold on a minimum read
count per cell and the upper percentile of cells to remove. The latter could
correspond to doublets, e.g. two cells in one droplet, while lowly covered cells
are not informative enough or may correspond to barcodes ligated to contaminant
DNA or library artifacts. Regions not supported by a minimum user-defined
percentage of cells that have a coverage greater than 1,000 reads are filtered
out.

Defaults parameters were chosen based on the analysis of multiple scChIP-seq
datasets:

* A minimum coverage of 1,600 unique reads per cell
* Filtering out the cells with the top 5% coverage
* Keeping regions detected in at least 1 % of cells.

Post quality control filtering, the matrices are normalized by total read count
and region size
([CPM normalization](https://haroldpimentel.wordpress.com/2014/05/08/what-the-fpkm-a-review-rna-seq-expression-units/).
At this step, the user can provide a list of genomic regions, in BED format, to
exclude from the subsequent analysis, in cases of known copy number variation
regions between cells for example.

To reduce the dimensions of the normalized matrix for further analysis, PCA is
applied to the matrix, with centering, and the 50 first PCs are kept for further
analysis.

If you want to run t-SNE for vizualisation in addition to PC and UMAP, tick the
‘Run T-SNE’ checkbox. This might take some time to run, depending on the size of
the dataset.

For some large datasets (e.g. more than 15,000 cells) or unbalance datasets
(i.e. number of cells per sample is very different), it might be a good option
to first run with the subsampling option. To do so, tick the ‘Perform
subsampling’ and select the maximum number of cells to subsample from each
sample. The sampling is done without replacement.

Users might want to remove specific loci from the analysis, e.g. repeat regions,
known Copy Number Altered regions that might bias the analysis. To do so, tick
the ‘Exclude specific genomic regions’ and browse for a BED file containing the
regions to exclude.

A batch correction option using mutual nearest neighbors ‘FastMNN’ function from
[batchelor](https://www.bioconductor.org/packages/release/bioc/html/batchelor.html)
is implemented to remove any known batch effect in the reduced feature space. To
do so, tick the ‘Perform batch correction’, select the number of batches and add
each sample to a batch.

![](data:image/png;base64...)

**Filter, Normalize & Reduce Tab:**  Adjust paramters to filter out low covered cells & features, as well as too highly covered cells that might be potential doublets. Normalize & Reduce dimensionality using PCA.

## 3.4 Visualize cells in reduced dimensions

The user can visualize the data after quality control in the PCA , t-SNE or UMAP
reduced dimensional space. The PCA and t-SNE plots are a convenient way to check
if cells form clusters in a way that was expected before any clustering method
is applied. For instance, the user should verify whether the QC filtering steps
and normalization procedure were efficient by checking the distribution of cells
in PC1 and PC2 space. Cells should group independently of normalized coverage.

Depending on wether you have ticked the ‘Run T-SNE’ checkbox in the previous
Tab, you will see the T-SNE two dimensional plot.

*Note:* You can change the colors of each samples, batch or cluster and the
saved colors will be saved in the Analysis.

![](data:image/png;base64...)

**Visualize Cells:**  Visualize cells in reduced dimensions: PCA, UMAP & TSNE. Color cells by sample, batch, or total count to make sure cells are not separating due to library size only.

A brief understanding into what features drives the main PCs is shown in the
‘Contribution to PCA’ box.

* In the barplot, you will get the top loci / closest genes associated to the top loci contributing to the Component of your choice. The top contributing features are taken by sorting the values of the features in the componenent of intereset (e.g. PC1, PC2…). If you observe a huge gap between the top 2-3 features and the rest, this means that very few features are driving most of the dimensionality reduction, and that other less contributing features might be hidden. This also gives you interesting features to look at in the Peak Calling & Coverage or Differential Analysis tabs.
* In the pie chart, the chromosome repartition of the top 100 most contributing features to the componenent of interest (e.g. PC1, PC2…) are displayed. This is used to see if there is any strong imbalance in the “chromosome contribution”, e.g. if a chromosome is contributing more than it should be. Usually, if a single chromosome has > 30% representation, this might indicate that CNVs or genetic events are happening on this chromosome, and you might want to look into more details at these events, or exclude them from the analysis (see Filter & Normalize tab)

![](data:image/png;base64...)

**Most contributing features**

## 3.5 Cluster cells

Using the first 50 first PCs of computed PCA as input, hierarchical clustering
is performed, taking 1-Pearson’s correlation score as distance metric. The cell
to cell correlation heatmap and dendogram describing the hierarchical clustering
is represented in the left panel.

To improve the stability of the clustering approaches and to remove from the
analysis isolated cells that do not belong to any subgroup, cells displaying a
Pearson’s pairwise correlation score below a threshold t with at least p % of
cells can be filtered out. The correlation threshold t is calculated as a
user-defined percentile of Pearson’s pairwise correlation scores for a
randomized dataset (percentile is recommended to be set as the 99th percentile).
To do so, open the “Filter lowly correlated cells” panel and click on “Filter &
Save”. This will filter any cells that are too rare to correlate with enough
other cells and form stable clusters.

To select a number of clusters, looking at the correlation heatmap and
dendogram, choose a number in the ‘Select Cluster Number’ panel and click on
‘Choose Cluster’.

If you are unsure of how many cluster to choose, you can run consensus
clustering using Bioconductor’s package
[ConsensusClusterPlus](https://www.bioconductor.org/packages/release/bioc/html/ConsensusClusterPlus.html)
package to determine what is the appropriate k-partition of the dataset into k
clusters. To do so, it evaluates the stability of the clusters and computes item
consensus score for each cell for each possible partition from k=2 to n. For
each k, consensus partitions of the dataset are done on the basis of 1,000
resampling iterations (80% of cells sampled at each iteration) of hierarchical
clustering, with Pearson’s dissimilarity as the distance metric and Ward’s
method for linkage analysis. The optimal number of clusters is then chosen by
the user; one option is to maximize intra-cluster correlation scores based on
the graphics displayed on the ‘Consensus Clustering’ Tab after processing.

If you ran consensus clustering, re-pick the cluster numbers in the ‘Select
Cluster Number’ panel making sure you check the ‘Use consensus’ checkbox and
re-click on ‘Choose Cluster’.

Cell clusters can then be visualized in two dimensions with the t-SNE or UMAP
plot.

*Note:* The correlation filtering and consensus clustering steps are optional as
they need long runtime. You might want to proceed to Differential Analysis and
Gene Set Analysis directly if you are confident in your choice of clusters.

![](data:image/png;base64...)

**Cluster Cells:**  Choose a number of cluster if you have clear clusters of cells, or run consensus clustering to test multiple clustering and find the optimal cluster number. Optionally filter out lowly correlated cells that might impact the clustering performance.

![    Cluster Cells - results:  Cluster visualization with UMAP.](data:image/png;base64...)
## Inter & Intra correlation violin plots

---

In this box, the heterogeneity of cells in various groups (e.g. sample or
cluster) are displayed with two plots:

* In the intra-correlation plot, the distribution of cell-to-cell Pearson
  correlation scores **within** each cluster or sample is displayed. Heterogeneous
  groups will have lower correlation than homogeneous groups.
* In the inter-correlation plot, the distribution of cell-to-cell Pearson
  correlation scores **between** each cluster or sample is displayed. This allows to
  understand which groups are closer to each other than other groups.

For both plots, you can add a layer of information by adding the single-cell
as jitter points on the plots. This is interesting when combining samples and
clusters to see the repartition of conditions into the clusters.

![](data:image/png;base64...)

**Inter/Intra correlation**

## 3.6 Peak Calling to refine bins to gene annotation

This step of the analysis is optional, but recommended for Gene Set Analysis if
working on genomic bins in order to refine the peak annotation prior to
enrichment analysis. To be able to run this module, some additional command line
tools are required such as SAMtools, BEDTools and MACS2. Therefore, this step is
only available for Linux and MacOS systems.

You need to input BAM files for the samples (one separate BAM file per sample),
with each read being labeled with the barcode ID in the ‘XB’ tag. ChromSCape
merges all files and splits them again according to the previously determined
clusters of cells (one separate BAM file per cluster). To do so, place all your
BAM files in a folder and click on the ‘Choose a folder containing the BAM
files’ button to browse for your folder. If some of the BAM files in the folder
are not part of your analyis, remove them by pressing the write box and deleting
them.

You can select significance threshold for peak detection (passed to MACS2) and
merging distance for peaks (defaults to p-value=0.05 and peak merge distance to
5,000). This allows to identify peaks in close proximity (<1,000bp) to a gene
transcription start site (TSS); these genes will be later used as input for the
enrichment analysis.

![](data:image/png;base64...)

**Peak Calling to refine bins to gene annotation:**  Call peaks on ‘pseudo-bulk’ cell clusters, and refine bins to genes annotation.

## 3.7 Differential Analysis

To identify differentially enriched regions across single-cells for a given
cluster, ChromSCape can perform
1. A non-parametric two-sided Wilcoxon rank sum test comparing normalized counts
from individual cells from one cluster versus all other cells, or cluster of
choice,
2. Or a parametric test comparing raw counts from individual cells, using the
Bioconductor package
[edgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html), based
on the assumption that the data follows a negative-binomial distribution. We
test for the null hypothesis that the distribution of normalized counts from the
two compared groups have the same median, with a confidence interval 0.95. The
calculated p-values are then corrected by the Benjamini-Hocheberg procedure. You
can modify the log2 fold-change threshold and corrected p-value threshold for
regions to be considered as significantly differentially enriched (default
settings are a p-value and log2 fold-change thresholds respectively of 0.01 and
1).

If you have specified batches to correct for batch effect, the differential
analysis is done using the ‘pairwiseWilcox’ function from the Bioconductor
package [scran](https://bioconductor.org/packages/release/bioc/html/scran.html)
, setting the batch of origin as a ‘blocking level’ for each cell.

![](data:image/png;base64...)

**Differential Analysis:**  Identify most differential features between the various cell clusters

## 3.8 Gene Sets Analysis

In this tab, using the refined annotation of peaks if available, the final step
is to look for enriched gene sets of the MSigDB v5 database within
differentially enriched regions (either enriched or depleted regions in the
studied histone mark). Click on ‘Start Enrichment Analysis’ in order to apply
hypergeometric tests to identify gene sets from the MSigDB v5 database
over-represented within differentially enriched regions, correcting for multiple
testing with the Benjamini-Hochberg procedure. Users can then visualize most
significantly enriched or depleted gene sets corresponding to the epigenetic
signatures of each cluster and download gene sets enrichment tables.

The top 100 most significant differential regions, single-cell Epigenomic
enrichment levels can be visualized overlaying read counts for each cell at
selected genes onto a t-SNE plot (right panel).

![](data:image/png;base64...)

**Gene Set Analysis:**  Look for pathways activated or depleted in most differential regions between clusters

# 4 Datasets

Try out ChromSCape with various kind of dataset :
[Dropbox repository](https://www.dropbox.com/sh/vk7umx3ksgoez3x/AACEq9zn-rRbtwf_Al9uEUaQa?dl=0)

# 5 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ChromSCape_1.20.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] later_1.4.4                 batchelor_1.26.0
##   [3] BiocIO_1.20.0               bitops_1.0-9
##   [5] matrixTests_0.2.3.1         tibble_3.3.0
##   [7] XML_3.99-0.19               gggenes_0.5.1
##   [9] lifecycle_1.0.4             edgeR_4.8.0
##  [11] lattice_0.22-7              magrittr_2.0.4
##  [13] limma_3.66.0                plotly_4.11.0
##  [15] sass_0.4.10                 rmarkdown_2.30
##  [17] jquerylib_0.1.4             yaml_2.3.10
##  [19] rlist_0.4.6.2               metapod_1.18.0
##  [21] httpuv_1.6.16               otel_0.2.0
##  [23] askpass_1.2.1               reticulate_1.44.0
##  [25] RColorBrewer_1.1-3          ConsensusClusterPlus_1.74.0
##  [27] ResidualMatrix_1.20.0       abind_1.4-8
##  [29] Rtsne_0.17                  GenomicRanges_1.62.0
##  [31] purrr_1.1.0                 BiocGenerics_0.56.0
##  [33] msigdbr_25.1.1              RCurl_1.98-1.17
##  [35] IRanges_2.44.0              S4Vectors_0.48.0
##  [37] ggrepel_0.9.6               irlba_2.3.5.1
##  [39] umap_0.2.10.0               RSpectra_0.16-2
##  [41] dqrng_0.4.1                 svglite_2.2.2
##  [43] DelayedMatrixStats_1.32.0   codetools_0.2-20
##  [45] DelayedArray_0.36.0         DT_0.34.0
##  [47] scuttle_1.20.0              xml2_1.4.1
##  [49] RApiSerialize_0.1.4         tidyselect_1.2.1
##  [51] farver_2.1.2                ScaledMatrix_1.18.0
##  [53] viridis_0.6.5               shinyWidgets_0.9.0
##  [55] matrixStats_1.5.0           stats4_4.5.1
##  [57] Seqinfo_1.0.0               GenomicAlignments_1.46.0
##  [59] jsonlite_2.0.0              BiocNeighbors_2.4.0
##  [61] scater_1.38.0               systemfonts_1.3.1
##  [63] tools_4.5.1                 stringdist_0.9.15
##  [65] Rcpp_1.1.0                  glue_1.8.0
##  [67] gridExtra_2.3               SparseArray_1.10.0
##  [69] xfun_0.53                   qualV_0.3-5
##  [71] MatrixGenerics_1.22.0       dplyr_1.1.4
##  [73] shinydashboard_0.7.3        BiocManager_1.30.26
##  [75] fastmap_1.2.0               bluster_1.20.0
##  [77] shinyjs_2.1.0               openssl_2.3.4
##  [79] digest_0.6.37               rsvd_1.0.5
##  [81] R6_2.6.1                    mime_0.13
##  [83] textshaping_1.0.4           dichromat_2.0-0.1
##  [85] cigarillo_1.0.0             tidyr_1.3.1
##  [87] generics_0.1.4              data.table_1.17.8
##  [89] rtracklayer_1.70.0          httr_1.4.7
##  [91] htmlwidgets_1.6.4           S4Arrays_1.10.0
##  [93] pkgconfig_2.0.3             gtable_0.3.6
##  [95] S7_0.2.0                    SingleCellExperiment_1.32.0
##  [97] XVector_0.50.0              htmltools_0.5.8.1
##  [99] shinyhelper_0.3.2           bookdown_0.45
## [101] scales_1.4.0                kableExtra_1.4.0
## [103] Biobase_2.70.0              png_0.1-8
## [105] scran_1.38.0                colorRamps_2.3.4
## [107] knitr_1.50                  rstudioapi_0.17.1
## [109] rjson_0.2.23                curl_7.0.0
## [111] shinydashboardPlus_2.0.6    cachem_1.1.0
## [113] stringr_1.5.2               KernSmooth_2.23-26
## [115] parallel_4.5.1              miniUI_0.1.2
## [117] vipor_0.4.7                 shinycssloaders_1.1.0
## [119] restfulr_0.0.16             pillar_1.11.1
## [121] grid_4.5.1                  vctrs_0.6.5
## [123] promises_1.4.0              ggfittext_0.10.2
## [125] stringfish_0.17.0           BiocSingular_1.26.0
## [127] shinyFiles_0.9.3            beachmat_2.26.0
## [129] xtable_1.8-4                cluster_2.1.8.1
## [131] beeswarm_0.4.0              evaluate_1.0.5
## [133] cli_3.6.5                   locfit_1.5-9.12
## [135] compiler_4.5.1              Rsamtools_2.26.0
## [137] rlang_1.1.6                 crayon_1.5.3
## [139] forcats_1.0.1               fs_1.6.6
## [141] ggbeeswarm_0.7.2            stringi_1.8.7
## [143] viridisLite_0.4.2           BiocParallel_1.44.0
## [145] assertthat_0.2.1            babelgene_22.9
## [147] Biostrings_2.78.0           lazyeval_0.2.2
## [149] coop_0.6-3                  colourpicker_1.3.0
## [151] Matrix_1.7-4                sparseMatrixStats_1.22.0
## [153] ggplot2_4.0.0               statmod_1.5.1
## [155] shiny_1.11.1                SummarizedExperiment_1.40.0
## [157] qs_0.27.3                   igraph_2.2.1
## [159] RcppParallel_5.1.11-1       bslib_0.9.0
```