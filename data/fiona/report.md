# fiona CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fiona_fio_bounds | PASS |  |
| fiona_fio_calc | Failed | image problem: shapely cannot load libc (OSError), so fio calc crashes |
| fiona_fio_cat | PASS |  |
| fiona_fio_collect | PASS |  |
| fiona_fio_distrib | PASS |  |
| fiona_fio_dump | PASS |  |
| fiona_fio_filter | Failed | image problem: shapely cannot load libc (OSError), so fio filter crashes |
| fiona_fio_info | PASS |  |
| fiona_fio_load | PASS |  |
| fiona_fio_ls | PASS |  |
| fiona_fio_rm | PASS |  |

## fiona_fio_info

### Tool Description
Print information about a dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fio info [OPTIONS] INPUT

  Print information about a dataset.

  When working with a multi-layer dataset the first layer is used by
  default. Use the '--layer' option to select a different layer.

Options:
  --layer INDEX|NAME      Print information about a specific layer.  The first
                          layer is used by default.  Layers use zero-based
                          numbering when accessed by index.

  --indent INTEGER        Indentation level for JSON output
  --count                 Print the count of features.
  -f, --format, --driver  Print the format driver.
  --crs                   Print the CRS as a PROJ.4 string.
  --bounds                Print the boundary coordinates (left, bottom, right,
                          top).

  --name                  Print the datasource's name.
  --help                  Show this message and exit.
```


## fiona_fio_cat

### Tool Description
Concatenate and print the features of input datasets as a sequence of GeoJSON features.

When working with a multi-layer dataset the first layer is used by
default. Use the '--layer' option to select a different layer.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fio cat [OPTIONS] INPUTS...

  Concatenate and print the features of input datasets as a sequence of
  GeoJSON features.

  When working with a multi-layer dataset the first layer is used by
  default. Use the '--layer' option to select a different layer.

Options:
  --layer TEXT                    Input layer(s), specified as
                                  'fileindex:layer` For example, '1:foo,2:bar'
                                  will concatenate layer foo from file 1 and
                                  layer bar from file 2

  --precision INTEGER             Decimal precision of coordinates.
  --indent INTEGER                Indentation level for JSON output
  --compact / --not-compact       Use compact separators (',', ':').
  --ignore-errors / --no-ignore-errors
                                  log errors but do not stop serialization.
  --dst-crs, --dst_crs TEXT       Destination CRS.
  --rs / --no-rs                  Use RS (0x1E) as a prefix for individual
                                  texts in a sequence as per
                                  http://tools.ietf.org/html/draft-ietf-json-
                                  text-sequence-13 (default is False).

  --bbox w,s,e,n                  filter for features intersecting a bounding
                                  box

  --help                          Show this message and exit.
```


## fiona_fio_load

### Tool Description
Load features from JSON to a file in another format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fio load [OPTIONS] OUTPUT FEATURES...

  Load features from JSON to a file in another format.

  The input is a GeoJSON feature collection or optionally a sequence of
  GeoJSON feature objects.

Options:
  -f, --format, --driver TEXT  Output format driver name.  [required]
  --src-crs, --src_crs TEXT    Source CRS.
  --dst-crs, --dst_crs TEXT    Destination CRS.  Defaults to --src-crs when
                               not given.

  --layer INDEX|NAME           Load features into specified layer.  Layers use
                               zero-based numbering when accessed by index.

  --help                       Show this message and exit.
```


## fiona_fio_bounds

### Tool Description
Print the bounding boxes of GeoJSON objects read from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio bounds [OPTIONS]

  Print the bounding boxes of GeoJSON objects read from stdin.

  Optionally explode collections and print the bounds of their features.

  To print identifiers for input objects along with their bounds as a {id:
  identifier, bbox: bounds} JSON object, use --with-id.

  To print the input objects themselves along with their bounds as GeoJSON
  object, use --with-obj. This has the effect of updating input objects with
  {id: identifier, bbox: bounds}.

Options:
  --precision INTEGER         Decimal precision of coordinates.
  --explode / --no-explode    Explode collections into features (default: no).
  --with-id / --without-id    Print GeoJSON ids and bounding boxes together
                              (default: without).

  --with-obj / --without-obj  Print GeoJSON objects and bounding boxes
                              together (default: without).

  --rs / --no-rs              Use RS (0x1E) as a prefix for individual texts
                              in a sequence as per
                              http://tools.ietf.org/html/draft-ietf-json-text-
                              sequence-13 (default is False).

  --help                      Show this message and exit.
```


## fiona_fio_calc

### Tool Description
Create a new property on GeoJSON features using the specified expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio calc [OPTIONS] PROPERTY_NAME EXPRESSION

  Create a new property on GeoJSON features using the specified expression.

  The expression is evaluated in a restricted namespace containing:
      - sum, pow, min, max and the imported math module
      - shape (optional, imported from shapely.geometry if available)
      - bool, int, str, len, float type conversions
      - f (the feature to be evaluated,
           allows item access via javascript-style dot notation using munch)

  The expression will be evaluated for each feature and its return value
  will be added to the properties as the specified property_name. Existing
  properties will not be overwritten by default (an Exception is raised).

  Example

  $ fio cat data.shp | fio calc sumAB  "f.properties.A + f.properties.B"

Options:
  --overwrite     Overwrite properties, default: False
  --rs / --no-rs  Use RS (0x1E) as a prefix for individual texts in a sequence
                  as per http://tools.ietf.org/html/draft-ietf-json-text-
                  sequence-13 (default is False).

  --help          Show this message and exit.
```


## fiona_fio_collect

### Tool Description
Make a GeoJSON feature collection from a sequence of GeoJSON features and print it.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio collect [OPTIONS]

  Make a GeoJSON feature collection from a sequence of GeoJSON features and
  print it.

Options:
  --precision INTEGER             Decimal precision of coordinates.
  --indent INTEGER                Indentation level for JSON output
  --compact / --not-compact       Use compact separators (',', ':').
  --record-buffered / --no-record-buffered
                                  Economical buffering of writes at record,
                                  not collection (default), level.

  --ignore-errors / --no-ignore-errors
                                  log errors but do not stop serialization.
  --src-crs, --src_crs TEXT       Source CRS.
  --with-ld-context / --without-ld-context
                                  add a JSON-LD context to JSON output.
  --add-ld-context-item TEXT      map a term to a URI and add it to the
                                  output's JSON LD context.

  --parse / --no-parse            load and dump the geojson feature (default
                                  is True)

  --help                          Show this message and exit.
```


## fiona_fio_distrib

### Tool Description
Distribute features from a collection.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio distrib [OPTIONS]

  Distribute features from a collection.

  Print the features of GeoJSON objects read from stdin.

Options:
  --rs / --no-rs  Use RS (0x1E) as a prefix for individual texts in a sequence
                  as per http://tools.ietf.org/html/draft-ietf-json-text-
                  sequence-13 (default is False).

  --help          Show this message and exit.
```


## fiona_fio_dump

### Tool Description
Dump a dataset either as a GeoJSON feature collection or a sequence of GeoJSON features.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio dump [OPTIONS] INPUT

  Dump a dataset either as a GeoJSON feature collection (the default) or a
  sequence of GeoJSON features.

Options:
  --layer INDEX|NAME              Print information about a specific layer.
                                  The first layer is used by default.  Layers
                                  use zero-based numbering when accessed by
                                  index.

  --encoding TEXT                 Specify encoding of the input file.
  --precision INTEGER             Decimal precision of coordinates.
  --indent INTEGER                Indentation level for JSON output
  --compact / --not-compact       Use compact separators (',', ':').
  --record-buffered / --no-record-buffered
                                  Economical buffering of writes at record,
                                  not collection (default), level.

  --ignore-errors / --no-ignore-errors
                                  log errors but do not stop serialization.
  --with-ld-context / --without-ld-context
                                  add a JSON-LD context to JSON output.
  --add-ld-context-item TEXT      map a term to a URI and add it to the
                                  output's JSON LD context.

  --help                          Show this message and exit.
```


## fiona_fio_filter

### Tool Description
Filter GeoJSON features by python expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio filter [OPTIONS] FILTER_EXPRESSION

  Filter GeoJSON features by python expression.

  Features are read from stdin.

  The expression is evaluated in a restricted namespace containing:     -
  sum, pow, min, max and the imported math module     - shape (optional,
  imported from shapely.geometry if available)     - bool, int, str, len,
  float type conversions     - f (the feature to be evaluated,
  allows item access via javascript-style dot notation using munch)

  The expression will be evaluated for each feature and, if true, the
  feature will be included in the output.  For example:

      $ fio cat data.shp \
          | fio filter "f.properties.area > 1000.0" \
          | fio collect > large_polygons.geojson

Options:
  --rs / --no-rs  Use RS (0x1E) as a prefix for individual texts in a sequence
                  as per http://tools.ietf.org/html/draft-ietf-json-text-
                  sequence-13 (default is False).

  --help          Show this message and exit.
```


## fiona_fio_ls

### Tool Description
List layers in a datasource.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio ls [OPTIONS] INPUT

  List layers in a datasource.

Options:
  --indent INTEGER  Indentation level for JSON output
  --help            Show this message and exit.
```


## fiona_fio_rm

### Tool Description
Remove a datasource or an individual layer.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: https://anaconda.org/channels/bioconda/packages/fiona/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fio rm [OPTIONS] INPUT

  Remove a datasource or an individual layer.

Options:
  --layer TEXT  Name of layer to remove.
  --yes
  --help        Show this message and exit.
```


## Metadata
- **Skill**: generated
