cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimize
label: tinker_minimize
doc: "The provided text contains container runtime logs and a fatal error message
  rather than the help documentation for the tool. Consequently, no arguments or tool
  descriptions could be extracted.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_minimize.out
