# Multi-subject scRNA-seq Analysis

Jason Ratcliff1, Andrew Thurman2, Michael Chimenti1 and Alejandro Pezzulo2

1Iowa Institute of Human Genetics, Roy J. and Lucille A. Carver College of Medicine, University of Iowa, Iowa City, IA 52242, USA
2Department of Internal Medicine, Roy J. and Lucille A. Carver College of Medicine, University of Iowa, Iowa City, IA 52242, USA

#### 29 October 2025

#### Abstract

A method for incorporating *biological replication* into differential gene
expression analysis of single cell RNA sequencing data.

#### Package

aggregateBioVar 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Case Study: Small Airway Epithelium in Cystic Fibrosis](#case-study-small-airway-epithelium-in-cystic-fibrosis)
  + [2.1 The `small_airway` Dataset](#the-small_airway-dataset)
  + [2.2 Cell Metadata](#cell-metadata)
  + [2.3 Aggregating Gene Counts](#aggregating-gene-counts)
    - [2.3.1 Gene-by-subject Count Matrix](#gene-by-subject-count-matrix)
    - [2.3.2 Subject Metadata](#subject-metadata)
    - [2.3.3 Return `SummarizedExperiment`](#return-summarizedexperiment)
  + [2.4 `aggregateBioVar()`](#aggregatebiovar)
* [3 Application to Differential Gene Expression (DGE)](#application-to-differential-gene-expression-dge)
  + [3.1 Exploratory Data Analysis](#exploratory-data-analysis)
  + [3.2 DGE with DESeq2](#dge-with-deseq2)
  + [3.3 Results](#results)
* [4 References](#references)
* **Appendix**
* [A Session Info](#session-info)

```
# For analysis of scRNAseq data
library(aggregateBioVar)
library(SummarizedExperiment, quietly = TRUE)
library(SingleCellExperiment, quietly = TRUE)
library(DESeq2, quietly = TRUE)

# For data transformation and visualization
library(magrittr, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(ggplot2, quietly = TRUE)
library(cowplot, quietly = TRUE)
library(ggtext, quietly = TRUE)
```

# 1 Introduction

Single cell RNA sequencing (scRNA-seq) studies allow gene expression
quantification at the level of individual cells, and these studies introduce
multiple layers of biological complexity. These include variations in gene
expression between cell states within a sample
(*e.g.*, T cells versus macrophages), between samples within a population
(*e.g.*, biological or technical replicates), and between populations
(*e.g.*, healthy versus diseased individuals).
Because many early scRNA-seq studies involved analysis of only a single sample,
many bioinformatics tools operate on the first layer, comparing gene expression
between cells within a sample.
This software is aimed at organizing scRNA-seq data to permit analysis in the
latter two layers, comparing gene expression between samples and between
populations. An example is given with an implementation of differential
gene expression analysis between populations. From scRNA-seq data stored as a
[`SingleCellExperiment`](https://bioconductor.org/packages/release/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html) (Lun and Risso, [2020](#ref-R-SingleCellExperiment)) object
with pre-defined cell states, `aggregateBioVar()` stratifies data as a list of
[`SummarizedExperiment`](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html) (Morgan *et al.*, [2020](#ref-R-SummarizedExperiment)) objects,
a standard [Bioconductor](https://bioconductor.org) data structure for
downstream analysis of RNA-seq data.

# 2 Case Study: Small Airway Epithelium in Cystic Fibrosis

To illustrate the utility of *biological replication* for scRNA-seq
sequencing experiments, consider a set of single cell data from
**porcine small airway epithelium**. In this study, small airway (< 2 mm) tissue
samples were collected from newborn pigs ([*Sus scrofa*](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=9823)) to
investigate gene expression patterns and cellular composition in a cystic
fibrosis phenotype. Single cell sequencing samples were prepared using a 10X
Genomics Chromium controller and sequenced on an Illumina HiSeq4000. Data
obtained from seven individuals include both non-CF
(**CFTR+/+**; genotype `WT`; n=4) and CFTR-knockout subjects expressing a
cystic fibrosis phenotype (**CFTR-/-**; genotype `CFTRKO`; n=3).
Cell types were determined following a standard scRNA-seq pipeline using
[Seurat](https://satijalab.org/seurat/) (Stuart *et al.*, [2019](#ref-Seurat2019)), including cell count
normalization, scaling, determination of highly variable genes,
dimension reduction via principal components analysis, and shared
nearest neighbor clustering. Both unsupervised marker detection
(via `Seurat::FindMarkers()`) and a list of known marker genes were used to
annotate cell types. The full data set has been uploaded to the
[Gene Expression Omnibus](https://www.ncbi.nlm.nih.gov/geo/)
as accession number **GSE150211.**

## 2.1 The `small_airway` Dataset

A subset of 1339 genes from 2722 cells
assigned as secretory, endothelial, and immune cell types are available in the
`small_airway` data set.
The data are formatted as a `SingleCellExperiment` class S4 object
(Amezquita *et al.*, [2020](#ref-SingleCellExperiment2020)), an extension of the
`RangedSummarizedExperiment` class from the `SummarizedExperiment` package.

```
small_airway
#> class: SingleCellExperiment
#> dim: 1339 2722
#> metadata(0):
#> assays(1): counts
#> rownames(1339): MPC1 PRKN ... OTOP1 UNC80
#> rowData names(0):
#> colnames(2722): SWT1_AAAGAACAGACATAAC SWT1_AAAGGATTCTCCGAAA ...
#>   SCF3_TTTGGAGGTAAGGCTG SCF3_TTTGGTTCAATAGTAG
#> colData names(6): orig.ident nCount_RNA ... Region celltype
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

The primary data in `SingleCellExperiment` objects are stored in the `assays`
slot. Here, a single assay `counts` contains gene counts from the single cell
sequencing data. Each column of the assay count matrix represents a cell and
each row a feature (*e.g.*, gene).
Assay slot data can be obtained by `SummarizedExperiment::assay()`, indicating
the`SingleCellExperiment` object and name of the assay slot (here, `"counts"`).
In the special case of the assay being named `"counts"`, the data can be
accessed with `SingleCellExperiment::counts()`.

```
assays(small_airway)
#> List of length 1
#> names(1): counts

# Dimensions of gene-by-cell count matrix
dim(counts(small_airway))
#> [1] 1339 2722

# Access dgCMatrix with gene counts
counts(small_airway)[1:5, 1:30]
#> 5 x 30 sparse Matrix of class "dgCMatrix"
#>   [[ suppressing 30 column names 'SWT1_AAAGAACAGACATAAC', 'SWT1_AAAGGATTCTCCGAAA', 'SWT1_AAAGGTATCCACGTAA' ... ]]
#>
#> MPC1    . 1 2 8 15 4 . 1 7 3 . 3 1 4 3 1 7 8 4 2 2 1  3 2 4 . 3 2 3  2
#> PRKN    . . . .  . . . . . . . . . . . . . . . . . .  . . . . . . .  .
#> SLC22A3 . . . .  . . . . . . . . . . . . . . . . . .  . . . . . . .  .
#> CNKSR3  . . 1 .  1 . . . . . . . . . . . 1 . 1 . . .  2 . . . . . .  3
#> UTRN    2 2 . 4  6 1 . . 1 . 3 6 1 4 1 . 9 2 1 8 1 1 12 5 4 1 2 5 1 14
```

## 2.2 Cell Metadata

`SingleCellExperiment` objects may also include column metadata with
additional information annotating individual cells.
Here, the metadata variable `orig.ident` identifies the biological sample of the
cell while `celltype` indicates the assigned cellular identity.
Of the 7 individual
subjects, 3 are CF (SCF1, SCF2, SCF3) and 4 are non-CF (SWT1, SWT2, SWT3, SWT4).
`Genotype` indicates the sample genotype, one of `WT` or `CFTRKO` for non-CF and
CF subjects, respectively.
Column metadata from `SingleCellExperiment` objects can be accessed with the `$`
operator, where the length of a metadata column variable is equal to the number
of columns (*i.e.*, cells) in the feature count matrix from the `assays` slot.

```
# Subject values
table(small_airway$orig.ident)
#>
#> SCF1 SCF2 SCF3 SWT1 SWT2 SWT3 SWT4
#>  450  283  758  324  294  258  355

# Cell type values
table(small_airway$celltype)
#>
#> Endothelial cell      Immune cell   Secretory cell
#>              915              585             1222

# Subject genotype
table(small_airway$Genotype)
#>
#> CFTRKO     WT
#>   1491   1231
```

The experiment metadata are included as an S4 `DataFrame` object.
To access the full column metadata from `SingleCellExperiment` objects, use
`colData()` from the `SummarizedExperiment` package.
Here, metadata include
6 variables for each of
2722 cells.
In addition to the biological sample identifier, cell type, and genotype,
metadata include total unique molecular identifiers (UMIs) and
number of detected features.

```
colData(small_airway)
#> DataFrame with 2722 rows and 6 columns
#>                        orig.ident nCount_RNA nFeature_RNA    Genotype
#>                       <character>  <numeric>    <integer> <character>
#> SWT1_AAAGAACAGACATAAC        SWT1        594          169          WT
#> SWT1_AAAGGATTCTCCGAAA        SWT1       1133          301          WT
#> SWT1_AAAGGTATCCACGTAA        SWT1       1204          281          WT
#> SWT1_AACACACCAATCCTTT        SWT1       1998          365          WT
#> SWT1_AACCACAGTTACTCAG        SWT1       3268          427          WT
#> ...                           ...        ...          ...         ...
#> SCF3_TTTGGAGAGCAGTAAT        SCF3       1953          301      CFTRKO
#> SCF3_TTTGGAGAGCGTCTGC        SCF3        215           95      CFTRKO
#> SCF3_TTTGGAGCATATACCG        SCF3       1154          234      CFTRKO
#> SCF3_TTTGGAGGTAAGGCTG        SCF3        703          187      CFTRKO
#> SCF3_TTTGGTTCAATAGTAG        SCF3       2319          360      CFTRKO
#>                            Region       celltype
#>                       <character>       <factor>
#> SWT1_AAAGAACAGACATAAC       Small Immune cell
#> SWT1_AAAGGATTCTCCGAAA       Small Secretory cell
#> SWT1_AAAGGTATCCACGTAA       Small Secretory cell
#> SWT1_AACACACCAATCCTTT       Small Secretory cell
#> SWT1_AACCACAGTTACTCAG       Small Secretory cell
#> ...                           ...            ...
#> SCF3_TTTGGAGAGCAGTAAT       Small Secretory cell
#> SCF3_TTTGGAGAGCGTCTGC       Small Secretory cell
#> SCF3_TTTGGAGCATATACCG       Small Secretory cell
#> SCF3_TTTGGAGGTAAGGCTG       Small Secretory cell
#> SCF3_TTTGGTTCAATAGTAG       Small Secretory cell
```

## 2.3 Aggregating Gene Counts

The main functionality of this package involves two generalizable operations:

1. Aggregate within-subject gene counts
2. Summarize metadata to retain inter-subject variation

A wrapper function `aggregateBioVar()` abstracts away these operations
and applies them on a by-cell type basis. For input, a `SingleCellExperiment`
object containing gene counts should contain metadata variables for the
subject by which to aggregate cells (*e.g.*, biological sample) and the assigned
cell types.

### 2.3.1 Gene-by-subject Count Matrix

The first operation involves summing all gene counts by subject.
For each gene, counts from all cells within each subject are combined. A
*gene-by-cell* count matrix is converted into a *gene-by-subject* count matrix.

```
countsBySubject(scExp = small_airway, subjectVar = "orig.ident")
#> DataFrame with 1339 rows and 7 columns
#>              SWT1      SWT2      SWT3      SCF1      SCF2      SWT4      SCF3
#>         <numeric> <numeric> <numeric> <numeric> <numeric> <numeric> <numeric>
#> MPC1          977      1039      1053      1100       889       712      2907
#> PRKN            2         0        13         4         3         3        18
#> SLC22A3        13         4        19        10        18         1        13
#> CNKSR3        170       172       400       245       242       249       324
#> UTRN         1322      1060      1355      1617       730       979      1338
#> ...           ...       ...       ...       ...       ...       ...       ...
#> CNNM1           0         0         0         0         0         0         0
#> GABRQ           0         0         0         0         0         0         1
#> GIF             0         0         0         0         0         0         0
#> OTOP1           0         0         0         0         0         0         0
#> UNC80           0         0         0         0         0         0         0
```

### 2.3.2 Subject Metadata

The second operation removes metadata variables with intrasubject
variation. This effectively retains *inter-subject metadata* and eliminates
variables with intrasubject (*i.e.*, intercellular) variation
(*e.g.*, feature or gene counts by cell). This summarized metadata is used
for modeling a differential expression design matrix.

```
subjectMetaData(scExp = small_airway, subjectVar = "orig.ident")
#> DataFrame with 7 rows and 3 columns
#>       orig.ident    Genotype      Region
#>      <character> <character> <character>
#> SWT1        SWT1          WT       Small
#> SWT2        SWT2          WT       Small
#> SWT3        SWT3          WT       Small
#> SCF1        SCF1      CFTRKO       Small
#> SCF2        SCF2      CFTRKO       Small
#> SWT4        SWT4          WT       Small
#> SCF3        SCF3      CFTRKO       Small
```

### 2.3.3 Return `SummarizedExperiment`

Both the gene count aggregation and metadata collation steps are combined in
`summarizedCounts()`. This function returns a `SummarizedExperiment` object with
the gene-by-subject count matrix in the `assays` slot, and the summarized
inter-subject metadata as `colData`. Notice the column names now correspond
to the subject level, replacing the cellular barcodes in the
`SingleCellExperiment` following aggregation of gene counts from
within-subject cells.

```
summarizedCounts(scExp = small_airway, subjectVar = "orig.ident")
#> class: SummarizedExperiment
#> dim: 1339 7
#> metadata(0):
#> assays(1): counts
#> rownames(1339): MPC1 PRKN ... OTOP1 UNC80
#> rowData names(0):
#> colnames(7): SWT1 SWT2 ... SWT4 SCF3
#> colData names(3): orig.ident Genotype Region
```

## 2.4 `aggregateBioVar()`

These operations are applied to each cell type subset with `aggregateBioVar()`.
The full `SingleCellExperiment` object is subset by cell type (*e.g.*,
secretory, endothelial, and immune cell), the gene-by-subject aggregate count
matrix and collated metadata are tabulated, and a `SummarizedExperiment`
object for that cell type is constructed. A list of `SummarizedExperiment`
objects output by `summarizedCounts()` is the returned to the user. The first
element contains the aggregate `SummarizedExperiment` across all cells, and
subsequent list elements correspond to the cell type indicated by the metadata
variable `cellVar`:

```
aggregateBioVar(scExp = small_airway,
                subjectVar = "orig.ident", cellVar = "celltype")
#> Coercing metadata variable to character: celltype
#> $AllCells
#> class: SummarizedExperiment
#> dim: 1339 7
#> metadata(0):
#> assays(1): counts
#> rownames(1339): MPC1 PRKN ... OTOP1 UNC80
#> rowData names(0):
#> colnames(7): SWT1 SWT2 ... SWT4 SCF3
#> colData names(3): orig.ident Genotype Region
#>
#> $`Immune cell`
#> class: SummarizedExperiment
#> dim: 1339 7
#> metadata(0):
#> assays(1): counts
#> rownames(1339): MPC1 PRKN ... OTOP1 UNC80
#> rowData names(0):
#> colnames(7): SWT1 SWT2 ... SWT4 SCF3
#> colData names(4): orig.ident Genotype Region celltype
#>
#> $`Secretory cell`
#> class: SummarizedExperiment
#> dim: 1339 7
#> metadata(0):
#> assays(1): counts
#> rownames(1339): MPC1 PRKN ... OTOP1 UNC80
#> rowData names(0):
#> colnames(7): SWT1 SWT2 ... SWT4 SCF3
#> colData names(4): orig.ident Genotype Region celltype
#>
#> $`Endothelial cell`
#> class: SummarizedExperiment
#> dim: 1339 7
#> metadata(0):
#> assays(1): counts
#> rownames(1339): MPC1 PRKN ... OTOP1 UNC80
#> rowData names(0):
#> colnames(7): SWT1 SWT2 ... SWT4 SCF3
#> colData names(4): orig.ident Genotype Region celltype
```

# 3 Application to Differential Gene Expression (DGE)

In this case, we want to test for differential
expression between non-CF and CF pigs in the `Secretory cell` subset.
To do so, `aggregateBioVar()` is run on the `SingleCellExperiment` object
by indicated the metadata variables representing the subject-level
(`subjectVar`) and assigned cell type (`cellVar`).
If multiple assays are included in the input `scExp` object,
the **first assay slot** is used.

```
# Perform aggregation of counts and metadata by subject and cell type.
aggregate_counts <-
    aggregateBioVar(
        scExp = small_airway,
        subjectVar = "orig.ident", cellVar = "celltype"
    )
#> Coercing metadata variable to character: celltype
```

## 3.1 Exploratory Data Analysis

To visualize the gene-by-subject count aggregation, consider a function to
calculate log2 counts per million cells and display a heatmap
of normalized expression using `pheatmap` (Kolde, [2019](#ref-R-pheatmap)).
`RColorBrewer` (Neuwirth, [2014](#ref-R-RColorBrewer)) and `viridis` (Garnier, [2018](#ref-R-viridis)) are used to
generate discrete and continuous color scales, respectively.

```
#' Single-cell Counts `pheatmap`
#'
#' @param sumExp `SummarizedExperiment` or `SingleCellExperiment` object
#'   with individual cell or aggregate counts by-subject.
#' @param logSample Subset of log2 values to include for clustering.
#' @param ... Forwarding arguments to pheatmap
#' @inheritParams aggregateBioVar
#'
scPHeatmap <- function(sumExp, subjectVar, gtVar, logSample = 1:100, ...) {
    orderSumExp <- sumExp[, order(sumExp[[subjectVar]])]
    sumExpCounts <- as.matrix(
        SummarizedExperiment::assay(orderSumExp, "counts")
    )
    logcpm <- log2(
        1e6*t(t(sumExpCounts) / colSums(sumExpCounts)) + 1
    )
    annotations <- data.frame(
        Genotype = orderSumExp[[gtVar]],
        Subject = orderSumExp[[subjectVar]]
    )
    rownames(annotations) <- colnames(orderSumExp)

    singleCellpHeatmap <- pheatmap::pheatmap(
        mat = logcpm[logSample, ], annotation_col = annotations,
        cluster_cols = FALSE, show_rownames = FALSE, show_colnames = FALSE,
        scale = "none", ...
    )
    return(singleCellpHeatmap)
}
```

Without aggregation, bulk RNA-seq methods for differential expression analysis
would be applied at the cell level (here, secretory cells;
Figure [1](#fig:pheatmapCells)).

```
# Subset `SingleCellExperiment` secretory cells.
sumExp <- small_airway[, small_airway$celltype == "Secretory cell"]

# List of annotation color specifications for pheatmap.
ann_colors <- list(
    Genotype = c(CFTRKO = "red", WT = "black"),
    Subject = c(RColorBrewer::brewer.pal(7, "Accent"))
)
ann_names <- unique(sumExp[["orig.ident"]])
names(ann_colors$Subject) <- ann_names[order(ann_names)]

# Heatmap of log2 expression across all cells.
scPHeatmap(
    sumExp = sumExp, logSample = 1:100,
    subjectVar = "orig.ident", gtVar = "Genotype",
    color = viridis::viridis(75), annotation_colors = ann_colors,
    treeheight_row = 0, treeheight_col = 0
)
```

![Gene-by-cell Count Matrix. Heatmap of *secretory cell* gene expression with log~2~ counts per million cells. Includes 1222 cells from 7 subjects with genotypes `WT` (n=4, cells=406) and `CFTRKO` (n=3, cells=816).](data:image/png;base64...)

Figure 1: Gene-by-cell Count Matrix
Heatmap of *secretory cell* gene expression with log2 counts per million cells. Includes 1222 cells from 7 subjects with genotypes `WT` (n=4, cells=406) and `CFTRKO` (n=3, cells=816).

---

Summation of gene counts across all cells creates a “pseudo-bulk” data set
on which a subject-level test of differential expression is applied
(Figure [2](#fig:pheatmapSubject)).

```
# List of `SummarizedExperiment` objects with aggregate subject counts.
scExp <-
    aggregateBioVar(
        scExp = small_airway,
        subjectVar = "orig.ident", cellVar = "celltype"
    )
#> Coercing metadata variable to character: celltype

# Heatmap of log2 expression from aggregate gene-by-subject count matrix.
scPHeatmap(
    sumExp = aggregate_counts$`Secretory cell`, logSample = 1:100,
    subjectVar = "orig.ident", gtVar = "Genotype",
    color = viridis::viridis(75), annotation_colors = ann_colors,
    treeheight_row = 0, treeheight_col = 0
)
```

![Gene-by-subject Count Matrix. Heatmap of gene counts aggregated by subject with `aggregateBioVar()`.The `SummarizedExperiment` object with the *Secretory cells* subset contains gene counts summed by subject. Aggregate gene-by-subject counts are used as input for bulk RNA-seq tools.](data:image/png;base64...)

Figure 2: Gene-by-subject Count Matrix
Heatmap of gene counts aggregated by subject with `aggregateBioVar()`.The `SummarizedExperiment` object with the *Secretory cells* subset contains gene counts summed by subject. Aggregate gene-by-subject counts are used as input for bulk RNA-seq tools.

## 3.2 DGE with DESeq2

To run [`DESeq2`](https://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html) (Love *et al.*, [2014](#ref-DESeq2)), a `DESeqDataSet` object can be
constructed using `DESeqDataSetFromMatrix()`.
Here, the aggregate counts and subject metadata from the secretory cell subset
are modeled by the variable `Genotype`.
Differential expression analysis is performed with `DESeq` and a results table
is extracted by `results()` to obtain log2 fold changes with p-values and
adjusted p-values.

```
subj_dds_dataset <-
    DESeqDataSetFromMatrix(
        countData = assay(aggregate_counts$`Secretory cell`, "counts"),
        colData = colData(aggregate_counts$`Secretory cell`),
        design = ~ Genotype
    )
#> converting counts to integer mode
#> Warning in DESeqDataSet(se, design = design, ignoreRank): some variables in
#> design formula are characters, converting to factors

subj_dds <- DESeq(subj_dds_dataset)
#> estimating size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing

subj_dds_results <-
    results(subj_dds, contrast = c("Genotype", "WT", "CFTRKO"))
```

For comparison of differential expression with and without aggregation of
gene-by-subject counts, a subset of all secretory cells is used to construct
a `DESeqDataSet` and analysis of differential expression is repeated.

```
cells_secretory <-
    small_airway[, which(
        as.character(small_airway$celltype) == "Secretory cell")]
cells_secretory$Genotype <- as.factor(cells_secretory$Genotype)

cell_dds_dataset <-
    DESeqDataSetFromMatrix(
        countData = assay(cells_secretory, "counts"),
        colData = colData(cells_secretory),
        design = ~ Genotype
    )
#> converting counts to integer mode

cell_dds <- DESeq(cell_dds_dataset)
#> estimating size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> -- note: fitType='parametric', but the dispersion trend was not well captured by the
#>    function: y = a/x + b, and a local regression fit was automatically substituted.
#>    specify fitType='local' or 'mean' to avoid this message next time.
#> final dispersion estimates
#> fitting model and testing
#> -- replacing outliers and refitting for 2 genes
#> -- DESeq argument 'minReplicatesForReplace' = 7
#> -- original counts are preserved in counts(dds)
#> estimating dispersions
#> fitting model and testing

cell_dds_results <-
    results(cell_dds, contrast = c("Genotype", "WT", "CFTRKO"))
```

Add a new variable with log10-transformed adjusted P-values.

```
subj_dds_transf <- as.data.frame(subj_dds_results) %>%
    bind_cols(feature = rownames(subj_dds_results)) %>%
    mutate(log_padj = - log(.data$padj, base = 10))

cell_dds_transf <- as.data.frame(cell_dds_results) %>%
    bind_cols(feature = rownames(cell_dds_results)) %>%
    mutate(log_padj = - log(.data$padj, base = 10))
```

## 3.3 Results

DGE is summarized by volcano plot `ggplot` (Wickham and Chang *et al.*, [2020](#ref-R-ggplot2)) to show cell-level
(Figure [3](#fig:plotVolcano)A)
and subject-level tests (Figure [3](#fig:plotVolcano)B).
Aggregation of gene counts by subject reduced the number of genes with both
an adjusted p-value < 0.05 and an absolute log2 fold change > 1 from
65 genes to 2 (Figure [3](#fig:plotVolcano)).

```
# Function to add theme for ggplots of DESeq2 results.
deseq_themes <- function() {
    list(
        theme_classic(),
        lims(x = c(-4, 5), y = c(0, 80)),
        labs(
            x = "log<sub>2</sub> (fold change)",
            y = "-log<sub>10</sub> (p<sub>adj</sub>)"
        ),
        ggplot2::theme(
            axis.title.x = ggtext::element_markdown(),
            axis.title.y = ggtext::element_markdown())
    )
}

# Build ggplots to visualize subject-level differential expression in scRNA-seq
ggplot_full <- ggplot(data = cell_dds_transf) +
    geom_point(aes(x = log2FoldChange, y = log_padj), na.rm = TRUE) +
    geom_point(
        data = filter(
            .data = cell_dds_transf,
            abs(.data$log2FoldChange) > 1, .data$padj < 0.05
        ),
        aes(x = log2FoldChange, y = log_padj), color = "red"
    ) +
    deseq_themes()

ggplot_subj <- ggplot(data = subj_dds_transf) +
    geom_point(aes(x = log2FoldChange, y = log_padj), na.rm = TRUE) +
    geom_point(
        data = filter(
            .data = subj_dds_transf,
            abs(.data$log2FoldChange) > 1, .data$padj < 0.05
        ),
        aes(x = log2FoldChange, y = log_padj), color = "red"
    ) +
    geom_label(
        data = filter(
            .data = subj_dds_transf,
            abs(.data$log2FoldChange) > 1, .data$padj < 0.05
        ),
        aes(x = log2FoldChange + 0.5, y = log_padj + 5, label = feature)
    ) +
    deseq_themes()

cowplot::plot_grid(ggplot_full, ggplot_subj, ncol = 2, labels = c("A", "B"))
```

![Differential expression analysis of scRNA-seq data. Comparison of differential expression in secretory cells from small airway epithelium without aggregation (A) and after aggregation of gene counts by subject (biological replicates; B). Genes with an absolute log~2~ fold change greater than 1 and an adjusted P value less than 0.05 are highlighted in red. Aggregation of counts by subject reduced the number of differentially expressed genes to CD36 and CFTR for the secretory cell subset.](data:image/png;base64...)

Figure 3: Differential expression analysis of scRNA-seq data
Comparison of differential expression in secretory cells from small airway epithelium without aggregation (A) and after aggregation of gene counts by subject (biological replicates; B). Genes with an absolute log2 fold change greater than 1 and an adjusted P value less than 0.05 are highlighted in red. Aggregation of counts by subject reduced the number of differentially expressed genes to CD36 and CFTR for the secretory cell subset.

---

From the significantly differentially expressed genes CFTR and CD36,
the aggregate counts by subject are plotted in Figure [4](#fig:plotGeneCounts).

```
# Extract counts subset by gene to plot normalized counts.
ggplot_counts <- function(dds_obj, gene) {
    norm_counts <-
        counts(dds_obj, normalized = TRUE)[grepl(gene, rownames(dds_obj)), ]
    sc_counts <-
        data.frame(
            norm_count = norm_counts,
            subject = colData(dds_obj)[["orig.ident"]],
            genotype = factor(
                colData(dds_obj)[["Genotype"]],
                levels = c("WT", "CFTRKO")
            )
        )

    count_ggplot <- ggplot(data = sc_counts) +
        geom_jitter(
            aes(x = genotype, y = norm_count, color = genotype),
            height = 0, width = 0.05
        ) +
        scale_color_manual(
            "Genotype", values = c("WT" = "blue", "CFTRKO" = "red")
        ) +
        lims(x = c("WT", "CFTRKO"), y = c(0, 350)) +
        labs(x = "Genotype", y = "Normalized Counts") +
        ggtitle(label = gene) +
        theme_classic()
    return(count_ggplot)
}

cowplot::plot_grid(
    ggplot_counts(dds_obj = subj_dds, gene = "CFTR") +
        theme(legend.position = "FALSE"),
    ggplot_counts(dds_obj = subj_dds, gene = "CD36") +
        theme(legend.position = "FALSE"),
    cowplot::get_legend(
        plot = ggplot_counts(dds_obj = subj_dds, gene = "CD36")
    ),
    ncol = 3, rel_widths = c(4, 4, 1)
)
```

![Normalized within-subject gene counts. Gene counts aggregated by subject for significantly differentially expressed genes from the secretory cell subset.](data:image/png;base64...)

Figure 4: Normalized within-subject gene counts
Gene counts aggregated by subject for significantly differentially expressed genes from the secretory cell subset.

# 4 References

Amezquita,R. *et al.* (2020) Orchestrating single-cell analysis with bioconductor. *Nature Methods*, **17**, 137–145.

Bache,S.M. and Wickham,H. (2014) magrittr: A forward-pipe operator for r.

Garnier,S. (2018) viridis: Default color maps from ’matplotlib’.

Kolde,R. (2019) pheatmap: Pretty heatmaps.

Love,M.I. *et al.* (2014) Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. *Genome Biology*, **15**, 550.

Lun,A. and Risso,D. (2020) SingleCellExperiment: S4 classes for single cell data.

Morgan,M. *et al.* (2020) SummarizedExperiment: SummarizedExperiment container.

Neuwirth,E. (2014) RColorBrewer: ColorBrewer palettes.

Stuart,T. *et al.* (2019) Comprehensive integration of single-cell data. *Cell*, **177**, 1888–1902.

Wickham,H. *et al.* (2020) ggplot2: Create elegant data visualisations using the grammar of graphics.

Wickham,H. *et al.* (2020) dplyr: A grammar of data manipulation.

Wilke,C.O. (2019) cowplot: Streamlined plot theme and plot annotations for ’ggplot2’.

Wilke,C.O. (2020) ggtext: Improved text rendering support for ’ggplot2’.

# Appendix

Amezquita,R. *et al.* (2020) Orchestrating single-cell analysis with bioconductor. *Nature Methods*, **17**, 137–145.

Bache,S.M. and Wickham,H. (2014) magrittr: A forward-pipe operator for r.

Garnier,S. (2018) viridis: Default color maps from ’matplotlib’.

Kolde,R. (2019) pheatmap: Pretty heatmaps.

Love,M.I. *et al.* (2014) Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. *Genome Biology*, **15**, 550.

Lun,A. and Risso,D. (2020) SingleCellExperiment: S4 classes for single cell data.

Morgan,M. *et al.* (2020) SummarizedExperiment: SummarizedExperiment container.

Neuwirth,E. (2014) RColorBrewer: ColorBrewer palettes.

Stuart,T. *et al.* (2019) Comprehensive integration of single-cell data. *Cell*, **177**, 1888–1902.

Wickham,H. *et al.* (2020) ggplot2: Create elegant data visualisations using the grammar of graphics.

Wickham,H. *et al.* (2020) dplyr: A grammar of data manipulation.

Wilke,C.O. (2019) cowplot: Streamlined plot theme and plot annotations for ’ggplot2’.

Wilke,C.O. (2020) ggtext: Improved text rendering support for ’ggplot2’.

# A Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] ggtext_0.1.2                cowplot_1.2.0
#>  [3] ggplot2_4.0.0               dplyr_1.1.4
#>  [5] magrittr_2.0.4              DESeq2_1.50.0
#>  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [15] generics_0.1.4              MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0           aggregateBioVar_1.20.0
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
#>  [7] parallel_4.5.1      tibble_3.3.0        pkgconfig_2.0.3
#> [10] pheatmap_1.0.13     Matrix_1.7-4        RColorBrewer_1.1-3
#> [13] S7_0.2.0            lifecycle_1.0.4     stringr_1.5.2
#> [16] compiler_4.5.1      farver_2.1.2        tinytex_0.57
#> [19] codetools_0.2-20    litedown_0.7        htmltools_0.5.8.1
#> [22] sass_0.4.10         yaml_2.3.10         pillar_1.11.1
#> [25] jquerylib_0.1.4     BiocParallel_1.44.0 DelayedArray_0.36.0
#> [28] cachem_1.1.0        magick_2.9.0        viridis_0.6.5
#> [31] abind_1.4-8         commonmark_2.0.0    tidyselect_1.2.1
#> [34] locfit_1.5-9.12     digest_0.6.37       stringi_1.8.7
#> [37] bookdown_0.45       labeling_0.4.3      fastmap_1.2.0
#> [40] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [43] S4Arrays_1.10.0     dichromat_2.0-0.1   withr_3.0.2
#> [46] scales_1.4.0        rmarkdown_2.30      XVector_0.50.0
#> [49] gridExtra_2.3       evaluate_1.0.5      knitr_1.50
#> [52] viridisLite_0.4.2   markdown_2.0        rlang_1.1.6
#> [55] gridtext_0.1.5      Rcpp_1.1.0          glue_1.8.0
#> [58] BiocManager_1.30.26 xml2_1.4.1          jsonlite_2.0.0
#> [61] R6_2.6.1
```