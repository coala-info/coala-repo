# Introduction to SigsPack

Sigspack provides tools for easy computation of signature exposures from mutational catalogues.

The package provides several features, allowing to read the primary mutation data, normalise the mutational catalogues if necessary and compute signature exposures with their bootstrapped variation estimates.

## Loading the package

```
library(SigsPack)
```

## Loading a VCF

In most cases you will want to analyse real data, e.g. fit a sample’s mutational profile to known mutational signatures. You can easily load your data and use it with the package.

```
if (require(BSgenome.Hsapiens.UCSC.hg19)) {
  sample <- vcf2mut_cat(
    system.file("extdata", "example.vcf.gz", package="SigsPack"),
    BSgenome.Hsapiens.UCSC.hg19
  )
}
#> Loading required package: BSgenome.Hsapiens.UCSC.hg19
#> Loading required package: BSgenome
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following object is masked from 'package:SigsPack':
#>
#>     normalize
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: GenomicRanges
#> Loading required package: Biostrings
#> Loading required package: XVector
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#> Loading required package: BiocIO
#> Loading required package: rtracklayer
```

It will be transformed into a ‘mutational profile’ sorting all single nucleotide variants according to their trinucleotide context and mutation. The result is a 96 by 1 matrix that can be used as input to the analysis functions of the package as well as in most other packages of this field.

## Simulating data

Instead of using real-life data it is also possible to generate synthetic data that can be used to analyse signatures stability. The following code generates 10 mutational catalogues with exposure to the COSMIC signatures 2, 6, 15 and 27. The catalogues consist of mutation counts sampled from a distribution that is a linear combination of the aforementioned signatures. The weight of each of these signatures can optionally be specified, too. For convenience, the COSMIC reference signature matrix is included in the package and used as default in the functions. However, it is also possible to use all functions with a custom signature matrix.

```
data("cosmicSigs")

cats <- create_mut_catalogues(10, 500, P=cosmicSigs, sig_set = c(2,6,15,27))
knitr::kable(head(cats[['catalogues']]))
```

|  | sample\_1 | sample\_2 | sample\_3 | sample\_4 | sample\_5 | sample\_6 | sample\_7 | sample\_8 | sample\_9 | sample\_10 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A[C>A]A | 1 | 0 | 1 | 1 | 3 | 0 | 0 | 1 | 2 | 2 |
| A[C>A]C | 1 | 2 | 3 | 0 | 0 | 1 | 2 | 4 | 0 | 0 |
| A[C>A]G | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A[C>A]T | 0 | 0 | 0 | 0 | 1 | 2 | 0 | 4 | 1 | 3 |
| C[C>A]A | 1 | 3 | 3 | 2 | 5 | 5 | 2 | 1 | 3 | 4 |
| C[C>A]C | 6 | 3 | 6 | 5 | 10 | 6 | 3 | 8 | 4 | 3 |

## Estimating signature exposures and bootstrapping samples

The function bootstrap\_mut\_catalogues bootstraps a sample returning a specified amount of re-samples which can be used to gain a better variability estimation of the sample’s signature exposure.

The signature exposure is calculated using quadratic programming. This can be done on one or several samples at once. The COSMIC signatures have been included in the package, and are used by default. However, it is possible to use your own signature matrix, or use a sub-set of COSMIC signatures, instead of the whole matrix.

```
reps <- bootstrap_mut_catalogues(n = 1000, original = cats[["catalogues"]][,1])

# using only signatures 4, 17, 23 and 30 for signature estimation
sigs <- signature_exposure(reps, sig_set = c(4,17,23,30))

print(sigs$exposures[,1])
#>  Signature 1  Signature 2  Signature 3  Signature 4  Signature 5  Signature 6
#> 0.000000e+00 0.000000e+00 0.000000e+00 4.754729e-02 0.000000e+00 0.000000e+00
#>  Signature 7  Signature 8  Signature 9 Signature 10 Signature 11 Signature 12
#> 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00
#> Signature 13 Signature 14 Signature 15 Signature 16 Signature 17 Signature 18
#> 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 3.392984e-02 0.000000e+00
#> Signature 19 Signature 20 Signature 21 Signature 22 Signature 23 Signature 24
#> 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 2.330644e-18 0.000000e+00
#> Signature 25 Signature 26 Signature 27 Signature 28 Signature 29 Signature 30
#> 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 9.185229e-01
```

With one command you can bootstrap a mutational catalogue and obtain a table and a plot illustrating the results of the signature estimation for this sample and the bootstrapped re-samples. The plot shows the distribution of estimated signature exposure for all the re-samples, highlighting the one of the original mutational catalogue, thus providing insights on the reliability of the estimates.

```
report <- summarize_exposures(reps[,1])

knitr::kable(
  head(report)
  )
```

|  | original exposure | min | 1. quartile | median | 3. quartile | max |
| --- | --- | --- | --- | --- | --- | --- |
| Signature 1 | 0.0339845 | 0.0000000 | 0.0000000 | 0.0278146 | 0.0741307 | 0.2435741 |
| Signature 2 | 0.4555971 | 0.3393034 | 0.4261347 | 0.4547794 | 0.4763832 | 0.5608115 |
| Signature 3 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 |
| Signature 4 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 |
| Signature 5 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 | 0.0000000 |
| Signature 6 | 0.3038300 | 0.0000000 | 0.2398368 | 0.2881350 | 0.3318271 | 0.4710952 |

![](data:image/png;base64...)

## Tri-nucleotide contexts and normalization

Accurate exposures estimation requires matching tri-nucleotide frequencies between observations and the signature matrix. The COSMIC signature matrix provided in the package is relative to the whole genome (GRCh37) tri-nucleotide frequencies. So if you want to fit those signatures to exome data, the data need to be normalized to match the signatures prior to exposures estimation.

Let’s say, that the vcf we derived the mutational catalogue from contained exome data. In the case of this example, we want to scale our exome data to the genome ‘space’ to match the COSMIC reference signatures. Hence, we need both the tri-nucleotide distribution of the human genome (GRCh37) and the exome that our data were collected on.

Extract the tri-nucleotide context frequencies from a genome (BSgenome object) or exome and use them to normalize the data.

```
if (require(BSgenome.Hsapiens.UCSC.hg19)){
  genome_contexts <- get_context_freq(BSgenome.Hsapiens.UCSC.hg19)
  exome_contexts <- get_context_freq(
    BSgenome.Hsapiens.UCSC.hg19,
    system.file("extdata", "example.bed.gz", package="SigsPack")
  )
  normalized_mut_cat <- SigsPack::normalize(sample, exome_contexts, hg19context_freq)
}
```

The normalization returns frequencies, not count numbers. If you want to use them for exposure estimation or for bootstrapping, the catalogue size must be scaled, or input together with the normalized catalogue.

```
if (require(BSgenome.Hsapiens.UCSC.hg19)) {
  sigs_norm <- signature_exposure(sum(sample) * normalized_mut_cat)
  report_norm <- summarize_exposures(normalized_mut_cat, m=sum(sample))
  reps_norm <- bootstrap_mut_catalogues(
      n=1000,
      original=normalized_mut_cat,
      m=sum(sample)
  )
}
```

![](data:image/png;base64...)

## sessionInfo

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
#>  [3] rtracklayer_1.70.0                BiocIO_1.20.0
#>  [5] Biostrings_2.78.0                 XVector_0.50.0
#>  [7] GenomicRanges_1.62.0              Seqinfo_1.0.0
#>  [9] IRanges_2.44.0                    S4Vectors_0.48.0
#> [11] BiocGenerics_0.56.0               generics_0.1.4
#> [13] SigsPack_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
#>  [3] rjson_0.2.23                xfun_0.53
#>  [5] bslib_0.9.0                 Biobase_2.70.0
#>  [7] lattice_0.22-7              quadprog_1.5-8
#>  [9] vctrs_0.6.5                 tools_4.5.1
#> [11] bitops_1.0-9                curl_7.0.0
#> [13] parallel_4.5.1              AnnotationDbi_1.72.0
#> [15] RSQLite_2.4.3               blob_1.2.4
#> [17] Matrix_1.7-4                cigarillo_1.0.0
#> [19] lifecycle_1.0.4             compiler_4.5.1
#> [21] Rsamtools_2.26.0            codetools_0.2-20
#> [23] GenomeInfoDb_1.46.0         htmltools_0.5.8.1
#> [25] sass_0.4.10                 RCurl_1.98-1.17
#> [27] yaml_2.3.10                 crayon_1.5.3
#> [29] jquerylib_0.1.4             BiocParallel_1.44.0
#> [31] DelayedArray_0.36.0         cachem_1.1.0
#> [33] abind_1.4-8                 digest_0.6.37
#> [35] restfulr_0.0.16             VariantAnnotation_1.56.0
#> [37] fastmap_1.2.0               grid_4.5.1
#> [39] cli_3.6.5                   SparseArray_1.10.0
#> [41] S4Arrays_1.10.0             GenomicFeatures_1.62.0
#> [43] XML_3.99-0.19               UCSC.utils_1.6.0
#> [45] bit64_4.6.0-1               rmarkdown_2.30
#> [47] httr_1.4.7                  matrixStats_1.5.0
#> [49] bit_4.6.0                   png_0.1-8
#> [51] memoise_2.0.1               evaluate_1.0.5
#> [53] knitr_1.50                  rlang_1.1.6
#> [55] DBI_1.2.3                   jsonlite_2.0.0
#> [57] R6_2.6.1                    MatrixGenerics_1.22.0
#> [59] GenomicAlignments_1.46.0
```