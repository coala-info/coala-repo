# rGenomeTracks

rGenomeTracks package leverages the power of [pyGenomeTracks](https://github.com/deeptools/pyGenomeTracks) software with the interactivity of R. [pyGenomeTracks](https://github.com/deeptools/pyGenomeTracks) is a python software that offers robust method for visualizing epigenetic data files like narrowPeak, Hic matrix, TADs and arcs, however though, here is no way currently to use it within R interactive session. rGenomeTracks wrapped the whole functionality of pyGenomeTracks with additional utilites to make to more pleasant for R users.

```
# loading the rGenomeTracks
library(rGenomeTracks)
# loading example data
#library(rGenomeTracksData)
```

## Installing PyGenomeTracks

You should have pyGenomeTracks installed on R’s loading environment. To avoid dependency clash, we highly recommend using `install_pyGenomeTracks()`. That way, you ensure using the tested pyGenomeTracks version with the current release. rGenomeTracks is supposed to automatically prompt you to install this dependency after running `plot_gtracks()`. If this step failed, you can manually install pyGenomeTracks with `install_pyGenomeTracks()`

```
install_pyGenomeTracks()
```

## Principle

rGenomeTracks deals creates tracks in a class `genome_track`. Currently, there are 14 tracks available: 1. track\_bed() 2. track\_bedgraph() 3. track\_bedgraph\_matrix() 4. track\_gtf() 5. track\_hlines() 6. track\_vlines() 7. track\_spacer() 8. track\_bigwig() 9. track\_epilogos() 10. track\_narrowPeak() 11. track\_domains() 12. track\_hic\_matrix() 13. track\_links() 14. track\_scalebar() 15. track\_x\_axis()

Please refer to the help page for each one of them for details and examples.

We will download .h5 matrix and store the location in temporary directory for demonstration.

```
# Download h5 example
ah <- AnnotationHub()
query(ah, "rGenomeTracksData")
h5_dir <-  ah[["AH95901"]]

 # Create HiC track from HiC matrix
 h5 <- track_hic_matrix(
   file = h5_dir, depth = 250000, min_value = 5, max_value = 200,
   transform = "log1p", show_masked_bins = FALSE
 )
```

Other demonstration for TADS, arcs and bigwig data will be loaded from the built-in package example data.

```
 # Load other examples
 tads_dir <- system.file("extdata", "tad_classification.bed", package = "rGenomeTracks")
 arcs_dir <- system.file("extdata", "links2.links", package = "rGenomeTracks")
 bw_dir <- system.file("extdata", "bigwig2_X_2.5e6_3.5e6.bw", package = "rGenomeTracks")

 # Create TADS track
 tads <- track_domains(
   file = tads_dir, border_color = "black",
   color = "none", height = 5,
   line_width = 5,
   show_data_range = FALSE,
   overlay_previous = "share-y"
 )

 # Create arcs track
 arcs <- track_links(
   file = arcs_dir, links_type = "triangles",
   line_style = "dashed",
   overlay_previous = "share-y",
   color = "darkred",
   line_width = 3,
   show_data_range = FALSE
 )

 # Create bigwig track
 bw <- track_bigwig(
   file = bw_dir, color = "red",
   max_value = 50,
   min_value = 0,
   height = 4,
   overlay_previous = "no",
   show_data_range = FALSE
 )
```

`genome_track` objects can be added together using `+` function.

```
 # Create one object from HiC, arcs and bigwid
 tracks <- tads + arcs + bw
```

The track(s) to be plotted is to be passed to `plot_gtracks()` for the generation of the plot. Additionally, `plot_gtracks()` requires the genomic region to be plotted. Optionally, you can set plot title, dpi, width, height, fontsize, track-to-label fraction, label alignment position, and directory to save the plot.

```
 # Plot the tracks
## Note to verify installing miniconda if not installed.

 layout(matrix(c(1,1,2,3,4,4), nrow = 3, ncol = 2, byrow = TRUE))
 plot_gtracks(tracks, chr = "X", start = 25 * 10^5, end = 31 * 10^5)

# Plot HiC, TADS and bigwig tracks
 plot_gtracks(h5 + tads + bw, chr = "X", start = 25 * 10^5, end = 31 * 10^5)
```

![](data:image/png;base64...)![](data:image/png;base64...)

## Tips

### Quickly create multiple tracks

If you have tracks with the same format, you can import them quickly by using lapply() and reduce() functions.

```
dirs <- list.files(system.file("extdata", package = "rGenomeTracks"), full.names = TRUE)

# filter only bed files (without bedgraphs or narrowpeaks)
bed_dirs <- grep(
  dirs,  pattern = ".bed(?!graph)", perl = TRUE, value = TRUE)

bed_list <- lapply(bed_dirs, track_bed)

bed_tracks <- Reduce("+", bed_list)
```

You can repeat this process for tracks of same category then pass the tracks to plot\_gtracks()

### Create complex layout figures

You may choose create a complex figure using layout() and split.screen() function then save the device.

Note that you cannot make use of dir argument in plot\_gtracks() if you used this method as it is passed to pyGenomeTracks. So, you have to capture R’s graphic device and save it manually.

## Session Information

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
#> [1] rGenomeTracks_1.16.0
#>
#> loaded via a namespace (and not attached):
#>  [1] vctrs_0.6.5              cli_3.6.5                knitr_1.50
#>  [4] rlang_1.1.6              xfun_0.53                stringi_1.8.7
#>  [7] tiff_0.1-12              purrr_1.1.0              png_0.1-8
#> [10] readbitmap_0.1.5         jsonlite_2.0.0           glue_1.8.0
#> [13] htmltools_0.5.8.1        sass_0.4.10              rmarkdown_2.30
#> [16] grid_4.5.1               evaluate_1.0.5           jquerylib_0.1.4
#> [19] fastmap_1.2.0            yaml_2.3.10              lifecycle_1.0.4
#> [22] stringr_1.5.2            compiler_4.5.1           bmp_0.3.1
#> [25] igraph_2.2.1             Rcpp_1.1.0               pkgconfig_2.0.3
#> [28] imager_1.0.5             lattice_0.22-7           digest_0.6.37
#> [31] R6_2.6.1                 reticulate_1.44.0        magrittr_2.0.4
#> [34] rGenomeTracksData_0.99.0 Matrix_1.7-4             bslib_0.9.0
#> [37] tools_4.5.1              jpeg_0.1-11              cachem_1.1.0
```