cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher comet
label: philosopher_comet
doc: "Run comet\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: noindex
    type:
      - 'null'
      - boolean
    doc: skip raw file indexing
    inputBinding:
      position: 101
      prefix: --noindex
  - id: param
    type:
      - 'null'
      - string
    doc: comet parameter file
    inputBinding:
      position: 101
      prefix: --param
  - id: print
    type:
      - 'null'
      - boolean
    doc: print a comet.params file
    inputBinding:
      position: 101
      prefix: --print
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_comet.out
