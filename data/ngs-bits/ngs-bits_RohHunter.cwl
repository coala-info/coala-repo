cwlVersion: v1.2
class: CommandLineTool
baseCommand: RohHunter
label: ngs-bits_RohHunter
doc: "The provided text does not contain help information for the tool. It contains
  a system error message regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_RohHunter.out
