cwlVersion: v1.2
class: CommandLineTool
baseCommand: newton
label: tinker_newton
doc: "The Newton program performs a molecular energy minimization using a truncated
  Newton method. The provided text appears to be a container build error log rather
  than help text, so no arguments could be extracted from the source.\n\nTool homepage:
  https://dasher.wustl.edu/tinker/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_newton.out
