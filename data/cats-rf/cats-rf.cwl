cwlVersion: v1.2
class: CommandLineTool
baseCommand: cats-rf
label: cats-rf
doc: "The provided text does not contain help information or usage instructions for
  cats-rf. It contains system logs indicating a failure to build or extract a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/bodulic/CATS-rf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rf:1.0.4--hdfd78af_0
stdout: cats-rf.out
