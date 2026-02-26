cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - info
label: fiona_fio info
doc: "Print information about a dataset.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: input
    type: string
    doc: Input dataset
    inputBinding:
      position: 1
  - id: bounds
    type:
      - 'null'
      - boolean
    doc: Print the boundary coordinates (left, bottom, right, top).
    inputBinding:
      position: 102
      prefix: --bounds
  - id: count
    type:
      - 'null'
      - boolean
    doc: Print the count of features.
    inputBinding:
      position: 102
      prefix: --count
  - id: crs
    type:
      - 'null'
      - boolean
    doc: Print the CRS as a PROJ.4 string.
    inputBinding:
      position: 102
      prefix: --crs
  - id: format_driver
    type:
      - 'null'
      - boolean
    doc: Print the format driver.
    inputBinding:
      position: 102
      prefix: --format
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
    doc: Print information about a specific layer. The first layer is used by 
      default. Layers use zero-based numbering when accessed by index.
    inputBinding:
      position: 102
      prefix: --layer
  - id: name
    type:
      - 'null'
      - boolean
    doc: Print the datasource's name.
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona_fio info.out
