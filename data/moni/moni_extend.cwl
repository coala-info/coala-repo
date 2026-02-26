cwlVersion: v1.2
class: CommandLineTool
baseCommand: moni extend
label: moni_extend
doc: "Extend query patterns against a reference index.\n\nTool homepage: https://github.com/maxrossi91/moni"
inputs:
  - id: batch
    type:
      - 'null'
      - int
    doc: number of reads per thread batch
    default: 100
    inputBinding:
      position: 101
      prefix: --batch
  - id: extl
    type:
      - 'null'
      - int
    doc: length of reference substring for extension
    default: 100
    inputBinding:
      position: 101
      prefix: --extl
  - id: gape
    type:
      - 'null'
      - string
    doc: coma separated gap extension penalty values
    default: 2,1
    inputBinding:
      position: 101
      prefix: --gape
  - id: gapo
    type:
      - 'null'
      - string
    doc: coma separated gap open penalty values
    default: 4,13
    inputBinding:
      position: 101
      prefix: --gapo
  - id: grammar
    type:
      - 'null'
      - string
    doc: select the grammar [plain, shaped]
    default: plain
    inputBinding:
      position: 101
      prefix: --grammar
  - id: index
    type: Directory
    doc: reference index folder
    inputBinding:
      position: 101
      prefix: --index
  - id: pattern
    type: string
    doc: the input query
    inputBinding:
      position: 101
      prefix: --pattern
  - id: smatch
    type:
      - 'null'
      - int
    doc: match score value
    default: 2
    inputBinding:
      position: 101
      prefix: --smatch
  - id: smismatch
    type:
      - 'null'
      - int
    doc: mismatch penalty value
    default: 4
    inputBinding:
      position: 101
      prefix: --smismatch
  - id: threads
    type:
      - 'null'
      - int
    doc: number of helper threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: output directory path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
