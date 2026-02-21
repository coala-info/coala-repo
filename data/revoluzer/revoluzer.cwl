cwlVersion: v1.2
class: CommandLineTool
baseCommand: revoluzer
label: revoluzer
doc: "No description available (the provided text was a container build log and did
  not contain help information).\n\nTool homepage: https://gitlab.com/Bernt/revoluzer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
stdout: revoluzer.out
