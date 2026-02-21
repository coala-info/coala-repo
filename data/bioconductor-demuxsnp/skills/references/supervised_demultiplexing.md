# Supervised Demultiplexing using Cell Hashing and SNPs

Michael Lynch1 and Aedin Culhane1

1University of Limerick

#### 29 October 2025

```
library(demuxSNP)
library(ComplexHeatmap)
library(viridisLite)
library(Seurat)
library(ggpubr)
library(dittoSeq)
library(utils)
library(EnsDb.Hsapiens.v86)
```

```
colors <- structure(viridis(n = 3), names = c("-1", "0", "1"))
```

# 1 Introduction

Multiplexing in scRNAseq involves the sequencing of samples from different
patients, treatment types or physiological locations together, resulting in
significant cost savings. The cells must then be demultiplexed, or assigned back
to their respective groups. A number of experimental and computational methods
have been proposed to facilitate this, but a universally robust algorithm
remains elusive. Below, we introduce some existing methods, highlight the novel
features of our approach and its advantages to the user.

## 1.1 Existing Methods

### 1.1.1 Cell Hashing

Cells from each group are labelled with a distinct tag (HTO or LMO) which is
sequenced to give a counts matrix. Due to non-specific binding, these counts
form a bimodal distribution. Such methods are generally computationally
efficient. Their classification performance, however, is highly dependent on the
tagging quality and many methods do not account for uncertainty in
classification (Boggy et al. ([2022](#ref-boggy_bff_2022)), Kim et al. ([2020](#ref-kim_citefuse_2020)) & Stoeckius et al. ([2018](#ref-stoeckius_cell_2018))).

More recent methods, including
[demuxmix](https://bioconductor.org/packages/release/bioc/html/demuxmix.html),
assign a probability that a cell is from a particular group, or made up of
multiple groups (doublet). This allows users to define a cut-off threshold for
the assignment confidence. Accounting for uncertainty is an important feature
for these types of algorithms. But, while they give the user greater flexibility
in determining which cells to keep, this ultimately results in a trade-off
between keeping cells which cannot be confidently called or discarding them -
due to issues with tagging quality rather than RNA quality.

### 1.1.2 SNPs

The second class of methods exploits natural genetic variation between cells and
so can only be used where the groups are genetically distinct. Demuxlet
(Kang et al. ([2018](#ref-kang_multiplexed_2018))) uses genotype information from each group to classify
samples. This genotyping incurs additional experimental cost. To address this,
Souporcell (Heaton et al. ([2020](#ref-heaton_souporcell_2020))) and Vireo (Huang, McCarthy, and Stegle ([2019](#ref-huang_vireo_2019))) among other
methods were developed to classify cells based on their SNPs in an unsupervised
manner. Without prior knowledge of the SNPs associated with each group, these
unsupervised methods may confuse groups with lower cell counts for other signals
in the data.

Demuxlet remains the standard often used to benchmark other methods but its more
widespread adoption has been limited by the requirement of sample genotype
information.

## 1.2 demuxSNP Motivation

**With cell hashing, we can confidently demultiplex *some* but not *all* cells.
Using these high confidence cells, we can learn the SNPs associated with each
group. This SNP information can then be used to assign remaining cells (which we
could not confidently call using cell hashing) to their most similar group based
on their SNP profile.**

Novel features:

* Uses both cell hashing and SNP data. Current methods are limited to using
  one or the other.
* Selects SNPs based on being located in a gene expressed in a large
  proportion of cells to reduce noise, computational cost and increase
  interpretability.

Impact:

* Users can visually confirm validity (or lack thereof) of existing
  demultiplexing results in a tangible manner.
* Users can recover otherwise high quality cells which could not be
  confidently assigned using other methods.
* Cells from groups which are present in lower proportions may be classified
  better than with unsupervised SNP approaches.

Note: the approach used here differs from most SNP methods in that it is
supervised. We attain knowledge of which SNPs are associated with which patients
from the high confidence cells then use this to train a classifier. It is
similar to demuxlet in the sense that the classifier uses group specific SNP
information, **however** our method does not require the expense of genotyping
and so may be much more widely applicable.

## 1.3 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("demuxSNP")

## or for development version:

devtools::install_github("michaelplynch/demuxSNP")
```

## 1.4 Quick Usage

For full list of arguments and explanation of each function, please refer to
relevant documentation.

## 1.5 Workflow

```
#Data loading
data(multiplexed_scrnaseq_sce,
     commonvariants_1kgenomes_subset,
     vartrix_consensus_snps,
     package = "demuxSNP")

small_sce<-multiplexed_scrnaseq_sce[,1:100]
ensdb <- EnsDb.Hsapiens.v86::EnsDb.Hsapiens.v86

#Preprocessing
top_genes<-common_genes(small_sce)
vcf_sub<-subset_vcf(commonvariants_1kgenomes_subset, top_genes, ensdb)
small_sce<-high_conf_calls(small_sce)

#Use subsetted vcf with VarTrix in default 'consensus' mode to generate SNPs
#matrix

small_sce<-add_snps(small_sce,vartrix_consensus_snps[,1:100])

small_sce<-reassign_centroid(small_sce,min_cells = 5)

table(small_sce$knn)
```

### 1.5.1 Function Explanation

`top_genes <- common_genes(sce)`: Returns the genes which are expressed
(expression > 0) in the highest proportion of cells. These genes are used below
to subset the .vcf file.

`new_vcf <- subset_vcf(vcf = vcf, top_genes = top_genes, ensdb = ensdb)`:
Subsets a supplied .vcf to SNP locations within the genes supplied. The ranges
of the genes are extracted from the EnsDb object.

`sce <- high_conf_calls(sce = sce, assay = "HTO")`:
Takes a SingleCellExperiment object with HTO altExp, runs
[demuxmix](https://bioconductor.org/packages/release/bioc/html/demuxmix.html)
and returns a factor of assigned labels, a logical vector indicating high
confidence calls and a logical vector indicating which cells to predict (all).

`sce <- add_snps(sce = sce, mat = vartrix_consensus_snps, thresh = 0.8)`:
Adds the SNP data from VarTrix (default consensus mode) to the
SingleCellExperiment object as an altExp. Additionally, filters out SNPs with no
reads in less than ‘thresh’ proportion of cells.

```
sce <- reassign_centroid(sce,
    train_cells = sce$train,
    predict_cells = sce$predict,
    min_cells=5
)
```

Reassigns cells based on SNP profiles of high confidence cells. Singlet training
data is based on high confidence singlet assignment. Doublets are simulated
by systematically sampling and combining the SNP profiles of n cells pairs from
each grouping combination. Cells to be used for training data are specified by
“train\_cells” (logical). Cells to be used for prediction are specified by
“predict\_cells” (logical), this may also include the training data.

# 2 Exploratory Analysis

We load three data objects: a SingleCellExperiment object containing RNA and HTO
counts, a .vcf file of class CollapsedVCF containing SNPs from 1000 Genomes
common variants and a matrix containing SNP information for each cell (we will
show you how to generate this SNPs matrix using
[VarTrix](https://github.com/10XGenomics/vartrix) outside of R). We have already
removed low quality cells (library size<1,000 and percentage of genes mapping
to mitochondrial genes>10%).

```
data(multiplexed_scrnaseq_sce,
     commonvariants_1kgenomes_subset,
     vartrix_consensus_snps,
     package = "demuxSNP")

class(multiplexed_scrnaseq_sce)
#> [1] "SingleCellExperiment"
#> attr(,"package")
#> [1] "SingleCellExperiment"
class(commonvariants_1kgenomes_subset)
#> [1] "CollapsedVCF"
#> attr(,"package")
#> [1] "VariantAnnotation"
class(vartrix_consensus_snps)
#> [1] "matrix" "array"
```

The HTO or LMO distribution is usually bimodal, with a signal (high counts) and
background distribution (low counts) caused by non-specific binding. Ideally,
these distributions would be clearly separated with no overlap, but in practice,
this is not always the case. In our example data, we see that the signal and
noise overlap to varying extents in each group.

![](data:image/png;base64...)

We will begin by running Seurat’s HTODemux, a popular HTO demultiplexing
algorithm on the data.

```
logcounts(multiplexed_scrnaseq_sce) <- counts(multiplexed_scrnaseq_sce)
seurat <- as.Seurat(multiplexed_scrnaseq_sce)
seurat <- HTODemux(seurat)
seurat$hash.ID <- factor(as.character(seurat$hash.ID))
multiplexed_scrnaseq_sce$seurat <- seurat$hash.ID

multiplexed_scrnaseq_sce$seurat <- seurat$hash.ID

table(multiplexed_scrnaseq_sce$seurat)
#>
#>  Doublet Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6 Negative
#>      633      121       29      264      158      177      383      235
```

Although HTO library size of the Negative group is low, the RNA library size is
similar to that of other groups, indicating that they may be misclassified as
Negative due to their tagging quality rather than overall RNA quality.

```
dittoPlot(seurat, "nCount_HTO", group.by = "hash.ID")
```

![](data:image/png;base64...)

```
dittoPlot(seurat, "nCount_RNA", group.by = "hash.ID")
```

![](data:image/png;base64...)

For the remainder of this vignette we will outline our method of checking
whether or not these cells have been called correctly and how to assign them to
their appropriate group!

# 3 Preprocessing

Common variants files, for example from the 1000 Genomes Project, can contain
over 7 million SNPs. To reduce computational cost and cell-type effects, we
subset our SNPs list to those located within genes expressed across most cells
in our data.

We first find the most commonly expressed genes in our RNA data.

```
top_genes <- common_genes(sce = multiplexed_scrnaseq_sce, n = 100)

top_genes[1:10]
#>  [1] "TPT1"   "RPL13"  "RPL28"  "TMSB4X" "RPS27"  "EEF1A1" "RPL41"  "B2M"
#>  [9] "RPLP1"  "RPL32"
```

We have a sample .vcf preloaded, but you can load your .vcf file in using
‘readVcf()’ from
[VariantAnnotation](https://bioconductor.org/packages/release/bioc/html/VariantAnnotation.html).

We will subset our .vcf file to SNPs seen in commonly expressed genes from our
dataset. Notice that the genome for the vcf and EnsDb object must be compatible!

The returned vcf can be written to file and used with VarTrix later on.

```
ensdb <- EnsDb.Hsapiens.v86::EnsDb.Hsapiens.v86

genome(commonvariants_1kgenomes_subset)[1] == genome(ensdb)[1]
#>    1
#> TRUE

new_vcf <- subset_vcf(commonvariants_1kgenomes_subset, top_genes = top_genes, ensdb)
commonvariants_1kgenomes_subset
#> class: CollapsedVCF
#> dim: 2609 0
#> rowRanges(vcf):
#>   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
#> info(vcf):
#>   DataFrame with 1 column: AF
#> info(header(vcf)):
#>       Number Type  Description
#>    AF A      Float Estimated allele frequency in the range (0,1)
#> geno(vcf):
#>   List of length 0:
new_vcf
#> class: CollapsedVCF
#> dim: 2399 0
#> rowRanges(vcf):
#>   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
#> info(vcf):
#>   DataFrame with 1 column: AF
#> info(header(vcf)):
#>       Number Type  Description
#>    AF A      Float Estimated allele frequency in the range (0,1)
#> geno(vcf):
#>   List of length 0:
```

The subsetted .vcf can be written to disk using ‘writeVcf()’, again from
[VariantAnnotation](https://bioconductor.org/packages/release/bioc/html/VariantAnnotation.html)
package.

Next, we wish to identify cells which we can confidently call to a particular
group. There are a number of ways this can be achieved, including probabilistic
modelling of the HTO counts, manually setting non-conservative thresholds or
using consensus calls. The user may wish to experiment with different
approaches. Here we have used
[demuxmix](https://bioconductor.org/packages/release/bioc/html/demuxmix.html), a
probabilistic model which we have set with a high acceptance threshold to
identify high confidence cell calls to use as training data (cells which we can
confidently call as a particular singlet group).

```
multiplexed_scrnaseq_sce <- high_conf_calls(multiplexed_scrnaseq_sce)

table(multiplexed_scrnaseq_sce$train)
#>
#> FALSE  TRUE
#>   955  1045

table(multiplexed_scrnaseq_sce$predict)
#>
#> TRUE
#> 2000

table(multiplexed_scrnaseq_sce$labels)
#>
#>  Hashtag1  Hashtag2  Hashtag3  Hashtag4  Hashtag5  Hashtag6 multiplet  negative
#>        62        15       226       102       348       292       335        12
#> uncertain
#>       608
```

So, for this particular dataset, we can confidently call 1,045 cells as being
from a particular singlet group. 608 cells cannot be called to a group with high
confidence.

# 4 Variant Calling (VarTrix)

Variant calling is not done within the package. Instead, we refer the reader to
[VarTrix](https://github.com/10XGenomics/vartrix), where they can use the
subsetted .vcf file along with their .bam, barcodes.tsv and reference genome to
call SNPs in each cell.

A sample VarTrix command looks like the following:

```
./vartrix -v <path_to_input_vcf> -b <path_to_cellranger_bam> -f <path_to_fasta_file> -c <path_to_cell_barcodes_file> -o <path_for_output_matrix>
```

Using the output matrix from Vartrix and the high confidence classifications
from the HTO algorithm, we can reassign cells using k-nearest neighbours.

# 5 Cell Reassignment, Visualisation and Evaluation

To keep things tidy, we will add the SNP data to our SingleCellExperiment object
as an altExp. We recode the SNP matrix as follows: 0=no read, 1=SNP present,
-1=SNP absent. This function also filters out SNPs which are observed at a low
frequency in the data, and the frequency threshold can be set manually.

```
dim(vartrix_consensus_snps)
#> [1] 2542 2000

multiplexed_scrnaseq_sce <- add_snps(multiplexed_scrnaseq_sce, vartrix_consensus_snps, thresh = 0.95)

altExp(multiplexed_scrnaseq_sce, "SNP")
#> class: SingleCellExperiment
#> dim: 85 2000
#> metadata(0):
#> assays(1): counts
#> rownames(85): Snp Snp ... Snp Snp
#> rowData names(0):
#> colnames(2000): AAACCTGAGATCTGCT-1 AAACCTGAGCGTCAAG-1 ...
#>   ACTTTCAGTAAGTTCC-1 ACTTTCAGTAGGCATG-1
#> colData names(0):
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

Before we reassign any cells, we will first use the SNPs data to inspect the
results from stand-alone algorithms. Splitting the SNP data by Seurat HTODemux
classification, we initially see a large number of ‘negative’ cells which appear
of good quality (high proportion of reads) which may be assignable to another
group. This is consistent with the library size plot we visualised earlier.

```
hm <- Heatmap(counts(altExp(multiplexed_scrnaseq_sce, "SNP")),
    column_split = multiplexed_scrnaseq_sce$seurat,
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "SNP profiles split by Seurat HTODemux call",
    padding = unit(c(2, 15, 2, 2), "mm")
)
```

![](data:image/png;base64...)

We will use our knn method to reassign cells based on their SNP profiles. The
training data is the high confidence cells

```
set.seed(1)
multiplexed_scrnaseq_sce$labels<-as.character(multiplexed_scrnaseq_sce$labels)
multiplexed_scrnaseq_sce$knn <- reassign_centroid(multiplexed_scrnaseq_sce,
    train_cells = multiplexed_scrnaseq_sce$train,
    predict_cells = multiplexed_scrnaseq_sce$predict,
    min_cells = 5
)
#> [1] 2542    6
#> [1] 3837
#> Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6  Doublet  Doublet
#>      579      394      845      571      696      752      501      756
#>  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet
#>      689      746      743      528      480      499      477      773
#>  Doublet  Doublet  Doublet  Doublet  Doublet
#>      875      944      706      719      846
#> [1] 1500

table(multiplexed_scrnaseq_sce$knn)
#>
#>  Doublet Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6
#>      464      119       30      340      155      429      463
```

```
hm <- Heatmap(counts(altExp(multiplexed_scrnaseq_sce, "SNP")),
    column_split = multiplexed_scrnaseq_sce$knn,
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_names_rot = 45,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "SNP profiles split by updated knn classification",
    padding = unit(c(2, 15, 2, 2), "mm")
)
```

![](data:image/png;base64...)

Focusing in on the knn Hashtag5 group, we see that a lot of the Negative cells
have now been correctly reclassed to this group, as well as a small number of
cells from other groups.

```
hm <- Heatmap(counts(altExp(multiplexed_scrnaseq_sce, "SNP"))[, multiplexed_scrnaseq_sce$knn == "Hashtag5"],
    column_split = multiplexed_scrnaseq_sce$seurat[multiplexed_scrnaseq_sce$knn == "Hashtag5"],
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_names_rot = 45,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "knn Hashtag5 group split by Seurat HTODemux classification",
    padding = unit(c(2, 15, 2, 2), "mm")
)
```

![](data:image/png;base64...)

## 5.1 Performance

Next we will run some basic performance checks. We subset our
SingleCellExperiment object to only retain cells which we could confidently call
as being from a singlet group, then split this into a training and test dataset.

```
sce_test <- multiplexed_scrnaseq_sce[, multiplexed_scrnaseq_sce$train == TRUE]
sce_test$knn <- NULL
#sce_test$labels <- droplevels(sce_test$labels)
sce_test
#> class: SingleCellExperiment
#> dim: 259 1045
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(259): RPL22 CDC42 ... MT-ND5 MT-CYB
#> rowData names(0):
#> colnames(1045): AAACCTGAGCGTCAAG-1 AAACCTGAGGCGTACA-1 ...
#>   ACTTTCAGTAAGAGAG-1 ACTTTCAGTAAGTTCC-1
#> colData names(11): orig.ident nCount_RNA ... predict labels
#> reducedDimNames(0):
#> mainExpName: RNA
#> altExpNames(3): HTO SNPcons SNP

sce_test$train2 <- rep(FALSE, length(sce_test$train))
sce_test$train2[seq_len(500)] <- TRUE

sce_test$test <- sce_test$train2 == FALSE
```

Comparing the predicted labels in the test dataset with the hidden high
confidence labels, we see excellent agreement.

```
sce_test$knn <- reassign_centroid(sce_test, train_cells = sce_test$train2, predict_cells = sce_test$test, min_cells = 5)
#> [1] 2542    6
#> [1] 3837
#> Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6  Doublet  Doublet
#>      579      394      845      571      696      752      501      756
#>  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet
#>      689      746      743      528      480      499      477      773
#>  Doublet  Doublet  Doublet  Doublet  Doublet
#>      875      944      706      719      846

table(sce_test$labels[sce_test$test == TRUE], sce_test$knn[sce_test$test == TRUE])
#>
#>            Doublet Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6
#>   Hashtag1       2       34        0        0        0        0        0
#>   Hashtag2       0        0       11        0        0        0        0
#>   Hashtag3       0        0        0      122        0        0        0
#>   Hashtag4       1        0        0        0       45        0        0
#>   Hashtag5       7        0        0        0        0      187        1
#>   Hashtag6       1        0        0        0        0        0      134
```

We can also show that that the model can correct misclassified cells when
predicted back on the training data. We create a new vector “labels2” which is
initially identical to the labels used in training previously.

```
sce_test$knn <- NULL

sce_test$labels2 <- sce_test$labels

table(sce_test$labels, sce_test$labels2)
#>
#>            Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6
#>   Hashtag1       62        0        0        0        0        0
#>   Hashtag2        0       15        0        0        0        0
#>   Hashtag3        0        0      226        0        0        0
#>   Hashtag4        0        0        0      102        0        0
#>   Hashtag5        0        0        0        0      348        0
#>   Hashtag6        0        0        0        0        0      292
```

We then randomly reassign 25 cells from Hashtag5 to Hashtag2 in the training
data. Predicting the model back on itself we see that in the new predicted
labels, the 25 altered have been correctly reclassified back to Hashtag5

```
sce_test$labels2[which(sce_test$labels2 == "Hashtag5")[1:25]] <- "Hashtag2"

table(sce_test$labels, sce_test$labels2)
#>
#>            Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6
#>   Hashtag1       62        0        0        0        0        0
#>   Hashtag2        0       15        0        0        0        0
#>   Hashtag3        0        0      226        0        0        0
#>   Hashtag4        0        0        0      102        0        0
#>   Hashtag5        0       25        0        0      323        0
#>   Hashtag6        0        0        0        0        0      292

sce_test$knn <- reassign_centroid(sce_test,
    train_cells = sce_test$train,
    predict_cells = sce_test$train,
    min_cells = 5
)
#> [1] 2542    6
#> [1] 3837
#> Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6  Doublet  Doublet
#>      579      394      845      571      696      752      501      756
#>  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet  Doublet
#>      689      746      743      528      480      499      477      773
#>  Doublet  Doublet  Doublet  Doublet  Doublet
#>      875      944      706      719      846

table(sce_test$labels, sce_test$knn)
#>
#>            Doublet Hashtag1 Hashtag2 Hashtag3 Hashtag4 Hashtag5 Hashtag6
#>   Hashtag1       2       60        0        0        0        0        0
#>   Hashtag2       0        0       15        0        0        0        0
#>   Hashtag3       0        0        0      226        0        0        0
#>   Hashtag4       2        0        0        0      100        0        0
#>   Hashtag5      15        0        0        0        0      332        1
#>   Hashtag6       1        0        0        0        0        0      291
```

For the knn Hashtag6 group, we see mostly good agreement with the original
demuxmix labels. However, it appears one cell now being called a Hashtag6 was
originally called Hashtag5. Again, we can investigate this by visualising the
corresponding SNP profile. In doing so, we can see that this most likely is a
true Hashtag6.

```
hm <- Heatmap(counts(altExp(sce_test, "SNP"))[, sce_test$knn == "Hashtag6"],
    column_split = sce_test$labels[sce_test$knn == "Hashtag6"],
    cluster_rows = FALSE,
    show_column_names = FALSE,
    cluster_column_slices = FALSE,
    column_names_rot = 45,
    column_title_rot = -45,
    row_title = "SNPs",
    show_row_names = FALSE,
    col = colors
)

draw(hm,
    column_title = "knn Hashtag6 group split by demuxmix classification",
    padding = unit(c(2, 15, 2, 2), "mm")
)
```

![](data:image/png;base64...)

# 6 Session Info

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
#> [1] grid      stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] EnsDb.Hsapiens.v86_2.99.0   dittoSeq_1.22.0
#>  [3] ggpubr_0.6.2                ggplot2_4.0.0
#>  [5] Seurat_5.3.1                SeuratObject_5.2.0
#>  [7] sp_2.2-0                    viridisLite_0.4.2
#>  [9] ComplexHeatmap_2.26.0       demuxSNP_1.8.0
#> [11] ensembldb_2.34.0            AnnotationFilter_1.34.0
#> [13] GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
#> [15] VariantAnnotation_1.56.0    Rsamtools_2.26.0
#> [17] Biostrings_2.78.0           XVector_0.50.0
#> [19] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#> [21] Biobase_2.70.0              GenomicRanges_1.62.0
#> [23] Seqinfo_1.0.0               IRanges_2.44.0
#> [25] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [27] generics_0.1.4              MatrixGenerics_1.22.0
#> [29] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] ProtGenerics_1.42.0      spatstat.sparse_3.1-0    bitops_1.0-9
#>   [4] httr_1.4.7               RColorBrewer_1.1-3       doParallel_1.0.17
#>   [7] ggsci_4.1.0              tools_4.5.1              sctransform_0.4.2
#>  [10] backports_1.5.0          R6_2.6.1                 lazyeval_0.2.2
#>  [13] uwot_0.2.3               GetoptLong_1.0.5         withr_3.0.2
#>  [16] gridExtra_2.3            progressr_0.17.0         KernelKnn_1.1.6
#>  [19] cli_3.6.5                Cairo_1.7-0              spatstat.explore_3.5-3
#>  [22] fastDummies_1.7.5        labeling_0.4.3           sass_0.4.10
#>  [25] S7_0.2.0                 spatstat.data_3.1-9      ggridges_0.5.7
#>  [28] pbapply_1.7-4            dichromat_2.0-0.1        parallelly_1.45.1
#>  [31] BSgenome_1.78.0          RSQLite_2.4.3            shape_1.4.6.1
#>  [34] BiocIO_1.20.0            ica_1.0-3                spatstat.random_3.4-2
#>  [37] car_3.1-3                dplyr_1.1.4              Matrix_1.7-4
#>  [40] abind_1.4-8              lifecycle_1.0.4          yaml_2.3.10
#>  [43] carData_3.0-5            SparseArray_1.10.0       Rtsne_0.17
#>  [46] blob_1.2.4               promises_1.4.0           crayon_1.5.3
#>  [49] miniUI_0.1.2             lattice_0.22-7           cowplot_1.2.0
#>  [52] cigarillo_1.0.0          KEGGREST_1.50.0          demuxmix_1.12.0
#>  [55] magick_2.9.0             pillar_1.11.1            knitr_1.50
#>  [58] rjson_0.2.23             future.apply_1.20.0      codetools_0.2-20
#>  [61] glue_1.8.0               spatstat.univar_3.1-4    data.table_1.17.8
#>  [64] vctrs_0.6.5              png_0.1-8                spam_2.11-1
#>  [67] gtable_0.3.6             cachem_1.1.0             xfun_0.53
#>  [70] S4Arrays_1.10.0          mime_0.13                survival_3.8-3
#>  [73] pheatmap_1.0.13          iterators_1.0.14         tinytex_0.57
#>  [76] fitdistrplus_1.2-4       ROCR_1.0-11              nlme_3.1-168
#>  [79] bit64_4.6.0-1            RcppAnnoy_0.0.22         GenomeInfoDb_1.46.0
#>  [82] bslib_0.9.0              irlba_2.3.5.1            KernSmooth_2.23-26
#>  [85] otel_0.2.0               colorspace_2.1-2         DBI_1.2.3
#>  [88] tidyselect_1.2.1         bit_4.6.0                compiler_4.5.1
#>  [91] curl_7.0.0               DelayedArray_0.36.0      plotly_4.11.0
#>  [94] bookdown_0.45            rtracklayer_1.70.0       scales_1.4.0
#>  [97] lmtest_0.9-40            stringr_1.5.2            digest_0.6.37
#> [100] goftest_1.2-3            spatstat.utils_3.2-0     rmarkdown_2.30
#> [103] htmltools_0.5.8.1        pkgconfig_2.0.3          fastmap_1.2.0
#> [106] rlang_1.1.6              GlobalOptions_0.1.2      htmlwidgets_1.6.4
#> [109] UCSC.utils_1.6.0         shiny_1.11.1             farver_2.1.2
#> [112] jquerylib_0.1.4          zoo_1.8-14               jsonlite_2.0.0
#> [115] BiocParallel_1.44.0      RCurl_1.98-1.17          magrittr_2.0.4
#> [118] Formula_1.2-5            dotCall64_1.2            patchwork_1.3.2
#> [121] Rcpp_1.1.0               reticulate_1.44.0        stringi_1.8.7
#> [124] MASS_7.3-65              plyr_1.8.9               parallel_4.5.1
#> [127] listenv_0.9.1            ggrepel_0.9.6            deldir_2.0-4
#> [130] splines_4.5.1            tensor_1.5.1             circlize_0.4.16
#> [133] igraph_2.2.1             spatstat.geom_3.6-0      ggsignif_0.6.4
#> [136] RcppHNSW_0.6.0           reshape2_1.4.4           XML_3.99-0.19
#> [139] evaluate_1.0.5           BiocManager_1.30.26      foreach_1.5.2
#> [142] httpuv_1.6.16            RANN_2.6.2               tidyr_1.3.1
#> [145] purrr_1.1.0              polyclip_1.10-7          future_1.67.0
#> [148] clue_0.3-66              scattermore_1.2          broom_1.0.10
#> [151] xtable_1.8-4             restfulr_0.0.16          RSpectra_0.16-2
#> [154] rstatix_0.7.3            later_1.4.4              class_7.3-23
#> [157] tibble_3.3.0             memoise_2.0.1            GenomicAlignments_1.46.0
#> [160] cluster_2.1.8.1          globals_0.18.0
```

# References

Boggy, Gregory J, G W McElfresh, Eisa Mahyari, Abigail B Ventura, Scott G Hansen, Louis J Picker, and Benjamin N Bimber. 2022. “BFF and cellhashR: Analysis Tools for Accurate Demultiplexing of Cell Hashing Data.” *Bioinformatics* 38 (10): 2791–2801. <https://doi.org/10.1093/bioinformatics/btac213>.

Heaton, Haynes, Arthur M. Talman, Andrew Knights, Maria Imaz, Daniel J. Gaffney, Richard Durbin, Martin Hemberg, and Mara K. N. Lawniczak. 2020. “Souporcell: Robust Clustering of Single-Cell RNA-Seq Data by Genotype Without Reference Genotypes.” *Nature Methods* 17 (6): 615–20. <https://doi.org/10.1038/s41592-020-0820-1>.

Huang, Yuanhua, Davis J. McCarthy, and Oliver Stegle. 2019. “Vireo: Bayesian Demultiplexing of Pooled Single-Cell RNA-Seq Data Without Genotype Reference.” *Genome Biology* 20 (1): 273. <https://doi.org/10.1186/s13059-019-1865-2>.

Kang, Hyun Min, Meena Subramaniam, Sasha Targ, Michelle Nguyen, Lenka Maliskova, Elizabeth McCarthy, Eunice Wan, et al. 2018. “Multiplexed Droplet Single-Cell RNA-Sequencing Using Natural Genetic Variation.” *Nature Biotechnology* 36 (1): 89–94. <https://doi.org/10.1038/nbt.4042>.

Kim, Hani Jieun, Yingxin Lin, Thomas A Geddes, Jean Yee Hwa Yang, and Pengyi Yang. 2020. “CiteFuse Enables Multi-Modal Analysis of CITE-Seq Data.” *Bioinformatics* 36 (14): 4137–43. <https://doi.org/10.1093/bioinformatics/btaa282>.

Stoeckius, Marlon, Shiwei Zheng, Brian Houck-Loomis, Stephanie Hao, Bertrand Z. Yeung, William M. Mauck, Peter Smibert, and Rahul Satija. 2018. “Cell Hashing with Barcoded Antibodies Enables Multiplexing and Doublet Detection for Single Cell Genomics.” *Genome Biology* 19 (1): 224. <https://doi.org/10.1186/s13059-018-1603-1>.