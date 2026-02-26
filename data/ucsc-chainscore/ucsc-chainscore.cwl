cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainScore
label: ucsc-chainscore
doc: "Score chains using a substitution matrix and gap costs. Note: The provided help
  text was a Docker error message; arguments are based on standard tool documentation.\n\
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: target_2bit
    type: File
    doc: Target 2bit file
    inputBinding:
      position: 2
  - id: query_2bit
    type: File
    doc: Query 2bit file
    inputBinding:
      position: 3
  - id: linear_gap
    type:
      - 'null'
      - File
    doc: Read linear gap costs from file
    inputBinding:
      position: 104
      prefix: -linearGap
  - id: matrix
    type:
      - 'null'
      - File
    doc: Read substitution matrix from file
    inputBinding:
      position: 104
      prefix: -matrix
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbose level
    inputBinding:
      position: 104
      prefix: -verbose
outputs:
  - id: out_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainscore:455--h1536b3f_1
