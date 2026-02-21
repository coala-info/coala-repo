cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmox
label: dmox
doc: "The provided text does not contain a description of the tool; it contains container
  runtime log messages and a fatal error regarding disk space.\n\nTool homepage: https://gitlab.mbb.cnrs.fr/ibonnici/dmox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmox:0.2.1--h3ab6199_0
stdout: dmox.out
