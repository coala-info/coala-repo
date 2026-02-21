# ggmsa-Getting Started

#### GuangChuang Yu and Lang Zhou

#### 2025-10-30

# Install package

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("ggmsa")
```

# Introduction

ggmsa is a package designed to plot multiple sequence alignments.

This package implements functions to visualize publication-quality multiple sequence alignments (protein/DNA/RNA) in R extremely simple and powerful. It uses module design to annotate sequence alignments and allows to accept other data sets for diagrams combination.

In this tutorial, we’ll work through the basics of using ggmsa.

```
library(ggmsa)
```

![](data:image/png;base64...)

# Importing MSA data

We’ll start by importing some example data to use throughout this tutorial. Expect FASTA files, some of the objects in R can also as input. `available_msa()` can be used to list MSA objects currently available.

```
 available_msa()
#> 1.files currently available:
#> .fasta
#> 2.XStringSet objects from 'Biostrings' package:
#> DNAStringSet RNAStringSet AAStringSet BStringSet DNAMultipleAlignment RNAMultipleAlignment AAMultipleAlignment
#> 3.bin objects:
#> DNAbin AAbin

 protein_sequences <- system.file("extdata", "sample.fasta",
                                  package = "ggmsa")
 miRNA_sequences <- system.file("extdata", "seedSample.fa",
                                package = "ggmsa")
 nt_sequences <- system.file("extdata", "LeaderRepeat_All.fa",
                             package = "ggmsa")
```

# Basic use: MSA Visualization

The most simple code to use ggmsa:

```
ggmsa(protein_sequences, 300, 350, color = "Clustal",
      font = "DroidSansMono", char_width = 0.5, seq_name = TRUE )
```

![](data:image/png;base64...)

## Color Schemes

ggmsa predefines several color schemes for rendering MSA are shipped in the package. In the same ways, using `available_msa()` to list color schemes currently available. Note that amino acids (protein) and nucleotides (DNA/RNA) have different names.

```
available_colors()
#> 1.color schemes for nucleotide sequences currently available:
#> Chemistry_NT Shapely_NT Taylor_NT Zappo_NT
#> 2.color schemes for AA sequences currently available:
#> ClustalChemistry_AA Shapely_AA Zappo_AA Taylor_AA LETTER CN6 Hydrophobicity
```

![](data:image/png;base64...)

## Font

Several predefined fonts are shipped ggmsa. Users can use `available_fonts()` to list the font currently available.

```
available_fonts()
#> font families currently available:
#> helvetical mono TimesNewRoman DroidSansMono
```

# MSA Annotation

ggmsa supports annotations for MSA. Similar to the ggplot2, it implements annotations by `geom` and users can perform annotation with `+` , like this: `ggmsa() + geom_*()`. Automatically generated annotations that containing colored labels and symbols are overlaid on MSAs to indicate potentially conserved or divergent regions.

For example, visualizing multiple sequence alignment with **sequence logo** and **bar chart**:

```
ggmsa(protein_sequences, 221, 280, seq_name = TRUE, char_width = 0.5) +
  geom_seqlogo(color = "Chemistry_AA") + geom_msaBar()
```

![](data:image/png;base64...)

This table shows the annnotation layers supported by ggmsa as following:

| Annotation modules | Type | Description |
| --- | --- | --- |
| geom\_seqlogo() | geometric layer | automatically generated sequence logos for a MSA |
| geom\_GC() | annotation module | shows GC content with bubble chart |
| geom\_seed() | annotation module | highlights seed region on miRNA sequences |
| geom\_msaBar() | annotation module | shows sequences conservation by a bar chart |
| geom\_helix() | annotation module | depicts RNA secondary structure as arc diagrams(need extra data) |
|  |  |  |

# Learn more

Check out the guides for learning everything there is to know about all the different features:

* [Getting Started](https://yulab-smu.top/ggmsa/articles/ggmsa.html)
* [Annotations](https://yulab-smu.top/ggmsa/articles/Annotations.html)
* [Color Schemes and Font Families](https://yulab-smu.top/ggmsa/articles/Color_schemes_And_Font_Families.html)
* [Theme](https://yulab-smu.top/ggmsa/articles/guides/MSA_theme.html)
* [Other Modules](https://yulab-smu.top/ggmsa/articles/Other_Modules.html)
* [View Modes](https://yulab-smu.top/ggmsa/articles/View_modes.html)

# Session Info

```
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] kableExtra_1.4.0  yulab.utils_0.2.1 ggplot2_4.0.0     ggmsa_1.16.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6            xfun_0.53               bslib_0.9.0
#>  [4] htmlwidgets_1.6.4       lattice_0.22-7          vctrs_0.6.5
#>  [7] tools_4.5.1             generics_0.1.4          stats4_4.5.1
#> [10] parallel_4.5.1          tibble_3.3.0            pkgconfig_2.0.3
#> [13] ggplotify_0.1.3         RColorBrewer_1.1-3      S7_0.2.0
#> [16] S4Vectors_0.48.0        lifecycle_1.0.4         stringr_1.5.2
#> [19] compiler_4.5.1          farver_2.1.2            textshaping_1.0.4
#> [22] treeio_1.34.0           Biostrings_2.78.0       prettydoc_0.4.1
#> [25] ggforce_0.5.0           Seqinfo_1.0.0           ggtree_4.0.0
#> [28] fontLiberation_0.1.0    ggfun_0.2.0             fontquiver_0.2.1
#> [31] htmltools_0.5.8.1       sass_0.4.10             yaml_2.3.10
#> [34] lazyeval_0.2.2          pillar_1.11.1           crayon_1.5.3
#> [37] jquerylib_0.1.4         tidyr_1.3.1             MASS_7.3-65
#> [40] cachem_1.1.0            seqmagick_0.1.7         fontBitstreamVera_0.1.1
#> [43] nlme_3.1-168            tidyselect_1.2.1        aplot_0.2.9
#> [46] digest_0.6.37           stringi_1.8.7           dplyr_1.1.4
#> [49] purrr_1.1.0             labeling_0.4.3          polyclip_1.10-7
#> [52] fastmap_1.2.0           grid_4.5.1              cli_3.6.5
#> [55] magrittr_2.0.4          patchwork_1.3.2         dichromat_2.0-0.1
#> [58] ape_5.8-1               withr_3.0.2             gdtools_0.4.4
#> [61] scales_1.4.0            rappdirs_0.3.3          rmarkdown_2.30
#> [64] XVector_0.50.0          evaluate_1.0.5          knitr_1.50
#> [67] IRanges_2.44.0          viridisLite_0.4.2       gridGraphics_0.5-1
#> [70] rlang_1.1.6             ggiraph_0.9.2           Rcpp_1.1.0
#> [73] glue_1.8.0              R4RNA_1.38.0            tidytree_0.4.6
#> [76] xml2_1.4.1              tweenr_2.0.3            BiocGenerics_0.56.0
#> [79] svglite_2.2.2           rstudioapi_0.17.1       jsonlite_2.0.0
#> [82] R6_2.6.1                systemfonts_1.3.1       fs_1.6.6
```