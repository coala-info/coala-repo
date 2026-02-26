cwlVersion: v1.2
class: CommandLineTool
baseCommand: imfusion
label: imfusion_insertions
doc: "imfusion\n\nTool homepage: https://github.com/iamsh4shank/Imfusion"
inputs:
  - id: command
    type: string
    doc: command
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
stdout: imfusion_insertions.out
