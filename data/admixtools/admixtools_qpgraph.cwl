cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpgraph
label: admixtools_qpgraph
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding disk space during a container build
  process.\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpgraph.out
