cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartpca
label: eigensoft_smartpca
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error message regarding a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/DReichLab/EIG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigensoft:8.0.0--h75d7a4a_6
stdout: eigensoft_smartpca.out
