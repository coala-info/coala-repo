cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomic_address_service
label: genomic_address_service
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding disk
  space.\n\nTool homepage: https://pypi.org/project/genomic-address-service"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomic_address_service:0.3.2--pyhdfd78af_0
stdout: genomic_address_service.out
