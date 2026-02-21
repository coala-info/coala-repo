cwlVersion: v1.2
class: CommandLineTool
baseCommand: gridss
label: gridss
doc: "GRIDSS is a module software suite for the detection of genomic rearrangements.\n
  \nTool homepage: https://github.com/PapenfussLab/gridss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gridss:2.13.2--h96c455f_6
stdout: gridss.out
