cwlVersion: v1.2
class: CommandLineTool
baseCommand: ymp
label: ymp
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://ymp.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp.out
