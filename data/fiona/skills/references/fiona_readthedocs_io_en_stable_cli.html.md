[Fiona](index.html)

stable

* [Project Information](README.html)
* [Installation](install.html)
* [User Manual](manual.html)
* [API Documentation](modules.html)
* CLI Documentation
  + [bounds](#bounds)
  + [calc](#calc)
  + [cat](#cat)
  + [collect](#collect)
  + [distrib](#distrib)
  + [dump](#dump)
  + [info](#info)
  + [load](#load)
  + [filter](#filter)
  + [map](#map)
  + [reduce](#reduce)
  + [rm](#rm)
  + [Expressions and functions](#expressions-and-functions)
  + [Builtin Python functions](#builtin-python-functions)
  + [Itertools functions](#itertools-functions)
  + [Shapely functions](#shapely-functions)
  + [Functions specific to fiona](#functions-specific-to-fiona)
  + [Feature and geometry context for expressions](#feature-and-geometry-context-for-expressions)
  + [Coordinate Reference System Transformations](#coordinate-reference-system-transformations)
  + [Sizing up and simplifying shapes](#sizing-up-and-simplifying-shapes)
    - [Counting vertices in a feature collection](#counting-vertices-in-a-feature-collection)
    - [Counting vertices after making a simplified buffer](#counting-vertices-after-making-a-simplified-buffer)
    - [Counting vertices after dissolving convex hulls of features](#counting-vertices-after-dissolving-convex-hulls-of-features)
    - [Counting vertices after dissolving concave hulls of features](#counting-vertices-after-dissolving-concave-hulls-of-features)

[Fiona](index.html)

* Command Line Interface
* [Edit on GitHub](https://github.com/Toblerity/Fiona/blob/f285ccb45a3769b28aff0282b84475b93a153cf7/docs/cli.rst)

---

# Command Line Interface[](#command-line-interface "Link to this heading")

Fiona’s new command line interface is a program named “fio”.

```
Usage: fio [OPTIONS] COMMAND [ARGS]...

  Fiona command line interface.

Options:
  -v, --verbose           Increase verbosity.
  -q, --quiet             Decrease verbosity.
  --aws-profile TEXT      Select a profile from the AWS credentials file
  --aws-no-sign-requests  Make requests anonymously
  --aws-requester-pays    Requester pays data transfer costs
  --version               Show the version and exit.
  --gdal-version          Show the version and exit.
  --python-version        Show the version and exit.
  --help                  Show this message and exit.

Commands:
  bounds   Print the extent of GeoJSON objects
  calc     Calculate GeoJSON property by Python expression
  cat      Concatenate and print the features of datasets
  collect  Collect a sequence of features.
  distrib  Distribute features from a collection.
  dump     Dump a dataset to GeoJSON.
  env      Print information about the fio environment.
  filter   Evaluate pipeline expressions to filter GeoJSON features.
  info     Print information about a dataset.
  insp     Open a dataset and start an interpreter.
  load     Load GeoJSON to a dataset in another format.
  ls       List layers in a datasource.
  map      Map a pipeline expression over GeoJSON features.
  reduce   Reduce a stream of GeoJSON features to one value.
  rm       Remove a datasource or an individual layer.
```

It is developed using the `click` package.

## bounds[](#bounds "Link to this heading")

The bounds command reads LF or RS-delimited GeoJSON texts, either features or
collections, from stdin and prints their bounds with or without other data to
stdout.

With no options, it works like this:

```
$ fio cat docs/data/test_uk.shp | head -n 1 \
> | fio bounds
[0.735, 51.357216, 0.947778, 51.444717]
```

Using `--with-id` gives you

```
$ fio cat docs/data/test_uk.shp | head -n 1 \
> | fio bounds --with-id
{"id": "0", "bbox": [0.735, 51.357216, 0.947778, 51.444717]}
```

## calc[](#calc "Link to this heading")

The calc command creates a new property on GeoJSON features using the
specified expression.

The expression is evaluated in a restricted namespace containing 4 functions
(sum, pow, min, max), the math module, the shapely shape function,
type conversions (bool, int, str, len, float), and an object f
representing the feature to be evaluated. This f object allows access in
javascript-style dot notation for convenience.

The expression will be evaluated for each feature and its return value will be
added to the properties as the specified property\_name. Existing properties
will not be overwritten by default (an Exception is raised).

```
$ fio cat data.shp | fio calc sumAB  "f.properties.A + f.properties.B"
```

Note

`fio calc` requires installation of the “calc” set of extra requirements
that will be installed by `pip install fiona[calc]`.

## cat[](#cat "Link to this heading")

The cat command concatenates the features of one or more datasets and prints
them as a [JSON text sequence](https://datatracker.ietf.org/doc/html/rfc7464) of features.
In other words: GeoJSON feature objects, possibly pretty printed, optionally
separated by ASCII RS (x1e) chars using –rs.

The output of `fio cat` can be piped to `fio load` to create new
concatenated datasets.

```
$ fio cat docs/data/test_uk.shp docs/data/test_uk.shp \
> | fio load /tmp/double.shp --driver Shapefile
$ fio info /tmp/double.shp --count
96
$ fio info docs/data/test_uk.shp --count
48
```

The cat command provides optional methods to filter data, which are
different to the `fio filter` tool.
A bounding box `--bbox w,s,e,n` tests for a spatial intersection with
the geometries. An attribute filter `--where TEXT` can use
an [SQL WHERE clause](https://gdal.org/user/ogr_sql_dialect.html#where).
If more than one datasets is passed to `fio cat`, the attributes used
in the WHERE clause must be valid for each dataset.

## collect[](#collect "Link to this heading")

The collect command takes a JSON text sequence of GeoJSON feature objects, such
as the output of `fio cat` and writes a GeoJSON feature collection.

```
$ fio cat docs/data/test_uk.shp docs/data/test_uk.shp \
> | fio collect > /tmp/collected.json
$ fio info /tmp/collected.json --count
96
```

## distrib[](#distrib "Link to this heading")

The inverse of fio-collect, fio-distrib takes a GeoJSON feature collection
and writes a JSON text sequence of GeoJSON feature objects.

```
$ fio info --count tests/data/coutwildrnp.shp
67
$ fio cat tests/data/coutwildrnp.shp | fio collect | fio distrib | wc -l
67
```

## dump[](#dump "Link to this heading")

The dump command reads a vector dataset and writes a GeoJSON feature collection
to stdout. Its output can be piped to `fio load` (see below).

```
$ fio dump docs/data/test_uk.shp --indent 2 --precision 2 | head
{
  "features": [
    {
      "geometry": {
        "coordinates": [
          [
            [
              0.9,
              51.36
            ],
```

You can optionally dump out JSON text sequences using `--x-json-seq`. Since
version 1.4.0, `fio cat` is the better tool for generating sequences.

```
$ fio dump docs/data/test_uk.shp --precision 2 --x-json-seq | head -n 2
{"geometry": {"coordinates": [[[0.9, 51.36], [0.89, 51.36], [0.79, 51.37], [0.78, 51.37], [0.77, 51.38], [0.76, 51.38], [0.75, 51.39], [0.74, 51.4], [0.73, 51.41], [0.74, 51.43], [0.75, 51.44], [0.76, 51.44], [0.79, 51.44], [0.89, 51.42], [0.9, 51.42], [0.91, 51.42], [0.93, 51.4], [0.94, 51.39], [0.94, 51.38], [0.95, 51.38], [0.95, 51.37], [0.95, 51.37], [0.94, 51.37], [0.9, 51.36], [0.9, 51.36]]], "type": "Polygon"}, "id": "0", "properties": {"AREA": 244820.0, "CAT": 232.0, "CNTRY_NAME": "United Kingdom", "FIPS_CNTRY": "UK", "POP_CNTRY": 60270708.0}, "type": "Feature"}
{"geometry": {"coordinates": [[[-4.66, 51.16], [-4.67, 51.16], [-4.67, 51.16], [-4.67, 51.17], [-4.67, 51.19], [-4.67, 51.19], [-4.67, 51.2], [-4.66, 51.2], [-4.66, 51.19], [-4.65, 51.16], [-4.65, 51.16], [-4.65, 51.16], [-4.66, 51.16]]], "type": "Polygon"}, "id": "1", "properties": {"AREA": 244820.0, "CAT": 232.0, "CNTRY_NAME": "United Kingdom", "FIPS_CNTRY": "UK", "POP_CNTRY": 60270708.0}, "type": "Feature"}
```

## info[](#info "Link to this heading")

The info command prints information about a dataset as a JSON object.

```
$ fio info docs/data/test_uk.shp --indent 2
{
  "count": 48,
  "crs": "+datum=WGS84 +no_defs +proj=longlat",
  "driver": "ESRI Shapefile",
  "bounds": [
    -8.621389,
    49.911659,
    1.749444,
    60.844444
  ],
  "schema": {
    "geometry": "Polygon",
    "properties": {
      "CAT": "float:16",
      "FIPS_CNTRY": "str:80",
      "CNTRY_NAME": "str:80",
      "AREA": "float:15.2",
      "POP_CNTRY": "float:15.2"
    }
  }
}
```

You can process this JSON using, e.g.,
[underscore-cli](https://github.com/ddopson/underscore-cli).

```
$ fio info docs/data/test_uk.shp | underscore extract count
48
```

You can also optionally get single info items as plain text (not JSON)
strings

```
$ fio info docs/data/test_uk.shp --count
48
$ fio info docs/data/test_uk.shp --bounds
-8.621389 49.911659 1.749444 60.844444
```

## load[](#load "Link to this heading")

The load command reads GeoJSON features from stdin and writes them to a vector
dataset using another format.

```
$ fio dump docs/data/test_uk.shp \
> | fio load /tmp/test.shp --driver Shapefile
```

This command also supports GeoJSON text sequences. RS-separated sequences will
be detected. If you want to load LF-separated sequences, you must specify
`--x-json-seq`.

```
$ fio cat docs/data/test_uk.shp | fio load /tmp/foo.shp --driver Shapefile
$ fio info /tmp/foo.shp --indent 2
{
  "count": 48,
  "crs": "+datum=WGS84 +no_defs +proj=longlat",
  "driver": "ESRI Shapefile",
  "bounds": [
    -8.621389,
    49.911659,
    1.749444,
    60.844444
  ],
  "schema": {
    "geometry": "Polygon",
    "properties": {
      "AREA": "float:24.15",
      "CNTRY_NAME": "str:80",
      "POP_CNTRY": "float:24.15",
      "FIPS_CNTRY": "str:80",
      "CAT": "float:24.15"
    }
  }
}
```

The underscore-cli process command is another way of turning a GeoJSON feature
collection into a feature sequence.

```
$ fio dump docs/data/test_uk.shp \
> | underscore process \
> 'each(data.features,function(o){console.log(JSON.stringify(o))})' \
> | fio load /tmp/test-seq.shp --x-json-seq --driver Shapefile
```

## filter[](#filter "Link to this heading")

For each feature read from stdin, filter evaluates a pipeline of one or
more steps described using methods from the Shapely library in Lisp-like
expressions. If the pipeline expression evaluates to True, the feature passes
through the filter. Otherwise the feature does not pass.

For example, this pipeline expression

```
$ fio cat zip+https://s3.amazonaws.com/fiona-testing/coutwildrnp.zip \
| fio filter '< (distance g (Point -109.0 38.5)) 100'
```

lets through all features that are less than 100 meters from the given point
and filters out all other features.

*New in version 1.10*: these parenthesized list expressions.

The older style Python expressions like

```
'f.properties.area > 1000.0'
```

are deprecated and will not be supported in version 2.0.

Note this tool is different from `fio cat --where TEXT ...`, which provides
SQL WHERE clause filtering of feature attributes.

Note

`fio filter` requires installation of the “calc” set of extra requirements
that will be installed by `pip install fiona[calc]`.

## map[](#map "Link to this heading")

For each feature read from stdin, `fio map` applies a transformation pipeline and
writes a copy of the feature, containing the modified geometry, to stdout. For
example, polygonal features can be roughly “cleaned” by using a `buffer g 0`
pipeline.

```
$ fio cat zip+https://s3.amazonaws.com/fiona-testing/coutwildrnp.zip \
| fio map 'buffer g 0'
```

*New in version 1.10*.

Note

`fio map` requires installation of the “calc” set of extra requirements
that will be installed by `pip install fiona[calc]`.

## reduce[](#reduce "Link to this heading")

Given a sequence of GeoJSON features (RS-delimited or not) on stdin this prints
a single value using a provided transformation pipeline. The set of geometries
of the input features in the context of these expressions is named `c`.

For example, the pipeline expression

```
$ fio cat zip+https://s3.amazonaws.com/fiona-testing/coutwildrnp.zip \
| fio reduce 'unary_union c'
```

dissolves the geometries of input features.

*New in version 1.10*.

Note

`fio reduce` requires installation of the “calc” set of extra requirements
that will be installed by `pip install fiona[calc]`.

## rm[](#rm "Link to this heading")

The rm command deletes an entire datasource or a single layer in a multi-layer
datasource. If the datasource is composed of multiple files (e.g. an ESRI
Shapefile) all of the files will be removed.

```
$ fio rm countries.shp
$ fio rm --layer forests land_cover.gpkg
```

## Expressions and functions[](#expressions-and-functions "Link to this heading")

`fio filter`, `fio map`, and `fio reduce` expressions take the form of
parenthesized lists that may contain other expressions. The first item in a
list is the name of a function or method, or an expression that evaluates to a
function. The second item is the function’s first argument or the object to
which the method is bound. The remaining list items are the positional and
keyword arguments for the named function or method. The list of functions and
callables available in an expression includes:

* Python operators such as `+`, `/`, and `<=`
* Python builtins such as `dict`, `list`, and `map`
* All public functions from itertools, e.g. `islice`, and `repeat`
* All functions importable from Shapely 2.0, e.g. `Point`, and `unary_union`
* All methods of Shapely geometry classes
* Functions specific to Fiona

Expressions are evaluated by `fiona.features.snuggs.eval()`. Let’s look at
some examples using that function.

Note

The outer parentheses are not optional within `snuggs.eval()`.

Note

`snuggs.eval()` does not use Python’s builtin `eval()` but isn’t intended
to be a secure computing environment. Expressions which access the
computer’s filesystem and create new processes are possible.

## Builtin Python functions[](#builtin-python-functions "Link to this heading")

`bool()`

```
>>> snuggs.eval('(bool 0)')
False
```

`range()`

```
>>> snuggs.eval('(range 1 4)')
range(1, 4)
```

`list()`

```
>>> snuggs.eval('(list (range 1 4))')
[1, 2, 3]
```

Values can be bound to names for use in expressions.

```
>>> snuggs.eval('(list (range start stop))', start=0, stop=5)
[0, 1, 2, 3, 4]
```

## Itertools functions[](#itertools-functions "Link to this heading")

Here’s an example of using `itertools.repeat()`.

```
>>> snuggs.eval('(list (repeat "*" times))', times=6)
['*', '*', '*', '*', '*', '*']
```

## Shapely functions[](#shapely-functions "Link to this heading")

Here’s an expression that evaluates to a Shapely Point instance.

```
>>> snuggs.eval('(Point 0 0)')
<POINT (0 0)>
```

The expression below evaluates to a MultiPoint instance.

```
>>> snuggs.eval('(union (Point 0 0) (Point 1 1))')
<MULTIPOINT (0 0, 1 1)>
```

## Functions specific to fiona[](#functions-specific-to-fiona "Link to this heading")

The fio 