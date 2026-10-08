cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - distrib
label: fiona_fio_distrib
doc: "Distribute features from a collection. Print the features of GeoJSON objects read from stdin.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: features
    type: File
    doc: GeoJSON objects read from stdin
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
stdout: fiona_fio_distrib.out
