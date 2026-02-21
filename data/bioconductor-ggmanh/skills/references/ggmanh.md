# Guide to ggmanh Package

#### 30 October 2025

#### Package

ggmanh 1.14.0

# 1 Introduction

The package `ggmanh` is aimed to provide easy and direct access to visualisation to the GWAS / PWAS results while also providing many functionalities and features.

Manhattan plot is commonly used to display significant Single Nucleotide Polymorphisms (SNPs) in Genome Wide Association Study (GWAS). The x-axis is divided into chromosomes, and SNPs are plotted in their respective positions. The y-axis typically represents \(-10\*log(p value)\). Majority of the points have low y-values, with some of the significant SNPs having high y-values. It is not uncommon to see strong association between SNPs and a phenotype, yielding a high y-value. This results in a wide y-scales in which SNPs with lower significance are squished.

This function addresses this problem by rescaling the y-axis according to the range of y.
There are more features, such as labelling without overlap (with the help of [ggrepel package](https://ggrepel.slowkow.com)), reflecting the size of chromosomes along the x-axis, and displaying significant lines.

The package can be installed by:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("ggmanh")
```

# 2 Functions Overview

`manhattan_plot()` is a generic method that can take a `data.frame`, `MPdata`, or a `GRanges` object. The `data.frame`, at bare minimum, must have three columns containing: `chromosome`, `position`, and `p.value`. For a `GRanges` object, meta data column name for the p-value needs to be passed.

There are two steps to this function: preprocess data and plot data. The preprocessing step (accomplished with `manhattan_data_preprocess()`) preprocesses the data by calculating the new x-position to map to the plot (`new_pos` column added to the data), “thining” the data points, and saving other graphical information needed for manhattan plot, which is returned as a `MPdata` object. The plot step (accomplished with `manhattan_plot()`) determines if rescaling of the y-axis is needed and plots / saves the manhattan plot.

While using `manhattan_plot()` on `data.frame` is sufficient, it is fine to separately run pre-processing and plotting for customizing the plot without having to preprocess again and again.

# 3 Example with Simulated GWAS

```
library(ggmanh)
#> Loading required package: ggplot2
library(SeqArray)
#> Loading required package: gdsfmt
```

First, create a simulated data to be used for demonstration.

```
set.seed(1000)

nsim <- 50000

simdata <- data.frame(
  "chromosome" = sample(c(1:22,"X"), size = nsim, replace = TRUE),
  "position" = sample(1:100000000, size = nsim),
  "P.value" = rbeta(nsim, shape1 = 5, shape2 = 1)^7
)
```

`manhattan_plot` expects data.frame to have at least three columns: chromosome, position, and p.value.

```
head(simdata)
#>   chromosome position     P.value
#> 1         16 41575779 0.135933290
#> 2          4 73447172 0.764033749
#> 3         11 82120979 0.002440878
#> 4         22 94419970 0.644460838
#> 5         19 38141341 0.184945910
#> 6          3 43235060 0.774330251
```

To avoid ambiguity in plotting, it is recommended that that the chromosome column is passed as a factor, or `chr.order` is specified.

```
simdata$chromosome <- factor(simdata$chromosome, c(1:22,"X"))
```

This is the bare minimum to plot manhattan plot, and `manhattan_plot` can handle the rest.

```
g <- manhattan_plot(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", plot.title = "Simulated P.Values", y.label = "P")
g
```

![](data:image/png;base64...)

`manhattan_plot` is also defaulted to display the GWAS p.value threshold at `5e-8` and `5e-7`. For now, the threshold is required; the values and color can be customized.

## 3.1 Rescaling

The function is also suited to rescale the y-axis depending on the magnitude of p values.

Let’s suppose that there are signals from chromosome 5 and 21, and the significant p-value is low for chromosome 21 and even lower for chromosome 5.

```
tmpdata <- data.frame(
  "chromosome" = c(rep(5, 10), rep(21, 5)),
  "position" = c(sample(250000:250100, 10, replace = FALSE), sample(590000:600000, 5, replace = FALSE)),
  "P.value" = c(10^-(rnorm(10, 100, 3)), 10^-rnorm(5, 9, 1))
)

simdata <- rbind(simdata, tmpdata)
simdata$chromosome <- factor(simdata$chromosome, c(1:22,"X"))
```

```
g <- manhattan_plot(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", plot.title = "Simulated P.Values - Significant", rescale = FALSE)
g
```

![](data:image/png;base64...)

The significant point at chromosome 5 has such a small p-value compared to other chromosomes that other significant poitns are less visible and the pattern at other chromosomes are masked. Rescaling attempts to fix this by changing the visual scale near the significant cutoff, removing the large white space in between.

```
g <- manhattan_plot(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", plot.title = "Simulated P.Values - Significant", rescale = TRUE)
g
```

![](data:image/png;base64...)

The place where jump happens is indicated on the y-axis by a double line (“=”).

## 3.2 Annotation

Annotation is also very simple. The function makes use of `ggrepel`’s `geom_repel_label()` to annotate each point while trying to avoid collision between texts.

All that is needed is to add a column containing labels. **The function labels everything included in the column**, so it is important to keep the labels for the points you are interested in, and set the rest with `NA` or `""`. From my understanding & experience, the differences between the two options are:

1. `NA`: The labels will likely not overlap, but may conceal the points. If there are a lot of points & labels, this is faster than using `""`.
2. `""`: The labels will avoid other labels as well as other points.

If you forget to do so and try to label all the points, the plotting may take hours.

```
sig <- simdata$P.value < 5e-07

simdata$label <- ""
simdata$label[sig] <- sprintf("Label: %i", 1:sum(sig))
```

To add the labels to the plot, specify the column name with labels to `label.colname`. Also, you can change various aspects of the plot by with different arguments. To avoid having to preprocess over and over, you can separately preprocess first and then customize the plot.

```
simdata$label2 <- ""
i <- (simdata$chromosome == 5) & (simdata$P.value < 5e-8)
simdata$label2[i] <- paste("Chromosome 5 label", 1:sum(i))

mpdata <- manhattan_data_preprocess(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position")

g <- manhattan_plot(x = mpdata, label.colname = "label", plot.title = "Simulated P.Values with labels")
g
```

![](data:image/png;base64...)

```
g <- manhattan_plot(x = mpdata, label.colname = "label2", label.font.size = 2, plot.title = "Simulated P.Values with labels", max.overlaps = Inf, force = 5)
g
```

![](data:image/png;base64...)

## 3.3 Highlighting

You can also choose the colors for each point. You will need to add a column that categorizes the point to the data, and supply the column name to `highlight.colname` as well pass a character vector to `highlight.col`, which specifies the colop mapped to each value in `highlight.colname`. Then set `color.by.highlight = TRUE`.

You can see that you only have to preprocess the original data once while still making changes to the plot itself.

```
simdata$color <- "Not Significant"
simdata$color[simdata$P.value <= 5e-8] <- "Significant"

highlight_colormap <- c("Not Significant" = "grey", "Significant" = "black")

tmp <- manhattan_data_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  highlight.colname = "color", highlight.col = highlight_colormap
)

g_nohighlight <- manhattan_plot(tmp, plot.title = "No Highlight Points")
g <- manhattan_plot(tmp, plot.title = "Highlight Points", color.by.highlight = TRUE)
g_nohighlight
```

![](data:image/png;base64...)

```
g
```

![](data:image/png;base64...)

## 3.4 thinPoints

Another simple, yet useful, feature of the package is a function called `thinPoints`. The function can be called manually or used as a part of `manhattan_data_preprocess`. It will partition the \(log\_{10}(pvalue)\) into `nbin` bins (`manhattan_data_preprocess` uses 200 bins to be conservative), and then randomly sample up to `n` points to effectively reduce the data while keeping the resulting output visually equal. This is done to keep the size of `MPdata`, which contains the data itself, small, and speed up the process of plotting.

## 3.5 Zoom into Chromosome

If a value is passed to `chromosome` argument of the function `manhattan_plot` or `manhattan_data_preprocess`, then the plot zooms into a chromosome if you are interested in a specific chromosome.

**NOTE:** When `chromosome` is specified, the default behavior is to turn off `thinPoints` as the default `thin.n` value may be too small and may make the plot less cluttered than it actually is. The user can manually increase `thin.n` so that the visual output is not changed dramatically while keeping the data size small.

```
manhattan_plot(simdata, chromosome = 5, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position")
```

![](data:image/png;base64...)

# 4 Binned Manhattan Plot

I created another variant of the manhattan plot, which I call binned manhattan plot.
The binned manhattan plot can be useful when the number of points is too large, as is usually the case for GWAS.
In this plot, the variants are binned into grids, avoiding the need to plot every point.

```
binned_manhattan_plot(simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position")
```

![](data:image/png;base64...)

Number of horizontal and vertical bins can be adjusted.

```
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  bins.x = 7, # number of bins for the "widest" chromosome, either calculated by position or by number of variants
  bins.y = 100, # number of vertical bins
  show.legend = FALSE, plot.title = "Binned Manhattan Plot"
)
```

![](data:image/png;base64...)

Just like regular manhattan plot in this package, pre-processing and plotting are split into two stages so that
you can adjust customize some plotting aspects without having to preprocess over and over again. This is very helpful in
this case since pre-processing takes the majority of computation time especially with full summary statistics.

```
mpdat <- binned_manhattan_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  bins.x = 7, bins.y = 100,
  chr.gap.scaling = 0.5, # scaling factor for chromo some gap
  show.message = FALSE # this suppresses some warning messages built into the function
)

binned_manhattan_plot(mpdat, bin.outline = TRUE)
```

![](data:image/png;base64...)

## 4.1 Choosing Palettes for Coloring Bins

Different palettes can be chosen for the plot. The default palette is `viridis::plasma`. The user can choose from any of the palettes available in the `paletteer` package.
More details about which palettes can be used are available [in this link](https://github.com/EmilHvitfeldt/r-color-palettes).

Paletters meant for continuous variables are only compatible with continuous variable used to color the bins. Likewise, palettes meant for discrete variables are only compatible with discrete variables used to color the bins. If continuous palette is used for discrete variable and vice versa, the plot fails.

```
# using discrete palette for continuous
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  bins.x = 7, bins.y = 100, show.legend = FALSE, plot.title = "Binned Manhattan Plot",
  bin.palette = "Polychrome::dark", # choose bin palette
  palette.direction = -1 # set to -1 for reverse palette direction
)
#> Error in `paletteer_c()`:
#> ! Palette not found. Make sure both package and palette name are spelled correct in the format "package::palette".
```

```
# using discrete palette for discrete
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  highlight.colname = "chromosome", chr.gap.scaling = 0.4,
  bins.x = 7, bins.y = 100,
  show.legend = FALSE, # choose not to show legend
  plot.title = "Binned Manhattan Plot",
  bin.palette = "Polychrome::dark", palette.direction = -1
)
```

![](data:image/png;base64...)

```
# using continuous palette for continuous variable
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  chr.gap.scaling = 0.4,
  bins.x = 7, bins.y = 100, show.legend = FALSE, plot.title = "Binned Manhattan Plot",
  bin.palette = "pals::kovesi.isoluminant_cm_70_c39", palette.direction = -1
)
```

![](data:image/png;base64...)

## 4.2 Summary Expression

Since variants are binned together, it would also be useful to provide a way to summarize the data within each bin.
Through `summarise.expression.list`, the user can specify a list of expressions to summarise the data within each bin.
The list contains formulas, where the left side is the new column name, and the right side is the expression to be passed onto `dplyr::summarise()`.

```
tmp <- manhattan_data_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position"
)

mpdata <- binned_manhattan_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  bins.x = 7, bins.y = 100, chr.gap.scaling = 0.5,
  # summary expression list
  summarise.expression.list = list(
    max_log10p ~ max(-log10(P.value)), # creates column "min_log10p", which holds the maximum -log10(P.value) among the variants inside the bin
    signif ~ ifelse(max(P.value) < 5e-8, "Significant", "Not Significant") # creates column "signif" which indicates significance of the bin
  )
)

print(head(mpdata$data))
#> # A tibble: 6 × 10
#>   chromosome .nth_bin_x .nth_bin_y .n_points max_log10p signif .xmin .xmax .ymin
#>   <fct>           <int>      <int>     <int>      <dbl> <chr>  <dbl> <dbl> <dbl>
#> 1 1                   1          1       237       1.04 Not S… 0     0.150  0
#> 2 1                   1          2        45       2.04 Not S… 0     0.150  1.04
#> 3 1                   1          3         7       2.54 Not S… 0     0.150  2.09
#> 4 1                   1          4         1       3.50 Not S… 0     0.150  3.13
#> 5 1                   1          5         1       4.98 Not S… 0     0.150  4.17
#> 6 1                   2          1       257       1.03 Not S… 0.150 0.301  0
#> # ℹ 1 more variable: .ymax <dbl>

binned_manhattan_plot(
  mpdata, bin.palette = "Polychrome::dark", bin.alpha = 1, bin.outline = TRUE,
  highlight.colname = "signif", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot"
)
```

![](data:image/png;base64...)

```
binned_manhattan_plot(
  mpdata, bin.palette = "viridis::inferno", bin.alpha = 1, bin.outline = TRUE,
  bin.outline.alpha = 0.3,
  highlight.colname = "max_log10p", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot"
)
```

![](data:image/png;base64...)

For example, this could be used to have the grid represent the mean, median, min, or max of the effect size (or of the absolute value). However, the values in the variants that are not significant can skew the scale and render the color aesthetic less useful. To deal with this, I’ve also added `nonsignif.default=` argument, which allows you to set a default value for the non-significant bins (for example, `0` or `NA`).

```
binned_manhattan_plot(
  mpdata, bin.palette = "viridis::inferno", bin.alpha = 1, bin.outline = TRUE,
  bin.outline.alpha = 0.3,
  highlight.colname = "max_log10p", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot",
  plot.subtitle = "Default nonsignif value = NA",
  nonsignif.default = NA
)
```

![](data:image/png;base64...)

```
binned_manhattan_plot(
  mpdata, bin.palette = "viridis::inferno", bin.alpha = 1, bin.outline = TRUE,
  bin.outline.alpha = 0.3,
  highlight.colname = "max_log10p", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot",
  plot.subtitle = "Default nonsignif value = 0",
  nonsignif.default = 0
)
```

![](data:image/png;base64...)

# 5 Annotation with GDS File

The package also comes with a small [GDS file](https://academic.oup.com/bioinformatics/article/33/15/2251/3072873) in a [SeqArray](https://bioconductor.org/packages/release/bioc/html/SeqArray.html) file format that contains chromosome, position, reference / alternate allele, and [Ensembl Variant Effect Predictor](https://useast.ensembl.org/info/docs/tools/vep/index.html) of highest consequence. We obtained exomic data from the [GnomAD database](https://gnomad.broadinstitute.org/downloads) in VCF format, then converted to GDS file. Finally, some cleaning was done to get this final GDS file. The gds data that comes with this package can be located with this code after installation.

```
default_gds_path <- system.file("extdata", "gnomad.exomes.vep.hg19.v5.gds", mustWork = TRUE, package = "ggmanh")
print(default_gds_path)

gds <- SeqArray::seqOpen(default_gds_path)
print(gds)
SeqArray::seqClose(gds)
```

The gds file contains `position`, `chromosome`, and `allele` (reference and alternate), which can be used to search variants. In this file, the gene symbol, consequence (by VEP), and the loss of function predictor (by LOFTEE) are stored in `annotation/symbol`, `annotation/consequence`, `annnotation/LoF`, respectively. We were able to keep the annotation data size small due to several reasons:

```
* We have removed RS IDs, which is stored in `annotation/id`. Although the gds file has the capabilities to store the RS IDs, we removed them to save space
* Each variant may have multiple Gene/Consequence predicted by VEP. For example, VEP predicts rs429358 to have an effect on APOE and TOMM40 genes. We've selected only one effect with the highest consequence in this case. Only one predicted effect is included for each variant.
* The VCF data format has been converted to a GDS data format.
```

`gds_annotate()` is used to retrieve annotations.

```
sampledata <- data.frame(
  chromosome = c(1, 17, 19, 22),
  position = c(12422750, 10366900, 43439739, 39710145),
  Reference = c("A", "T", "T", "G"),
  Alternate = c("G", "G", "C", "A")
)
gds_annotate(
  sampledata, annot.method = "position",
  chr = "chromosome", pos = "position", ref = "Reference", alt = "Alternate"
  )
#> Using default gds annotation file from ggmanh package. Run '?ggmanh_annotation_gds' for more information.
#> # of selected variants: 2
#> [1] ""                ""                "PSG7/missense"   "RPL3/synonymous"
```

Annotations are returned in the same order as the rows in the `data.frame`. If the parameter `gdsfile` is empty (`NULL`), then the default GDS file is used.

There are two ways to retrieve annotations. One way is to match the variants by chromosome, position, reference allele, and alternate allele. Another way is to match by RS ID (the RS ID needs to be stored in “annotation/id” in the annotation gds file. Look up documentation for `SeqArray::seqSetFilterAnnotID` for more detail).

Therefore, you can use `gds_annotate` to quickly add annotations to the GWAS summary results, and then plot manhattan plot with annotations.

```
simdata$Reference <- NA
simdata$Alternate <- NA
simdata <- simdata[,c("chromosome", "position", "Reference", "Alternate", "P.value")]
sampledata$P.value <- 10^-rnorm(4, 14, 1)
sampledata <- sampledata[c("chromosome", "position", "Reference", "Alternate", "P.value")]
simdata_label <- rbind(simdata, sampledata)

# add annotation
simdata_label$label <- gds_annotate(x = simdata_label, annot.method = "position", chr = "chromosome", pos = "position", ref = "Reference", alt = "Alternate")
#> Using default gds annotation file from ggmanh package. Run '?ggmanh_annotation_gds' for more information.
#> # of selected variants: 2

manhattan_plot(simdata_label, outfn = NULL, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", label.colname = "label")
```

![](data:image/png;base64...)

# 6 SessionInfo

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] SeqArray_1.50.0  gdsfmt_1.46.0    ggmanh_1.14.0    ggplot2_4.0.0
#> [5] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] utf8_1.2.6           sass_0.4.10          generics_0.1.4
#>  [4] tidyr_1.3.1          prismatic_1.1.2      digest_0.6.37
#>  [7] magrittr_2.0.4       evaluate_1.0.5       grid_4.5.1
#> [10] RColorBrewer_1.1-3   bookdown_0.45        maps_3.4.3
#> [13] fastmap_1.2.0        jsonlite_2.0.0       pals_1.10
#> [16] ggrepel_0.9.6        rematch2_2.1.2       BiocManager_1.30.26
#> [19] purrr_1.1.0          viridisLite_0.4.2    scales_1.4.0
#> [22] Biostrings_2.78.0    jquerylib_0.1.4      cli_3.6.5
#> [25] rlang_1.1.6          crayon_1.5.3         XVector_0.50.0
#> [28] withr_3.0.2          cachem_1.1.0         yaml_2.3.10
#> [31] tools_4.5.1          parallel_4.5.1       dplyr_1.1.4
#> [34] colorspace_2.1-2     BiocGenerics_0.56.0  paletteer_1.6.0
#> [37] mapproj_1.2.12       vctrs_0.6.5          R6_2.6.1
#> [40] stats4_4.5.1         lifecycle_1.0.4      Seqinfo_1.0.0
#> [43] S4Vectors_0.48.0     IRanges_2.44.0       pkgconfig_2.0.3
#> [46] pillar_1.11.1        bslib_0.9.0          gtable_0.3.6
#> [49] Rcpp_1.1.0           glue_1.8.0           xfun_0.53
#> [52] tibble_3.3.0         GenomicRanges_1.62.0 tidyselect_1.2.1
#> [55] knitr_1.50           dichromat_2.0-0.1    farver_2.1.2
#> [58] htmltools_0.5.8.1    rmarkdown_2.30       labeling_0.4.3
#> [61] compiler_4.5.1       S7_0.2.0
```