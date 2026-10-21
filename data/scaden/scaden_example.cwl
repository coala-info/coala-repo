cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scaden
  - example
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
      - string
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
  - id: counts_file
    type: File
    doc: Example scRNA-seq count file (example_counts.txt)
    outputBinding:
      glob: $((inputs.out || '.') + '/example_counts.txt')
  - id: celltypes_file
    type: File
    doc: Example cell type labels (example_celltypes.txt)
    outputBinding:
      glob: $((inputs.out || '.') + '/example_celltypes.txt')
  - id: bulk_file
    type: File
    doc: Example bulk RNA-seq data (example_bulk_data.txt)
    outputBinding:
      glob: $((inputs.out || '.') + '/example_bulk_data.txt')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.out ? {class: 'Directory', basename: inputs.out, listing: []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
