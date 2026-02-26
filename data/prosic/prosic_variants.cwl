cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosic
label: prosic_variants
doc: "ProSIc: a tool for predicting the impact of variants on protein stability\n\n\
  Tool homepage: https://prosic.github.io"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (e.g., 'variants')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
stdout: prosic_variants.out
