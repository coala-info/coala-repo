cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgorient
label: vgorient
doc: "The provided text does not contain help information for the tool; it is a log
  of a container build failure.\n\nTool homepage: https://github.com/whelixw/vgOrient"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
stdout: vgorient.out
