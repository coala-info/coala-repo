cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread-align
label: subread_subread-align
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stdout: subread_subread-align.out
