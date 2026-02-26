cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcov collapse
label: transcov_collapse
doc: "\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: matrices
    type:
      - 'null'
      - type: array
        items: string
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --output-file
  - id: uint32
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --uint32
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
stdout: transcov_collapse.out
