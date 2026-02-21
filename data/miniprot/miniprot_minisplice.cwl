cwlVersion: v1.2
class: CommandLineTool
baseCommand: minisplice
label: miniprot_minisplice
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding container image conversion and disk space.\n\nTool
  homepage: https://github.com/lh3/miniprot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniprot:0.18--h577a1d6_0
stdout: miniprot_minisplice.out
