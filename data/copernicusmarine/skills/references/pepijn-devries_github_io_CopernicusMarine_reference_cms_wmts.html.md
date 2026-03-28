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

# Obtain a WMTS entry for specific Copernicus marine products and add to a leaflet map

Source: [`R/cms_wmts.r`](https://github.com/pepijn-devries/CopernicusMarine/blob/master/R/cms_wmts.r)

`cms_wmts.Rd`

[![[Stable]](figures/lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) Functions for retrieving Web Map Tile Services information for
specific products, layers and variables and add them to a `leaflet` map.

## Usage

```
cms_wmts_details(product, layer, variable)

addCmsWMTSTiles(
  map,
  product,
  layer,
  variable,
  tilematrixset = "EPSG:3857",
  options = leaflet::WMSTileOptions(format = "image/png", transparent = TRUE),
  ...
)

cms_wmts_get_capabilities(product, layer, variable, type = c("list", "xml"))
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

map
:   A map widget object created from `[leaflet::leaflet()](https://rstudio.github.io/leaflet/reference/leaflet.html)`

tilematrixset
:   A `character` string representing the tilematrixset to be used. In
    many cases `"EPSG:3857"` (Pseudo-Mercator) or `"EPSG:4326"` (World Geodetic System 1984)
    are available, but should be checked with `cms_wmts_details`.

options
:   Passed on to `[leaflet::addWMSTiles()](https://rstudio.github.io/leaflet/reference/map-layers.html)`.

...
:   Passed on to `[leaflet::addWMSTiles()](https://rstudio.github.io/leaflet/reference/map-layers.html)`.

type
:   A `character` string indicating whether the capabilities should be returned
    as `"list"` (default) or `"xml"` (`[xml2::xml_new_document()](http://xml2.r-lib.org/reference/xml_new_document.html)`).

## Value

`cms_wmts_details` returns a tibble with detains on the WMTS service.
`cms_wmts_getcapabilities` returns either a `list` or `xml_document` depending on the value
of `type`. `AddCmsWMTSTiles` returns a `leaflet` `map` updated with the requested tiles.

## Author

Pepijn de Vries

## Examples

```
if (interactive()) {
  wmts_details <-
    cms_wmts_details(
      product  = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
      layer    = "cmems_mod_glo_phy-thetao_anfc_0.083deg_P1D-m",
      variable = "thetao"
    )

  capabilities <-
    cms_wmts_get_capabilities("GLOBAL_ANALYSISFORECAST_PHY_001_024")

  if (nrow(wmts_details) > 0) {
    leaflet::leaflet() |>
      leaflet::setView(lng = 3, lat = 54, zoom = 4) |>
      leaflet::addProviderTiles("Esri.WorldImagery") |>
      addCmsWMTSTiles(
        product  = "GLOBAL_ANALYSISFORECAST_PHY_001_024",
        layer    = "cmems_mod_glo_phy-thetao_anfc_0.083deg_P1D-m",
        variable = "thetao")
  }
}
```

## On this page

Developed by Pepijn de Vries.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.