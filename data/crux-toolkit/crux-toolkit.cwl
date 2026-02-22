cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux-toolkit
doc: "The provided text does not contain help information or a description of the
  tool; it is a system log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: http://crux.ms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crux-toolkit:4.2--h9ee0642_0
stdout: crux-toolkit.out
