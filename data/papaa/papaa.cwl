cwlVersion: v1.2
class: CommandLineTool
baseCommand: papaa
label: papaa
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to disk space and container image
  conversion.\n\nTool homepage: https://github.com/nvk747/papaa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/papaa:0.1.9--hdfd78af_1
stdout: papaa.out
