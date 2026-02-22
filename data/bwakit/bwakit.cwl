cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwakit
label: bwakit
doc: "The provided text does not contain help information or documentation for bwakit;
  it contains system error messages related to disk space and container image conversion.\n\
  \nTool homepage: https://github.com/lh3/bwa/tree/master/bwakit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0
stdout: bwakit.out
