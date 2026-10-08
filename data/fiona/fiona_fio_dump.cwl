cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - dump
label: fiona_fio_dump
doc: "Dump a dataset either as a GeoJSON feature collection (the default) or a sequence of GeoJSON features.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: input
    type: File
    doc: Input dataset (for a shapefile, the .shx, .dbf, .prj and .cpg files are staged beside it)
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
  - id: layer
    type:
      - 'null'
      - string
    doc: Print information about a specific layer. The first layer is used by default. Layers use zero-based numbering when accessed by index.
    inputBinding:
      position: 102
      prefix: --layer
  - id: encoding
    type:
      - 'null'
      - string
    doc: Specify encoding of the input file.
    inputBinding:
      position: 102
      prefix: --encoding
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona_fio_dump.out
