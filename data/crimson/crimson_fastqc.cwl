cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crimson
  - fastqc
label: crimson_fastqc
doc: "Convert FastQC output to JSON\n\nTool homepage: https://github.com/bow/crimson"
inputs:
  - id: input
    type: File
    doc: Input FastQC file or directory
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output JSON file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crimson:1.1.1--pyh7cba7a3_0
