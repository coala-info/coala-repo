cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpf4ratio
label: admixtools_qpf4ratio
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpf4ratio.out
