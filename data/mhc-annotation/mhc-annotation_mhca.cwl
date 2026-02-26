cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhca
label: mhc-annotation_mhca
doc: "mhc-annotation_mhca\n\nTool homepage: https://github.com/DiltheyLab/MHC-annotation"
inputs:
  - id: subcommand
    type: string
    doc: sub-command help
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
stdout: mhc-annotation_mhca.out
