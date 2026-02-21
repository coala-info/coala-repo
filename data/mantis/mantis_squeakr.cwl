cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mantis
  - squeakr
label: mantis_squeakr
doc: "The provided text does not contain help information for the tool; it contains
  system error logs regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/splatlab/mantis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_squeakr.out
