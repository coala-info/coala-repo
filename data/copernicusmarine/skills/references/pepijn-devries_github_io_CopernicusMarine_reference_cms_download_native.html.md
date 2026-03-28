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

# Download raw files as provided to Copernicus Marine

Source: [`R/cms_download_native.R`](https://github.com/pepijn-devries/CopernicusMarine/blob/master/R/cms_download_native.R)

`cms_download_native.Rd`

[![[Stable]](figures/lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) Full marine data sets can be downloaded using the functions
documented here. Use `cms_list_native_files()` to list available files, and
`cms_download_native()` to download specific files. Files are usually organised per product,
layer, year, month and day.

## Usage

```
cms_download_native(
  destination,
  product,
  layer,
  pattern,
  prefix,
  progress = TRUE,
  ...,
  username = cms_get_username(),
  password = cms_get_password()
)

cms_list_native_files(product, layer, pattern, prefix, max = Inf, ...)
```

## Arguments

destination
:   Path where to store the downloaded file(s).

product
:   An identifier (type `character`) of the desired Copernicus marine product.
    Can be obtained with `[cms_products_list](cms_products_list.html)`.

layer
:   The name of a desired layer within a product (type `character`). Can be obtained with `[cms_product_services](cms_product_services.html)` (listed as `id` column).

pattern
:   A regular expression ([regex](https://en.wikipedia.org/wiki/Regular_expression))
    pattern. Only paths that match the pattern will be returned. It can be used
    to select specific files. For instance if `pattern = "2022/06/"`, only files for the
    year 2022 and the month June will be listed (assuming that the file path is structured as such, see
    examples)

prefix
:   A `character` string. A prefix to be added to the search path of the files.
    Only the matching file (info) is downloaded (generally faster then using `pattern`)

progress
:   A `logical` value. When `TRUE` a progress bar is shown.

...
:   Ignored

username
:   Your Copernicus marine user name. Can be provided with
    `[cms_get_username()](account.html)` (default), or as argument here.

password
:   Your Copernicus marine password. Can be provided as
    `[cms_get_password()](account.html)` (default), or as argument here.

max
:   A maximum number of records to be returned.

## Value

Returns `NULL` invisibly.

## Author

Pepijn de Vries

## Examples

```
if (interactive()) {
  cms_list_native_files(
    product       = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
    layer         = "cmems_mod_glo_phy_anfc_0.083deg_PT1H-m",
    prefix        = "2022/06/"
  )

## If you omit the prefix, you may want to limit the
## number of results by setting `max`
  cms_list_native_files(
    product       = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
    layer         = "cmems_mod_glo_phy_anfc_0.083deg_PT1H-m",
    max           = 10
  )

## Prefix can be omitted when not relevant:
  cms_list_native_files(product = "SEALEVEL_GLO_PHY_MDT_008_063")

## Use 'pattern' to download a file for a specific day:
  cms_download_native(
    destination   = tempdir(),
    product       = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
    layer         = "cmems_mod_glo_phy_anfc_0.083deg_PT1H-m",
    prefix        = "2022/06/",
    pattern       = "m_20220630"
  )
}
```

## On this page

Developed by Pepijn de Vries.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.