# Reading HDF5 Files In The Cloud

Mike L. Smith1

1de.NBI & EMBL Heidelberg

#### 4 December 2025

#### Package

rhdf5 2.54.1

# Contents

* [1 Public S3 Buckets](#public-s3-buckets)
* [2 Private S3 Buckets](#private-s3-buckets)
* [3 Session Info](#session-info)

The *[rhdf5](https://bioconductor.org/packages/3.22/rhdf5)* provides limited support for read-only access to HDF5 files stored in Amazon S3 buckets. This is implemented via the [HDF5 S3 Virtual File Driver](https://portal.hdfgroup.org/display/HDF5/Virtual%2BFile%2BDrivers%2B-%2BS3%2Band%2BHDFS) and allows access to HDF5 files hosted in both public and private S3 buckets.

Currently only the functions `h5ls()`, `h5dump()` and `h5read()` are supported.

```
library(rhdf5)
```

# 1 Public S3 Buckets

To access a file in a public Amazon S3 bucket you provide the file’s URL to the `file` argument. You also need to set the argument `s3 = TRUE`, otherwise `h5ls()` will treat the URL as a path on the local disk fail.

```
public_S3_url <- "https://rhdf5-public.s3.eu-central-1.amazonaws.com/h5ex_t_array.h5"
h5ls(file = public_S3_url,
     s3 = TRUE)
```

```
##   group name       otype dclass dim
## 0     /  DS1 H5I_DATASET  ARRAY   4
```

The same arguments are also valid for using `h5dump()` to retrieve the contents of a file.

```
public_S3_url <- "https://rhdf5-public.s3.eu-central-1.amazonaws.com/h5ex_t_cmpd.h5"
h5dump(file = public_S3_url,
     s3 = TRUE)
```

```
## $DS1
##   Serial number          Location Temperature (F) Pressure (inHg)
## 1          1153 Exterior (static)           53.23           24.57
## 2          1184            Intake           55.12           22.95
## 3          1027   Intake manifold          103.55           31.23
## 4          1313  Exhaust manifold         1252.89           84.11
```

In addition to examining and reading whole files, we can also extract just a subset, without needed to read or download the entire file. In the example below we use `h5ls()` to examine a file in an S3 bucket and identify the name of a dataset within it (`a1`) and the number of dimensions for that dataset (3). We can then use `h5read()` along with the `name` and `index` arguments to read only a subset of the dataset into our R session.

```
public_S3_url <- 'https://rhdf5-public.s3.eu-central-1.amazonaws.com/rhdf5ex_t_float_3d.h5'
h5ls(file = public_S3_url, s3 = TRUE)
```

```
##   group name       otype dclass        dim
## 0     /   a1 H5I_DATASET  FLOAT 5 x 10 x 2
```

```
h5read(public_S3_url,
       name = "a1",
       index = list(1:2, 3, NULL),
       s3 = TRUE)
```

```
## , , 1
##
##           [,1]
## [1,] 0.2444485
## [2,] 0.3873723
##
## , , 2
##
##           [,1]
## [1,] 0.7906603
## [2,] 0.3274960
```

# 2 Private S3 Buckets

To access files in a private Amazon S3 bucket you will need to provide three additional details: The AWS region where the files are hosted, your AWS access key ID, and your AWS secret access key. More information on how to obtain AWS access keys can be found under [AWS Security Credentials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys).

These three values need to be stored in a list like below. *Important note: for now they must be in this specific order.*

```
## these are example credentials and will not work
s3_cred <- list(
    aws_region = "eu-central-1",
    access_key_id = "AKIAIOSFODNN7EXAMPLE",
    secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
)
```

Finally we pass this list to `h5ls()` via the `s3credentials` argument.

```
public_S3_url <- "https://rhdf5-private.s3.eu-central-1.amazonaws.com/h5ex_t_array.h5"
h5ls(file = public_S3_url,
     s3 = TRUE,
     s3credentials = s3_cred)
```

The `s3credentials` arguments is used in exactly the same way for `h5dump()` and `h5read()`.

# 3 Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocParallel_1.44.0 ggplot2_4.0.1       dplyr_1.1.4
## [4] rhdf5_2.54.1        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bit_4.6.0           gtable_0.3.6        jsonlite_2.0.0
##  [4] compiler_4.5.2      BiocManager_1.30.27 Rcpp_1.1.0
##  [7] tinytex_0.58        tidyselect_1.2.1    magick_2.9.0
## [10] rhdf5filters_1.22.0 parallel_4.5.2      dichromat_2.0-0.1
## [13] jquerylib_0.1.4     scales_1.4.0        yaml_2.3.11
## [16] fastmap_1.2.0       R6_2.6.1            labeling_0.4.3
## [19] generics_0.1.4      knitr_1.50          tibble_3.3.0
## [22] bookdown_0.45       bslib_0.9.0         pillar_1.11.1
## [25] RColorBrewer_1.1-3  rlang_1.1.6         utf8_1.2.6
## [28] cachem_1.1.0        xfun_0.54           sass_0.4.10
## [31] S7_0.2.1            bit64_4.6.0-1       cli_3.6.5
## [34] withr_3.0.2         magrittr_2.0.4      Rhdf5lib_1.32.0
## [37] digest_0.6.39       grid_4.5.2          lifecycle_1.0.4
## [40] vctrs_0.6.5         bench_1.1.4         evaluate_1.0.5
## [43] glue_1.8.0          farver_2.1.2        codetools_0.2-20
## [46] rmarkdown_2.30      tools_4.5.2         pkgconfig_2.0.3
## [49] htmltools_0.5.9
```