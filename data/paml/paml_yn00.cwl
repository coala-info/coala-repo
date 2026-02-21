cwlVersion: v1.2
class: CommandLineTool
baseCommand: yn00
label: paml_yn00
doc: "YN00 in paml version 4.10.10, 29 Jan 2026. Estimating synonymous and nonsynonymous
  substitution rates between two sequences.\n\nTool homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: Control file (usually yn00.ctl). If not provided, the program looks for yn00.ctl
      in the current directory.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_yn00.out
