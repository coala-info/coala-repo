cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - bioquant
label: philosopher_bioquant
doc: "Bioquant\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: id
    type:
      - 'null'
      - string
    doc: UniProt proteome ID
    inputBinding:
      position: 101
      prefix: --id
  - id: level
    type:
      - 'null'
      - float
    doc: cluster identity level
    default: 0.9
    inputBinding:
      position: 101
      prefix: --level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_bioquant.out
