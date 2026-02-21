cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgreat
label: bgreat
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or extract the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/Malfoy/BGREAT2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgreat:2.0.0--hd28b015_0
stdout: bgreat.out
