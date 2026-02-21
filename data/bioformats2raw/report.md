# bioformats2raw CWL Generation Report

## bioformats2raw

### Tool Description
Convert Bio-Formats supported formats to a Zarr-based multi-resolution pyramid.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats2raw:0.9
- **Homepage**: https://github.com/glencoesoftware/bioformats2raw
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bioformats2raw/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/glencoesoftware/bioformats2raw
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
Missing required parameter for option '--tile-height' (<tileHeight>)
Usage: <main class> [-p] [--help] [--keep-memo-files] [--no-hcs] [--[no-]
                    minmax] [--[no-]nested] [--no-ome-meta-export]
                    [--no-root-group] [--overwrite]
                    [--use-existing-resolutions] [--version] [--debug
                    [=<logLevel>]] [--extra-readers[=<extraReaders>[,
                    <extraReaders>...]]]... [--options[=<readerOptions>[,
                    <readerOptions>...]]]... [-s[=<seriesList>[,
                    <seriesList>...]]]...
                    [--additional-scale-format-string-args=<additionalScaleForma
                    tCSV>] [-c=<compression>]
                    [--dimension-order=<dimensionOrder>]
                    [--downsample-type=<downsampling>]
                    [--fill-value=<fillValue>] [-h=<tileHeight>]
                    [--max-cached-tiles=<maxCachedTiles>]
                    [--max-workers=<maxWorkers>]
                    [--memo-directory=<memoDirectory>]
                    [--pyramid-name=<pyramidName>] [-r=<resolutions>]
                    [--scale-format-string=<scaleFormat>]
                    [--target-min-size=<minImageSize>] [-w=<tileWidth>]
                    [-z=<chunkDepth>]
                    [--compression-properties=<String=Object>]...
                    [--output-options=<String=String>[\|<String=String>...]]...
                    <inputPath> <outputPath>
      <inputPath>            file to convert
      <outputPath>           path to the output pyramid directory. The given
                               path can also be a URI (containing ://) which
                               will activate **experimental** support for
                               Filesystems. For example, if the output path
                               given is 's3://my-bucket/some-path' *and* you
                               have an S3FileSystem implementation in your
                               classpath, then all files will be written to S3.
      --additional-scale-format-string-args=<additionalScaleFormatCSV>
                             Additional format string argument CSV file
                               (without header row).  Arguments will be added
                               to the end of the scale format string mapping
                               the at the corresponding CSV row index.  It is
                               expected that the CSV file contain exactly the
                               same number of rows as the input file has series
  -c, --compression=<compression>
                             Compression type for Zarr (null, zlib, blosc;
                               default: blosc)
      --compression-properties=<String=Object>
                             Properties for the chosen compression (see https:
                               //jzarr.readthedocs.io/en/latest/tutorial.
                               html#compressors )
      --debug, --log-level[=<logLevel>]
                             Change logging level; valid values are OFF, ERROR,
                               WARN, INFO, DEBUG, TRACE and ALL. (default: WARN)
      --dimension-order=<dimensionOrder>
                             Override the input file dimension order in the
                               output file [Can break compatibility with
                               raw2ometiff] (XYZCT, XYZTC, XYCTZ, XYCZT, XYTCZ,
                               XYTZC)
      --downsample-type=<downsampling>
                             Tile downsampling algorithm (SIMPLE, GAUSSIAN,
                               AREA, LINEAR, CUBIC, LANCZOS)
      --extra-readers[=<extraReaders>[,<extraReaders>...]]
                             Separate set of readers to include; (default: com.
                               glencoesoftware.bioformats2raw.PyramidTiffReader,
                               com.glencoesoftware.bioformats2raw.MiraxReader,
                               com.glencoesoftware.bioformats2raw.BioTekReader,
                               com.glencoesoftware.bioformats2raw.
                               ND2PlateReader,com.glencoesoftware.
                               bioformats2raw.MetaxpressReader,com.
                               glencoesoftware.bioformats2raw.MCDReader)
      --fill-value=<fillValue>
                             Default value to fill in for missing tiles (0-255)
                               (currently .mrxs only)
  -h, --tile-height, --tile_height=<tileHeight>
                             Maximum tile height (default: 1024). This is both
                               the chunk size (in Y) when writing Zarr and the
                               tile size used for reading from the original
                               data. Changing the tile size may have
                               performance implications.
      --help                 Print usage information and exit
      --keep-memo-files      Do not delete .bfmemo files created during
                               conversion
      --max-cached-tiles, --max_cached_tiles=<maxCachedTiles>
                             Maximum number of tiles that will be cached across
                               all workers (default: 64)
      --max-workers, --max_workers=<maxWorkers>
                             Maximum number of workers (default: 4)
      --memo-directory=<memoDirectory>
                             Directory used to store .bfmemo cache files
      --no-hcs               Turn off HCS writing
      --[no-]minmax          Whether to calculate minimum and maximum pixel
                               values. Min/max calculation can result in slower
                               conversions. If true, min/max values are saved
                               as OMERO rendering metadata (true by default)
      --[no-]nested          Whether to use '/' as the chunk path separator
                               (true by default)
      --no-ome-meta-export   Turn off OME metadata exporting [Will break
                               compatibility with raw2ometiff]
      --no-root-group        Turn off creation of root group and corresponding
                               metadata [Will break compatibility with
                               raw2ometiff]
      --options[=<readerOptions>[,<readerOptions>...]]
                             Reader-specific options, in format key=value[,
                               key2=value2]
      --output-options=<String=String>[\|<String=String>...]
                             |-separated list of key-value pairs to be used as
                               an additional argument to Filesystem
                               implementations if used. For example,
                               --output-options=s3fs_path_style_access=true|...
                               might be useful for connecting to minio.
      --overwrite            Overwrite the output directory if it exists
  -p, --progress             Print progress bars during conversion
      --pyramid-name=<pyramidName>
                             Name of pyramid (default: null) [Can break
                               compatibility with raw2ometiff]
  -r, --resolutions=<resolutions>
                             Number of pyramid resolutions to generate
  -s, --series[=<seriesList>[,<seriesList>...]]
                             Comma-separated list of series indexes to convert
      --scale-format-string=<scaleFormat>
                             Format string for scale paths; the first two
                               arguments will always be series and resolution
                               followed by any additional arguments brought in
                               from `--additional-scale-format-string-args`
                               [Can break compatibility with raw2ometiff]
                               (default: %d/%d)
      --target-min-size=<minImageSize>
                             Specifies the desired size for the largest XY
                               dimension of the smallest resolution, when
                               calculating the number of resolutions generate.
                               If the target size cannot be matched exactly,
                               the largest XY dimension of the smallest
                               resolution should be smaller than the target
                               size.
      --use-existing-resolutions
                             Use existing sub resolutions from original input
                               format[Will break compatibility with raw2ometiff]
  -w, --tile-width, --tile_width=<tileWidth>
                             Maximum tile width (default: 1024). This is both
                               the chunk size (in X) when writing Zarr and the
                               tile size used for reading from the original
                               data. Changing the tile size may have
                               performance implications.
  -z, --chunk-depth, --chunk_depth=<chunkDepth>
                             Maximum chunk depth to read (default: 1)
      --version              Print version information and exit
```


## Metadata
- **Skill**: generated
