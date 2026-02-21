# Quality control and Exploration of UMI-based repertoire data

#### 27 October 2020

# Contents

* [1 Load contig files](#load-contig-files)
* [2 High confidence UMIs belonging to T cells per cell](#high-confidence-umis-belonging-to-t-cells-per-cell)
* [3 Reads / UMIs](#reads-umis)
* [4 Apply T-cell contig UMI filter](#apply-t-cell-contig-umi-filter)
* [5 Colophone](#colophone)

This vignette shows an example of loading data from the CellRanger pipeline and doing some QC to pick barcodes. If gene expression was also collected, it is better to do joint cell calling.
Some types of multiplets / debris can be better assessed with by using the gene expression data. See
`vignette('repertoire_and_expression')` for details of how to merge repertoire with a `SingleCellExperiment` object.

```
library(CellaRepertorium)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)
```

# 1 Load contig files

```
files = list.files(system.file('extdata', package = 'CellaRepertorium'), pattern = "all_contig_annotations_.+?.csv.xz", recursive = TRUE, full.names = TRUE)
# Pull out sample and population names
samp_map = tibble(anno_file = files, pop = str_match(files, 'b6|balbc')[,1], sample = str_match(files, '_([0-9])\\.')[,2])

knitr::kable(samp_map)
```

| anno\_file | pop | sample |
| --- | --- | --- |
| /tmp/Rtmpn0ygSH/Rinst1fc1bc70088/CellaRepertorium/extdata/all\_contig\_annotations\_b6\_4.csv.xz | b6 | 4 |
| /tmp/Rtmpn0ygSH/Rinst1fc1bc70088/CellaRepertorium/extdata/all\_contig\_annotations\_b6\_5.csv.xz | b6 | 5 |
| /tmp/Rtmpn0ygSH/Rinst1fc1bc70088/CellaRepertorium/extdata/all\_contig\_annotations\_b6\_6.csv.xz | b6 | 6 |
| /tmp/Rtmpn0ygSH/Rinst1fc1bc70088/CellaRepertorium/extdata/all\_contig\_annotations\_balbc\_1.csv.xz | balbc | 1 |
| /tmp/Rtmpn0ygSH/Rinst1fc1bc70088/CellaRepertorium/extdata/all\_contig\_annotations\_balbc\_2.csv.xz | balbc | 2 |
| /tmp/Rtmpn0ygSH/Rinst1fc1bc70088/CellaRepertorium/extdata/all\_contig\_annotations\_balbc\_3.csv.xz | balbc | 3 |

PBMC pooled from BALB/c and C57BL/6 mice [were assayed on 10X genomics V3 chemistry](https://support.10xgenomics.com/single-cell-vdj/datasets/3.0.0/vdj_v1_mm_c57bl6_pbmc_t) and a library enriched for TCR were run. For the purposes of illustrating functionality in this package, cell barcodes were subsampled 3 times for each of the BALB/c and Black6 pools to generate distinct `samples`, which is reflected in the `sample` column. More details are available in the scripts in the `script` directory of this package.

```
# read in CSV
all_anno = samp_map %>% rowwise() %>% mutate(anno = list(read_csv(anno_file, col_types = cols(
  barcode = col_character(),
  is_cell = col_logical(),
  contig_id = col_character(),
  high_confidence = col_logical(),
  length = col_double(),
  chain = col_character(),
  v_gene = col_character(),
  d_gene = col_character(),
  j_gene = col_character(),
  c_gene = col_character(),
  full_length = col_logical(),
  productive = col_character(),
  cdr3 = col_character(),
  cdr3_nt = col_character(),
  reads = col_double(),
  umis = col_double(),
  raw_clonotype_id = col_character(),
  raw_consensus_id = col_character()
))))

all_anno = all_anno %>% unnest(cols = c(anno))
```

(The column types typically don’t need to be specified in such detail, but watch for issues in the `high_confidence`, `is_cell` and `full_length` columns which may be read as a character vs logical depending on your specific inputs. Either is fine, but you will want to be consistent across files.)

We read in several files of annotated “contigs” output from 10X genomics VDJ version 3.0.

The pipeline for assembling reads into contigs, and mapping them to UMIs and cells is described in [the 10X genomics documentation](https://support.10xgenomics.com/single-cell-vdj/software/pipelines/latest/algorithms/overview), and its source code is available [here](https://github.com/10XGenomics/cellranger/tree/5f5a6293bbc067e1965e50f0277286914b96c908).

```
cell_tbl = unique(all_anno[c("barcode","pop","sample","is_cell")])
cdb = ContigCellDB(all_anno, contig_pk = c('barcode','pop','sample','contig_id'), cell_tbl = cell_tbl, cell_pk = c('barcode','pop','sample'))
```

Note that initially there are 3818 contigs.

```
cdb = mutate_cdb(cdb, celltype = guess_celltype(chain))
cdb = filter_cdb(cdb, high_confidence)
```

After filtering for only high\_confidence contigs there are 2731 contigs.

We read in the contig annotation file for each of the samples, and annotate the contig as a alpha-beta T cell, gamma-delta T cell, B cell or chimeric “multi” cell type based on where various

# 2 High confidence UMIs belonging to T cells per cell

```
total_umi = crosstab_by_celltype(cdb)
T_ab_umi = total_umi[c(cdb$cell_pk,"is_cell","T_ab")]

ggplot(T_ab_umi, aes(color = factor(is_cell), x = T_ab, group = interaction(is_cell, sample, pop))) + stat_ecdf() + coord_cartesian(xlim = c(0, 10)) + ylab('Fraction of barcodes') + theme_minimal() + scale_color_discrete('10X called cell?')
```

![](data:image/png;base64...)

10X defines [a procedure](https://support.10xgenomics.com/single-cell-vdj/software/pipelines/latest/algorithms/cell-calling) to separate cells from background that fits a Gaussian mixture model to the UMI distributions for each sample. However in some cases, it may be desirable to implement a common QC threshold with a different stringency, such as:

* Comparing across multiple samples
* When a sample has been enriched for a particular cell type (eg with pre-sequencing flow cytometry).

When we consider only high confidence UMIs that unambiguous map to T cells, most “non cells” have 1 or fewer, while most putative cells have >5. However, we might want to adopt a different UMI-based cell filter, as was done below.

# 3 Reads / UMIs

```
qual_plot = ggplot(cdb$contig_tbl, aes(x = celltype, y= umis)) + geom_violin() + geom_jitter() + facet_wrap(~sample + pop) + scale_y_log10() + xlab("Annotated cell type")

qual_plot
```

![](data:image/png;base64...)

```
qual_plot + aes(y = reads)
```

![](data:image/png;base64...)

The number of UMIs and reads by sample and annotated cell type.

# 4 Apply T-cell contig UMI filter

```
# At least 2 UMI mapping to high confidence T cell contigs.
good_bc = total_umi %>% ungroup() %>% filter(is_cell) %>% filter(T_ab >= 2)
total_cells = good_bc %>% group_by(sample, pop) %>% summarize(good_bc = n())
#> `summarise()` regrouping output by 'sample' (override with `.groups` argument)
knitr::kable(total_cells)
```

| sample | pop | good\_bc |
| --- | --- | --- |
| 1 | balbc | 133 |
| 2 | balbc | 137 |
| 3 | balbc | 143 |
| 4 | b6 | 149 |
| 5 | b6 | 150 |
| 6 | b6 | 148 |

Apply a filter on UMIs.

```
contigs_qc = semi_join(cdb$contig_tbl, good_bc %>% select(sample, pop, barcode)) %>%
  filter(full_length, productive == 'True', high_confidence, chain != 'Multi')
#> Joining, by = c("pop", "sample", "barcode")
```

And take only high confidence, full length, productive \(\alpha-\beta\) T cell contigs.

# 5 Colophone

```
sessionInfo()
#> R version 4.0.3 (2020-10-10)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats4    parallel  stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] Biostrings_2.58.0      XVector_0.30.0         IRanges_2.24.0
#>  [4] S4Vectors_0.28.0       BiocGenerics_0.36.0    ggdendro_0.1.22
#>  [7] purrr_0.3.4            stringr_1.4.0          tidyr_1.1.2
#> [10] readr_1.4.0            ggplot2_3.3.2          dplyr_1.0.2
#> [13] CellaRepertorium_1.0.0 BiocStyle_2.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] splines_4.0.3       assertthat_0.2.1    statmod_1.4.35
#>  [4] BiocManager_1.30.10 highr_0.8           broom.mixed_0.2.6
#>  [7] yaml_2.2.1          progress_1.2.2      pillar_1.4.6
#> [10] backports_1.1.10    lattice_0.20-41     glue_1.4.2
#> [13] digest_0.6.27       RColorBrewer_1.1-2  minqa_1.2.4
#> [16] colorspace_1.4-1    cowplot_1.1.0       htmltools_0.5.0
#> [19] Matrix_1.2-18       plyr_1.8.6          pkgconfig_2.0.3
#> [22] broom_0.7.2         magick_2.5.0        bookdown_0.21
#> [25] zlibbioc_1.36.0     scales_1.1.1        lme4_1.1-25
#> [28] tibble_3.0.4        generics_0.0.2      farver_2.0.3
#> [31] ellipsis_0.3.1      withr_2.3.0         TMB_1.7.18
#> [34] cli_2.1.0           magrittr_1.5        crayon_1.3.4
#> [37] evaluate_0.14       fansi_0.4.1         nlme_3.1-150
#> [40] MASS_7.3-53         forcats_0.5.0       tools_4.0.3
#> [43] prettyunits_1.1.1   hms_0.5.3           lifecycle_0.2.0
#> [46] munsell_0.5.0       compiler_4.0.3      rlang_0.4.8
#> [49] grid_4.0.3          nloptr_1.2.2.2      labeling_0.4.2
#> [52] rmarkdown_2.5       boot_1.3-25         gtable_0.3.0
#> [55] reshape2_1.4.4      R6_2.4.1            knitr_1.30
#> [58] utf8_1.1.4          stringi_1.5.3       Rcpp_1.0.5
#> [61] png_0.1-7           vctrs_0.3.4         tidyselect_1.1.0
#> [64] xfun_0.18           coda_0.19-4
```