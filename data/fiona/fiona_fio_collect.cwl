cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - collect
label: fiona_fio_collect
doc: "Make a GeoJSON feature collection from a sequence of GeoJSON features and print it.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: features
    type: File
    doc: Sequence of GeoJSON features read from stdin
  - id: precision
    type:
      - 'null'
      - int
    doc: Decimal precision of coordinates.
    inputBinding:
      position: 102
      prefix: --precision
  - id: indent
    type:
      - 'null'
      - int
    doc: Indentation level for JSON output
    inputBinding:
      position: 102
      prefix: --indent
  - id: compact
    type:
      - 'null'
      - boolean
    doc: Use compact separators (',', ':').
    inputBinding:
      position: 102
      prefix: --compact
  - id: not_compact
    type:
      - 'null'
      - boolean
    doc: Do not use compact separators.
    inputBinding:
      position: 102
      prefix: --not-compact
  - id: record_buffered
    type:
      - 'null'
      - boolean
    doc: Economical buffering of writes at record, not collection (default), level.
    inputBinding:
      position: 102
      prefix: --record-buffered
  - id: no_record_buffered
    type:
      - 'null'
      - boolean
    doc: Buffer writes at collection level (default).
    inputBinding:
      position: 102
      prefix: --no-record-buffered
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: log errors but do not stop serialization.
    inputBinding:
      position: 102
      prefix: --ignore-errors
  - id: no_ignore_errors
    type:
      - 'null'
      - boolean
    doc: Stop serialization on errors.
    inputBinding:
      position: 102
      prefix: --no-ignore-errors
  - id: src_crs
    type:
      - 'null'
      - string
    doc: Source CRS.
    inputBinding:
      position: 102
      prefix: --src-crs
  - id: with_ld_context
    type:
      - 'null'
      - boolean
    doc: add a JSON-LD context to JSON output.
    inputBinding:
      position: 102
      prefix: --with-ld-context
  - id: without_ld_context
    type:
      - 'null'
      - boolean
    doc: Do not add a JSON-LD context to JSON output.
    inputBinding:
      position: 102
      prefix: --without-ld-context
  - id: add_ld_context_item
    type:
      - 'null'
      - string
    doc: map a term to a URI and add it to the output's JSON LD context.
    inputBinding:
      position: 102
      prefix: --add-ld-context-item
  - id: parse
    type:
      - 'null'
      - boolean
    doc: load and dump the geojson feature (default is True)
    inputBinding:
      position: 102
      prefix: --parse
  - id: no_parse
    type:
      - 'null'
      - boolean
    doc: Do not load and dump the geojson feature.
    inputBinding:
      position: 102
      prefix: --no-parse
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdin: $(inputs.features.path)
stdout: fiona_fio_collect.out
