cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros
label: sipros
doc: "Sipros is a tool for protein identification and quantification. Note: The provided
  text contains container runtime error logs rather than the tool's help documentation,
  so specific arguments could not be extracted.\n\nTool homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros.out
