cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fiona
  - fio
  - cat
label: fiona_fio cat
doc: "Concatenate and print the features of input datasets as a sequence of GeoJSON
  features.\n\nWhen working with a multi-layer dataset the first layer is used by\n\
  default. Use the '--layer' option to select a different layer.\n\nTool homepage:
  https://github.com/Toblerity/Fiona"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input datasets
    inputBinding:
      position: 1
  - id: bbox
    type:
      - 'null'
      - string
    doc: "filter for features intersecting a bounding\nbox"
    inputBinding:
      position: 102
      prefix: --bbox
  - id: compact
    type:
      - 'null'
      - boolean
    doc: Use compact separators (',', ':').
    inputBinding:
      position: 102
      prefix: --compact
  - id: dst_crs
    type:
      - 'null'
      - string
    doc: Destination CRS.
    inputBinding:
      position: 102
      prefix: --dst-crs
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: log errors but do not stop serialization.
    inputBinding:
      position: 102
      prefix: --ignore-errors
  - id: indent
    type:
      - 'null'
      - int
    doc: Indentation level for JSON output
    inputBinding:
      position: 102
      prefix: --indent
  - id: layer
    type:
      - 'null'
      - string
    doc: "Input layer(s), specified as\n'fileindex:layer` For example, '1:foo,2:bar'\n\
      will concatenate layer foo from file 1 and\nlayer bar from file 2"
    inputBinding:
      position: 102
      prefix: --layer
  - id: no_ignore_errors
    type:
      - 'null'
      - boolean
    doc: log errors but do not stop serialization.
    inputBinding:
      position: 102
      prefix: --no-ignore-errors
  - id: no_rs
    type:
      - 'null'
      - boolean
    doc: "Use RS (0x1E) as a prefix for individual\ntexts in a sequence as per\nhttp://tools.ietf.org/html/draft-ietf-json-\n\
      text-sequence-13 (default is False)."
    inputBinding:
      position: 102
      prefix: --no-rs
  - id: not_compact
    type:
      - 'null'
      - boolean
    doc: Use compact separators (',', ':').
    inputBinding:
      position: 102
      prefix: --not-compact
  - id: precision
    type:
      - 'null'
      - int
    doc: Decimal precision of coordinates.
    inputBinding:
      position: 102
      prefix: --precision
  - id: rs
    type:
      - 'null'
      - boolean
    doc: "Use RS (0x1E) as a prefix for individual\ntexts in a sequence as per\nhttp://tools.ietf.org/html/draft-ietf-json-\n\
      text-sequence-13 (default is False)."
    inputBinding:
      position: 102
      prefix: --rs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona_fio cat.out
