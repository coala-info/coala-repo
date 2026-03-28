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

# Changelog

Source: [`NEWS.md`](https://github.com/pepijn-devries/CopernicusMarine/blob/master/NEWS.md)

## CopernicusMarine v0.4.5.0003

* Added more safeguards to vignette to pass CRAN checks
* Added more tests
* Fixed issue [164](https://github.com/pepijn-devries/CopernicusMarine/issues/164)

## CopernicusMarine v0.4.5

CRAN release: 2026-03-12

* Added `[vignette("product-info")](../articles/product-info.html)`
* Omitting subset-arguments in `[cms_download_subset()](../reference/cms_download_subset.html)` calls is now allowed
* Removed deprecated argument ‘crop’ in `[cms_download_subset()](../reference/cms_download_subset.html)`
* Added warnings for mismatch between requested and available dimension ranges for `[cms_download_subset()](../reference/cms_download_subset.html)`
* Fix for [issue 143](https://github.com/pepijn-devries/CopernicusMarine/issues/143)
* Added tests
* Updated documentation

## CopernicusMarine v0.4.4

CRAN release: 2026-02-26

* Added `[vignette("proxy")](../articles/proxy.html)` and `[vignette("blosc")](../articles/blosc.html)`
* In order to pass CRAN checks:
  + Added safeguards to vignette
  + Improved handling of comparing floating point numbers when slicing stars\_proxy objects
  + Added more rigorous checking of availability of required dependencies
* Added credentials check to all functions downloading from S3 storage.

## CopernicusMarine v0.4.0

CRAN release: 2026-02-12

* `[cms_download_subset()](../reference/cms_download_subset.html)` now uses GDAL library with Zarr driver. Advantages:
  + Simpler code, easier to maintain
  + Smaller dependency footprint
* Added `[cms_zarr_proxy()](../reference/cms_zarr_proxy.html)` and `[cms_native_proxy()](../reference/cms_native_proxy.html)`. Both can create [`stars_proxy` objects](https://r-spatial.github.io/stars/articles/stars2.html#stars-proxy-objects).
* Let `httr2` handle request errors, it has become a lot better at it

## CopernicusMarine v0.3.7

CRAN release: 2025-11-30

* Fix for [issue](https://github.com/pepijn-devries/CopernicusMarine/issues/111) [#111](https://github.com/pepijn-devries/CopernicusMarine/issues/111)

## CopernicusMarine v0.3.6

CRAN release: 2025-11-11

* Updated documentation
* Small fix to pass CRAN checks

## CopernicusMarine v0.3.5

CRAN release: 2025-11-07

* Updated documentation
* Fix for [issue](https://github.com/pepijn-devries/CopernicusMarine/issues/100) [#100](https://github.com/pepijn-devries/CopernicusMarine/issues/100)
* Fix for [issue](https://github.com/pepijn-devries/CopernicusMarine/issues/102) [#102](https://github.com/pepijn-devries/CopernicusMarine/issues/102)

## CopernicusMarine v0.3.2

CRAN release: 2025-10-12

* Added `[cms_translate()](../reference/cms_translate.html)`
* Added `[vignette("translate")](../articles/translate.html)`
* Fix in dimensioning of Zarr data

## CopernicusMarine v0.3.1

CRAN release: 2025-09-27

* Added support for sub-setting OMI, and downsampled4 assets
* Some minor fixes
* Moved dependency “blosc” to suggests as per CRAN request

## CopernicusMarine v0.3.0

CRAN release: 2025-09-11

* `[cms_download_subset()](../reference/cms_download_subset.html)` is operational again!
* Some fixes in native download routines
* Improved test coverage

## CopernicusMarine v0.2.6

CRAN release: 2025-07-14

* Decommissioned STAC functions in order to pass pass CRAN checks.
* Implemented `[cms_list_native_files()](../reference/cms_download_native.html)` and `csm_download_native()` as alternatives to STAC.
* Updated login routine
* Improved test coverage
* Added code of conduct

## CopernicusMarine v0.2.5

CRAN release: 2025-04-05

* Fix to pass CRAN checks

## CopernicusMarine v0.2.4

CRAN release: 2024-12-22

* Added check workflow
* Added code coverage workflow
* Removed deprecated functions
* Updated documentation
* Fix in `addCmsWMTSTiles`
* Fix for change in remote API
* Fix in login function

## CopernicusMarine v0.2.3

CRAN release: 2024-01-25

* Some fixes in the subset download routine
* Additions to documentation

## CopernicusMarine v0.2.0

CRAN release: 2024-01-08

* Added functions for new services (subset, STAC and WMTS)
* Added warnings to functions interacting with deprecated Copernicus Marine services.
* Added login function
* Switched from `httr` to `httr2` dependency
* Switch from `magrittr`’s pipe to R’s native pipe operator

## CopernicusMarine v0.1.1

CRAN release: 2023-11-09

* Fix to pass CRAN checks

## CopernicusMarine v0.1.0

* Fix for migrated Copernicus server

## CopernicusMarine v0.0.9

CRAN release: 2023-08-21

* Updates in order to comply with latest CRAN policies
* Bug fix in log-in routine

## CopernicusMarine v0.0.6

CRAN release: 2023-01-30

* Fix in tests in order to comply with CRAN policy
* Catch and handle errors and warnings when connecting with internet resources and return gracefully
* Update documentation on GDAL utils dependency in WMS functions

## CopernicusMarine v0.0.3

CRAN release: 2023-01-18

* Initial implementation features data imports via:
  + MOTU service
  + File Transfer Protocol (FTP)
  + Web Map Service (WMS)

## On this page

Developed by Pepijn de Vries.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.