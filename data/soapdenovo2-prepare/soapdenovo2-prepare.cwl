cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapdenovo2-prepare
label: soapdenovo2-prepare
doc: The provided text does not contain help information or usage instructions; it
  contains container engine log messages and a fatal error regarding image retrieval.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2-prepare:2.0--h577a1d6_9
stdout: soapdenovo2-prepare.out
