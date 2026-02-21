# Cancer Testis Datasets

Julie Devis, Laurent Gatto, Axelle Loriot

#### 29 October 2025

#### Package

CTdata 1.10.0

# 1 Introduction

`CTdata` is the companion Package for `CTexploreR` and provides omics
data to select and characterise cancer testis genes. Data come from
public databases and include expression and methylation values of
genes in normal, fetal and tumor samples as well as in tumor cell lines, and
expression in cells treated with a demethylating agent is also
available.

The data are served through the `ExperimentHub` infrastructure, which
allows download them only once and cache them for further
use. Currently available data are summarised in the table below and
details in the next section.

```
library("CTdata")
DT::datatable(CTdata())
```

# 2 Installation

To install the package:

```
if (!require("BiocManager"))
    install.packages("CTdata")

BiocManager::install("CTdata")
```

To install the package from GitHub:

```
if (!require("BiocManager"))
    install.packages("BiocManager")

BiocManager::install("UCLouvain-CBIO/CTdata")
```

# 3 Available data

![](data:image/png;base64...)

For details about each data, see their respective manual pages.

## 3.1 Normal adult tissues

### 3.1.1 GTEX data

A `SummarizedExperiment` object with gene expression data in normal
tissues from GTEx database:

```
library("SummarizedExperiment")
```

```
GTEX_data()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24504 32
## metadata(0):
## assays(1): TPM
## rownames(24504): ENSG00000243485 ENSG00000237613 ... ENSG00000198695
##   ENSG00000198727
## rowData names(5): external_gene_name GTEX_category q75_TPM_somatic
##   max_TPM_somatic ratio_testis_somatic
## colnames(32): Testis Ovary ... Uterus Vagina
## colData names(0):
```

### 3.1.2 Normal tissue gene expression

A `SummarizedExperiment` object with gene expression values in normal
tissues with or without allowing multimapping:

```
normal_tissues_multimapping_data()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24504 18
## metadata(0):
## assays(2): TPM_no_multimapping TPM_with_multimapping
## rownames(24504): ENSG00000000003 ENSG00000000005 ... ENSG00000284543
##   ENSG00000284546
## rowData names(3): external_gene_name lowly_expressed_in_GTEX
##   multimapping_analysis
## colnames(18): adrenal_gland breast_epithelium ... transverse_colon
##   upper_lobe_of_left_lung
## colData names(0):
```

### 3.1.3 Methylation in normal adult tissues

A `RangedSummarizedExperiment` containing methylation of CpGs located
within gene promoters in normal tissues:

```
methylation_in_tissues()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: RangedSummarizedExperiment
## dim: 4280327 14
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames(14): adipose colon ... thyroid sperm
## colData names(0):
```

(`CT_methylation_in_tissues` before v 1.5)

A `SummarizedExperiment` with all genes’ promoters mean
methylation in normal tissues:

```
mean_methylation_in_tissues()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24502 14
## metadata(0):
## assays(1): ''
## rownames(24502): MIR1302-2HG FAM138A ... MT-ND6 MT-CYB
## rowData names(7): ensembl_gene_id CpG_density ... somatic_methylation
##   germline_methylation
## colnames(14): adipose colon ... thyroid sperm
## colData names(0):
```

(`CT_mean_methylation_in_tissues` before v 1.5)

### 3.1.4 Testis scRNAseq data

A `SingleCellExperiment` object containing gene expression from testis
single cell RNAseq experiment (*The adult human testis transcriptional
cell atlas* (Guo et al. 2018)):

```
library("SingleCellExperiment")
```

```
testis_sce()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 20891 6490
## metadata(0):
## assays(2): counts logcounts
## rownames(20891): FAM87B LINC00115 ... NCF4-AS1 LINC01689
## rowData names(4): external_gene_name percent_pos_testis_germcells
##   percent_pos_testis_somatic testis_cell_type
## colnames(6490): Donor2-AAACCTGGTGCCTTGG-1 Donor2-AAACCTGTCAACGGGA-1 ...
##   Donor1-TTTGTCAGTGTGCGTC-2 Donor1-TTTGTCATCCAAACTG-2
## colData names(6): nGene nUMI ... Donor sizeFactor
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

### 3.1.5 Oocytes scRNAseq data

A `SingleCellExperiment` object containing gene expression from oocytes
single cell RNAseq experiment (Yan et al. 2021):

```
oocytes_sce()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 26500 899
## metadata(0):
## assays(2): counts logcounts
## rownames(26500): A1BG A1BG-AS1 ... ZSCAN12P1 ZUFSP
## rowData names(0):
## colnames(899): RNA_GO1_sc1 RNA_GO1_sc2 ... RNA_Immune_sc19
##   RNA_Immune_sc20
## colData names(5): type sex stage germcell sizeFactor
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

### 3.1.6 Human Protein Atlas scRNAseq data

A `SingleCellExperiment` object containing gene expression in different human
cell types based on scRNAseq data obtained from the Human Protein Atlas
(<https://www.proteinatlas.org>)

```
scRNAseq_HPA()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 20082 66
## metadata(0):
## assays(1): TPM
## rownames(20082): ENSG00000000003 ENSG00000000005 ... ENSG00000288684
##   ENSG00000288695
## rowData names(4): external_gene_name max_TPM_in_a_somatic_cell_type
##   max_in_germcells_group Higher_in_somatic_cell_type
## colnames(66): Adipocytes T-cells ... Syncytiotrophoblasts Extravillous
##   trophoblasts
## colData names(2): Cell_type group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

### 3.1.7 Human Protein Atlas cell type specificity data

A `tibble` object containing cell type specificities based on scRNAseq data
analysis from the Human Protein Atlas (<https://www.proteinatlas.org>)

```
HPA_cell_type_specificities()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## # A tibble: 24,504 × 7
##    ensembl_gene_id external_gene_name HPA_scRNAseq_celltype_sp…¹ max_HPA_somatic
##    <chr>           <chr>              <chr>                                <dbl>
##  1 ENSG00000243485 MIR1302-2HG        <NA>                                   NA
##  2 ENSG00000237613 FAM138A            <NA>                                   NA
##  3 ENSG00000186092 OR4F5              <NA>                                   NA
##  4 ENSG00000237491 LINC01409          <NA>                                   NA
##  5 ENSG00000177757 FAM87B             <NA>                                   NA
##  6 ENSG00000228794 LINC01128          <NA>                                   NA
##  7 ENSG00000225880 LINC00115          <NA>                                   NA
##  8 ENSG00000230368 FAM41C             <NA>                                   NA
##  9 ENSG00000223764 LINC02593          <NA>                                   NA
## 10 ENSG00000187634 SAMD11             Rod photoreceptor cells: …            239.
## # ℹ 24,494 more rows
## # ℹ abbreviated name: ¹​HPA_scRNAseq_celltype_specific_nTPM
## # ℹ 3 more variables: max_HPA_germcell <dbl>,
## #   not_detected_in_somatic_HPA <lgl>, HPA_ratio_germ_som <dbl>
```

## 3.2 Fetal cells

### 3.2.1 Fetal germ cell scRNAseq data

A `SingleCellExperiment` object containing gene expression from fetal germ cells
single cell RNAseq experiment (*Single-cell roadmap of human gonadal development*(Garcia-Alonso et al. 2022)):

```
FGC_sce()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 22489 10850
## metadata(0):
## assays(2): counts logcounts
## rownames(22489): A1BG A1BG-AS1 ... ZYX ZZEF1
## rowData names(0):
## colnames(10850): FCA_GND8047885_AAGACCTCAGTATAAG
##   FCA_GND8047885_AAGGTTCAGTTAAGTG ...
##   HCA_F_GON10941969_AAGTCTGCAAGGTTCT HCA_F_GON10941969_ACCGTAATCTTCGGTC
## colData names(52): nFeaturess_RNA sample ... stage germcell
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

### 3.2.2 Methylation in fetal germ cells (scWGBS)

A `RangedSummarizedExperiment` containing methylation of CpGs (hg19 based)
located within gene promoters in fetal germ cells (*Dissecting the epigenomic
dynamics of human fetal germ cell development at single-cell resolution*(Li et
al. 2021)):

```
methylation_in_FGC()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: RangedSummarizedExperiment
## dim: 1915545 337
## metadata(0):
## assays(1): ''
## rownames(1915545): 1 2 ... 1915544 1915545
## rowData names(0):
## colnames(337): M_FGC_6W_embryo1_sc1 M_FGC_6W_embryo1_sc2 ...
##   F_Soma_8W_embryo1_sc13 F_Soma_8W_embryo1_sc14
## colData names(25): files sample ... Pass Quality Control (True or
##   False) cellType
```

A `SummarizedExperiment` with all genes’ promoters mean
methylation in fetal germ cells:

```
mean_methylation_in_FGC()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: RangedSummarizedExperiment
## dim: 24441 337
## metadata(0):
## assays(1): ''
## rownames(24441): MIR1302-2HG FAM138A ... CDY1 TTTY3
## rowData names(4): external_gene_name chr TSS_liftover ensembl_gene_id
## colnames(337): M_FGC_6W_embryo1_sc1 M_FGC_6W_embryo1_sc2 ...
##   F_Soma_8W_embryo1_sc13 F_Soma_8W_embryo1_sc14
## colData names(25): files sample ... Pass Quality Control (True or
##   False) cellType
```

### 3.2.3 Embryonic stem cells RNA-Seq data

A `SummarizedExperiment` object with gene expression data in embryonic stem
cells from ENCODE database:

```
hESC_data()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24488 4
## metadata(0):
## assays(1): ''
## rownames(24488): ENSG00000186827 ENSG00000186891 ... ENSG00000198695
##   ENSG00000198727
## rowData names(1): external_gene_name
## colnames(4): H1 H7 H9 HUES64
## colData names(5): sample genotype cell_type dataset data
```

### 3.2.4 Methylation in embryonic stem cells

A `RangedSummarizedExperiment` containing methylation of CpGs
located within gene promoters in embryonic stem cells from ENCODE

```
methylation_in_hESC()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: RangedSummarizedExperiment
## dim: 4280098 3
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames(3): H1 HUES64 H9
## colData names(4): genotype cell_type dataset data
```

A `SummarizedExperiment` with all genes’ promoters mean
methylation in embryonic stem cells:

```
mean_methylation_in_hESC()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24488 3
## metadata(0):
## assays(1): ''
## rownames(24488): MIR1302-2HG FAM138A ... MT-ND6 MT-CYB
## rowData names(1): ensembl_gene_id
## colnames(3): H1 HUES64 H9
## colData names(4): genotype cell_type dataset data
```

### 3.2.5 Early embryo scRNA-seq data

A `SingleCellExperiment` object containing gene expression from early embryo
single cell RNAseq experiment (Petropulous et al, 2014):

```
embryo_sce_Petropoulos()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 26178 1481
## metadata(0):
## assays(1): ''
## rownames(26178): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(1481): E3.1.443 E3.1.444 ... E3.53.3437 E3.53.3438
## colData names(10): sample individual ... genotype day_stage
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

A `SingleCellExperiment` object containing gene expression from early embryo
single cell RNAseq experiment (Zhu et al, 2018):

```
embryo_sce_Zhu()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 26255 50
## metadata(0):
## assays(1): ''
## rownames(26255): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(50): Icm01-W-b185R Icm01-W-b186R ... Icm11-Q-s111R
##   Icm13-Q-s123R
## colData names(5): sample embryo sex genotype stage
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

### 3.2.6 Methylation in early embryo

A `RangedSummarizedExperiment` containing methylation of CpGs (hg19 based)
located within gene promoters in early embryo (*Single Cell DNA Methylome
Sequencing of Human Preimplantation Embryos* (Zhu et al. 2018)):

```
methylation_in_embryo()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: RangedSummarizedExperiment
## dim: 1915545 492
## metadata(0):
## assays(1): ''
## rownames(1915545): 1 2 ... 1915544 1915545
## rowData names(0):
## colnames(492): scBS-2C-11-2 scBS-2C-6-1 ... 9W-PBAT-villus-1
##   9W-PBAT-villus-2
## colData names(17): sample Sample_Name ... stage_level individual
```

A `RangedSummarizedExperiment` with all genes’ promoters mean
methylation in early embryo:

```
mean_methylation_in_embryo()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: RangedSummarizedExperiment
## dim: 24441 492
## metadata(0):
## assays(1): ''
## rownames(24441): MIR1302-2HG FAM138A ... CDY1 TTTY3
## rowData names(4): external_gene_name chr TSS_liftover ensembl_gene_id
## colnames(492): scBS-2C-11-2 scBS-2C-6-1 ... 9W-PBAT-villus-1
##   9W-PBAT-villus-2
## colData names(17): sample Sample_Name ... stage_level individual
```

## 3.3 Demethylated gene expression

A `SummarizedExperiment` object containing genes differential
expression analysis (with RNAseq expression values) in cell lines
treated or not with a demethylating agent (5-Aza-2’-Deoxycytidine).

```
DAC_treated_cells()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24516 32
## metadata(0):
## assays(2): counts log1p
## rownames(24516): ENSG00000243485 ENSG00000237613 ... ENSG00000198695
##   ENSG00000198727
## rowData names(51): external_gene_name logFC_B2-1 ...
##   expressed_in_n_CTLs induced
## colnames(32): B2-1_CTL_rep1 B2-1_CTL_rep2 ... TS603_DAC_rep1
##   TS603_DAC_rep2
## colData names(9): ref cell ... library lab
```

As above, with multimapping:

```
DAC_treated_cells_multimapping()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24516 32
## metadata(0):
## assays(2): counts log1p
## rownames(24516): ENSG00000243485 ENSG00000237613 ... ENSG00000198695
##   ENSG00000198727
## rowData names(51): external_gene_name logFC_B2-1 ...
##   expressed_in_n_CTLs induced
## colnames(32): B2-1_CTL_rep1 B2-1_CTL_rep2 ... TS603_DAC_rep1
##   TS603_DAC_rep2
## colData names(9): ref cell ... library lab
```

## 3.4 Tumor cells

### 3.4.1 CCLE data

A `SummarizedExperiment` object with gene expression data in cancer
cell lines from CCLE:

```
CCLE_data()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24473 1229
## metadata(0):
## assays(1): TPM
## rownames(24473): ENSG00000000003 ENSG00000000005 ... ENSG00000284543
##   ENSG00000284546
## rowData names(5): external_gene_name
##   percent_of_positive_CCLE_cell_lines
##   percent_of_negative_CCLE_cell_lines max_TPM_in_CCLE CCLE_category
## colnames(1229): LC1SQSF COLO794 ... ECC2 A673
## colData names(30): DepMap_ID cell_line_name ... Cellosaurus_issues type
```

Also, a `matrix` with gene expression correlations in CCLE cancer cell lines:

```
dim(CCLE_correlation_matrix())
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## [1]   280 24473
```

```
CCLE_correlation_matrix()[1:10, 1:5]
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
## loading from cache
```

```
##                 ENSG00000000003 ENSG00000000005 ENSG00000000419 ENSG00000000457
## ENSG00000234593    -0.042559061     -0.02260210    -0.001087715     -0.03065048
## ENSG00000131914     0.098018050      0.06235265     0.046643780      0.05024423
## ENSG00000142698    -0.009432254     -0.01408246     0.007391337      0.02454294
## ENSG00000237853    -0.138887798     -0.01271797    -0.037329853      0.05698454
## ENSG00000137948     0.033196350     -0.02608040    -0.048157615      0.03628293
## ENSG00000198765     0.065224719      0.18979142    -0.027800786      0.04206350
## ENSG00000237463     0.021518007      0.08340824    -0.049098371      0.06081589
## ENSG00000215817     0.008231479      0.02363575    -0.025976223      0.22487743
## ENSG00000162843    -0.081540599     -0.02955100    -0.028112586      0.10566880
## ENSG00000231532     0.017052699     -0.03030163    -0.011278072      0.11582391
##                 ENSG00000000460
## ENSG00000234593    -0.014316867
## ENSG00000131914     0.032435630
## ENSG00000142698     0.008474658
## ENSG00000237853     0.005744308
## ENSG00000137948     0.040348684
## ENSG00000198765     0.082344278
## ENSG00000237463     0.022831373
## ENSG00000215817     0.153775364
## ENSG00000162843     0.020582537
## ENSG00000231532     0.094532634
```

### 3.4.2 TCGA data

A `SummarizedExperiment` with gene expression data in TCGA samples
(tumor and peritumoral samples : SKCM, LUAD, LUSC, COAD, ESCA, BRCA
and HNSC):

```
TCGA_TPM()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 24497 4141
## metadata(0):
## assays(1): TPM
## rownames(24497): ENSG00000000003 ENSG00000000005 ... ENSG00000284543
##   ENSG00000284546
## rowData names(32): external_gene_name percent_pos_SKCM ...
##   max_q75_in_NT TCGA_category
## colnames(4141): TCGA-EB-A5SF-01A-11R-A311-07
##   TCGA-EE-A3J8-06A-11R-A20F-07 ... TCGA-CV-6935-11A-01R-1915-07
##   TCGA-CV-7183-01A-11R-2016-07
## colData names(65): patient sample ... CD8_T_cells proliferation_score
```

Also, a `SummarizedExperiment` with gene promoters methylation data in TCGA
samples (tumor and peritumoral samples : SKCM, LUAD, LUSC, COAD, ESCA, BRCA
and HNSC):

```
TCGA_methylation()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## class: RangedSummarizedExperiment
## dim: 79445 3423
## metadata(0):
## assays(1): methylation
## rownames(79445): cg14057946 cg11422233 ... cg22051787 cg03930849
## rowData names(52): address_A address_B ... MASK_extBase MASK_general
## colnames(3423): TCGA-ER-A42L-06A-11D-A24V-05
##   TCGA-WE-A8K1-06A-21D-A373-05 ... TCGA-BB-A6UO-01A-12D-A34K-05
##   TCGA-IQ-A61O-01A-11D-A30F-05
## colData names(3): samples sample project_id
```

(`TCGA_CT_methylation` before v 1.5)

## 3.5 CT genes determination

### 3.5.1 All genes

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

The analysis for all genes can be found in `all_genes`, a tibble like `CT_genes`
containing all 24488 genes characterisation.

```
all_genes()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## # A tibble: 24,488 × 47
##    ensembl_gene_id external_gene_name CT_gene_type testis_specificity
##    <chr>           <chr>              <chr>        <chr>
##  1 ENSG00000243485 MIR1302-2HG        other        not_testis_specific
##  2 ENSG00000237613 FAM138A            other        not_testis_specific
##  3 ENSG00000186092 OR4F5              other        not_testis_specific
##  4 ENSG00000237491 LINC01409          other        not_testis_specific
##  5 ENSG00000177757 FAM87B             other        not_testis_specific
##  6 ENSG00000228794 LINC01128          other        not_testis_specific
##  7 ENSG00000225880 LINC00115          other        not_testis_specific
##  8 ENSG00000230368 FAM41C             other        not_testis_specific
##  9 ENSG00000223764 LINC02593          other        not_testis_specific
## 10 ENSG00000187634 SAMD11             other        not_testis_specific
## # ℹ 24,478 more rows
## # ℹ 43 more variables: regulated_by_methylation <lgl>, X_linked <lgl>,
## #   chr <chr>, strand <int>, transcript_start <int>, transcript_end <int>,
## #   transcription_start_site <int>, GTEX_category <chr>, q75_TPM_somatic <dbl>,
## #   max_TPM_somatic <dbl>, ratio_testis_somatic <dbl>, TPM_testis <dbl>,
## #   lowly_expressed_in_GTEX <lgl>, multimapping_analysis <chr>,
## #   HPA_scRNAseq_celltype_specific_nTPM <chr>, max_HPA_somatic <dbl>, …
```

### 3.5.2 CT genes

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

With the datasets above, we generated a list of 280 CT and CTP genes (see
figure below for details).

We used multimapping because many CT genes belong to gene families
from which members have identical or nearly identical sequences. This
is likely the reason why these genes are not detected in GTEx
database, as GTEx processing pipeline specifies that overlapping
intervals between genes are excluded from all genes for counting. Some
CT genes can thus only be detected in RNAseq data in which
multimapping reads are not discarded.

![](data:image/png;base64...)

A `tibble` with Cancer-Testis (CT) genes and their characteristics:

```
CT_genes()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## # A tibble: 280 × 47
##    ensembl_gene_id external_gene_name CT_gene_type testis_specificity
##    <chr>           <chr>              <chr>        <chr>
##  1 ENSG00000234593 KAZN-AS1           CT_gene      testis_specific
##  2 ENSG00000131914 LIN28A             CT_gene      testis_specific
##  3 ENSG00000142698 C1orf94            CT_gene      testis_specific
##  4 ENSG00000237853 NFIA-AS1           CT_gene      testis_specific
##  5 ENSG00000137948 BRDT               CT_gene      testis_specific
##  6 ENSG00000198765 SYCP1              CT_gene      testis_specific
##  7 ENSG00000237463 LRRC52-AS1         CT_gene      testis_specific
##  8 ENSG00000215817 ZC3H11B            CT_gene      testis_specific
##  9 ENSG00000162843 WDR64              CT_gene      testis_specific
## 10 ENSG00000231532 LINC01249          CT_gene      testis_specific
## # ℹ 270 more rows
## # ℹ 43 more variables: regulated_by_methylation <lgl>, X_linked <lgl>,
## #   chr <chr>, strand <int>, transcript_start <int>, transcript_end <int>,
## #   transcription_start_site <int>, GTEX_category <chr>, q75_TPM_somatic <dbl>,
## #   max_TPM_somatic <dbl>, ratio_testis_somatic <dbl>, TPM_testis <dbl>,
## #   lowly_expressed_in_GTEX <lgl>, multimapping_analysis <chr>,
## #   HPA_scRNAseq_celltype_specific_nTPM <chr>, max_HPA_somatic <dbl>, …
```

# Session information

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
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           CTdata_1.10.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.53            bslib_0.9.0
##  [4] httr2_1.2.1          htmlwidgets_1.6.4    lattice_0.22-7
##  [7] vctrs_0.6.5          tools_4.5.1          crosstalk_1.2.2
## [10] curl_7.0.0           tibble_3.3.0         AnnotationDbi_1.72.0
## [13] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
## [16] Matrix_1.7-4         dbplyr_2.5.1         lifecycle_1.0.4
## [19] compiler_4.5.1       Biostrings_2.78.0    htmltools_0.5.8.1
## [22] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
## [25] crayon_1.5.3         jquerylib_0.1.4      DT_0.34.0
## [28] DelayedArray_0.36.0  cachem_1.1.0         abind_1.4-8
## [31] ExperimentHub_3.0.0  AnnotationHub_4.0.0  tidyselect_1.2.1
## [34] digest_0.6.37        purrr_1.1.0          dplyr_1.1.4
## [37] bookdown_0.45        BiocVersion_3.22.0   grid_4.5.1
## [40] fastmap_1.2.0        SparseArray_1.10.0   cli_3.6.5
## [43] magrittr_2.0.4       S4Arrays_1.10.0      utf8_1.2.6
## [46] withr_3.0.2          filelock_1.0.3       rappdirs_0.3.3
## [49] bit64_4.6.0-1        rmarkdown_2.30       XVector_0.50.0
## [52] httr_1.4.7           bit_4.6.0            png_0.1-8
## [55] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
## [58] BiocFileCache_3.0.0  rlang_1.1.6          glue_1.8.0
## [61] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [64] R6_2.6.1
```