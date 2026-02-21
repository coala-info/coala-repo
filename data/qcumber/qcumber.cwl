cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcumber
label: qcumber
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://gitlab.com/RKIBioinformaticsPipelines/QCumber"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qcumber:2.0.4--0
stdout: qcumber.out
