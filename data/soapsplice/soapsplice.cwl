cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapsplice
label: soapsplice
doc: The provided text does not contain help information for soapsplice; it is a log
  of a failed container build process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapsplice:1.10--2
stdout: soapsplice.out
