# Description of chromhmmData

To install `chromhmmData` use

```
if(!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("chromhmmData")
```

```
library(chromhmmData)
```

This package include the genomic annotations required for running `ChromHMM`.

This includes:

1. `CHROMSIZES`: text files with the chromosomes’ sizes
2. `COORDS`: bed files with the coordinates of different genomic features
3. `ANCHORFILES`: text files with transcription start and end sites of known genes

The annotations for four different genomes are included in the package. Those are the human `hg18` and `hg19` and the mouse `mm10` and `mm9`.

Use `system.file` to access the files and directorys. For example

```
# access a directory
chromsizes <- system.file('extdata/CHROMSIZES', package = 'chromhmmData')
dir(chromsizes)
#> [1] "hg18.txt" "hg19.txt" "mm10.txt" "mm9.txt"

# access a file
system.file('extdata/CHROMSIZES', 'hg19.txt', package = 'chromhmmData')
#> [1] "/private/var/folders/sk/hy088prx12l_cqspv3lbpl9s6_3r11/T/RtmpfrF1ah/Rinst48a77110e7d/chromhmmData/extdata/CHROMSIZES/hg19.txt"
```

These annotation files are obtained from [`ChromHMM`](https://github.com/jernst98/ChromHMM) source code repository.

```
sessionInfo()
#> R version 4.1.0 Patched (2021-05-24 r80367)
#> Platform: x86_64-apple-darwin17.7.0 (64-bit)
#> Running under: macOS High Sierra 10.13.6
#>
#> Matrix products: default
#> BLAS:   /Users/ka36530_ca/R-stuff/bin/R-4-1/lib/libRblas.dylib
#> LAPACK: /Users/ka36530_ca/R-stuff/bin/R-4-1/lib/libRlapack.dylib
#>
#> locale:
#> [1] C/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] chromhmmData_0.99.2
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.27     R6_2.5.0          jsonlite_1.7.2    magrittr_2.0.1
#>  [5] evaluate_0.14     rlang_0.4.11      stringi_1.6.2     jquerylib_0.1.4
#>  [9] bslib_0.2.5.1     rmarkdown_2.9     tools_4.1.0       stringr_1.4.0
#> [13] xfun_0.24         yaml_2.2.1        compiler_4.1.0    htmltools_0.5.1.1
#> [17] knitr_1.33        sass_0.4.0
```