cwlVersion: v1.2
class: CommandLineTool
baseCommand: mauvealigner
label: mauvealigner
doc: "The provided text does not contain help information or usage instructions for
  mauvealigner; it contains system error messages related to a container runtime failure
  (no space left on device).\n\nTool homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mauvealigner:1.2.0--hfc679d8_0
stdout: mauvealigner.out
