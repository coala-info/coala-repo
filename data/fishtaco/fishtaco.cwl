cwlVersion: v1.2
class: CommandLineTool
baseCommand: fishtaco
label: fishtaco
doc: "Functional Identification of State-Heterogeneous Taxa Contributions to Omics-level
  differences\n\nTool homepage: https://github.com/borenstein-lab/fishtaco/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fishtaco:1.1.1--py36_0
stdout: fishtaco.out
