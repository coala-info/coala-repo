cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniprot
label: miniprot
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to pull the container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/lh3/miniprot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniprot:0.18--h577a1d6_0
stdout: miniprot.out
