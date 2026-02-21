cwlVersion: v1.2
class: CommandLineTool
baseCommand: qp3Pop
label: admixtools_qp3pop
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build or extract the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qp3pop.out
