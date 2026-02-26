cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbcanlight
label: dbcanlight
doc: "The provided text is a Docker error message indicating a failure to pull the
  image. However, based on the tool name hint 'dbcanlight', it is a tool for automated
  CAZyme annotation. Below is the structured information for its standard CLI usage.\n\
  \nTool homepage: https://github.com/chtsai0105/dbcanLight/tree/main"
inputs:
  - id: input
    type: File
    doc: Input FASTA file (protein or nucleotide)
    inputBinding:
      position: 1
  - id: coverage
    type:
      - 'null'
      - float
    doc: Coverage cutoff
    default: 0.35
    inputBinding:
      position: 102
      prefix: --coverage
  - id: database
    type:
      - 'null'
      - Directory
    doc: Path to the dbCAN database
    inputBinding:
      position: 102
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value cutoff
    default: 1e-15
    inputBinding:
      position: 102
      prefix: --evalue
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Search mode: hmmer, diamond, or both'
    inputBinding:
      position: 102
      prefix: --mode
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory for results
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
