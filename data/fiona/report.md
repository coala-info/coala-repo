# fiona CWL Generation Report

## fiona_fio

### Tool Description
Fiona command line interface.

### Metadata
- **Docker Image**: quay.io/biocontainers/fiona:1.8.6
- **Homepage**: https://github.com/Toblerity/Fiona
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/fiona/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/Toblerity/Fiona
- **Stars**: N/A
### Original Help Text
```text
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
  filter   Filter GeoJSON features by python expression.
  info     Print information about a dataset.
  insp     Open a dataset and start an interpreter.
  load     Load GeoJSON to a dataset in another format.
  ls       List layers in a datasource.
  rm       Remove a datasource or an individual layer.
```


## fiona_fio info

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


## fiona_fio cat

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


## fiona_fio load

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


## Metadata
- **Skill**: generated
