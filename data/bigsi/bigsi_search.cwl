cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigsi-v0.3.1 search
label: bigsi_search
doc: "Search for a sequence\n\nTool homepage: https://github.com/Phelimb/BIGSI"
inputs:
  - id: seq
    type: string
    doc: Basic text / string value
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - string
    doc: Basic text / string value
    inputBinding:
      position: 102
      prefix: --config
  - id: threshold
    type:
      - 'null'
      - float
    doc: A float number
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_search.out
