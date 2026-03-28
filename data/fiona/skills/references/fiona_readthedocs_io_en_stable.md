Fiona

stable

* [Project Information](README.html)
* [Installation](install.html)
* [User Manual](manual.html)
* [API Documentation](modules.html)
* [CLI Documentation](cli.html)

Fiona

* Fiona: access to simple geospatial feature data
* [Edit on GitHub](https://github.com/Toblerity/Fiona/blob/f285ccb45a3769b28aff0282b84475b93a153cf7/docs/index.rst)

---

# Fiona: access to simple geospatial feature data[](#fiona-access-to-simple-geospatial-feature-data "Link to this heading")

Fiona streams simple feature data to and from GIS formats like GeoPackage and
Shapefile. Simple features are record, or row-like, and have a single geometry
attribute. Fiona can read and write real-world simple feature data using
multi-layered GIS formats, zipped and in-memory virtual file systems, from
files on your hard drive or in cloud storage. This project includes Python
modules and a command line interface (CLI).

Here’s an example of streaming and filtering features from a zipped dataset on
the web and saving them to a new layer in a new Geopackage file.

```
import fiona

with fiona.open(
    "zip+https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip"
) as src:
    profile = src.profile
    profile["driver"] = "GPKG"

    with fiona.open("example.gpkg", "w", layer="selection", **profile) as dst:
        dst.writerecords(feat in src.filter(bbox=(-107.0, 37.0, -105.0, 39.0)))
```

The same result can be achieved on the command line using a combination of
fio-cat and fio-load.

```
fio cat zip+https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip --bbox "-107.0,37.0,-105.0,39.0" \
| fio load -f GPKG --layer selection example.gpkg
```

* [Project Information](README.html)
  + [Installation](README.html#installation)
  + [Python Usage](README.html#python-usage)
  + [CLI Usage](README.html#cli-usage)
  + [Documentation](README.html#documentation)
  + [Changes](README.html#changes)
  + [Credits](README.html#credits)
* [Installation](install.html)
  + [Easy installation](install.html#easy-installation)
  + [Advanced installation](install.html#advanced-installation)
* [User Manual](manual.html)
  + [1.1 Introduction](manual.html#introduction)
  + [1.2 Data Model](manual.html#data-model)
  + [1.3 Reading Vector Data](manual.html#reading-vector-data)
  + [1.4 Format Drivers, CRS, Bounds, and Schema](manual.html#format-drivers-crs-bounds-and-schema)
  + [1.5 Features](manual.html#features)
  + [1.6 Writing Vector Data](manual.html#writing-vector-data)
  + [1.7 Advanced Topics](manual.html#advanced-topics)
  + [1.8 Fiona command line interface](manual.html#fiona-command-line-interface)
  + [1.9 Final Notes](manual.html#final-notes)
  + [1.10 References](manual.html#references)
* [API Documentation](modules.html)
  + [fiona package](fiona.html)
* [CLI Documentation](cli.html)
  + [bounds](cli.html#bounds)
  + [calc](cli.html#calc)
  + [cat](cli.html#cat)
  + [collect](cli.html#collect)
  + [distrib](cli.html#distrib)
  + [dump](cli.html#dump)
  + [info](cli.html#info)
  + [load](cli.html#load)
  + [filter](cli.html#filter)
  + [map](cli.html#map)
  + [reduce](cli.html#reduce)
  + [rm](cli.html#rm)
  + [Expressions and functions](cli.html#expressions-and-functions)
  + [Builtin Python functions](cli.html#builtin-python-functions)
  + [Itertools functions](cli.html#itertools-functions)
  + [Shapely functions](cli.html#shapely-functions)
  + [Functions specific to fiona](cli.html#functions-specific-to-fiona)
  + [Feature and geometry context for expressions](cli.html#feature-and-geometry-context-for-expressions)
  + [Coordinate Reference System Transformations](cli.html#coordinate-reference-system-transformations)
  + [Sizing up and simplifying shapes](cli.html#sizing-up-and-simplifying-shapes)

## Indices and tables[](#indices-and-tables "Link to this heading")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

[Next](README.html "Fiona")

---

© Copyright 2011, Sean Gillies.
Revision `f285ccb4`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).