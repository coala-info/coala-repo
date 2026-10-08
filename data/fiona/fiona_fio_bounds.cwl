cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - bounds
label: fiona_fio_bounds
doc: "Print the bounding boxes of GeoJSON objects read from stdin. Optionally explode collections and print the bounds of their features.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: features
    type: File
    doc: GeoJSON objects (feature collection or feature sequence) read from stdin
  - id: precision
    type:
      - 'null'
      - int
    doc: Decimal precision of coordinates.
    inputBinding:
      position: 102
      prefix: --precision
  - id: explode
    type:
      - 'null'
      - boolean
    doc: "Explode collections into features (default: no)."
    inputBinding:
      position: 102
      prefix: --explode
  - id: no_explode
    type:
      - 'null'
      - boolean
    doc: Do not explode collections into features.
    inputBinding:
      position: 102
      prefix: --no-explode
  - id: with_id
    type:
      - 'null'
      - boolean
    doc: "Print GeoJSON ids and bounding boxes together (default: without)."
    inputBinding:
      position: 102
      prefix: --with-id
  - id: without_id
    type:
      - 'null'
      - boolean
    doc: Do not print GeoJSON ids with the bounding boxes.
    inputBinding:
      position: 102
      prefix: --without-id
  - id: with_obj
    type:
      - 'null'
      - boolean
    doc: "Print GeoJSON objects and bounding boxes together (default: without)."
    inputBinding:
      position: 102
      prefix: --with-obj
  - id: without_obj
    type:
      - 'null'
      - boolean
    doc: Do not print GeoJSON objects with the bounding boxes.
    inputBinding:
      position: 102
      prefix: --without-obj
  - id: rs
    type:
      - 'null'
      - boolean
    doc: Use RS (0x1E) as a prefix for individual texts in a sequence (default is False).
    inputBinding:
      position: 102
      prefix: --rs
  - id: no_rs
    type:
      - 'null'
      - boolean
    doc: Do not use RS (0x1E) as a prefix for individual texts in a sequence.
    inputBinding:
      position: 102
      prefix: --no-rs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdin: $(inputs.features.path)
stdout: fiona_fio_bounds.out
