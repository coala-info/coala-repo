cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - neighbours
label: seidr_neighbours
doc: "Get the top N first-degree neighbours for each node or a list of nodes\n\nTool
  homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
  - id: case_insensitive
    type:
      - 'null'
      - boolean
    doc: Search case insensitive nodes
    inputBinding:
      position: 102
      prefix: --case-insensitive
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene names to search
    inputBinding:
      position: 102
      prefix: --genes
  - id: index
    type:
      - 'null'
      - string
    doc: Index to use for selection
    default: last score
    inputBinding:
      position: 102
      prefix: --index
  - id: neighbours
    type:
      - 'null'
      - int
    doc: Number of top first-degree neighbours to return
    default: 10
    inputBinding:
      position: 102
      prefix: --neighbours
  - id: rank
    type:
      - 'null'
      - boolean
    doc: Use rank instead of score
    inputBinding:
      position: 102
      prefix: --rank
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Fail on all issues instead of warning
    inputBinding:
      position: 102
      prefix: --strict
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads for parallel sorting
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Print only unique edges
    inputBinding:
      position: 102
      prefix: --unique
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
