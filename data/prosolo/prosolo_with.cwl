cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosolo
label: prosolo_with
doc: "ProSolo is a tool for processing and analyzing single-cell RNA sequencing data.\n\
  \nTool homepage: https://github.com/PROSIC/prosolo/tree/v0.2.0"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
stdout: prosolo_with.out
