cwlVersion: v1.2
class: CommandLineTool
baseCommand: defiant
label: defiant
doc: "Defiant: Differentially Methylated Regions (DMRs) identification tool.\n\nTool
  homepage: https://github.com/hhg7/defiant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/defiant:1.1.4--h7b50bb2_6
stdout: defiant.out
