cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr_import
label: seidr_import
doc: "Convert various text based network representations to SeidrFiles\n\nTool homepage:
  https://github.com/bschiffthaler/seidr"
inputs:
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Rank on absolute of scores
    inputBinding:
      position: 101
      prefix: --absolute
  - id: drop_zero
    type:
      - 'null'
      - boolean
    doc: Drop edges with a weight of zero from the network
    inputBinding:
      position: 101
      prefix: --drop-zero
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: format
    type: string
    doc: The input file format [el, lm, m, ara]
    inputBinding:
      position: 101
      prefix: --format
  - id: genes
    type: File
    doc: Gene file for input
    inputBinding:
      position: 101
      prefix: --genes
  - id: infile
    type: File
    doc: Input file name ['-' for stdin]
    inputBinding:
      position: 101
      prefix: --infile
  - id: name
    type: string
    doc: Import name (algorithm name)
    inputBinding:
      position: 101
      prefix: --name
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Rank scores in descending order (highest first)
    inputBinding:
      position: 101
      prefix: --reverse
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads for parallel sorting
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: undirected
    type:
      - 'null'
      - boolean
    doc: Force all edges to be interpreted as undirected
    inputBinding:
      position: 101
      prefix: --undirected
outputs:
  - id: outfile
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
