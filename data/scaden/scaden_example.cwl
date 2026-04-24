cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaden_example
label: scaden_example
doc: "Generate an example dataset\n\nTool homepage: https://github.com/KevinMenden/scaden"
inputs:
  - id: cells
    type:
      - 'null'
      - int
    doc: Number of cells
    inputBinding:
      position: 101
      prefix: --cells
  - id: genes
    type:
      - 'null'
      - int
    doc: Number of genes
    inputBinding:
      position: 101
      prefix: --genes
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out
  - id: samples
    type:
      - 'null'
      - int
    doc: Number of bulk samples
    inputBinding:
      position: 101
      prefix: --samples
  - id: types
    type:
      - 'null'
      - int
    doc: Number of cell types
    inputBinding:
      position: 101
      prefix: --types
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
stdout: scaden_example.out
