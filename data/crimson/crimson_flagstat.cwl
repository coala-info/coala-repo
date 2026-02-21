cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crimson
  - flagstat
label: crimson_flagstat
doc: "Crimson flagstat parses samtools flagstat output into structured data.\n\nTool
  homepage: https://github.com/bow/crimson"
inputs:
  - id: input
    type: File
    doc: Input samtools flagstat file
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crimson:1.1.1--pyh7cba7a3_0
