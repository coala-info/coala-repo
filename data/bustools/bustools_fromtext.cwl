cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - fromtext
label: bustools_fromtext
doc: "Convert text files to BUS format\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: text_files
    type:
      type: array
      items: File
    doc: Text files to convert
    inputBinding:
      position: 1
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for BUS output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
