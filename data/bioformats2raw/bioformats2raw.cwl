cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioformats2raw
label: bioformats2raw
doc: "Convert Bio-Formats supported formats to a Zarr-based multi-resolution pyramid.\n
  \nTool homepage: https://github.com/glencoesoftware/bioformats2raw"
inputs:
  - id: input_path
    type: File
    doc: file to convert
    inputBinding:
      position: 1
  - id: additional_scale_format_string_args
    type:
      - 'null'
      - File
    doc: Additional format string argument CSV file (without header row).
    inputBinding:
      position: 102
      prefix: --additional-scale-format-string-args
  - id: chunk_depth
    type:
      - 'null'
      - int
    doc: Maximum chunk depth to read
    inputBinding:
      position: 102
      prefix: --chunk-depth
  - id: compression
    type:
      - 'null'
      - string
    doc: 'Compression type for Zarr (null, zlib, blosc; default: blosc)'
    inputBinding:
      position: 102
      prefix: --compression
  - id: compression_properties
    type:
      - 'null'
      - type: array
        items: string
    doc: Properties for the chosen compression
    inputBinding:
      position: 102
      prefix: --compression-properties
  - id: dimension_order
    type:
      - 'null'
      - string
    doc: Override the input file dimension order in the output file (XYZCT, XYZTC,
      XYCTZ, XYCZT, XYTCZ, XYTZC)
    inputBinding:
      position: 102
      prefix: --dimension-order
  - id: downsample_type
    type:
      - 'null'
      - string
    doc: Tile downsampling algorithm (SIMPLE, GAUSSIAN, AREA, LINEAR, CUBIC, LANCZOS)
    inputBinding:
      position: 102
      prefix: --downsample-type
  - id: extra_readers
    type:
      - 'null'
      - type: array
        items: string
    doc: Separate set of readers to include
    inputBinding:
      position: 102
      prefix: --extra-readers
  - id: fill_value
    type:
      - 'null'
      - int
    doc: Default value to fill in for missing tiles (0-255) (currently .mrxs only)
    inputBinding:
      position: 102
      prefix: --fill-value
  - id: keep_memo_files
    type:
      - 'null'
      - boolean
    doc: Do not delete .bfmemo files created during conversion
    inputBinding:
      position: 102
      prefix: --keep-memo-files
  - id: log_level
    type:
      - 'null'
      - string
    doc: Change logging level; valid values are OFF, ERROR, WARN, INFO, DEBUG, TRACE
      and ALL.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_cached_tiles
    type:
      - 'null'
      - int
    doc: Maximum number of tiles that will be cached across all workers
    inputBinding:
      position: 102
      prefix: --max-cached-tiles
  - id: max_workers
    type:
      - 'null'
      - int
    doc: Maximum number of workers
    inputBinding:
      position: 102
      prefix: --max-workers
  - id: memo_directory
    type:
      - 'null'
      - Directory
    doc: Directory used to store .bfmemo cache files
    inputBinding:
      position: 102
      prefix: --memo-directory
  - id: minmax
    type:
      - 'null'
      - boolean
    doc: Whether to calculate minimum and maximum pixel values. Min/max calculation
      can result in slower conversions. If true, min/max values are saved as OMERO
      rendering metadata (true by default)
    inputBinding:
      position: 102
      prefix: --minmax
  - id: nested
    type:
      - 'null'
      - boolean
    doc: Whether to use '/' as the chunk path separator (true by default)
    inputBinding:
      position: 102
      prefix: --nested
  - id: no_hcs
    type:
      - 'null'
      - boolean
    doc: Turn off HCS writing
    inputBinding:
      position: 102
      prefix: --no-hcs
  - id: no_ome_meta_export
    type:
      - 'null'
      - boolean
    doc: Turn off OME metadata exporting [Will break compatibility with raw2ometiff]
    inputBinding:
      position: 102
      prefix: --no-ome-meta-export
  - id: no_root_group
    type:
      - 'null'
      - boolean
    doc: Turn off creation of root group and corresponding metadata [Will break compatibility
      with raw2ometiff]
    inputBinding:
      position: 102
      prefix: --no-root-group
  - id: output_options
    type:
      - 'null'
      - type: array
        items: string
    doc: '|-separated list of key-value pairs to be used as an additional argument
      to Filesystem implementations if used.'
    inputBinding:
      position: 102
      prefix: --output-options
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it exists
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Print progress bars during conversion
    inputBinding:
      position: 102
      prefix: --progress
  - id: pyramid_name
    type:
      - 'null'
      - string
    doc: 'Name of pyramid (default: null)'
    inputBinding:
      position: 102
      prefix: --pyramid-name
  - id: reader_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Reader-specific options, in format key=value[, key2=value2]
    inputBinding:
      position: 102
      prefix: --options
  - id: resolutions
    type:
      - 'null'
      - int
    doc: Number of pyramid resolutions to generate
    inputBinding:
      position: 102
      prefix: --resolutions
  - id: scale_format_string
    type:
      - 'null'
      - string
    doc: Format string for scale paths
    inputBinding:
      position: 102
      prefix: --scale-format-string
  - id: series
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of series indexes to convert
    inputBinding:
      position: 102
      prefix: --series
  - id: target_min_size
    type:
      - 'null'
      - int
    doc: Specifies the desired size for the largest XY dimension of the smallest resolution
    inputBinding:
      position: 102
      prefix: --target-min-size
  - id: tile_height
    type:
      - 'null'
      - int
    doc: Maximum tile height. This is both the chunk size (in Y) when writing Zarr
      and the tile size used for reading from the original data.
    inputBinding:
      position: 102
      prefix: --tile-height
  - id: tile_width
    type:
      - 'null'
      - int
    doc: Maximum tile width. This is both the chunk size (in X) when writing Zarr
      and the tile size used for reading from the original data.
    inputBinding:
      position: 102
      prefix: --tile-width
  - id: use_existing_resolutions
    type:
      - 'null'
      - boolean
    doc: Use existing sub resolutions from original input format[Will break compatibility
      with raw2ometiff]
    inputBinding:
      position: 102
      prefix: --use-existing-resolutions
outputs:
  - id: output_path
    type: Directory
    doc: path to the output pyramid directory. The given path can also be a URI (containing
      ://) which will activate **experimental** support for Filesystems.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats2raw:0.9
