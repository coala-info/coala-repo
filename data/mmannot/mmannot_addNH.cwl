cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmannot_addNH
label: mmannot_addNH
doc: "A tool for adding NH tags to SAM/BAM files (Note: The provided text contains
  only system error messages and no help documentation).\n\nTool homepage: https://github.com/mzytnicki/mmannot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmannot:1.1--h077b44d_3
stdout: mmannot_addNH.out
