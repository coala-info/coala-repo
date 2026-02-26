cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - load
label: fiona_fio load
doc: "Load features from JSON to a file in another format.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: output
    type: File
    doc: Output file
    inputBinding:
      position: 1
  - id: features
    type:
      type: array
      items: string
    doc: Input GeoJSON features
    inputBinding:
      position: 2
  - id: dst_crs
    type:
      - 'null'
      - string
    doc: "Destination CRS.  Defaults to --src-crs when\n                         \
      \      not given."
    inputBinding:
      position: 103
      prefix: --dst-crs
  - id: format
    type: string
    doc: Output format driver name.
    inputBinding:
      position: 103
      prefix: --format
  - id: layer
    type:
      - 'null'
      - string
    doc: "Load features into specified layer.  Layers use\n                      \
      \         zero-based numbering when accessed by index."
    inputBinding:
      position: 103
      prefix: --layer
  - id: src_crs
    type:
      - 'null'
      - string
    doc: Source CRS.
    inputBinding:
      position: 103
      prefix: --src-crs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona_fio load.out
