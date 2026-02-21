cwlVersion: v1.2
class: CommandLineTool
baseCommand: polap
label: polap
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/goshng/polap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap.out
