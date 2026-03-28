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

# Subset and download a specific marine product from Copernicus

Source: [`R/cms_download_subset.r`](https://github.com/pepijn-devries/CopernicusMarine/blob/master/R/cms_download_subset.r)

`cms_download_subset.Rd`

[![[Experimental]](figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) Subset and download a specific marine product
from Copernicus.

## Usage

```
cms_download_subset(
  product,
  layer,
  variable,
  region,
  timerange,
  verticalrange,
  progress = TRUE,
  asset,
  ...,
  username = cms_get_username(),
  password = cms_get_password()
)
```

## Arguments

product
:   An identifier (type `character`) of the desired Copernicus marine product.
    Can be obtained with `[cms_products_list](cms_products_list.html)`.

layer
:   The name of a desired layer within a product (type `character`). Can be obtained with `[cms_product_services](cms_product_services.html)` (listed as `id` column).

variable
:   The name of a desired variable in a specific layer of a product (type `character`).
    Can be obtained with `[cms_product_details](cms_product_details.html)`. When omitted, all variables are selected.

region
:   Specification of the bounding box as a `vector` of `numeric`s WGS84 lat and lon coordinates.
    Should be in the order of: xmin, ymin, xmax, ymax.
    When omitted, the entire available region is selected.

timerange
:   A `vector` with two elements (lower and upper value)
    for a requested time range. The `vector` should be coercible to `POSIXct`.
    When omitted, the full available time range is selected.

verticalrange
:   A `vector` with two elements (minimum and maximum)
    numerical values for the depth of the vertical layers (if any). Note that values below the
    sea surface needs to be specified as negative values.
    When omitted, the entire available vertical range is selected.

progress
:   A logical value. When `TRUE` (default) progress is reported to the console.
    Otherwise, this function will silently proceed.

asset
:   Type of asset to be used when subsetting data. Should be one
    of `"default"`, `"ARCO"`, `"static"`, `"omi"`, or `"downsampled4"`.
    When missing, set to `NULL` or set to `"default"`, it will use the first
    asset available for the requested product and layer, in the order as listed
    before.

...
:   Ignored (reserved for future features).

username
:   Your Copernicus marine user name. Can be provided with
    `[cms_get_username()](account.html)` (default), or as argument here.

password
:   Your Copernicus marine password. Can be provided as
    `[cms_get_password()](account.html)` (default), or as argument here.

## Value

Returns a `[stars::st_as_stars()](https://r-spatial.github.io/stars/reference/st_as_stars.html)` object.

## Author

Pepijn de Vries

## Examples

```
if (interactive()) {

  mydata <- cms_download_subset(
    product       = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
    layer         = "cmems_mod_glo_phy-cur_anfc_0.083deg_P1D-m",
    variable      = c("uo", "vo"),
    region        = c(-1, 50, 10, 55),
    timerange     = c("2025-01-01 UTC", "2025-01-02 UTC"),
    verticalrange = c(0, -2)
  )

  plot(mydata["vo"])
} else {
  message("Make sure to run this in an interactive environment")
}
#> Make sure to run this in an interactive environment
```

## On this page

Developed by Pepijn de Vries.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.