cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultra
label: ultra
doc: "The provided text does not contain a description of the tool's functionality,
  as it appears to be a container build log rather than help text.\n\nTool homepage:
  https://github.com/TravisWheelerLab/ULTRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultra:1.2.1--h9948957_0
stdout: ultra.out
