cwlVersion: v1.2
class: CommandLineTool
baseCommand: reparation_blast
label: reparation_blast
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/RickGelhausen/REPARATION_blast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
stdout: reparation_blast.out
