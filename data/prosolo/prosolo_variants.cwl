cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosolo
label: prosolo_variants
doc: "Prosolo variants tool\n\nTool homepage: https://github.com/PROSIC/prosolo/tree/v0.2.0"
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
    dockerPull: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
stdout: prosolo_variants.out
