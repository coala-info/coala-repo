cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinker
label: tinker
doc: "Tinker molecular modeling software suite. (Note: The provided text appears to
  be a container build log rather than CLI help text; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker.out
