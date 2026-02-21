cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmsc-mapper
label: gmsc-mapper
doc: "Global Microbial Sparse Coding mapper (Note: The provided text contained only
  system error logs and no usage information).\n\nTool homepage: https://github.com/BigDataBiology/GMSC-mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
stdout: gmsc-mapper.out
