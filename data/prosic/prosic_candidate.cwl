cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosic
label: prosic_candidate
doc: "prosic\n\nTool homepage: https://prosic.github.io"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
stdout: prosic_candidate.out
