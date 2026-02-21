# Cancer Testis explorer

Julie Devis, Laurent Gatto, Axelle Loriot

#### 29 October 2025

#### Package

CTexploreR 1.6.0

# 1 Introduction

Cancer-Testis (CT) genes, also called Cancer-Germline (CG), are a group of genes
whose expression is normally restricted to the germline but that are found
aberrantly activated in many types of cancers. These genes produce cancer
specific antigens represent ideal targets for anti-cancer vaccines.
Besides their interest in immunotherapy, they can also be used as cancer
biomarkers and as target of anti-tumor therapies with limited side effect.

Many CT genes use DNA methylation as a primary mechanism of transcriptionnal
regulation. This is another interesting point about CT genes as they represent
suitable models to study DNA demethylation in cancer.

Currently the reference database gathering CT genes is the
[CTdatabase](http://www.cta.lncc.br/) that was published in 2009, based on a
literature screening(Almeida et al., 2009). This database is however not up to
date. Recently identified CT genes are not referenced (in particular CT genes
identified by omics methods that didn’t exist at the time) while some genes
referred as CT genes appeared to be in reality expressed in many somatic
tissues. Furthermore, the database is not in an easily importable format, some
genes are not encoded properly (by synonyms names rather than by their official
HGNC symbol names, or by a concatenation of both) resulting in poor
interoperability for downstream analyses. More recent
studies proposed other lists of CT genes like Wang’s CTatlas (Wang et al., 2016,
Jamin et al., 2021, Carter et al., 2023). These lists were established using
different criteria to define CT genes and hence differ substantially from each
other. Moreover, these lists are usually provided as supplemental data files and
are not strictly speaking databases. Finally, none of these studies describe the
involvement of DNA methylation in the regulation of individual CT genes.

We therefore created `CTexploreR`, a Bioconductor R package, aimed to redefine
rigorously the list of CT genes based on publicly available RNAseq databases
and to summarize their main characteristics. We included methylation analyses
to classify these genes according to whether they are regulated or not by DNA
methylation. The package also offers tools to visualize CT genes expression and
promoter DNA methylation in normal and tumoral tissues. CTexploreR hence
represents an up-to-date reference database for CT genes and can be used as a
starting point for further investigations related to these genes.

# 2 Installation

To install the package:

```
if (!require("BiocManager")) {
    install.packages("BiocManager")
}

BiocManager::install("CTexploreR")
```

To install the package from GitHub:

```
if (!require("BiocManager")) {
    install.packages("BiocManager")
}

BiocManager::install("UCLouvain-CBIO/CTexploreR")
```

# 3 CT genes

The central element of `CTexploreR` is the list of
280 CT and CTP genes (see table below) selected based
on their expression in normal and tumoral tissues (selection details in the next
section). The table also summarises their main characteristics.

```
library(CTexploreR)
```

```
## Loading required package: CTdata
```

```
head(CT_genes, 10)
```

`CTdata` is the companion Package for `CTexploreR` and provides the omics
data that was necessary to select and characterize cancer testis genes as well
as exploring them. The data are served through the `ExperimentHub` infrastructure.
Currently available data are summarised in the table below and details can be
found in `CTdata` vignette or manuals.

```
CTdata()
```

# 4 CT gene selection

In order to generate the list of CT genes, we followed a specific
selection procedure (see figure below).

![](data:image/png;base64...)

## 4.1 Testis-specific expression

Testis-specific genes (expressed exclusively in testis) and testis-preferential
genes (expressed in a few somatic tissues at a level lower than 10x testis
expression) were first selected using the GTEx database (Aguet et al., 2020).

Note that some genes were undetectable in the GTEx database due to multimapping
issues (these were flagged as “lowly expressed” in `GTEX_category` column).
A careful inspection of these genes showed that many of them are well-known
Cancer-Testis genes, belonging to gene families (MAGEA, SSX, CT45A, GAGE, …)
from which members have identical or nearly identical sequences. This is likely
the reason why these genes are not detected in the GTEx database, as GTEx
processing pipeline specifies that overlapping intervals between genes are
excluded from all genes for counting.For these genes, as testis-specificity
could not be assessed using GTEx database, RNAseq data from a set of normal
tissues were reprocessed in order to allow multimapping.
Expression of several genes became detectable in some tissues. Genes showing a
testis-specific expression (expression at least 10x higher in testis than in
any somatic tissues when multimapping was allowed) were selected, and flagged
as testis-specific in `multimapping_analysis` column.

Additionally, as our selection procedure is based on bulk RNAseq data, we wanted
to ensure that the selected genes are not expressed in rare populations of
somatic cells. We used the Single Cell Type Atlas classification from the
Human Protein Atlas (Uhlén et al., 2015) to exclude the ones that were flagged
as specific of any somatic cell type.

## 4.2 Activation in cancer cell lines and TCGA tumors

To assess activation in cancers, RNAseq data from cancer cell lines from CCLE
(Barretina et al., 2012) and from TCGA cancer samples (Cancer Genome Atlas
Research Network et al., 2013) were used. This allowed to select among
testis-specific and testis-preferential genes those that are activated in
cancers.

In the `CCLE_category` and `TCGA_category` columns, genes are tagged as
“activated” when they are highly expressed in at one percent of cancer cell
line/sample (TPM >= 1). However genes that were found to be expressed in all -or
almost all-cancer cell lines/samples were removed, as this probably reflects a
constitutive expression rather than a true activation. We filtered out genes
that were not completely repressed in at least 20 % of cancer cell lines/samples
(TPM <= 0.5). We also made use of the normal peritumoral samples available in
TCGA data to remove from our selection genes that were already detected in a
significant fraction of these cells.

## 4.3 IGV visualisation

All selected CT genes were visualised on IGV (Thorvaldsdóttir et al., 2013)
using a RNA-seq alignment from testis, to ensure that expression in testis
really corresponded to the canonical transcript. The aim was initially to
identify precisely the transcription start site of each gene, but unexpectedly
we observed that for some genes, the reads were not properly aligned on exons,
but were instead spread across a wide genomic region spanning the genes. These
genes, flagged as “unclear” in `IGV_backbone` column, were removed from the
CT\_gene category, as their expression values in GTEX, TCGA and CCLE might
reflect a poorly defined transcription in these regions and are hence likely
unreliable.

## 4.4 Regulation by methylation

Genes flagged as `TRUE` in `regulated_by_methylation` column correspond to

* Genes that are significantly induced by a demethylating agent
  (RNAseq analysis of cell lines reated with DAC
  (5-Aza-2′-Deoxycytidine)).
* Genes that have a highly methylated promoter in normal somatic
  tissues (WGBS analysis of a set of normal tissues).

For some genes showing a strong activation in cells treated with
5-Aza-2′-Deoxycytidine, methylation analysis was not possible due to
multimapping issues. In this case, genes were still considered as regulated by
methylation unless their promoter appeared unmethylated in somatic tissues or
methylated in germ cells.

# 5 Available functions

For details about functions, see their respective manual pages. For all
functions, an option `values_only` can be set to `TRUE` in order to get the values
instead of the visualisation.

All visualisation functions can be used on all GTEx genes, not only
on Cancer-Testis genes, as the data they refer to contains all genes. By default, if no genes are specified in a function, only strict CT genes will
be used. If one wants all 280 CT genes to be used, an option `include_CTP` can
be set to `TRUE` to also use CT preferential genes.

## 5.1 Expression in normal healthy adult tissues

### 5.1.1 `GTEX_expression()`

Allows to visualise gene expression in GTEx tissues. We can for example see the
difference of expression between testis-specific and testis-preferential genes.
Testis-specific genes have been determined with a stricter specificity to the
testis : they are lowly expressed in all somatic tissues and at least 10 times
more in the testis. Whereas testis-preferential accepts a little expression
outside the testis : they are lowly expressed in at least 75% of somatic
tissues, but still 10 times more in the testis.

* Applied to testis-specific genes : we can clearly see the expression strictly
  limited to the testis. We can also see genes that are lowly expressed in GTEx,
  and have thus been characterized using multimapping (see below).

```
testis_specific <- dplyr::filter(
    CT_genes,
    CT_gene_type  == "CT_gene")
GTEX_expression(testis_specific$external_gene_name, units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

* Applied to testis-preferential genes : we can see that the expression is
  less stringent to testis, as expected, with low expression in some other
  tissues, always with a strong testis signal.

```
testis_preferential <- dplyr::filter(
    CT_genes, CT_gene_type  == "CTP_gene")
GTEX_expression(testis_preferential$external_gene_name, units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

### 5.1.2 `normal_tissue_expression_multimapping()`

Allows to visualise the expression values obtained by counting or not
multi-mapped reads in normal tissues. We can apply that to genes that are lowly
expressed in GTEx (as seen above) in order to visualise their expression.
First heatmap shows expression without multimapping while multimapping was
allowed in the second one, where expression can be observed. This allowed
their determination as testis-specific genes.

```
testis_specific_in_multimapping_analysis <-
    dplyr::filter(CT_genes, lowly_expressed_in_GTEX)

normal_tissue_expression_multimapping(
    testis_specific_in_multimapping_analysis$external_gene_name,
    multimapping = FALSE, units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

```
normal_tissue_expression_multimapping(
    testis_specific_in_multimapping_analysis$external_gene_name,
    multimapping = TRUE, units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
## loading from cache
```

![](data:image/png;base64...)

### 5.1.3 `testis_expression()`

Allows to visualise gene expression in all different testis cell type, somatic
or germ, using data from the adult human testis transcriptional cell atlas.

Using CT genes localisation on the X chromosome, we can see that they tend to
be expressed in th early stages of spermatogenesis when located on the X.
We also visualise clearly that genes mainly expressed in an early stage of
spermatogenesis aren’t expressed later and vice-versa.

```
X_CT <-
    dplyr::filter(CT_genes, X_linked)

testis_expression(X_CT$external_gene_name,
                  cells = "germ_cells")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## Warning: 12 out of 82 names invalid: PPP4R3C, CENPVL2, CENPVL1, CT47A1, CT45A6,
## CT45A7, CT45A8, CT45A9, MAGEA4-AS1, MAGEA2, GAGE2E, GAGE12C.
## See the manual page for valid types.
```

```
## `use_raster` is automatically set to TRUE for a matrix with more than
## 2000 columns You can control `use_raster` argument by explicitly
## setting TRUE/FALSE to it.
##
## Set `ht_opt$message = FALSE` to turn off this message.
```

![](data:image/png;base64...)

```
notX_CT <-
    dplyr::filter(CT_genes, !X_linked)

testis_expression(notX_CT$external_gene_name,
                  cells = "germ_cells")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
## loading from cache
```

```
## Warning: 38 out of 198 names invalid: KAZN-AS1, NFIA-AS1, LRRC52-AS1, ZC3H11B,
## THORLNC, LINC02377, SLC7A11-AS1, LINC02241, LINC02228, LINC03004,
## SEC61G-DT, ZNF722, GTF2I-AS1, SPATA31C2, TEX48, LINC02663, LINC02750,
## FAM230C, GOLGA6L7, LINC02864, ZNF723, VCY, VCY1B, RBMY1B, LINC01783,
## DHCR24-DT, LINC03102, C2orf74-AS1, ZNF775-AS1, MIR3150BHG, CHKA-DT,
## UVRAG-DT, CCDC196, POLG-DT, APPBP2-DT, LINC01970, TUBB8B, FAM230I.
## See the manual page for valid types.
```

```
## `use_raster` is automatically set to TRUE for a matrix with more than
## 2000 columns You can control `use_raster` argument by explicitly
## setting TRUE/FALSE to it.
##
## Set `ht_opt$message = FALSE` to turn off this message.
```

![](data:image/png;base64...)

### 5.1.4 `oocytes_expression()`

Allows to visualise gene expression oocytes at different stage, using scRNA-seq
data form “Decoding dynamic epigenetic landscapes in human oocytes using
single-cell multi-omics sequencing” (Yan et al. Cell Stem Cell 2021)

We can here again compare the expression of CT genes that are located or not
on the X chromosome. Showing a lesser expression of X-linked genes in oocytes.

```
oocytes_expression(X_CT$external_gene_name)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## Warning: 4 out of 82 names invalid: PPP4R3C, XAGE1A, TEX13C, MAGEA4-AS1.
## See the manual page for valid types.
```

![](data:image/png;base64...)

```
oocytes_expression(notX_CT$external_gene_name)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
## loading from cache
```

```
## Warning: 52 out of 198 names invalid: KAZN-AS1, LRRC52-AS1, ZC3H11B, THORLNC,
## LINC02377, LINC02241, LINC02228, LINC03004, SEC61G-DT, ZNF722,
## GTF2I-AS1, LINC02663, LINC02750, FAM230C, CBY2, GARIN2, GOLGA6L7,
## CDRT15, CHCT1, LINC02864, TSPY9, DHCR24-DT, LINC03102, SPMIP3,
## C2orf74-AS1, NECTIN3-AS1, CFAP92, LINC02901, TMEM270, ERVW-1, GARIN1B,
## LLCFC1, ZNF775-AS1, PPP1R3B-DT, DNAJC5B, MIR3150BHG, C10orf55, CHKA-DT,
## UVRAG-DT, RB1-DT, CCDC196, INSYN1-AS1, POLG-DT, TEKT5, KCTD19,
## APPBP2-DT, MARCHF10, TUBB8B, SPMAP2, SAXO5, EFCAB8, FAM230I.
## See the manual page for valid types.
```

![](data:image/png;base64...)

### 5.1.5 `HPA_cell_type_expression()`

Allows to visualise gene expression in all different healthy cell type,
comparing different somatic cells to germ cells, using data from the
human proteome atlas.

Visualising all CT\_genes, the specificity to germ cells only is quite clear.

```
HPA_cell_type_expression(units = "scaled")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## Warning: 29 out of 146 names invalid: KAZN-AS1, NFIA-AS1, LRRC52-AS1, LINC01249,
## THORLNC, LINC01206, LINC02475, LINC02377, SLC7A11-AS1, LINC01098,
## LINC01511, LINC02241, LINC02228, LINC03004, SEC61G-DT, GTF2I-AS1,
## LINC00200, LINC02663, LINC01518, LINC02750, TMEM132D-AS1, FAM230C,
## LINC01193, LINC01413, FLJ36000, LINC00470, LINC02864, DSCR8,
## MAGEA4-AS1.
## See the manual page for valid types.
```

![](data:image/png;base64...)

## 5.2 Expression in fetal cells

No analysis was added to the `all_genes` and `CT_genes` tables using these
datasets.

### 5.2.1 `embryo_expression()`

Allows to visualise gene expression in human early embryos using two different
scRNA-seq datasets.

* Single-Cell RNA-Seq Reveals Lineage and X Chromosome Dynamics in Human
  Preimplantation Embryos, Petropoulos et al., Cell 2016

This dataset contains different stages of blastocysts and morula.

```
embryo_expression(dataset = "Petropoulos", include_CTP = FALSE)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## Warning: 62 out of 146 names invalid: KAZN-AS1, LRRC52-AS1, ZC3H11B, THORLNC,
## LINC02475, LINC02377, LINC01511, LINC02241, LINC02228, LINC03004,
## SEC61G-DT, ZNF722, GTF2I-AS1, TEX48, LINC02663, LINC01518, LINC02750,
## MAJIN, TMEM132D-AS1, CBY2, GARIN2, GOLGA6L7, CHCT1, LINC02864, ZNF723,
## PPP4R3C, GAGE12E, GAGE2A, CENPVL2, CENPVL1, XAGE1A, XAGE1B, SSX2,
## SSX2B, CXorf49, CXorf49B, NXF2, CT47A12, CT47A11, CT47A1, TEX13C,
## CT45A6, CT45A7, CT45A8, CT45A9, CT45A10, SPANXB1, CXorf51B, MAGEA9B,
## MAGEA9, MAGEA4-AS1, MAGEA2, CTAG1A, CTAG1B, TSPY4, TSPY3, TSPY9, VCY,
## VCY1B, RBMY1B, RBMY1A1, RBMY1E.
## See the manual page for valid types.
```

![](data:image/png;base64...)

* Single-cell DNA methylome sequencing of human preimplantation embryos,
  Zhu et al. Nat genetics 2018

This dataset only contains blastocyst stage.

```
embryo_expression(dataset = "Zhu", include_CTP = FALSE)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## Warning: 36 out of 146 names invalid: KAZN-AS1, LRRC52-AS1, ZC3H11B, THORLNC,
## LINC02475, LINC02377, LINC02241, LINC02228, LINC03004, SEC61G-DT,
## ZNF722, GTF2I-AS1, TEX48, LINC02663, LINC02750, MAJIN, TMEM132D-AS1,
## CBY2, GARIN2, GOLGA6L7, CHCT1, LINC02864, ZNF723, PPP4R3C, CENPVL2,
## CENPVL1, XAGE1A, CXorf49B, CT47A12, CT47A11, TEX13C, CT45A3, CT45A9,
## CXorf51B, MAGEA4-AS1, TSPY9.
## See the manual page for valid types.
```

![](data:image/png;base64...)

### 5.2.2 `fetal_germcells_expression()`

Allows to visualise gene expression in fetal germ cells the scRNA-seq dataset
from “Single-cell roadmap of human gonadal development” (Garcia-Alonso,
Nature 2022).

```
fetal_germcells_expression(include_CTP = FALSE, ncells_max = 100)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## Warning: 16 out of 146 names invalid: NFIA-AS1, SLC7A11-AS1, GTF2I-AS1,
## SPATA31C2, TEX48, LINC02864, CXorf49B, CT47A12, CT47A11, CT47A1,
## CT45A6, CT45A7, CT45A8, CT45A9, TSPY9, RBMY1B.
## See the manual page for valid types.
```

![](data:image/png;base64...)

### 5.2.3 `hESC_expression()`

Allows to visualise gene expression in human embryonic stem cells, using
scRNAseq data downloaded from Encode database.

```
hESC_expression(include_CTP = FALSE, units = "log_TPM",
                values_only = FALSE)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

## 5.3 Expression in cancer cells and samples

### 5.3.1 `CCLE_expression()`

Allows to visualise gene expression in different histological types of CCLE
cancer cell lines. We can thus compare genes that are or not activated in
tumoral cell lines.

* Applied to CT genes frequently activated in CCLE cell lines, more
  than 5% of CCLE cell\_lines are expressing each gene. A string signal
  is visible.

```
frequently_activated <- dplyr::filter(
    CT_genes,
    percent_of_positive_CCLE_cell_lines >= 5)

CCLE_expression(
    genes = frequently_activated$external_gene_name,
    type = c(
        "lung", "skin", "bile_duct", "bladder", "colorectal",
        "lymphoma", "uterine", "myeloma", "kidney",
        "pancreatic", "brain", "gastric", "breast", "bone",
        "head_and_neck", "ovarian", "sarcoma", "leukemia",
        "esophageal", "neuroblastoma"),
    units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

* Applied to CT genes not frequently activated in CCLE cell lines,
  more than 95% of cell lines are not expressing each genes. The lack
  of expression is very clear.

```
not_frequently_activated <- dplyr::filter(
    CT_genes,
    percent_of_negative_CCLE_cell_lines >= 95)

CCLE_expression(
    genes = not_frequently_activated$external_gene_name,
    type = c(
        "lung", "skin", "bile_duct", "bladder", "colorectal",
        "lymphoma", "uterine", "myeloma", "kidney",
        "pancreatic", "brain", "gastric", "breast", "bone",
        "head_and_neck", "ovarian", "sarcoma", "leukemia",
        "esophageal", "neuroblastoma"),
    units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

### 5.3.2 `CT_correlated_genes()`

A function that use expression data from all CCLE cell lines and returns genes
correlated (or anti-correlated) with specified CT gene.

Here with MAGEA3, we can see all genes (CT or not) whose expression is
correlated with it, like MAGEA6.

```
CT_correlated_genes("MAGEA3", 0.3)
```

```
## Warning: Removed 4 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

```
## Warning: ggrepel: 157 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](data:image/png;base64...)

### 5.3.3 `TCGA_expression()`

Allows to visualise gene expression in cancer samples from TCGA. We can thus for
example compare with activation in CCLE cell lines.

* Applied to CT genes frequently activated in CCLE cell lines

```
TCGA_expression(
    genes = frequently_activated$external_gene_name,
    tumor = "all",
    units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## `use_raster` is automatically set to TRUE for a matrix with more than
## 2000 columns You can control `use_raster` argument by explicitly
## setting TRUE/FALSE to it.
##
## Set `ht_opt$message = FALSE` to turn off this message.
```

![](data:image/png;base64...)

* Applied to CT genes not frequently activated in CCLE cell lines

```
TCGA_expression(
    genes = not_frequently_activated$external_gene_name,
    tumor = "all",
    units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

```
## `use_raster` is automatically set to TRUE for a matrix with more than
## 2000 columns You can control `use_raster` argument by explicitly
## setting TRUE/FALSE to it.
##
## Set `ht_opt$message = FALSE` to turn off this message.
```

![](data:image/png;base64...)

When visualising only one tumor, there is a separation between tumoral and
peritumoral tissue.

```
TCGA_expression(
    genes = frequently_activated$external_gene_name,
    tumor = "LUAD",
    units = "log_TPM")
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

## 5.4 Methylation analysis

### 5.4.1 `DAC_induction()`

Allows to visualise gene induction upon DAC treatment in a series of cell lines.
We can see the difference between CT genes regulated by methylation or not

* Applied to genes controlled by methylation

```
controlled_by_methylation <- dplyr::filter(CT_genes, regulated_by_methylation)
DAC_induction(genes = controlled_by_methylation$external_gene_name)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

* Applied to genes not controlled by methylation

```
not_controlled_by_methylation <- dplyr::filter(
    CT_genes,
    !regulated_by_methylation)
DAC_induction(genes = not_controlled_by_methylation$external_gene_name)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

### 5.4.2 `normal_tissues_methylation()`

Gives the methylation level of all CpGs located in each promoter region
(by default defined as 1000 nt upstream TSS and 200 nt downstream TSS) in a set
of normal tissues. Can be used to analyse more precisely the methylation of a
particular promoter in normal tissues as methylation values are given CpG by
CpG.

* Applied to a gene controlled by methylation

```
normal_tissues_methylation("MAGEB2")
```

![](data:image/png;base64...)

* Applied to a gene not controlled by methylation

```
normal_tissues_methylation("LIN28A")
```

![](data:image/png;base64...)

### 5.4.3 `normal_tissues_mean_methylation()`

Gives the mean methylation level of CpGs located in each promoter region
(by default defined as 1000 nt upstream TSS and 200 nt downstream TSS) in a set
of normal tissues. When comparing genes controlled or not by methylation, we can
see a specific methylation pattern in the first group.

* Applied to genes controlled by methylation

```
normal_tissues_mean_methylation(
    genes = controlled_by_methylation$external_gene_name)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

* Applied to genes not controlled by methylation

```
normal_tissues_mean_methylation(
    genes =
        not_controlled_by_methylation$external_gene_name)
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

### 5.4.4 `embryos_mean_methylation()`

Gives the mean methylation level of CpGs located in each promoter region
of any genes in early embryos, using WGSB data from (“Single-cell
DNA methylome sequencing of human preimplantation embryos”. Zhu et al.
Nat genetics 2018). Methylation levels in tissues correspond
to the mean methylation of CpGs located in range of 1000 pb upstream and
500 pb downstream from gene TSS.

Can be used to explore well known CT genes methylation in embryos as below.

```
embryos_mean_methylation(c("MAGEA1", "MAGEA3", "MAGEA4", "MAGEC2", "MAGEB16"),
                         stage = c( "MII Oocyte", "Sperm", "Zygote", "2-cell",
                                    "4-cell", "8-cell",  "Morula"))
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

### 5.4.5 `fetal_germcells_mean_methylation()`

Allows to visualise mean promoter methylation levels ofany genes in fetal germ
cells, using WGSB data from “Dissecting the epigenomic dynamics of human fetal
germ cell development at single-cell resolution” (Li et al. 2021). Methylation
levels in tissues correspond to the mean methylation of CpGs located in range of
1000 pb upstream and 500 pb downstream from gene TSS.

Can be used to explore well known CT genes methylation in fetal germ cells, as
below.

```
fetal_germcells_mean_methylation(c("MAGEA1", "MAGEA3", "MAGEA4", "MAGEC2"))
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

### 5.4.6 `hESC_mean_methylation()`

Allows to visualise mean promoter methylation levels of any genes in human
embryonic cell lines. WGBS methylation data was downloaded from Encode.
Methylation levels in tissues correspond to the mean methylation of CpGs located
in range of 1000 pb upstream and 200 pb downstream from gene TSS.

Here used on strict CT genes.

```
hESC_mean_methylation()
```

```
## see ?CTdata and browseVignettes('CTdata') for documentation
```

```
## loading from cache
```

![](data:image/png;base64...)

### 5.4.7 `TCGA_methylation_expression_correlation()`

Shows the correlation between gene expression and promoter methylation in
TCGA samples.

* Applied to a gene controlled by methylation

```
TCGA_methylation_expression_correlation(
    tumor = "all",
    gene = "TDRD1")
```

![](data:image/png;base64...)

* Applied to a gene not controlled by methylation

```
TCGA_methylation_expression_correlation(
    tumor = "all",
    gene = "LIN28A")
```

![](data:image/png;base64...)

# 6 Interactive heatmaps

CTexploreR’s heatmaps are compatible with the `InteractiveComplexHeatmap`
package. This allows the navigate in the last heatmap generated, search a
specific gene as well as creating subsets to facilitate data exploration.
More info about `InteractiveComplexHeatmap` available
[here](https://jokergoo.github.io/InteractiveComplexHeatmap/).

```
BiocManager::install("InteractiveComplexHeatmap")
library(InteractiveComplexHeatmap)

GTEX_expression(testis_specific$external_gene_name, units = "log_TPM")
htShiny()
```

# 7 Bibliography

Aguet, F., Anand, S., Ardlie, K. G., Gabriel, S., Getz, G. A., Graubert, A.,
Hadley, K., Handsaker, R. E., Huang, K. H., Kashin, S., Li, X.,
MacArthur, D. G., Meier, S. R., Nedzel, J. L., Nguyen, D. T., Segrè, A. V.,
Todres, E., Balliu, B., Barbeira, A. N., … Volpi, S. (2020).
The GTEx Consortium atlas of genetic regulatory effects across human tissues.
Science. <https://science.sciencemag.org/content/369/6509/1318.abstract>

Almeida, L. G., Sakabe, N. J., deOliveira, A. R., Silva, M. C. C., Mundstein, A.
S., Cohen, T., Chen, Y.-T., Chua, R., Gurung, S., Gnjatic, S., Jungbluth, A. A.,
Caballero, O. L., Bairoch, A., Kiesler, E., White, S. L., Simpson, A. J. G.,
Old, L. J., Camargo, A. A., & Vasconcelos, A. T. R. (2009). CTdatabase: a
knowledge-base of high-throughput and curated data on cancer-testis antigens.
Nucleic Acids Research, 37(Database issue), D816–D819.

Barretina, J., Caponigro, G., Stransky, N., Venkatesan, K., Margolin, A. A.,
Kim, S., Wilson, C. J., Lehár, J., Kryukov, G. V., Sonkin, D., Reddy, A., Liu,
M., Murray, L., Berger, M. F., Monahan, J. E., Morais, P., Meltzer, J., Korejwa,
A., Jané-Valbuena, J., … Garraway, L. A. (2012). The Cancer Cell Line
Encyclopedia enables predictive modelling of anticancer drug sensitivity.
Nature, 483(7391), 603–607.

Cancer Genome Atlas Research Network, Weinstein, J. N., Collisson, E. A., Mills,
G. B., Shaw, K. R. M., Ozenberger, B. A., Ellrott, K., Shmulevich, I., Sander,
C., & Stuart, J. M. (2013). The Cancer Genome Atlas Pan-Cancer analysis
project. Nature Genetics, 45(10), 1113–1120.

Carter, J. A., Matta, B., Battaglia, J., Somerville, C., Harris, B. D., LaPan,
M., Atwal, G. S., & Barnes, B. J. (2023). Identification of pan-cancer/testis
genes and validation of therapeutic targeting in triple-negative breast cancer:
Lin28a- and Siglece-based vaccination induces anti-tumor immunity and inhibits
metastasis. In bioRxiv (p. 2023.05.09.539617).

Guo, J. et al. The adult human testis transcriptional cell atlas. Cell Res. 28,
1141–1157 (2018).

Uhlén, M. et al. Proteomics. Tissue-based map of the human proteome. Science
347, 1260419 (2015).

Thorvaldsdóttir, H., Robinson, J. T., & Mesirov, J. P. (2013). Integrative
Genomics Viewer (IGV): high-performance genomics data visualization and
exploration. Briefings in Bioinformatics, 14(2), 178–192.

Wang, C., Gu, Y., Zhang, K., Xie, K., Zhu, M., Dai, N., Jiang, Y., Guo, X., Liu,
M., Dai, J., Wu, L., Jin, G., Ma, H., Jiang, T., Yin, R., Xia, Y., Liu, L.,
Wang, S., Shen, B., … Hu, Z. (2016). Systematic identification of genes with a
cancer-testis expression pattern in 19 cancer types. Nature Communications, 7,
10499.

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
## [11] matrixStats_1.5.0           CTexploreR_1.6.0
## [13] CTdata_1.10.0               BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3             httr2_1.2.1           rlang_1.1.6
##  [4] magrittr_2.0.4        clue_0.3-66           GetoptLong_1.0.5
##  [7] compiler_4.5.1        RSQLite_2.4.3         png_0.1-8
## [10] vctrs_0.6.5           pkgconfig_2.0.3       shape_1.4.6.1
## [13] crayon_1.5.3          fastmap_1.2.0         dbplyr_2.5.1
## [16] magick_2.9.0          XVector_0.50.0        labeling_0.4.3
## [19] rmarkdown_2.30        tinytex_0.57          purrr_1.1.0
## [22] bit_4.6.0             xfun_0.53             cachem_1.1.0
## [25] jsonlite_2.0.0        blob_1.2.4            DelayedArray_0.36.0
## [28] parallel_4.5.1        cluster_2.1.8.1       R6_2.6.1
## [31] bslib_0.9.0           RColorBrewer_1.1-3    jquerylib_0.1.4
## [34] Rcpp_1.1.0            bookdown_0.45         iterators_1.0.14
## [37] knitr_1.50            Matrix_1.7-4          tidyselect_1.2.1
## [40] dichromat_2.0-0.1     abind_1.4-8           yaml_2.3.10
## [43] doParallel_1.0.17     codetools_0.2-20      curl_7.0.0
## [46] lattice_0.22-7        tibble_3.3.0          withr_3.0.2
## [49] KEGGREST_1.50.0       S7_0.2.0              evaluate_1.0.5
## [52] BiocFileCache_3.0.0   circlize_0.4.16       ExperimentHub_3.0.0
## [55] Biostrings_2.78.0     pillar_1.11.1         BiocManager_1.30.26
## [58] filelock_1.0.3        foreach_1.5.2         BiocVersion_3.22.0
## [61] ggplot2_4.0.0         scales_1.4.0          glue_1.8.0
## [64] tools_4.5.1           AnnotationHub_4.0.0   grid_4.5.1
## [67] Cairo_1.7-0           tidyr_1.3.1           AnnotationDbi_1.72.0
## [70] colorspace_2.1-2      cli_3.6.5             rappdirs_0.3.3
## [73] S4Arrays_1.10.0       ComplexHeatmap_2.26.0 dplyr_1.1.4
## [76] gtable_0.3.6          sass_0.4.10           digest_0.6.37
## [79] SparseArray_1.10.0    ggrepel_0.9.6         rjson_0.2.23
## [82] farver_2.1.2          memoise_2.0.1         htmltools_0.5.8.1
## [85] lifecycle_1.0.4       httr_1.4.7            GlobalOptions_0.1.2
## [88] bit64_4.6.0-1
```