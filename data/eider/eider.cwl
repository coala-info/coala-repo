cwlVersion: v1.2
class: CommandLineTool
baseCommand: eider
label: eider
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime environment.\n\nTool homepage:
  https://github.com/heuermh/eider"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eider:0.1--hdfd78af_0
stdout: eider.out
