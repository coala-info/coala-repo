cwlVersion: v1.2
class: CommandLineTool
baseCommand: moni ms
label: moni_ms
doc: "Moni tool for sequence matching\n\nTool homepage: https://github.com/maxrossi91/moni"
inputs:
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
stdout: moni_ms.out
