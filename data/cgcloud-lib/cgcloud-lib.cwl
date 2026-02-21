cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgcloud-lib
label: cgcloud-lib
doc: The provided text does not contain help documentation or usage instructions for
  cgcloud-lib. It consists of system logs and a fatal error message regarding a container
  build failure (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgcloud-lib:1.6.0--py27_1
stdout: cgcloud-lib.out
