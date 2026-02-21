cwlVersion: v1.2
class: CommandLineTool
baseCommand: eigenstrat
label: eigensoft_eigenstrat
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/DReichLab/EIG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigensoft:8.0.0--h75d7a4a_6
stdout: eigensoft_eigenstrat.out
