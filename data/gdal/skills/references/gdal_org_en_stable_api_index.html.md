[![Logo](../_static/gdalicon.png)](../index.html)

* [Download](../download.html)
* [Programs](../programs/index.html)
* [Raster drivers](../drivers/raster/index.html)
* [Vector drivers](../drivers/vector/index.html)
* [User](../user/index.html)
* API
  + [Full Doxygen output](#id2)
  + [C API](#c-api)
  + [C++ API](#id3)
  + [Python API](#python-api)
  + [Java API](#id4)
  + [GDAL/OGR In Other Languages](#gdal-ogr-in-other-languages)
* [Tutorials](../tutorials/index.html)
* [Development](../development/index.html)
* [Community](../community/index.html)
* [Sponsors](../sponsors/index.html)
* [How to contribute?](../contributing/index.html)
* [FAQ](../faq.html)
* [Glossary](../glossary.html)
* [License](../license.html)
* [Thanks](../thanks.html)

[GDAL](../index.html)

* [GDAL documentation](../index.html)  »
* API
* [Edit on GitHub](https://github.com/OSGeo/gdal/edit/master/doc/source/api/index.rst)

[Next](cpl.html "Common Portability Library C API")
 [Previous](../user/security.html "Security considerations")

---

# API[](#api "Link to this heading")

## [Full Doxygen output](../doxygen/index.html)[](#id2 "Link to this heading")

## C API[](#c-api "Link to this heading")

* [Common Portability Library C API](cpl.html)
* [gdal\_fwd.h: Forward definitions of GDAL/OGR/OSR C handle types.](gdal_fwd.html)
* [gdal.h: Raster C API](raster_c_api.html)
* [ogr\_core.h and ogr\_api.h: Vector C API](vector_c_api.html)
* [gdal\_alg.h: GDAL Algorithms C API](gdal_alg.html)
* [gdalalgorithm.h: GDALAlgorithm (CLI) C API](cli_algorithm_c.html)
* [ogr\_srs\_api.h: Spatial Reference System C API](ogr_srs_api.html)
* [gdal\_utils.h: GDAL Algorithms C API](gdal_utils.html)

## C++ API[](#id3 "Link to this heading")

### Raster API[](#raster-api "Link to this heading")

* [Entry point for C++ Raster API](gdal_raster_cpp.html)
* [GDALMajorObject C++ API](gdalmajorobject_cpp.html)
* [GDALDriver C++ API](gdaldriver_cpp.html)
* [GDALDataset C++ API](gdaldataset_cpp.html)
* [GDALRasterBand C++ API](gdalrasterband_cpp.html)
* [GDALColorTable C++ API](gdalcolortable_cpp.html)
* [GDALRasterAttributeTable C++ API](gdalrasterattributetable_cpp.html)
* [Warper C++ API](gdalwarp_cpp.html)

### Vector API[](#vector-api "Link to this heading")

* [Entry point for C++ Vector API](gdal_vector_cpp.html)
* [OGRFeature C++ API](ogrfeature_cpp.html)
* [OGRFeature Style C++ API](ogrfeaturestyle_cpp.html)
* [OGRGeometry C++ API](ogrgeometry_cpp.html)
* [OGRGeomCoordinatePrecision C++ API](ogrgeomcoordinateprecision_cpp.html)
* [OGRLayer C++ API](ogrlayer_cpp.html)

### Spatial reference system API[](#spatial-reference-system-api "Link to this heading")

* [Spatial Reference System C++ API](ogrspatialref.html)

### Multi-dimensional array API[](#multi-dimensional-array-api "Link to this heading")

* [Entry point for C++ Multi-dimensional Array API](gdal_multidim_cpp.html)
* [GDALGroup C++ API](gdalgroup_cpp.html)
* [GDALDimension C++ API](gdaldimension_cpp.html)
* [GDALAbstractMDArray C++ API](gdalabstractmdarray_cpp.html)
* [GDALMDArray C++ API](gdalmdarray_cpp.html)
* [GDALAttribute C++ API](gdalattribute_cpp.html)
* [GDALExtendedDataType C++ API](gdalextendeddatatype_cpp.html)

### Miscellaneous C++ API[](#miscellaneous-c-api "Link to this heading")

* [GDALAlgorithm C++ API](cli_algorithm_cpp.html)
* [Common Portability Library C++ API](cpl_cpp.html)
* [Geographic Network C++ API](gnm_cpp.html)

## Python API[](#python-api "Link to this heading")

* [Python API](python/index.html)
  + [General information](python/python_bindings.html)
  + [Examples](python/python_examples.html)
  + [Submodules](python/osgeo.html)
  + [Raster API](python/raster_api.html)
  + [Vector API](python/vector_api.html)
  + [Spatial Reference System API](python/spatial_ref_api.html)
  + [Multi-dimensional array API](python/mdim_api.html)
  + [Utilities / Algorithms API](python/utilities.html)
  + [General API](python/general.html)
  + [Gotchas in the GDAL and OGR Python Bindings](python/python_gotchas.html)
  + [Sample scripts](python/python_samples.html)

## [Java API](../java/index.html)[](#id4 "Link to this heading")

## GDAL/OGR In Other Languages[](#gdal-ogr-in-other-languages "Link to this heading")

There is a set of generic [SWIG](http://www.swig.org/) interface files in the GDAL source tree (subdirectory swig) and a set of language bindings based on those. Currently active ones are:

* [C# bindings](csharp/index.html)
* [Java bindings](java/index.html)

There are also other bindings that are developed outside of the GDAL source tree (**note**: those offer APIs not strictly coupled to the GDAL/OGR C/C++ API). These include bindings for

> > * [Go](https://github.com/lukeroth/gdal)
> > * [Julia](https://github.com/JuliaGeo/GDAL.jl)
> > * [Original Node.js bindings](https://github.com/naturalatlas/node-gdal)
> > * [Node.js fork with full Promise-based async and TypeScript support](https://www.npmjs.com/package/gdal-async)
> > * [Perl](https://metacpan.org/release/Geo-GDAL-FFI)
> > * [PHP](http://dl.maptools.org/dl/php_ogr/php_ogr_documentation.html)
> > * [R](https://cran.r-project.org/web/packages/gdalraster/index.html)
> > * [Ruby](https://github.com/telus-agcg/ffi-gdal)
> > * [Rust](https://github.com/georust/gdal)
>
> There are also more Pythonic ways of using the vector/OGR functions with
>
> > * [Fiona](https://github.com/Toblerity/Fiona)
> > * [Rasterio](https://github.com/mapbox/rasterio)
>
> There is a more idiomatic Golang way of using the raster functions with
>
> > * [Godal](https://github.com/airbusgeo/godal)

[Next](cpl.html "Common Portability Library C API")
 [Previous](../user/security.html "Security considerations")

---

© 1998-2026 [Frank Warmerdam](https://github.com/warmerdam),
[Even Rouault](https://github.com/rouault), and
[others](https://github.com/OSGeo/gdal/graphs/contributors)