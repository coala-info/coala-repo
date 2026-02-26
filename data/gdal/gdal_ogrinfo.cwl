cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdal_ogrinfo
label: gdal_ogrinfo
doc: "Prints detailed information about OGR data sources and layers.\n\nTool homepage:
  https://github.com/OSGeo/gdal"
inputs:
  - id: datasource_name
    type: string
    doc: The data source name.
    inputBinding:
      position: 1
  - id: layers
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific layers to query.
    inputBinding:
      position: 2
  - id: all
    type:
      - 'null'
      - boolean
    doc: List all layers and their contents.
    inputBinding:
      position: 103
      prefix: -al
  - id: dialect
    type:
      - 'null'
      - string
    doc: SQL dialect to use.
    inputBinding:
      position: 103
  - id: fid
    type:
      - 'null'
      - string
    doc: Filter features by FID.
    inputBinding:
      position: 103
  - id: fields
    type:
      - 'null'
      - string
    doc: Control whether to list fields (YES/NO).
    inputBinding:
      position: 103
  - id: geom
    type:
      - 'null'
      - string
    doc: Control whether to list geometry (YES/NO/SUMMARY).
    inputBinding:
      position: 103
  - id: geomfield
    type:
      - 'null'
      - string
    doc: Use the specified geometry field.
    inputBinding:
      position: 103
  - id: list_metadata
    type:
      - 'null'
      - boolean
    doc: List all metadata domains.
    inputBinding:
      position: 103
      prefix: -listmdd
  - id: metadata_domains
    type:
      - 'null'
      - type: array
        items: string
    doc: List specific metadata domains or 'all'.
    inputBinding:
      position: 103
  - id: no_count
    type:
      - 'null'
      - boolean
    doc: Do not count features.
    inputBinding:
      position: 103
      prefix: -nocount
  - id: no_extent
    type:
      - 'null'
      - boolean
    doc: Do not calculate extent.
    inputBinding:
      position: 103
      prefix: -noextent
  - id: no_metadata
    type:
      - 'null'
      - boolean
    doc: Do not list metadata.
    inputBinding:
      position: 103
      prefix: -nomd
  - id: open_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Open option NAME=VALUE.
    inputBinding:
      position: 103
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages.
    inputBinding:
      position: 103
      prefix: -q
  - id: read_only
    type:
      - 'null'
      - boolean
    doc: Open the data source in read-only mode.
    inputBinding:
      position: 103
      prefix: -ro
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively list layers in subdirectories.
    inputBinding:
      position: 103
      prefix: -rl
  - id: spat
    type:
      - 'null'
      - string
    doc: Filter features by spatial extent (xmin ymin xmax ymax).
    inputBinding:
      position: 103
  - id: sql
    type:
      - 'null'
      - string
    doc: Execute an SQL statement.
    inputBinding:
      position: 103
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Print a summary of layers.
    inputBinding:
      position: 103
      prefix: -so
  - id: where
    type:
      - 'null'
      - string
    doc: Filter features using a WHERE clause.
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_ogrinfo.out
