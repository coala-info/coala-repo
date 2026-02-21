cwlVersion: v1.2
class: CommandLineTool
baseCommand: prodigal-gv
label: prodigal-gv
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/apcamargo/prodigal-gv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal-gv:2.11.0--h577a1d6_5
stdout: prodigal-gv.out
