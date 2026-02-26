cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlinker variant-linker
label: varlinker_variant-linker
doc: "Links variants across different datasets.\n\nTool homepage: https://github.com/IBCHgenomic/varlinker"
inputs:
  - id: vcfile
    type: File
    doc: Input variant call file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0
stdout: varlinker_variant-linker.out
