cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogrinfo
label: gdal_ogrinfo
doc: "Lists information about an OGR-supported data source.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: datasource_name
    type: File
    doc: "Input datasource (for a shapefile, the .shx, .dbf, .prj and .cpg files are staged beside it)."
    secondaryFiles:
      - pattern: ^.shx
        required: false
      - pattern: ^.dbf
        required: false
      - pattern: ^.prj
        required: false
      - pattern: ^.cpg
        required: false
    inputBinding:
      position: 1
  - id: layers
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names of the layers to report."
    inputBinding:
      position: 2
  - id: read_only
    type:
      - 'null'
      - boolean
    doc: "Open the data source in read-only mode."
    inputBinding:
      position: 103
      prefix: -ro
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Quiet verbose reporting of various information, including coordinate system, layer schema, extents, and feature count."
    inputBinding:
      position: 103
      prefix: -q
  - id: where
    type:
      - 'null'
      - string
    doc: "Attribute query restricting the features reported (like an SQL WHERE clause)."
    inputBinding:
      position: 103
      prefix: -where
  - id: spat
    type:
      - 'null'
      - type: array
        items: float
    doc: "Spatial query extents: xmin ymin xmax ymax."
    inputBinding:
      position: 103
      prefix: -spat
  - id: geomfield
    type:
      - 'null'
      - string
    doc: "Name of the geometry field on which the spatial filter operates."
    inputBinding:
      position: 103
      prefix: -geomfield
  - id: fid
    type:
      - 'null'
      - string
    doc: "If provided, only the feature with this feature id will be reported."
    inputBinding:
      position: 103
      prefix: -fid
  - id: sql
    type:
      - 'null'
      - string
    doc: "Execute the indicated SQL statement and return the result."
    inputBinding:
      position: 103
      prefix: -sql
  - id: dialect
    type:
      - 'null'
      - string
    doc: "SQL dialect (OGRSQL, SQLITE, ...)."
    inputBinding:
      position: 103
      prefix: -dialect
  - id: all
    type:
      - 'null'
      - boolean
    doc: "List all features of all layers (not only the summary)."
    inputBinding:
      position: 103
      prefix: -al
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Report the extent and feature count of each layer in a dataset with a layer-by-layer pass (-rl)."
    inputBinding:
      position: 103
      prefix: -rl
  - id: summary
    type:
      - 'null'
      - boolean
    doc: "Summary only: suppress listing of features, show only the summary information like projection, schema, feature count and extents."
    inputBinding:
      position: 103
      prefix: -so
  - id: fields
    type:
      - 'null'
      - string
    doc: "If set to NO, the feature dump will not display field values. Default value is YES."
    inputBinding:
      position: 103
      prefix: -fields=
      separate: false
  - id: geom
    type:
      - 'null'
      - string
    doc: "If set to NO, the feature dump will not display the geometry. If SUMMARY, only a summary of the geometry is printed. Default is YES."
    inputBinding:
      position: 103
      prefix: -geom=
      separate: false
  - id: open_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -oo
    doc: "Open option for the datasource (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 103
  - id: no_metadata
    type:
      - 'null'
      - boolean
    doc: "Suppress metadata printing."
    inputBinding:
      position: 103
      prefix: -nomd
  - id: list_metadata
    type:
      - 'null'
      - boolean
    doc: "List all metadata domains available."
    inputBinding:
      position: 103
      prefix: -listmdd
  - id: metadata_domains
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -mdd
    doc: "Report metadata for the specified domain; 'all' for all domains. Repeat as needed."
    inputBinding:
      position: 103
  - id: no_count
    type:
      - 'null'
      - boolean
    doc: "Suppress feature count printing."
    inputBinding:
      position: 103
      prefix: -nocount
  - id: no_extent
    type:
      - 'null'
      - boolean
    doc: "Suppress spatial extent printing."
    inputBinding:
      position: 103
      prefix: -noextent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_ogrinfo.out
