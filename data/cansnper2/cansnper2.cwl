cwlVersion: v1.2
class: CommandLineTool
baseCommand: cansnper2
label: cansnper2
doc: "The provided text does not contain help information or a description of the
  tool. It is an error log indicating a failure to build a container image due to
  lack of disk space.\n\nTool homepage: https://github.com/FOI-Bioinformatics/CanSNPer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper2:2.0.6--py_0
stdout: cansnper2.out
