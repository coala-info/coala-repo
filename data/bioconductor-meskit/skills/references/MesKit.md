# MesKit: Analyze and Visualize Multi-region Whole-exome Sequencing Data

#### 2025-10-30

### 1. Introduction

Intra-tumor heterogeneity (ITH) is now thought to be a key factor that results in the therapeutic failures and drug resistance, which have arose increasing attention in cancer research. Here, we present an R package, MesKit, for characterizing cancer genomic ITH and inferring the history of tumor evolutionary. MesKit provides a wide range of analyses including ITH evaluation, enrichment, signature, clone evolution analysis via implementation of well-established computational and statistical methods. The source code and documents are freely available through Github (<https://github.com/Niinleslie/MesKit>). We also developed a shiny application to provide easier analysis and visualization.

#### 1.1 Citation

In R console, enter `citation("MesKit")`.

\_**MesKit: A Tool Kit for Dissecting Cancer Evolution of Multi-region Tumor Biopsies through Somatic Alterations (In production)**

### 2. Prepare input Data

To analyze with MesKit, you need to provide:

* A MAF file of multi-region samples from patients. (`*.maf / *.maf.gz`). **Required**
* A clinical file contains the clinical data of tumor samples from each patient. **Required**
* Cancer cell fraction (CCF) data of somatic mutations. **Optional but recommended**
* A segmentation file. **Optional**
* The GISTIC outputs. **Optional**

**Note:** `Tumor_Sample_Barcode` should be consistent in all input files, respectively.

#### 2.1 MAF files

Mutation Annotation Format (MAF) files are tab-delimited text files with aggregated mutations information from VCF Files. The input MAF file could be gz compressed, and allowed values of `Variant_Classification`column can be found at [Mutation Annotation Format Page](https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/).

The following fields are required to be contained in the MAF files with MesKit.

**Mandatory fields:**

`Hugo_Symbol`, `Chromosome`, `Start_Position`, `End_Position`, `Variant_Classification`, `Variant_Type`, `Reference_Allele`, `Tumor_Seq_Allele2`, `Ref_allele_depth`, `Alt_allele_depth`, `VAF`, `Tumor_Sample_Barcode`

**Note:**

* The `Tumor_Sample_Barcode` of each sample should be unique.
* The `VAF` (variant allele frequencie) can be on the scale 0-1 or 0-100.

**Example MAF file**

```
##   Hugo_Symbol Chromosome Start_Position End_Position Variant_Classification
## 1      KLHL17          1         899515       899515                 Silent
## 2       MFSD6          2      191301342    191301342      Missense_Mutation
## 3    KIAA0319          6       24596837     24596837      Missense_Mutation
##   Variant_Type Reference_Allele Tumor_Seq_Allele2 Ref_allele_depth
## 1          SNP                C                 T               85
## 2          SNP                G                 A               53
## 3          SNP                C                 T                6
##   Alt_allele_depth   VAF Tumor_Sample_Barcode
## 1                1 0.012             V402_P_1
## 2                0 0.000             V750_P_2
## 3                0 0.000            V750_BM_3
```

#### 2.2 Clinical data files

Clinical data file contains clinical information about each patient and their tumor samples, and mandatory fields are `Tumor_Sample_Barcode`, `Tumor_ID`, `Patient_ID`, and `Tumor_Sample_Label`.

**Example clinical data file**

```
##   Tumor_Sample_Barcode Tumor_ID Patient_ID Tumor_Sample_Label
## 1             V402_P_1        P       V402                P_1
## 2             V402_P_2        P       V402                P_2
## 3             V402_P_3        P       V402                P_3
## 4             V402_P_4        P       V402                P_4
## 5            V402_BM_1       BM       V402               BM_1
```

#### 2.3 CCF files

By default, there are six mandatory fields in input CCF file: `Patient_ID`, `Tumor_Sample_Barcode`, `Chromosome`, `Start_Position`, `CCF` and `CCF_Std`/`CCF_CI_High` (required when identifying clonal/subclonal mutations). The `Chromosome` field of your MAF file and CCF file should be in the same format (both in number or both start with “chr”). Notably, `Reference_Allele` and `Tumor_Seq_Allele2` are also required if you want include contains INDELs in the CCF file.

**Example CCF file**

```
##   Patient_ID Tumor_Sample_Barcode Chromosome Start_Position   CCF CCF_Std
## 1       V402             V402_P_1          1         899515 0.031   0.126
## 2       V402             V402_P_1          1         982996 0.031   0.117
## 3       V402             V402_P_1          1        2452742 0.125   0.239
## 4       V402             V402_P_1          1        6203883 0.422   0.750
## 5       V402             V402_P_1          1       11106655 0.094   0.324
```

#### 2.4 Segmentation files

The segmentation file is a tab-delimited file with the following columns:

* `Patient_ID` - patient ID
* `Tumor_Sample_Barcode` - tumor sample barcode of samples
* `Chromosome` - chromosome name or ID
* `Start_Position` - genomic start position of segments (1-indexed)
* `End_Position` - genomic end position of segments (1-indexed)
* `SegmentMean/CopyNumber` - segment mean value or absolute integer copy number
* `Minor_CN` - copy number of minor allele **Optional**
* `Major_CN` - copy number of major allele **Optional**
* `Tumor_Sample_Label` - the specific label of each tumor sample. **Optional**

**Note:** Positions are in base pair units.

**Example Segmentation file**

```
##   Patient_ID Tumor_Sample_Barcode Chromosome Start_Position End_Position
## 1       V402             V402_P_1          1              1      1650882
## 2       V402             V402_P_1          1        1650883     33159352
## 3       V402             V402_P_1          1       33159353     33610373
## 4       V402             V402_P_1          1       33610374     88509894
## 5       V402             V402_P_1          1       88509895     89462108
##   CopyNumber Minor_CN Major_CN Tumor_Sample_Label
## 1          2        1        1                P_1
## 2          1        0        1                P_1
## 3          3        0        3                P_1
## 4          2        1        1                P_1
## 5          2        0        2                P_1
```

### 3. Installation

#### Via Bioconductor

```
# Installation of MesKit requires Bioconductor version 3.12 or higher
if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
}
# The following initializes usage of Bioc 3.12
BiocManager::install(version = "3.12")
BiocManager::install("MesKit")
```

#### Via GitHub

Install the latest version of this package by typing the commands below in R console:

```
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
devtools::install_github("Niinleslie/MesKit")
```

### 4. Start with the Maf object

`readMaf` function creates Maf/MafList objects by reading MAF files, clinical files and cancer cell fraction (CCF) data (optional but recommended). Parameter `refBuild` is used to set reference genome version for Homo sapiens reference (`"hg18"`, `"hg19"` or `"hg38"`). You should set `use.indel.ccf = TRUE` when your `ccfFile` contains INDELs apart from SNVs.

```
library(MesKit)
```

```
maf.File <- system.file("extdata/", "CRC_HZ.maf", package = "MesKit")
ccf.File <- system.file("extdata/", "CRC_HZ.ccf.tsv", package = "MesKit")
clin.File <- system.file("extdata", "CRC_HZ.clin.txt", package = "MesKit")
# Maf object with CCF information
maf <- readMaf(mafFile = maf.File,
               ccfFile = ccf.File,
               clinicalFile  = clin.File,
               refBuild = "hg19")
```

### 5. Mutational landscape

#### 5.1 Mutational profile

In order to explore the genomic alterations during cancer progression with multi-region sequencing approach, we provided `classifyMut` function to categorize mutations. The classification is based on shared pattern or clonal status (CCF data is required) of mutations, which can be specified by `class` option. Additionally, `classByTumor` can be used to reveal the mutational profile within tumors.

```
# Driver genes of CRC collected from [IntOGen] (https://www.intogen.org/search) (v.2020.2)
driverGene.file <- system.file("extdata/", "IntOGen-DriverGenes_COREAD.tsv", package = "MesKit")
driverGene <- as.character(read.table(driverGene.file)$V1)
mut.class <- classifyMut(maf, class =  "SP", patient.id = 'V402')
head(mut.class)
```

`plotMutProfile` function can visualize the mutational profile of tumor samples.

```
plotMutProfile(maf, class =  "SP", geneList = driverGene, use.tumorSampleLabel = TRUE)
```

![](data:image/png;base64...)

#### 5.2 CNA profile

The `plotCNA` function can characterize the CNA landscape across samples based on copy number data from segmentation algorithms. Besides, MesKit provides options to integrate GISTIC2 results, which can be obtained from <http://gdac.broadinstitute.org>. Please make sure the genome version based on these results is consistent with `refBuild` of the Maf/MafList object .

```
# Read segment file
segCN <- system.file("extdata", "CRC_HZ.seg.txt", package = "MesKit")
# Read gistic output files
all.lesions <- system.file("extdata", "COREAD_all_lesions.conf_99.txt", package = "MesKit")
amp.genes <- system.file("extdata", "COREAD_amp_genes.conf_99.txt", package = "MesKit")
del.genes <- system.file("extdata", "COREAD_del_genes.conf_99.txt", package = "MesKit")
seg <- readSegment(segFile = segCN, gisticAllLesionsFile = all.lesions,
                   gisticAmpGenesFile = amp.genes, gisticDelGenesFile = del.genes)
```

```
## --Processing COREAD_amp_genes.conf_99.txt
## --Processing COREAD_del_genes.conf_99.txt
## --Processing COREAD_all_lesions.conf_99.txt
```

```
seg$V402[1:5, ]
```

```
plotCNA(seg, patient.id = c("V402", "V750", "V824"), use.tumorSampleLabel = TRUE)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the MesKit package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### 6. Measurement of intra-tumor heterogeneity

#### 6.1 Within tumors

##### 6.1.1 MATH score

The `mathScore` function estimates ITH per sample using mutant-allele tumor heterogeneity (MATH) approach [1](#refer). Typically, the higher the MATH score is, more heterogeneous a tumor sample is [2](#refer) [3](#refer). For MRS, this function can estimate the MATH score within tumor based on the merged VAF when `withTumor = TRUE`.

```
# calculate MATH score of each sample
mathScore(maf, patient.id = 'V402')
```

```
## $V402
##   Patient_ID Tumor_Sample_Barcode MATH_Score
## 1       V402            V402_BM_1    123.550
## 2       V402            V402_BM_2    105.900
## 3       V402            V402_BM_3    101.664
## 4       V402            V402_BM_4    108.724
## 5       V402             V402_P_1     80.191
## 6       V402             V402_P_2     99.897
## 7       V402             V402_P_3    100.515
## 8       V402             V402_P_4     92.337
```

##### 6.1.2 AUC of CCF

The `ccfAUC` function calculates the area under the curve (AUC) of the cumulative density function based on the CCFs per tumor. Tumors with higher AUC values are considered to be more heterogeneous [4](#refer).

```
AUC <- ccfAUC(maf, patient.id = 'V402', use.tumorSampleLabel = TRUE)
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the MesKit package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
names(AUC)
```

```
## [1] "AUC.value"        "CCF.density.plot"
```

```
# show cumulative density plot of CCF
AUC$CCF.density.plot
```

![](data:image/png;base64...)

##### 6.1.3 Mutation clustering

For a single region/tumor, `mutCluster` function clusters mutations in one dimension by VAFs or CCFs based on a Gaussian finite mixture model (using mclust). This function only focuses on heterozygous mutations within copy-number neutral and loss of heterozygosity (LOH)-free regions when clustering VAFs, as copy number aberrations will alter the fraction of reads bearing mutations. Note that, “low VAF/CCF” populations might be a mixture of subclones mutations represent admixed polyphyletic lineages [14](#refer).

```
mut.cluster <- mutCluster(maf, patient.id = 'V402',
                          use.ccf = TRUE, use.tumorSampleLabel = TRUE)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
clusterPlots <- mut.cluster$cluster.plot
cowplot::plot_grid(plotlist = clusterPlots[1:6])
```

![](data:image/png;base64...)

#### 6.2 Between regions/tumors

To quantify the genetic divergence of ITH between regions or tumors, we introduced two classical metrics derived from population genetics, which were Wright’s fixation index (Fst) [5](#refer) [6](#refer) [7](#refer) and Nei’s genetic distance [8](#refer).

##### 6.2.1 Fixation index

```
# calculate the Fst of brain metastasis from V402
calFst(maf, patient.id = 'V402', plot = TRUE, use.tumorSampleLabel = TRUE,
       withinTumor  = TRUE, number.cex = 10)[["V402_BM"]]
```

```
## $Fst.avg
## [1] 0.03600727
##
## $Fst.pair
##            BM_1       BM_2       BM_3       BM_4
## BM_1 1.00000000 0.03825504 0.05133115 0.02173604
## BM_2 0.03825504 1.00000000 0.04722441 0.02393010
## BM_3 0.05133115 0.04722441 1.00000000 0.03356684
## BM_4 0.02173604 0.02393010 0.03356684 1.00000000
##
## $Fst.plot
```

![](data:image/png;base64...)

##### 6.2.2 Nei’s genetic distance

```
# calculate the Nei's genetic distance of brain metastasis from V402
calNeiDist(maf, patient.id = 'V402', use.tumorSampleLabel = TRUE,
           withinTumor  = TRUE, number.cex = 10)[["V402_BM"]]
```

```
## $Nei.dist.avg
## [1] 0.01008835
##
## $Nei.dist
##             BM_1        BM_2       BM_3        BM_4
## BM_1 1.000000000 0.007271303 0.01751193 0.004240568
## BM_2 0.007271303 1.000000000 0.01573008 0.004302810
## BM_3 0.017511933 0.015730084 1.00000000 0.011473404
## BM_4 0.004240568 0.004302810 0.01147340 1.000000000
##
## $Nei.plot
```

![](data:image/png;base64...)

### 7. Metastatic routes inference

Metastasis remains poorly understood despite its critical clinical significance, and the understanding of metastasis process offers supplementary information for clinical treatments.

#### 7.1 Pairwise CCF comparison

Distinct patterns of monoclonal versus polyclonal seeding based on the CCFs of somatic mutations between sample/tumor pairs. `compareCCF` function returns a result list of pairwise CCF of mutations, which are identified across samples from a single patient. Recently, this method has been widely used to deduce the potential metastatic route between different paired tumor lesions [9](#refer) [10](#refer).

```
ccf.list <- compareCCF(maf, pairByTumor = TRUE, min.ccf = 0.02,
                       use.adjVAF = TRUE, use.indel = FALSE)
V402_P_BM <- ccf.list$V402$`P-BM`
# visualize via smoothScatter R package
graphics::smoothScatter(matrix(c(V402_P_BM[, 3], V402_P_BM[, 4]),ncol = 2),
                xlim = c(0, 1), ylim = c(0, 1),
                colramp = colorRampPalette(c("white", RColorBrewer::brewer.pal(9, "BuPu"))),
                xlab = "P", ylab = "BM")

## show driver genes
gene.idx <- which(V402_P_BM$Hugo_Symbol %in% driverGene)
points(V402_P_BM[gene.idx, 3:4], cex = 0.6, col = 2, pch = 2)
text(V402_P_BM[gene.idx, 3:4], cex = 0.7, pos = 1,
       V402_P_BM$Hugo_Symbol[gene.idx])
title("V402 JSI = 0.341", cex.main = 1.5)
```

![](data:image/png;base64...)

#### 7.2 Jaccard similarity index

The Jaccard similarity index (JSI) can be used to calculate mutational similarity between regions, which is defined as the ratio of shared variants to all variants for sample pairs [11](#refer). Users can distinguish monoclonal versus polyclonal seeding in metastases (including lymph node metastases and distant metastases) via `calJSI` function, and higher JSI values indicate the higher possibility of polyclonal seeding [12](#refer).

```
JSI.res <- calJSI(maf, patient.id = 'V402', pairByTumor = TRUE, min.ccf = 0.02,
                  use.adjVAF = TRUE, use.indel = FALSE, use.tumorSampleLabel = TRUE)
names(JSI.res)
```

```
## [1] "JSI.multi" "JSI.pair"
```

```
# show the JSI result
JSI.res$JSI.multi
```

```
## [1] 0.3410853
```

```
JSI.res$JSI.pair
```

```
##            P        BM
## P  1.0000000 0.3410853
## BM 0.3410853 1.0000000
```

#### 7.3 Neutral evolution

The subclonal mutant allele frequencies of a tumor follow a simple power-law distribution predicted by neutral growth [13](#refer). Users can evaluate whether a tumor follows neutral evolution or not under strong selection via the `testNeutral` function. Tumors with R2 >= `R2.threshold` (Default: 0.98) are considered to follow neutral evolution. Besides, this function can also generate the model fitting plot of each sample if the argument `plot` is set to`TRUE`. Please note that this analysis has been superseded by [*mobster*](https://github.com/caravagnalab/mobster) [14](#refer).

```
neutralResult <- testNeutral(maf, min.mut.count = 10, patient.id = 'V402', use.tumorSampleLabel = TRUE)
neutralResult$neutrality.metrics
```

```
neutralResult$model.fitting.plot$P_1
```

![](data:image/png;base64...)

### 8. Phylogenetic tree analysis

#### 8.1 Phylogenetic tree construction

With MesKit, phylogenetic tree construction for each individual is based on the binary present/absence matrix of mutations across all tumor regions.
Based on the Maf object, `getPhyloTree` function reconstructs phylogenetic tree in different methods, including “NJ” (Neibor-Joining) , “MP” (maximum parsimony), “ML” (maximum likelihood), “FASTME.ols” and “FASTME.bal”, which can be set by controlling the `method` parameter. The phylogenetic tree would be stored in a `phyloTree/phyloTreeList` object, and it can be further used for functional exploration, mutational signature analysis and tree visualization.

```
phyloTree <- getPhyloTree(maf, patient.id = "V402", method = "NJ", min.vaf = 0.06)
```

#### 8.2 Compare Phylogenetic trees

Comparison between phylogenetic trees can reveal consensus patterns of tumor evolution. The `compareeTree` function computes distances between phylogenetic trees constructed through different methods, and it returns a vector containing four distances by `treedist` from `phangorn` R package. See [treedist](http://evolution.genetics.washington.edu/phylip/doc/treedist.html) for details.

```
tree.NJ <- getPhyloTree(maf, patient.id = 'V402', method = "NJ")
tree.MP <- getPhyloTree(maf, patient.id = 'V402', method = "MP")
# compare phylogenetic trees constructed by two approaches
compareTree(tree.NJ, tree.MP, plot = TRUE, use.tumorSampleLabel = TRUE)
```

```
## 4 clades are common between two trees.
```

```
## $compare.dist
##     Symmetric.difference       KF-branch distance          Path difference
##                 4.000000               111.858196                 5.291503
## Weighted path difference
##               678.297716
##
## $compare.plot
```

![](data:image/png;base64...)

#### 8.3 Functional exploration (custom module)

Users can conduct functional exploration based on `phyloTree` objects. Below is an example showing how to perform KEGG enrichment analysis via [ClusterProfiler](https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html) by extracting genes in certain categories from a phylotree object.

```
library(org.Hs.eg.db)
library(clusterProfiler)
# Pathway enrichment analysis
V402.branches <- getMutBranches(phyloTree)
# pathway enrichment for private mutated genes of the primary tumor in patient V402
V402_Public <- V402.branches[V402.branches$Mutation_Type == "Private_P", ]
geneIDs = suppressMessages(bitr(V402_Public$Hugo_Symbol, fromType="SYMBOL",
                              toType=c("ENTREZID"), OrgDb="org.Hs.eg.db"))
KEGG_V402_Private_P  = enrichKEGG(
  gene = geneIDs$ENTREZID,
  organism = 'hsa',
  keyType = 'kegg',
  pvalueCutoff = 0.05,
)
dotplot(KEGG_V402_Private_P)
```

![](data:image/png;base64...)

#### 8.4 Mutational characteristics analysis

The sequence context of the base substitutions can be retrieved from the corresponding reference genome to construct a mutation matrix with counts for all 96 trinucleotide changes using “mut\_matrix”. Subsequently, the 6 base substitution type spectrum can be plotted with “plot\_spectrum” , which can be divided into several sample groups.

`mutTrunkBranch` function calculates the fraction of branch/trunk mutations occurring in each of the six types of base substitution types (C>A, C>G, C>T, T>A, T>C, T>G) and conducts two-sided Fisher’s exact tests. For C>T mutations, it can be further classified as C>T at CpG sites or other sites by setting `CT = TRUE`. This function provides option `plot` to show the distribution of branch/trunk mutations. Substitutions types with significant difference between trunk and branch mutations are marked with Asterisks.

```
# load the genome reference
library(BSgenome.Hsapiens.UCSC.hg19)
```

```
mutClass <- mutTrunkBranch(phyloTree, CT = TRUE, plot = TRUE)
names(mutClass)
```

```
## [1] "mutTrunkBranch.res"  "mutTrunkBranch.plot"
```

```
mutClass$mutTrunkBranch.res
```

```
mutClass$mutTrunkBranch.plot
```

![](data:image/png;base64...)

`triMatrix` function generates a mutation count matrix of 96 trinucleotides based on somatic SNVs per sample, which can be later fed into the `fitSignatures` function to estimates the optimal contributions of known signatures to reconstruct a mutational profile. Besides, the signature matrix can be specified (`"cosmic_v2"`, `"exome_cosmic_v3"` and `"nature2013"`) or provided by users via `signaturesRef` parameter. `plotMutSigProfile` function can be utilized to visualize both original mutational profile and reconstructed mutational profile.

```
trimatrix_V402 <- triMatrix(phyloTree, level = 5)
# Visualize the 96 trinucleodide mutational profile
plotMutSigProfile(trimatrix_V402)[[1]]
```

![](data:image/png;base64...)

```
# reconstruct mutational profile of V402 using COSMIC V2 signatures
fit_V402 <- fitSignatures(trimatrix_V402, signaturesRef = "cosmic_v2")
# Compare the reconstructed mutational profile with the original mutational profile
plotMutSigProfile(fit_V402)[[1]]
```

![](data:image/png;base64...)

```
# Below plot shows cosine similarities between the mutational profile of each group and COSMIC signatures
library(ComplexHeatmap)
ComplexHeatmap::Heatmap(fit_V402$V402$cosine.similarity, name = "Cosine similarity")
```

![](data:image/png;base64...)

### 9. Phylogenetic tree visualization

The `plotPhyloTree` functionan of MesKit implemented an auto-layout algorithm to visualize rooted phylogenetic trees with annotations. The branches can be either colored according to classification of mutations or putative known signatures by `branchCol` parameter. Argument `show.bootstrap` is provided to show the support values of internal nodes. Additionally, a phylogenetic tree along with a heatmap of mutation profile (via `mutHeatmap` functionan) enable a better depiction of mutational patterns in tumor phylogeny.

```
# A phylogenetic tree along with binary and CCF heatmap of mutations
phylotree_V402 <- plotPhyloTree(phyloTree, use.tumorSampleLabel = TRUE)
binary_heatmap_V402 <- mutHeatmap(maf, min.ccf = 0.04, use.ccf = FALSE, patient.id = "V402", use.tumorSampleLabel = TRUE)
CCF_heatmap_V402 <- mutHeatmap(maf, use.ccf = TRUE, patient.id = "V402",
                                 min.ccf = 0.04, use.tumorSampleLabel = TRUE)
cowplot::plot_grid(phylotree_V402, binary_heatmap_V402,
                   CCF_heatmap_V402, nrow = 1, rel_widths = c(1.5, 1, 1))
```

![](data:image/png;base64...)

### 10. Shiny APP with video tutorial

The guidance video for MesKit Shiny APP can be found at <http://meskit.renlab.org/video.html>.

### 11. References

1. Mroz, E. A., & Rocco, J. W. (2013). MATH, a novel measure of intratumor genetic heterogeneity, is high in poor-outcome classes of head and neck squamous cell carcinoma. Oral oncology, 49(3), 211–215. <https://doi.org/10.1016/j.oraloncology.2012.09.007>
2. Mroz, E. A., Tward, A. D., Pickering, C. R., Myers, J. N., Ferris, R. L., & Rocco, J. W. (2013). High intratumor genetic heterogeneity is related to worse outcome in patients with head and neck squamous cell carcinoma. Cancer, 119(16), 3034–3042. <https://doi.org/10.1002/cncr.28150>
3. Mroz, E. A., Tward, A. D., Hammon, R. J., Ren, Y., & Rocco, J. W. (2015). Intra-tumor genetic heterogeneity and mortality in head and neck cancer: analysis of data from the Cancer Genome Atlas. PLoS medicine, 12(2), e1001786. <https://doi.org/10.1371/journal.pmed.1001786>
4. Charoentong, P., Finotello, F., Angelova, M., Mayer, C., Efremova, M., Rieder, D., Hackl, H., & Trajanoski, Z. (2017). Pan-cancer Immunogenomic Analyses Reveal Genotype-Immunophenotype Relationships and Predictors of Response to Checkpoint Blockade. Cell reports, 18(1), 248–262. <https://doi.org/10.1016/j.celrep.2016.12.019>
5. Weir, B. S., & Cockerham, C. C. (1984). ESTIMATING F-STATISTICS FOR THE ANALYSIS OF POPULATION STRUCTURE. Evolution; international journal of organic evolution, 38(6), 1358–1370. <https://doi.org/10.1111/j.1558-5646.1984.tb05657.x>
6. Bhatia, G., Patterson, N., Sankararaman, S., & Price, A. L. (2013). Estimating and interpreting FST: the impact of rare variants. Genome research, 23(9), 1514–1521. <https://doi.org/10.1101/gr.154831.113>
7. Holsinger, K. E., & Weir, B. S. (2009). Genetics in geographically structured populations: defining, estimating and interpreting F(ST). Nature reviews. Genetics, 10(9), 639–650. <https://doi.org/10.1038/nrg2611>
8. Puente, X. S., Pinyol, M., Quesada, V., Conde, L., Ordóñez, G. R., Villamor, N., Escaramis, G., Jares, P., Beà, S., González-Díaz, M., Bassaganyas, L., Baumann, T., Juan, M., López-Guerra, M., Colomer, D., Tubío, J. M., López, C., Navarro, A., Tornador, C., Aymerich, M., … Campo, E. (2011). Whole-genome sequencing identifies recurrent mutations in chronic lymphocytic leukaemia. Nature, 475(7354), 101–105. <https://doi.org/10.1038/nature10113>
9. Hu, Z., Ding, J., Ma, Z., Sun, R., Seoane, J. A., Scott Shaffer, J., Suarez, C. J., Berghoff, A. S., Cremolini, C., Falcone, A., Loupakis, F., Birner, P., Preusser, M., Lenz, H. J., & Curtis, C. (2019). Quantitative evidence for early metastatic seeding in colorectal cancer. Nature genetics, 51(7), 1113–1122. <https://doi.org/10.1038/s41588-019-0423-x>
10. Xue, R., Chen, L., Zhang, C., Fujita, M., Li, R., Yan, S. M., Ong, C. K., Liao, X., Gao, Q., Sasagawa, S., Li, Y., Wang, J., Guo, H., Huang, Q. T., Zhong, Q., Tan, J., Qi, L., Gong, W., Hong, Z., Li, M., … Zhang, N. (2019). Genomic and Transcriptomic Profiling of Combined Hepatocellular and Intrahepatic Cholangiocarcinoma Reveals Distinct Molecular Subtypes. Cancer cell, 35(6), 932–947.e8. <https://doi.org/10.1016/j.ccell.2019.04.007>
11. Makohon-Moore, A. P., Zhang, M., Reiter, J. G., Bozic, I., Allen, B., Kundu, D., Chatterjee, K., Wong, F., Jiao, Y., Kohutek, Z. A., Hong, J., Attiyeh, M., Javier, B., Wood, L. D., Hruban, R. H., Nowak, M. A., Papadopoulos, N., Kinzler, K. W., Vogelstein, B., & Iacobuzio-Donahue, C. A. (2017). Limited heterogeneity of known driver gene mutations among the metastases of individual patients with pancreatic cancer. Nature genetics, 49(3), 358–366. <https://doi.org/10.1038/ng.3764>
12. Hu, Z., Li, Z., Ma, Z., & Curtis, C. (2020). Multi-cancer analysis of clonality and the timing of systemic spread in paired primary tumors and metastases. Nature genetics, 52(7), 701–708. <https://doi.org/10.1038/s41588-020-0628-z>
13. Williams, M. J., Werner, B., Barnes, C. P., Graham, T. A., & Sottoriva, A. (2016). Identification of neutral tumor evolution across cancer types. Nature genetics, 48(3), 238–244. <https://doi.org/10.1038/ng.3489>
14. Caravagna, G., Heide, T., Williams, M. J., Zapata, L., Nichol, D., Chkhaidze, K., Cross, W., Cresswell, G. D., Werner, B., Acar, A., Chesler, L., Barnes, C. P., Sanguinetti, G., Graham, T. A., & Sottoriva, A. (2020). Subclonal reconstruction of tumors by using machine learning and population genetics. Nature genetics, 52(9), 898–907. <https://doi.org/10.1038/s41588-020-0675-5>

### 12. Session Info

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ComplexHeatmap_2.26.0             BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] BSgenome_1.78.0                   rtracklayer_1.70.0
##  [5] BiocIO_1.20.0                     Biostrings_2.78.0
##  [7] XVector_0.50.0                    GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0                     clusterProfiler_4.18.0
## [11] org.Hs.eg.db_3.22.0               AnnotationDbi_1.72.0
## [13] IRanges_2.44.0                    S4Vectors_0.48.0
## [15] Biobase_2.70.0                    BiocGenerics_0.56.0
## [17] generics_0.1.4                    MesKit_1.20.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] shape_1.4.6.1               magrittr_2.0.4
##   [5] ggtangle_0.0.7              magick_2.9.0
##   [7] farver_2.1.2                rmarkdown_2.30
##   [9] GlobalOptions_0.1.2         fs_1.6.6
##  [11] vctrs_0.6.5                 Rsamtools_2.26.0
##  [13] memoise_2.0.1               Cairo_1.7-0
##  [15] RCurl_1.98-1.17             ggtree_4.0.0
##  [17] S4Arrays_1.10.0             htmltools_0.5.8.1
##  [19] curl_7.0.0                  SparseArray_1.10.0
##  [21] gridGraphics_0.5-1          sass_0.4.10
##  [23] pracma_2.4.6                KernSmooth_2.23-26
##  [25] bslib_0.9.0                 htmlwidgets_1.6.4
##  [27] plyr_1.8.9                  cachem_1.1.0
##  [29] GenomicAlignments_1.46.0    igraph_2.2.1
##  [31] lifecycle_1.0.4             iterators_1.0.14
##  [33] pkgconfig_2.0.3             Matrix_1.7-4
##  [35] R6_2.6.1                    fastmap_1.2.0
##  [37] gson_0.1.0                  MatrixGenerics_1.22.0
##  [39] clue_0.3-66                 digest_0.6.37
##  [41] aplot_0.2.9                 enrichplot_1.30.0
##  [43] colorspace_2.1-2            patchwork_1.3.2
##  [45] RSQLite_2.4.3               labeling_0.4.3
##  [47] abind_1.4-8                 httr_1.4.7
##  [49] mgcv_1.9-3                  compiler_4.5.1
##  [51] bit64_4.6.0-1               fontquiver_0.2.1
##  [53] withr_3.0.2                 doParallel_1.0.17
##  [55] S7_0.2.0                    BiocParallel_1.44.0
##  [57] DBI_1.2.3                   R.utils_2.13.0
##  [59] DelayedArray_0.36.0         rappdirs_0.3.3
##  [61] rjson_0.2.23                tools_4.5.1
##  [63] ape_5.8-1                   R.oo_1.27.1
##  [65] glue_1.8.0                  quadprog_1.5-8
##  [67] restfulr_0.0.16             nlme_3.1-168
##  [69] GOSemSim_2.36.0             cluster_2.1.8.1
##  [71] reshape2_1.4.4              fgsea_1.36.0
##  [73] gtable_0.3.6                R.methodsS3_1.8.2
##  [75] tidyr_1.3.1                 data.table_1.17.8
##  [77] ggrepel_0.9.6               foreach_1.5.2
##  [79] pillar_1.11.1               stringr_1.5.2
##  [81] yulab.utils_0.2.1           circlize_0.4.16
##  [83] splines_4.5.1               dplyr_1.1.4
##  [85] treeio_1.34.0               lattice_0.22-7
##  [87] bit_4.6.0                   tidyselect_1.2.1
##  [89] fontLiberation_0.1.0        GO.db_3.22.0
##  [91] knitr_1.50                  fontBitstreamVera_0.1.1
##  [93] SummarizedExperiment_1.40.0 xfun_0.53
##  [95] matrixStats_1.5.0           stringi_1.8.7
##  [97] lazyeval_0.2.2              ggfun_0.2.0
##  [99] yaml_2.3.10                 cigarillo_1.0.0
## [101] evaluate_1.0.5              codetools_0.2-20
## [103] gdtools_0.4.4               tibble_3.3.0
## [105] qvalue_2.42.0               ggplotify_0.1.3
## [107] cli_3.6.5                   systemfonts_1.3.1
## [109] jquerylib_0.1.4             dichromat_2.0-0.1
## [111] Rcpp_1.1.0                  png_0.1-8
## [113] XML_3.99-0.19               parallel_4.5.1
## [115] ggplot2_4.0.0               blob_1.2.4
## [117] mclust_6.1.1                DOSE_4.4.0
## [119] bitops_1.0-9                phangorn_2.12.1
## [121] tidytree_0.4.6              ggiraph_0.9.2
## [123] scales_1.4.0                ggridges_0.5.7
## [125] purrr_1.1.0                 crayon_1.5.3
## [127] GetoptLong_1.0.5            rlang_1.1.6
## [129] cowplot_1.2.0               fastmatch_1.1-6
## [131] KEGGREST_1.50.0
```