[Fiona](index.html)

stable

* [Project Information](README.html)
* [Installation](install.html)
* User Manual
  + [1.1 Introduction](#introduction)
    - [1.1.1 Rules of Thumb](#rules-of-thumb)
    - [1.1.2 Example](#example)
  + [1.2 Data Model](#data-model)
  + [1.3 Reading Vector Data](#reading-vector-data)
    - [1.3.1 Collection indexing](#collection-indexing)
    - [1.3.2 Closing Files](#closing-files)
  + [1.4 Format Drivers, CRS, Bounds, and Schema](#format-drivers-crs-bounds-and-schema)
    - [1.4.1 Keeping Schemas Simple](#keeping-schemas-simple)
    - [1.4.2 Field Types](#field-types)
    - [1.4.3 Geometry Types](#geometry-types)
  + [1.5 Features](#features)
    - [1.5.1 Feature Id](#feature-id)
    - [1.5.2 Feature Properties](#feature-properties)
    - [1.5.3 Feature Geometry](#feature-geometry)
    - [1.5.4 Point Set Theory and Simple Features](#point-set-theory-and-simple-features)
  + [1.6 Writing Vector Data](#writing-vector-data)
    - [1.6.1 Appending Data to Existing Files](#appending-data-to-existing-files)
    - [1.6.2 Creating files of the same structure](#creating-files-of-the-same-structure)
    - [1.6.3 Writing new files from scratch](#writing-new-files-from-scratch)
      * [1.6.3.1 Ordering Record Fields](#ordering-record-fields)
    - [1.6.4 3D Coordinates and Geometry Types](#d-coordinates-and-geometry-types)
  + [1.7 Advanced Topics](#advanced-topics)
    - [1.7.1 OGR configuration options](#ogr-configuration-options)
    - [1.7.2 Driver configuration options](#driver-configuration-options)
    - [1.7.3 Cloud storage credentials](#cloud-storage-credentials)
    - [1.7.4 Slicing and masking iterators](#slicing-and-masking-iterators)
    - [1.7.5 Reading Multilayer data](#reading-multilayer-data)
    - [1.7.6 Writing Multilayer data](#writing-multilayer-data)
    - [1.7.7 Unsupported drivers](#unsupported-drivers)
    - [1.7.8 MemoryFile and ZipMemoryFile](#memoryfile-and-zipmemoryfile)
  + [1.8 Fiona command line interface](#fiona-command-line-interface)
  + [1.9 Final Notes](#final-notes)
  + [1.10 References](#references)
* [API Documentation](modules.html)
* [CLI Documentation](cli.html)

[Fiona](index.html)

* 1 The Fiona User Manual
* [Edit on GitHub](https://github.com/Toblerity/Fiona/blob/f285ccb45a3769b28aff0282b84475b93a153cf7/docs/manual.rst)

---

# 1 The Fiona User Manual[](#the-fiona-user-manual "Link to this heading")

Author:
:   Sean Gillies, <sean.gillies@gmail.com>

Version:

Date:
:   Sep 16, 2024

Copyright:
:   This work, with the exception of code examples, is licensed under a [Creative
    Commons Attribution 3.0 United States License](https://creativecommons.org/licenses/by/3.0/us/). The code examples are
    licensed under the BSD 3-clause license (see LICENSE.txt in the repository
    root).

Abstract:
:   Fiona is OGR’s neat, nimble, no-nonsense API. This document explains how to
    use the Fiona package for reading and writing geospatial data files. Python
    3 is used in examples. See the [README](README.html) for installation and
    quick start instructions.

## 1.1 Introduction[](#introduction "Link to this heading")

*Geographic information systems* (GIS) help us plan, react to, and
understand changes in our physical, political, economic, and cultural
landscapes. A generation ago, GIS was something done only by major institutions
like nations and cities, but it’s become ubiquitous today thanks to accurate
and inexpensive global positioning systems, commoditization of satellite
imagery, and open source software.

The kinds of data in GIS are roughly divided into *rasters* representing
continuous scalar fields (land surface temperature or elevation, for example)
and *vectors* representing discrete entities like roads and administrative
boundaries. Fiona is concerned exclusively with the latter. It is a Python
wrapper for vector data access functions from the [GDAL/OGR](https://gdal.org) library. A very simple wrapper for minimalists.
It reads data records from files as GeoJSON-like mappings and writes the same
kind of mappings as records back to files. That’s it. There are no layers, no
cursors, no geometric operations, no transformations between coordinate
systems, no remote method calls; all these concerns are left to other Python
packages such as `Shapely` and
`pyproj` and Python language
protocols. Why? To eliminate unnecessary complication. Fiona aims to be simple
to understand and use, with no gotchas.

Please understand this: Fiona is designed to excel in a certain range of tasks
and is less optimal in others. Fiona trades memory and speed for simplicity and
reliability. Where OGR’s Python bindings (for example) use C pointers, Fiona
copies vector data from the data source to Python objects. These are simpler
and safer to use, but more memory intensive. Fiona’s performance is relatively
more slow if you only need access to a single record field – and of course if
you just want to reproject or filter data files, nothing beats the
**ogr2ogr** program – but Fiona’s performance is much better than OGR’s
Python bindings if you want *all* fields and coordinates of a record. The
copying is a constraint, but it simplifies programs. With Fiona, you don’t have
to track references to C objects to avoid crashes, and you can work with vector
data using familiar Python mapping accessors. Less worry, less time spent
reading API documentation.

### 1.1.1 Rules of Thumb[](#rules-of-thumb "Link to this heading")

In what cases would you benefit from using Fiona?

* If the features of interest are from or destined for a file in a non-text
  format like ESRI Shapefiles, Mapinfo TAB files, etc.
* If you’re more interested in the values of many feature properties than in
  a single property’s value.
* If you’re more interested in all the coordinate values of a feature’s
  geometry than in a single value.
* If your processing system is distributed or not contained to a single
  process.

In what cases would you not benefit from using Fiona?

* If your data is in or destined for a JSON document you should use Python’s
  `json` or `simplejson` modules.
* If your data is in a RDBMS like PostGIS, use a Python DB package or ORM like
  `SQLAlchemy` or `GeoAlchemy`. Maybe you’re using
  `GeoDjango` already. If so, carry on.
* If your data is served via HTTP from CouchDB or CartoDB, etc, use an HTTP
  package (`httplib2`, `Requests`, etc) or the provider’s
  Python API.
* If you can use **ogr2ogr**, do so.

### 1.1.2 Example[](#example "Link to this heading")

The first example of using Fiona is this: copying features (another word for
record) from one file to another, adding two attributes and making sure that
all polygons are facing “up”. Orientation of polygons is significant in some
applications, extruded polygons in Google Earth for one. No other library (like
`Shapely`) is needed here, which keeps it uncomplicated. There’s a
`coutwildrnp.zip` file in the Fiona repository for use in this and other
examples.

```
import datetime

import fiona
from fiona import Geometry, Feature, Properties

def signed_area(coords):
    """Return the signed area enclosed by a ring using the linear time
    algorithm at http://www.cgafaq.info/wiki/Polygon_Area. A value >= 0
    indicates a counter-clockwise oriented ring.
    """
    xs, ys = map(list, zip(*coords))
    xs.append(xs[1])
    ys.append(ys[1])
    return sum(xs[i] * (ys[i + 1] - ys[i - 1]) for i in range(1, len(coords))) / 2.0

with fiona.open(
    "zip+https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip"
) as src:

    # Copy the source schema and add two new properties.
    dst_schema = src.schema
    dst_schema["properties"]["signed_area"] = "float"
    dst_schema["properties"]["timestamp"] = "datetime"

    # Create a sink for processed features with the same format and
    # coordinate reference system as the source.
    with fiona.open(
        "example.gpkg",
        mode="w",
        layer="oriented-ccw",
        crs=src.crs,
        driver="GPKG",
        schema=dst_schema,
    ) as dst:
        for feat in src:
            # If any feature's polygon is facing "down" (has rings
            # wound clockwise), its rings will be reordered to flip
            # it "up".
            geom = feat.geometry
            assert geom.type == "Polygon"
            rings = geom.coordinates
            sa = sum(signed_area(ring) for ring in rings)

            if sa < 0.0:
                rings = [r[::-1] for r in rings]
                geom = Geometry(type=geom.type, coordinates=rings)

            # Add the signed area of the polygon and a timestamp
            # to the feature properties map.
            props = Properties.from_dict(
                **feat.properties,
                signed_area=sa,
                timestamp=datetime.datetime.now().isoformat()
            )

            dst.write(Feature(geometry=geom, properties=props))
```

## 1.2 Data Model[](#data-model "Link to this heading")

Discrete geographic features are usually represented in geographic information
systems by *records*. The characteristics of records and their semantic
implications are well known [[Kent1978]](#kent1978). Among those most significant for
geographic data: records have a single type, all records of that type have the
same fields, and a record’s fields concern a single geographic feature.
Different systems model records in different ways, but the various models have
enough in common that programmers have been able to create useful abstract data
models. The [OGR model](https://gdal.org/user/vector_data_model.html) is one. Its
primary entities are *Data Sources*, *Layers*, and *Features*.
Features have not fields, but attributes and a *Geometry*. An OGR Layer
contains Features of a single type (“roads” or “wells”, for example). The
GeoJSON model is a bit more simple, keeping Features and substituting
*Feature Collections* for OGR Data Sources and Layers. The term “Feature”
is thus overloaded in GIS modeling, denoting entities in both our conceptual
and data models.

Various formats for record files exist. The *ESRI Shapefile* [[ESRI1998]](#esri1998)
has been, at least in the United States, the most significant of these up to
about 2005 and remains popular today. It is a binary format. The shape fields
are stored in one .shp file and the other fields in another .dbf file. The
GeoJSON [[GeoJSON]](#geojson) format, from 2008, proposed a human readable text format in
which geometry and other attribute fields are encoded together using
*Javascript Object Notation* [[JSON]](#json). In GeoJSON, there’s a uniformity of
data access. Attributes of features are accessed in the same manner as
attributes of a feature collection. Coordinates of a geometry are accessed in
the same manner as features of a collection.

The GeoJSON format turns out to be a good model for a Python API. JSON objects
and Python dictionaries are semantically and syntactically similar. Replacing
object-oriented Layer and Feature APIs with interfaces based on Python mappings
provides a uniformity of access to data and reduces the amount of time spent
reading documentation. A Python programmer knows how to use a mapping, so why
not treat features as dictionaries? Use of existing Python idioms is one of
Fiona’s major design principles.

TL;DR

Fiona subscribes to the conventional record model of data, but provides
GeoJSON-like access to the data via Python file-like and mapping protocols.

## 1.3 Reading Vector Data[](#reading-vector-data "Link to this heading")

Reading a GIS vector file begins by opening it in mode `'r'` using Fiona’s
[`open()`](fiona.html#fiona.open "fiona.open") function. It returns an opened
[`Collection`](fiona.html#fiona.collection.Collection "fiona.collection.Collection") object.

```
>>> import fiona
>>> colxn = fiona.open("zip+https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip", "r")
>>> colxn
<open Collection '/vsizip/vsicurl/https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip:coutwildrnp', mode 'r' at 0x7f9555af8f50>
>>> collection.closed
False
```

Mode `'r'` is the default and will be omitted in following examples.

Fiona’s [`Collection`](fiona.html#fiona.collection.Collection "fiona.collection.Collection") is like a Python
`file`, but is iterable for records rather than lines.

```
>>> next(iter(colxn))
{'geometry': {'type': 'Polygon', 'coordinates': ...
>>> len(list(colxn))
67
```

Note that `list()` iterates over the entire collection, effectively
emptying it as with a Python `file`.

```
>>> next(iter(colxn))
Traceback (most recent call last):
...
StopIteration
>>> len(list(colxn))
0
```

Seeking the beginning of the file is not supported. You must reopen the
collection to get back to the beginning.

```
>>> colxn = fiona.open("zip+https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip")
>>> len(list(colxn))
67
```

File Encoding

The format drivers will attempt to detect the encoding of your data, but may
fail. In this case, the proper encoding can be specified explicitly by using
the `encoding` keyword parameter of [`fiona.open()`](fiona.html#fiona.open "fiona.open"), for example:
`encoding='Windows-1252'`.

New in version 0.9.1.

### 1.3.1 Collection indexing[](#collection-indexing "Link to this heading")

Features of a collection may also be accessed by index.

```
>>> with fiona.open("zip+https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip") as colxn:
...     print(colxn[1])
...
<fiona.model.Feature object at 0x7f954bfc5f50>
```

Note that these indices are controlled by GDAL, and do not always follow Python
conventions. They can start from 0, 1 (e.g. geopackages), or even other values,
and have no guarantee of contiguity. Negative indices will only function
correctly if indices start from 0 and are contiguous.

New in version 1.1.6

### 1.3.2 Closing Files[](#closing-files "Link to this heading")

A [`Collection`](fiona.html#fiona.collection.Collection "fiona.collection.Collection") involves external resources. There’s
no guarantee that these will be released unless you explicitly
[`close()`](fiona.html#fiona.collection.Collection.close "fiona.collection.Collection.close") the object or use
a `with` statement. When a [`Collection`](fiona.html#fiona.collection.Collection "fiona.collection.Collection")
is a context guard, it is closed no matter what happens within the block.

```
>>> try:
...     with fiona.open("zip+https://github.com/Toblerity/Fiona/files/11151652/coutwildrnp.zip") as colxn:
...         print(len(list(colxn)))
...         assert True is False
... except Exception:
...     print(colxn.closed)
...     raise
...
67
True
Traceback (most recent call last):
  ...
AssertionError
```

An exception is raised in the `with` block above, but as you can see
from the print statement in the `except` clause `colxn.__exit__()`
(and thereby `colxn.close()`) has been called.

Important

Always call [`close()`](fiona.html#fiona.collection.Collection.close "fiona.col