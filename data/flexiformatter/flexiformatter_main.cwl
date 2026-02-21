cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flexiformatter
  - main
label: flexiformatter_main
doc: "Process BAM/SAM file.\n\nTool homepage: https://github.com/ljwharbers/flexiformatter"
inputs:
  - id: infile
    type: File
    doc: Input BAM/SAM file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexiformatter:1.0.6--pyhdfd78af_0
stdout: flexiformatter_main.out
