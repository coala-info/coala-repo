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

# Get a proxy stars object from a Zarr service

Source: [`R/cms_download_subset.r`](https://github.com/pepijn-devries/CopernicusMarine/blob/master/R/cms_download_subset.r)

`cms_zarr_proxy.Rd`

[![[Experimental]](figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) The advantage of
[`stars_proxy` objects](https://r-spatial.github.io/stars/articles/stars2.html#stars-proxy-objects),
is that they do not contain any data. They are therefore fast to handle
and consume only limited memory. You can still manipulate the object
lazily (like selecting slices). These operation are only executed when
calling `[stars::st_as_stars()](https://r-spatial.github.io/stars/reference/st_as_stars.html)` or `[plot()](https://rdrr.io/r/graphics/plot.default.html)` on the object.

## Usage

```
cms_zarr_proxy(
  product,
  layer,
  variable,
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

asset
:   An asset that is available for the `product`.
    Should be one of `"native"`, `"wmts"`, `"timeChunked"`, `"downsampled4"`,
    or `"geoChunked"`.

...
:   Ignored (reserved for future features).

username
:   Your Copernicus marine user name. Can be provided with
    `[cms_get_username()](account.html)` (default), or as argument here.

password
:   Your Copernicus marine password. Can be provided as
    `[cms_get_password()](account.html)` (default), or as argument here.

## Value

A [`stars_proxy` object](https://r-spatial.github.io/stars/articles/stars2.html#stars-proxy-objects)

## Details

For more details see `[vignette("proxy")](../articles/proxy.html)`.

## Author

Pepijn de Vries

## Examples

```
if (interactive()) {
  myproxy <- cms_zarr_proxy(
    product       = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
    layer         = "cmems_mod_glo_phy-cur_anfc_0.083deg_P1D-m",
    variable      = c("uo", "vo"),
    asset         = "timeChunked")
  plot(myproxy["uo",1:200,1:100,50,1], axes = TRUE)
}
```

## On this page

Developed by Pepijn de Vries.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.