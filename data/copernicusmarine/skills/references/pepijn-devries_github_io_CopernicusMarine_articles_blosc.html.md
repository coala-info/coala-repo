[Skip to contents](#main)

[CopernicusMarine](../index.html)
0.4.5.0003

* [Reference](../reference/index.html)
* Articles
  + [BLOSC Support](../articles/blosc.html)
  + [Product Information](../articles/product-info.html)
  + [Using stars\_proxy Objects](../articles/proxy.html)
  + [Translate Request](../articles/translate.html)
* [Changelog](../news/index.html)

![](../logo.svg)

# BLOSC Support

Source: [`vignettes/blosc.Rmd`](https://github.com/pepijn-devries/CopernicusMarine/blob/master/vignettes/blosc.Rmd)

`blosc.Rmd`

Functions that access Copernicus Marine raster files stored in the [ZARR format](https://zarr.dev/)
(`[cms_download_subset()](../reference/cms_download_subset.html)` and `[cms_zarr_proxy()](../reference/cms_zarr_proxy.html)`)
generally require [BLOSC
decompression](https://github.com/Blosc/c-blosc). This package uses the features provided by the GDAL
library as ported by the [sf
package](https://r-spatial.github.io/sf/).

Not all `sf` builds come with BLOSC support. If you
receive an error about missing BLOSC support, you need to reinstall
`sf` with BLOSC. Below you will find instructions to get
BLOSC support on your OS.

## Windows

The tool chain for building R packages on Windows includes BLOSC
support by default. You just need to install the latest version of [sf from CRAN](https://cran.r-project.org/package%3Dsf). If this
doesn’t work, you can build sf from source with RTools >= 4.5.

## MacOS

On MacOS you can build the `sf` package from source, but
ensure that you have the GDAL library installed first using the homebrew
formula (which contains BLOSC support)

```
brew install pkg-config
brew install gdal
```

```
install.packages("sf", type = "source", configure.args = "--with-proj-lib=$(brew --prefix)/lib/")
```

## Debian (and alike)

First run:

```
sudo apt-get install libblosc-dev
```

Then reinstall `sf` to make sure it compiles with BLOSC
support

## Fedora (and alike)

First run:

```
sudo yum install blosc-devel
```

Then reinstall `sf` to make sure it compiles with BLOSC
support

## On this page

Developed by Pepijn de Vries.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.