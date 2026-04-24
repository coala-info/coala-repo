cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr_adjacency
label: seidr_adjacency
doc: "Transform a SeidrFile into an adjacency matrix\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
  - id: diagonal
    type:
      - 'null'
      - boolean
    doc: Print matrix diagonal for triangular output format
    inputBinding:
      position: 102
      prefix: --diagonal
  - id: fmt
    type:
      - 'null'
      - string
    doc: Output format ['m','lm']
    inputBinding:
      position: 102
      prefix: --fmt
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: index
    type:
      - 'null'
      - string
    doc: Score index to use
    inputBinding:
      position: 102
      prefix: --index
  - id: missing
    type:
      - 'null'
      - string
    doc: Fill character for missing edges
    inputBinding:
      position: 102
      prefix: --missing
  - id: precision
    type:
      - 'null'
      - int
    doc: Number of significant digits to report
    inputBinding:
      position: 102
      prefix: --precision
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file name ['-' for stdout]
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
