cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr compare
label: seidr_compare
doc: "Compare edges or nodes in two networks.\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: network_1
    type: File
    doc: Input SeidrFile for network A
    inputBinding:
      position: 1
  - id: network_2
    type: File
    doc: Input SeidrFile for network B
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: index_a
    type:
      - 'null'
      - string
    doc: Merge scores on this index for network A
    inputBinding:
      position: 103
      prefix: --index-a
  - id: index_b
    type:
      - 'null'
      - string
    doc: Merge scores on this index for network B
    inputBinding:
      position: 103
      prefix: --index-b
  - id: nodes
    type:
      - 'null'
      - boolean
    doc: Print overlap of nodes instead of edges
    inputBinding:
      position: 103
      prefix: --nodes
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Directory to store temporary data
    inputBinding:
      position: 103
      prefix: --tempdir
  - id: translate
    type:
      - 'null'
      - File
    doc: Translate node names in network A according to this table
    inputBinding:
      position: 103
      prefix: --translate
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name ['-' for stdout]
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
