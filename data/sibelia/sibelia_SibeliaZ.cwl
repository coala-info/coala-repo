cwlVersion: v1.2
class: CommandLineTool
baseCommand: SibeliaZ
label: sibelia_SibeliaZ
doc: "SibeliaZ is a tool for finding synteny blocks in closely related genomes. (Note:
  The provided help text contains container runtime errors and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/bioinf/Sibelia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibelia:3.0.7--0
stdout: sibelia_SibeliaZ.out
