cwlVersion: v1.2
class: CommandLineTool
baseCommand: chicagotools
label: chicagotools
doc: The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure (no space
  left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chicagotools:1.2.0--py36r3.3.1_0
stdout: chicagotools.out
