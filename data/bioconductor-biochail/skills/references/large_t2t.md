# 02 Working with larger VCF: T2T by chromosome

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Overview](#overview)
* [2 Population stratification assessment via PCA](#population-stratification-assessment-via-pca)
* [3 Exercises](#exercises)
* [4 Appendix: using rclone with docker to get the chr17 data](#appendix-using-rclone-with-docker-to-get-the-chr17-data)
* [5 Installing `BiocHail`](#installing-biochail)
* [SessionInfo](#sessioninfo)

# 1 Overview

In this document we illustrate some issues with
large data volumes.

Here is how we acquire the genotypes for the thousand
genomes samples based on the T2T reference. We obtained
bgzipped vcf via

```
AnVIL::gsutil_cp("gs://fc-47de7dae-e8e6-429c-b760-b4ba49136eee/1KGP/joint_genotyping/joint_vcfs/raw/chr22.genotyped.vcf.gz", ".")
```

Then we used hail in python to deal with the conversion to MatrixTable.
We could have done this in R, but we had to learn how to manipulate
the ‘reference sequence’. We have a conjectural ‘reference sequence’
json document in the json folder of the BiocHail package, used here
as `t2tAnVIL.json`.

```
>>> import hail as h
>>> rg = h.get_reference('GRCh38')
Initializing Hail with default parameters...
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Running on Apache Spark version 3.1.3
SparkUI available at http://756809c79837:4040
Welcome to
     __  __     <>__
    / /_/ /__  __/ /
   / __  / _ `/ / /
  /_/ /_/\_,_/_/_/   version 0.2.105-acd89e80c345
LOGGING: writing to /home/rstudio/hail-20221213-1558-0.2.105-acd89e80c345.log
>>> nn = rg.read("t2tAnVIL.json")
>>> h.import_vcf("chr22.genotyped.vcf.gz", force_bgz=True, reference_genome=nn).write("t2t22.mt")
```

This operation seems to take a long time even with 64 cores. We
could not get exact timing owing to some connectivity problems.

Here we’ll work with the genotype data for T2T chr17. We assume
that the MatrixTable is located at the path given by the environment
variable `HAIL_T2T_CHR17`. This MatrixTable is available
in the Open Storage Network at osn:/bir190004-bucket01/Bioc1KGt2t/t17.zip.
This is a 45 GB file. It should be unzipped at the location pointed to
by `HAIL_T2T_CHR17`. Instructions for using rclone to acquire the zip file
are given in the appendix.

```
library(BiocHail)
```

(If the above command indicates that BiocHail is not available,
see the Installation section near the end of this document.)

```
hl <- hail_init()
```

```
## Using Python: /home/biocbuild/.pyenv/versions/3.9.22/bin/python3.9
## Creating virtual environment '/var/cache/basilisk/1.22.0/BiocHail/1.10.0/bsklenv' ...
```

```
## + /home/biocbuild/.pyenv/versions/3.9.22/bin/python3.9 -m venv /var/cache/basilisk/1.22.0/BiocHail/1.10.0/bsklenv
```

```
## Done!
## Installing packages: pip, wheel, setuptools
```

```
## + /var/cache/basilisk/1.22.0/BiocHail/1.10.0/bsklenv/bin/python -m pip install --upgrade pip wheel setuptools
```

```
## Installing packages: 'hail==0.2.135', 'ukbb_pan_ancestry==0.0.2', 'certifi==2025.4.26', 'cffi==1.17.1', 'charset-normalizer==3.4.2', 'click==8.1.8', 'cryptography==45.0.4', 'distro==1.9.0', 'gidgethub==5.4.0', 'idna==3.10', 'pycparser==2.22', 'pyjwt==2.10.1', 'requests==2.32.4', 'typing-extensions==4.14.0', 'uritemplate==4.2.0', 'urllib3==1.26.20', 'zulip==0.9.0'
```

```
## + /var/cache/basilisk/1.22.0/BiocHail/1.10.0/bsklenv/bin/python -m pip install --upgrade --no-user 'hail==0.2.135' 'ukbb_pan_ancestry==0.0.2' 'certifi==2025.4.26' 'cffi==1.17.1' 'charset-normalizer==3.4.2' 'click==8.1.8' 'cryptography==45.0.4' 'distro==1.9.0' 'gidgethub==5.4.0' 'idna==3.10' 'pycparser==2.22' 'pyjwt==2.10.1' 'requests==2.32.4' 'typing-extensions==4.14.0' 'uritemplate==4.2.0' 'urllib3==1.26.20' 'zulip==0.9.0'
```

```
## Virtual environment '/var/cache/basilisk/1.22.0/BiocHail/1.10.0/bsklenv' successfully created.
```

```
# NB the following two commands are now encapsulated in the rg_update function
nn <- hl$get_reference('GRCh38')
nn <- nn$read(system.file("json/t2tAnVIL.json", package="BiocHail"))
# updates the hail reference genome
bigloc = Sys.getenv("HAIL_T2T_CHR17")
if (nchar(bigloc)>0) {
  mt17 <- hl$read_matrix_table(Sys.getenv("HAIL_T2T_CHR17"))
  mt17$count()
}
```

# 2 Population stratification assessment via PCA

The following command would compute PCs based on all SNP.

```
pcastuff = hl$hwe_normalized_pca(mt17$GT)
```

This seems impractical. We have found that with a 64 core machine
at terra.bio, PCA on samples of 1-5% of the 3.8 million loci on T2T chr17
takes 40 minutes. Hail’s code seems good at utilizing all the cores.

We saved the PC scores for PCA based on 38k randomly sampled loci,
and 191k randomly sampled loci. Here’s a simple view of the latter.

```
utils::data(pcs_191k)
graphics::pairs(pcs_191k[,1:5], pch=".")
```

![](data:image/png;base64...)

# 3 Exercises

1. Comment on the gain in information about geographic origin
   achieved by using a 5% sample of loci instead of a 1% sample.
2. Find the geographic origins of donors of the 1000 genomes genotypes
   and bind them to `mt17` using the methods given in vignette `01_gwas_tut`.
   Use these codes to color the points in the PCA plot.
3. Produce an artificial “phenotype” for these donors via `rnorm(3202,0,1)`,
   bind it to the genotype data, and perform a naive GWAS. What are the
   loci most strongly associated with the artificial phenotype?
4. Produce a new artificial phenotype which has some association with
   geographic origin of donor, but no association with genotype.
   Produce a new naive GWAS, and a third using some of the PCA scores
   as covariates. What are the effects of this covariate adjustment on
   reasoning about genetic association with the artificial phenotype?

# 4 Appendix: using rclone with docker to get the chr17 data

It can be painful to install and configure rclone. We use
a docker container. Let RC\_DATADIR be an environment variable
evaluating to an available folder.

Also, place the text file with contents

```
[osn]
type = s3
provider = AWS
endpoint = https://mghp.osn.xsede.org
acl = public
no_check_bucket = true
```

in a file `rclone.conf` in a folder pointed to by the environment
variable `RC_CONFDIR`.

Then the following

```
docker run -v $RC_DATADIR:/data -v $RC_CONFDIR:/config/rclone -t rclone/rclone:latest ls osn:/bir190004-bucket01/Bioc1KGt2t
```

will list the files with 1KG samples genotyped against the T2T reference.

Use the rclone `copyto` command to obtain a local copy of the zip file `t17.zip`
in the folder pointed to by `$RC_DATADIR`:

```
docker run -v $RC_DATADIR:/data -v $RC_CONFDIR:/config/rclone -t rclone/rclone:latest copyto osn:/bir190004-bucket01/Bioc1KGt2t/t17.zip ./t17.zip
```

This file should be unzipped in a folder to which the environment variable `HAIL_T2T_CHR17` will
point.

# 5 Installing `BiocHail`

`BiocHail` should be installed as follows:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("BiocHail")
```

As of 1.0.0, a JDK for Java version `<=` 11.0 is necessary
to use the version of Hail that is installed with the package.
This package should be usable on MacOS with suitable java
support. If Java version `>=` 8.x is used, warnings from
Apache Spark may be observed. To the best of our knowledge
the conditions to which the warnings pertain do not affect program performance.

# SessionInfo

```
sessionInfo()
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggplot2_4.0.0    BiocHail_1.10.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         generics_0.1.4
##  [4] RSQLite_2.4.3       lattice_0.22-7      digest_0.6.37
##  [7] magrittr_2.0.4      RColorBrewer_1.1-3  evaluate_1.0.5
## [10] grid_4.5.1          bookdown_0.45       fastmap_1.2.0
## [13] blob_1.2.4          jsonlite_2.0.0      Matrix_1.7-4
## [16] DBI_1.2.3           tinytex_0.57        BiocManager_1.30.26
## [19] scales_1.4.0        httr2_1.2.1         jquerylib_0.1.4
## [22] cli_3.6.5           rlang_1.1.6         dbplyr_2.5.1
## [25] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0
## [28] yaml_2.3.10         tools_4.5.1         dir.expiry_1.18.0
## [31] parallel_4.5.1      memoise_2.0.1       dplyr_1.1.4
## [34] filelock_1.0.3      basilisk_1.22.0     BiocGenerics_0.56.0
## [37] curl_7.0.0          reticulate_1.44.0   vctrs_0.6.5
## [40] R6_2.6.1            png_0.1-8           magick_2.9.0
## [43] BiocFileCache_3.0.0 lifecycle_1.0.4     bit_4.6.0
## [46] pkgconfig_2.0.3     gtable_0.3.6        pillar_1.11.1
## [49] bslib_0.9.0         glue_1.8.0          Rcpp_1.1.0
## [52] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
## [55] dichromat_2.0-0.1   knitr_1.50          farver_2.1.2
## [58] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
## [61] S7_0.2.0
```