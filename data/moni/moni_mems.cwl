cwlVersion: v1.2
class: CommandLineTool
baseCommand: moni mems
label: moni_mems
doc: "Find maximal exact matches (MEMs) between a query and a reference genome.\n\n\
  Tool homepage: https://github.com/maxrossi91/moni"
inputs:
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: output MEM occurrence in the reference
    inputBinding:
      position: 101
      prefix: --extended-output
  - id: grammar
    type:
      - 'null'
      - string
    doc: select the grammar [plain, shaped]
    inputBinding:
      position: 101
      prefix: --grammar
  - id: index
    type: Directory
    doc: reference index folder
    inputBinding:
      position: 101
      prefix: --index
  - id: minimum_mem_length
    type:
      - 'null'
      - int
    doc: minimum MEM length
    inputBinding:
      position: 101
      prefix: --minimum-MEM-length
  - id: output
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: pattern
    type: string
    doc: the input query
    inputBinding:
      position: 101
      prefix: --pattern
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: output MEM in a SAM formatted file.
    inputBinding:
      position: 101
      prefix: --sam-output
  - id: threads
    type:
      - 'null'
      - int
    doc: number of helper threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
stdout: moni_mems.out
