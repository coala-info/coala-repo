# HDF5 Compression Filters

Mike L. Smith1

1de.NBI & EMBL Heidelberg

#### 30 October 2025

#### Package

rhdf5filters 1.22.0

# Contents

* [1 Motivation](#motivation)
* [2 Usage](#usage)
  + [2.1 With **rhdf5**](#with-rhdf5)
    - [2.1.1 Writing data](#writing-data)
    - [2.1.2 Reading data](#reading-data)
  + [2.2 With external applications](#with-external-applications)
    - [2.2.1 **h5dump** example](#h5dump-example)
* [3 Compiling the compression libraries](#compiling-the-compression-libraries)
* [Session info](#session-info)

# 1 Motivation

One of the advantages of using HDF5 is that data stored on disk can be compressed, reducing both the space required to store them and the time needed to read those data. This data compression is applied as part of the HDF5 “filter pipeline” that modifies data during I/O operations. HDF5 includes several filter algorithms as standard, and the version of the HDF5 library found in *[Rhdf5lib](https://bioconductor.org/packages/3.22/Rhdf5lib)* is additionally compiled with support for the *deflate* and *szip* compression filters which rely on third-party compression libraries. Collectively HDF5 refer to these as the “internal” filters. It is possible to use any combination of these (including none) when writing data using *[rhdf5](https://bioconductor.org/packages/3.22/rhdf5)*. The default filter pipeline is shown in Figure [1](#fig:filter-pipeline).

![The default compression pipeline used by rhdf5](data:image/png;base64...)

Figure 1: The default compression pipeline used by rhdf5

This pipeline approach has been designed so that filters can be chained together (as in the diagram above) or easily substituted for alternative filters. This allows tailoring the compression approach to best suit the data or application.

It may be case that for a specific usecase an alternative, third-party, compression algorithm would be the most appropriate to use. Such filters, which are not part of the standard HDF5 distribution, are referred to as “external” filters. In order to allow their use without requiring either the HDF5 library or applications to be built with support for all possible filters HDF5 is able to use dynamically loaded filters. These are compiled independently from the HDF5 library, but are available to an application at run time.

This package currently distributes external HDF5 filters employing [**bzip2**](https://sourceware.org/bzip2/), [LZF](http://oldhome.schmorp.de/marc/liblzf.html), [VBZ](https://github.com/nanoporetech/vbz_compression), [Zstandard](https://github.com/facebook/zstd) and the [**Blosc**](https://blosc.org/) meta-compressor. In total *[rhdf5filters](https://bioconductor.org/packages/3.22/rhdf5filters)* provides access to 11111 zlib & Zstandard compression are available as standalone filters and also available via Blosc. compression filters than can be applied to HDF5 datasets. The full list of filters currently provided by the package is:

* bzip2
* blosclz
* lz4
* lz4hc
* snappy
* Zstandard
* zlib
* LZF
* VBZ

# 2 Usage

## 2.1 With **rhdf5**

*[rhdf5filters](https://bioconductor.org/packages/3.22/rhdf5filters)* is principally designed to be used via the *[rhdf5](https://bioconductor.org/packages/3.22/rhdf5)* package, where several functions are able to utilise the compression filters. For completeness those functions are described here and are also documented in the *[rhdf5](https://bioconductor.org/packages/3.22/rhdf5)* vignette.

### 2.1.1 Writing data

The function `h5createDataset()` within *[rhdf5](https://bioconductor.org/packages/3.22/rhdf5)* takes the argument `filter` which specifies which compression filter should be used when a new dataset is created.

Also available in *[rhdf5](https://bioconductor.org/packages/3.22/rhdf5)* are the functions `H5Pset_bzip2()`, ``H5Pset_lzf()` and `H5Pset_blosc()`. These are not part of the standard HDF5 interface, but are modeled on the `H5Pset_deflate()` function and allow the *bzip2*, *lzf* and *blosc* filters to be set on dataset create property lists.

### 2.1.2 Reading data

As long as *[rhdf5filters](https://bioconductor.org/packages/3.22/rhdf5filters)* is installed, *[rhdf5](https://bioconductor.org/packages/3.22/rhdf5)* will be able to transparently read data compressed using any of the filters available in the package without requiring any action on your part.

## 2.2 With external applications

The dynamic loading design of the HDF5 compression filters means that you can use the versions distributed with *[rhdf5filters](https://bioconductor.org/packages/3.22/rhdf5filters)* with other applications, including other R packages that interface HDF5 as well as external applications not written in R e.g. HDFVIEW. The function `hdf5_plugin_path()` will return the location of in your packages library where the compiled plugins are stored. You can pass this location to the HDF5 function `H5PLprepend()` or you can the set the environment variable `HDF5_PLUGIN_PATH`, and other applications will be able to dynamically load the compression plugins found there if needed.

```
rhdf5filters::hdf5_plugin_path()
```

```
## [1] "/tmp/Rtmpz9M0Hq/Rinst2a25d1118aa7af/rhdf5filters/lib"
```

### 2.2.1 **h5dump** example

The next example demonstrates how the filters distributed by *[rhdf5filters](https://bioconductor.org/packages/3.22/rhdf5filters)* can be used by external applications to decompress data. Do do this we’ll use the version of **h5dump** installed on the system222 If **h5dump** is not found on your system these example will fail. and a file distributed with this package that has been compressed using the *blosc* filter.

```
## blosc compressed file
blosc_file <- system.file("h5examples/h5ex_d_blosc.h5",
                          package = "rhdf5filters")
```

Now we use `system2()` to call the system version of **h5dump** and capture the output, which is then printed below. The most important parts to note are the `FILTERS` section, which shows the dataset was indeed compressed with *blosc*, and `DATA`, where the error shows that **h5dump** is currently unable to read the dataset.

```
h5dump_out <- system2('h5dump',
                      args = c('-p', '-d /dset', blosc_file),
                      stdout = TRUE, stderr = TRUE)
cat(h5dump_out, sep = "\n")
```

```
## HDF5 "rhdf5filters/h5examples/h5ex_d_blosc.h5" {
## DATASET "/dset" {
##    DATATYPE  H5T_IEEE_F32LE
##    DATASPACE  SIMPLE { ( 30, 10, 20 ) / ( 30, 10, 20 ) }
##    STORAGE_LAYOUT {
##       CHUNKED ( 10, 10, 20 )
##       SIZE 3347 (7.171:1 COMPRESSION)
##    }
##    FILTERS {
##       USER_DEFINED_FILTER {
##          FILTER_ID 32001
##          COMMENT blosc
##          PARAMS { 2 2 4 8000 4 1 0 }
##       }
##    }
##    FILLVALUE {
##       FILL_TIME H5D_FILL_TIME_IFSET
##       VALUE  H5D_FILL_VALUE_DEFAULT
##    }
##    ALLOCATION_TIME {
##       H5D_ALLOC_TIME_INCR
##    }
##    DATA {h5dump error: unable to print data
##
##    }
## }
## }
```

Next we set `HDF5_PLUGIN_PATH` to the location where *[rhdf5filters](https://bioconductor.org/packages/3.22/rhdf5filters)* has stored the filters and re-run the call to **h5dump**. Printing the output333 The dataset is quite large, so we only show a few lines here. no longer returns an error in the `DATA` section, indicating that the *blosc* filter plugin was found and used by **h5dump**.

```
## set environment variable to hdf5filter location
Sys.setenv("HDF5_PLUGIN_PATH" = rhdf5filters::hdf5_plugin_path())
h5dump_out <- system2('h5dump',
                      args = c('-p', '-d /dset', '-w 50', blosc_file),
                      stdout = TRUE,  stderr = TRUE)

## find the data entry and print the first few lines
DATA_line <- grep(h5dump_out, pattern = "DATA \\{")
cat( h5dump_out[ (DATA_line):(DATA_line+2) ], sep = "\n" )
```

```
##   DATA {
##    (0,0,0): 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
##    (0,0,11): 11, 12, 13, 14, 15, 16, 17, 18,
```

# 3 Compiling the compression libraries

In order to compile the compression filters **rhdf5filters** needs to link them
against libraries for the relevant compression tools. These libraries include `bzip2`,
`blosc` and `zstd`. By default **rhdf5filters** will look for system installations
of those libraries and link against them. If they are not found then versions
that are bundled with the package will be compiled and used instead. It is possible
to use system libraries for some filters and the bundled versions for others -
**rhdf5filters** should be able to determine this at compile time.

If you wish to force the use of the bundled libraries, perhaps to ensure linking
against the static versions, this can be done by providing the configure argument
`"--with-bundled-libraries"` during package installation e.g.

```
BiocManager::install('rhdf5filters',
                     configure.args = "--with-bundled-libraries")
```

# Session info

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
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] rhdf5filters_1.22.0 knitr_1.50          htmltools_0.5.8.1
## [10] rmarkdown_2.30      lifecycle_1.0.4     cli_3.6.5
## [13] sass_0.4.10         jquerylib_0.1.4     compiler_4.5.1
## [16] tools_4.5.1         evaluate_1.0.5      bslib_0.9.0
## [19] yaml_2.3.10         BiocManager_1.30.26 jsonlite_2.0.0
## [22] rlang_1.1.6
```