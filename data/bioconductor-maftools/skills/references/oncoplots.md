# Customizing oncoplots

#### Anand Mayakonda

#### 2025-10-30

```
library(maftools)
```

```
#path to TCGA LAML MAF file
laml.maf = system.file('extdata', 'tcga_laml.maf.gz', package = 'maftools')
#clinical information containing survival information and histology. This is optional
laml.clin = system.file('extdata', 'tcga_laml_annot.tsv', package = 'maftools')

laml = read.maf(maf = laml.maf,
                clinicalData = laml.clin,
                verbose = FALSE)
```

## 0.1 Including Transition/Transversions into oncoplot

```
#By default the function plots top20 mutated genes
oncoplot(maf = laml, draw_titv = TRUE)
```

![](data:image/png;base64...)

## 0.2 Changing colors for variant classifications

```
#One can use any colors, here in this example color palette from RColorBrewer package is used
vc_cols = RColorBrewer::brewer.pal(n = 8, name = 'Paired')
names(vc_cols) = c(
  'Frame_Shift_Del',
  'Missense_Mutation',
  'Nonsense_Mutation',
  'Multi_Hit',
  'Frame_Shift_Ins',
  'In_Frame_Ins',
  'Splice_Site',
  'In_Frame_Del'
)

print(vc_cols)
#>   Frame_Shift_Del Missense_Mutation Nonsense_Mutation         Multi_Hit
#>         "#A6CEE3"         "#1F78B4"         "#B2DF8A"         "#33A02C"
#>   Frame_Shift_Ins      In_Frame_Ins       Splice_Site      In_Frame_Del
#>         "#FB9A99"         "#E31A1C"         "#FDBF6F"         "#FF7F00"

oncoplot(maf = laml, colors = vc_cols, top = 10)
```

![](data:image/png;base64...)

## 0.3 Including copy number data into oncoplots.

There are two ways one include CN status into MAF. 1. GISTIC results 2. Custom copy number table

### 0.3.1 GISTIC results

Most widely used tool for copy number analysis from large scale studies is GISTIC and we can simultaneously read gistic results along with MAF. GISTIC generates numerous files but we need mainly four files `all_lesions.conf_XX.txt`, `amp_genes.conf_XX.txt`, `del_genes.conf_XX.txt`, `scores.gistic` where XX is confidence level. These files contain significantly altered genomic regions along with amplified and deleted genes respectively.

```
#GISTIC results LAML
all.lesions =
  system.file("extdata", "all_lesions.conf_99.txt", package = "maftools")
amp.genes =
  system.file("extdata", "amp_genes.conf_99.txt", package = "maftools")
del.genes =
  system.file("extdata", "del_genes.conf_99.txt", package = "maftools")
scores.gis =
  system.file("extdata", "scores.gistic", package = "maftools")

#Read GISTIC results along with MAF
laml.plus.gistic = read.maf(
  maf = laml.maf,
  gisticAllLesionsFile = all.lesions,
  gisticAmpGenesFile = amp.genes,
  gisticDelGenesFile = del.genes,
  gisticScoresFile = scores.gis,
  isTCGA = TRUE,
  verbose = FALSE,
  clinicalData = laml.clin
)
```

```
oncoplot(maf = laml.plus.gistic, top = 10)
```

![](data:image/png;base64...)

This plot shows frequent deletions in TP53 gene which is located on one of the significantly deleted locus 17p13.2.

### 0.3.2 Custom copy-number table

In case there is no GISTIC results available, one can generate a table containing CN status for known genes in known samples. This can be easily created and read along with MAF file.

For example lets create a dummy CN alterations for `DNMT3A` in random 20 samples.

```
set.seed(seed = 1024)
barcodes = as.character(getSampleSummary(x = laml)[,Tumor_Sample_Barcode])
#Random 20 samples
dummy.samples = sample(x = barcodes,
                       size = 20,
                       replace = FALSE)

#Genarate random CN status for above samples
cn.status = sample(
  x = c('ShallowAmp', 'DeepDel', 'Del', 'Amp'),
  size = length(dummy.samples),
  replace = TRUE
)

custom.cn.data = data.frame(
  Gene = "DNMT3A",
  Sample_name = dummy.samples,
  CN = cn.status,
  stringsAsFactors = FALSE
)

head(custom.cn.data)
#>     Gene  Sample_name         CN
#> 1 DNMT3A TCGA-AB-2898 ShallowAmp
#> 2 DNMT3A TCGA-AB-2879        Del
#> 3 DNMT3A TCGA-AB-2920        Amp
#> 4 DNMT3A TCGA-AB-2866        Del
#> 5 DNMT3A TCGA-AB-2892        Del
#> 6 DNMT3A TCGA-AB-2863 ShallowAmp

# Its recommended to also include additional columns Chromosome, Start_Position, End_Position

laml.plus.cn = read.maf(maf = laml.maf,
                        cnTable = custom.cn.data,
                        verbose = FALSE)

oncoplot(maf = laml.plus.cn, top = 5)
```

![](data:image/png;base64...)

## 0.4 Bar plots

`leftBarData`, `rightBarData` and `topBarData` arguments can be used to display additional values as barplots. Below example demonstrates adding gene expression values and mutsig q-values as left and right side bars respectivelly.

```
#Selected AML driver genes
aml_genes = c("TP53", "WT1", "PHF6", "DNMT3A", "DNMT3B", "TET1", "TET2", "IDH1", "IDH2", "FLT3", "KIT", "KRAS", "NRAS", "RUNX1", "CEBPA", "ASXL1", "EZH2", "KDM6A")

#Variant allele frequcnies (Right bar plot)
aml_genes_vaf = subsetMaf(maf = laml, genes = aml_genes, fields = "i_TumorVAF_WU", mafObj = FALSE)[,mean(i_TumorVAF_WU, na.rm = TRUE), Hugo_Symbol]
colnames(aml_genes_vaf)[2] = "VAF"
head(aml_genes_vaf)
#>    Hugo_Symbol      VAF
#>         <char>    <num>
#> 1:       ASXL1 37.11250
#> 2:       CEBPA 22.00235
#> 3:      DNMT3A 43.51556
#> 4:      DNMT3B 37.14000
#> 5:        EZH2 68.88500
#> 6:        FLT3 34.60294

#MutSig results (Right bar plot)
laml.mutsig = system.file("extdata", "LAML_sig_genes.txt.gz", package = "maftools")
laml.mutsig = data.table::fread(input = laml.mutsig)[,.(gene, q)]
laml.mutsig[,q := -log10(q)] #transoform to log10
head(laml.mutsig)
#>      gene        q
#>    <char>    <num>
#> 1:   FLT3 12.64176
#> 2: DNMT3A 12.64176
#> 3:   NPM1 12.64176
#> 4:   IDH2 12.64176
#> 5:   IDH1 12.64176
#> 6:   TET2 12.64176

oncoplot(
  maf = laml,
  genes = aml_genes,
  leftBarData = aml_genes_vaf,
  leftBarLims = c(0, 100),
  rightBarData = laml.mutsig,
  rightBarLims = c(0, 20)
)
```

![](data:image/png;base64...)

## 0.5 Including annotations

Annotations are stored in `clinical.data` slot of MAF.

```
getClinicalData(x = laml)
#>      Tumor_Sample_Barcode FAB_classification days_to_last_followup
#>                    <char>             <char>                 <num>
#>   1:         TCGA-AB-2802                 M4                   365
#>   2:         TCGA-AB-2803                 M3                   792
#>   3:         TCGA-AB-2804                 M3                  2557
#>   4:         TCGA-AB-2805                 M0                   577
#>   5:         TCGA-AB-2806                 M1                   945
#>  ---
#> 189:         TCGA-AB-3007                 M3                  1581
#> 190:         TCGA-AB-3008                 M1                   822
#> 191:         TCGA-AB-3009                 M4                   577
#> 192:         TCGA-AB-3011                 M1                  1885
#> 193:         TCGA-AB-3012                 M3                  1887
#>      Overall_Survival_Status
#>                        <int>
#>   1:                       1
#>   2:                       1
#>   3:                       0
#>   4:                       1
#>   5:                       1
#>  ---
#> 189:                       0
#> 190:                       1
#> 191:                       1
#> 192:                       0
#> 193:                       0
```

Include `FAB_classification` from clinical data as one of the sample annotations.

```
oncoplot(maf = laml, genes = aml_genes, clinicalFeatures = 'FAB_classification')
```

![](data:image/png;base64...)

More than one annotations can be included by passing them to the argument `clinicalFeatures`. Above plot can be further enhanced by sorting according to annotations. Custom colors can be specified as a list of named vectors for each levels.

```
#Color coding for FAB classification
fabcolors = RColorBrewer::brewer.pal(n = 8,name = 'Spectral')
names(fabcolors) = c("M0", "M1", "M2", "M3", "M4", "M5", "M6", "M7")

#For continuous numrical annotations, use one of the below palettes
# c("Blues", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "Oranges",
#         "OrRd", "PuBu", "PuBuGn", "PuRd", "Purples", "RdPu", "Reds",
#         "YlGn", "YlGnBu", "YlOrBr", "YlOrRd")

anno_cols = list(FAB_classification = fabcolors, days_to_last_followup = "Blues")

print(anno_cols)
#> $FAB_classification
#>        M0        M1        M2        M3        M4        M5        M6        M7
#> "#D53E4F" "#F46D43" "#FDAE61" "#FEE08B" "#E6F598" "#ABDDA4" "#66C2A5" "#3288BD"
#>
#> $days_to_last_followup
#> [1] "Blues"

oncoplot(
  maf = laml, genes = aml_genes,
  clinicalFeatures = c('FAB_classification', 'days_to_last_followup'),
  sortByAnnotation = TRUE,
  annotationColor = anno_cols
)
```

![](data:image/png;base64...)

## 0.6 Highlighting samples

If you prefer to highlight mutations by a specific attribute, you can use `additionalFeature` argument.

Example: Highlight all mutations where alt allele is C.

```
oncoplot(maf = laml, genes = aml_genes,
         additionalFeature = c("Tumor_Seq_Allele2", "C"))
```

![](data:image/png;base64...)

Note that first argument (Tumor\_Seq\_Allele2) must a be column in MAF file, and second argument (C) is a value in that column. If you want to know what columns are present in the MAF file, use `getFields`.

```
getFields(x = laml)
#>  [1] "Hugo_Symbol"            "Entrez_Gene_Id"         "Center"
#>  [4] "NCBI_Build"             "Chromosome"             "Start_Position"
#>  [7] "End_Position"           "Strand"                 "Variant_Classification"
#> [10] "Variant_Type"           "Reference_Allele"       "Tumor_Seq_Allele1"
#> [13] "Tumor_Seq_Allele2"      "Tumor_Sample_Barcode"   "Protein_Change"
#> [16] "i_TumorVAF_WU"          "i_transcript_name"
```

## 0.7 Group by Pathways

Genes can be auto grouped based on their pathway belongings. Currently maftools has two pathway databases,

1. [oncogenic signalling pathways](https://doi.org/10.1016/j.cell.2018.03.035): A curated list of 10 signalling pathways
2. Catalog of known driver genes classified by their [biological processes](https://doi.org/10.1016/j.cell.2018.02.060)

By setting `pathways` argument either `sigpw` or `smgbp` - cohort can be summarized by altered pathways. `pathways` argument also accepts a custom pathway list in the form of a two column tsv file or a data.frame containing gene names and their corresponding pathway.

### 0.7.1 Oncogenic siganlling pathways

setting `pathways = 'sigpw'` to draw 5 most affected pathways

```
oncoplot(maf = laml, pathways = "sigpw", gene_mar = 8, fontSize = 0.6, topPathways = 5)
#> Drawing upto top 5 mutated pathways
#> Warning in oncoplot(maf = laml, pathways = "sigpw", gene_mar = 8, fontSize = 0.6, : Found following pathways with the same name as gene symbols. Renamed them with the suffix _pw
#> TP53
#> Warning in oncoplot(maf = laml, pathways = "sigpw", gene_mar = 8, fontSize =
#> 0.6, : Duplicated genes found across multiple pathways! This might cause issue
#> while plotting.
```

![](data:image/png;base64...)

### 0.7.2 Biological processes of known drivers

```
oncoplot(maf = laml, pathways = "smgbp", gene_mar = 8, fontSize = 0.8, topPathways = 5)
#> Drawing upto top 5 mutated pathways
```

![](data:image/png;base64...)

### 0.7.3 Custom pathway list

```
pathways = data.frame(
  Genes = c(
    "TP53",
    "WT1",
    "PHF6",
    "DNMT3A",
    "DNMT3B",
    "TET1",
    "TET2",
    "IDH1",
    "IDH2",
    "FLT3",
    "KIT",
    "KRAS",
    "NRAS",
    "RUNX1",
    "CEBPA",
    "ASXL1",
    "EZH2",
    "KDM6A"
  ),
  Pathway = rep(c(
    "TSG", "DNAm", "Signalling", "TFs", "ChromMod"
  ), c(3, 6, 4, 2, 3)),
  stringsAsFactors = FALSE
)

head(pathways)
#>    Genes Pathway
#> 1   TP53     TSG
#> 2    WT1     TSG
#> 3   PHF6     TSG
#> 4 DNMT3A    DNAm
#> 5 DNMT3B    DNAm
#> 6   TET1    DNAm

oncoplot(maf = laml, pathways = pathways, gene_mar = 8, fontSize = 0.6)
#> Drawing upto top 3 mutated pathways
```

![](data:image/png;base64...)

### 0.7.4 Collapse pathways

By setting `collapsePathway = TRUE`..

```
oncoplot(maf = laml, pathways = "sigpw", gene_mar = 8, fontSize = 0.6, topPathways = 5, collapsePathway = TRUE)
#> Drawing upto top 5 mutated pathways
#> Warning in oncoplot(maf = laml, pathways = "sigpw", gene_mar = 8, fontSize = 0.6, : Found following pathways with the same name as gene symbols. Renamed them with the suffix _pw
#> TP53
#> Warning in oncoplot(maf = laml, pathways = "sigpw", gene_mar = 8, fontSize =
#> 0.6, : Duplicated genes found across multiple pathways! This might cause issue
#> while plotting.
```

![](data:image/png;base64...)

## 0.8 Combining everything

```
oncoplot(
  maf = laml.plus.gistic,
  draw_titv = TRUE,
  pathways = pathways, topPathways = 5,
  clinicalFeatures = c('FAB_classification', 'days_to_last_followup'),
  sortByAnnotation = TRUE,
  additionalFeature = c("Tumor_Seq_Allele2", "C"),
  leftBarData = aml_genes_vaf,
  leftBarLims = c(0, 100),
  rightBarData = laml.mutsig[,.(gene, q)],
)
#> Drawing upto top 5 mutated pathways
```

![](data:image/png;base64...)

## 0.9 SessionInfo

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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] pheatmap_1.0.13                   doParallel_1.0.17
#>  [3] iterators_1.0.14                  foreach_1.5.2
#>  [5] NMF_0.28                          bigmemory_4.6.4
#>  [7] Biobase_2.70.0                    cluster_2.1.8.1
#>  [9] rngtools_1.5.2                    registry_0.5-1
#> [11] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
#> [13] rtracklayer_1.70.0                BiocIO_1.20.0
#> [15] Biostrings_2.78.0                 XVector_0.50.0
#> [17] GenomicRanges_1.62.0              Seqinfo_1.0.0
#> [19] IRanges_2.44.0                    S4Vectors_0.48.0
#> [21] BiocGenerics_0.56.0               generics_0.1.4
#> [23] mclust_6.1.1                      maftools_2.26.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            gridBase_0.4-7
#>  [3] dplyr_1.1.4                 farver_2.1.2
#>  [5] R.utils_2.13.0              S7_0.2.0
#>  [7] bitops_1.0-9                RaggedExperiment_1.34.0
#>  [9] fastmap_1.2.0               RCurl_1.98-1.17
#> [11] GenomicAlignments_1.46.0    XML_3.99-0.19
#> [13] digest_0.6.37               lifecycle_1.0.4
#> [15] survival_3.8-3              magrittr_2.0.4
#> [17] compiler_4.5.1              rlang_1.1.6
#> [19] sass_0.4.10                 tools_4.5.1
#> [21] yaml_2.3.10                 data.table_1.17.8
#> [23] knitr_1.50                  S4Arrays_1.10.0
#> [25] curl_7.0.0                  DelayedArray_0.36.0
#> [27] plyr_1.8.9                  RColorBrewer_1.1-3
#> [29] abind_1.4-8                 BiocParallel_1.44.0
#> [31] R.oo_1.27.1                 grid_4.5.1
#> [33] colorspace_2.1-2            ggplot2_4.0.0
#> [35] scales_1.4.0                MultiAssayExperiment_1.36.0
#> [37] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
#> [39] cli_3.6.5                   rmarkdown_2.30
#> [41] crayon_1.5.3                bigmemory.sri_0.1.8
#> [43] httr_1.4.7                  reshape2_1.4.4
#> [45] rjson_0.2.23                BiocBaseUtils_1.12.0
#> [47] DNAcopy_1.84.0              cachem_1.1.0
#> [49] stringr_1.5.2               splines_4.5.1
#> [51] BiocManager_1.30.26         restfulr_0.0.16
#> [53] matrixStats_1.5.0           vctrs_0.6.5
#> [55] Matrix_1.7-4                jsonlite_2.0.0
#> [57] berryFunctions_1.22.13      jquerylib_0.1.4
#> [59] glue_1.8.0                  codetools_0.2-20
#> [61] stringi_1.8.7               gtable_0.3.6
#> [63] tibble_3.3.0                pillar_1.11.1
#> [65] htmltools_0.5.8.1           R6_2.6.1
#> [67] evaluate_1.0.5              lattice_0.22-7
#> [69] R.methodsS3_1.8.2           Rsamtools_2.26.0
#> [71] cigarillo_1.0.0             bslib_0.9.0
#> [73] uuid_1.2-1                  Rcpp_1.1.0
#> [75] SparseArray_1.10.0          xfun_0.53
#> [77] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```