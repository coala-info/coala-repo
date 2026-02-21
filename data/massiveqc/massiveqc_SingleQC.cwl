cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - massiveqc
  - SingleQC
label: massiveqc_SingleQC
doc: "The provided text does not contain help information or usage instructions. It
  contains system error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/shimw6828/MassiveQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
stdout: massiveqc_SingleQC.out
