cwlVersion: v1.2
class: CommandLineTool
baseCommand: extern
label: extern
doc: "The provided text does not contain help information or a description for the
  tool 'extern'. It contains error logs related to a container build process.\n\n
  Tool homepage: https://github.com/xmu-xiaoma666/External-Attention-pytorch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extern:0.2.1--py27_0
stdout: extern.out
