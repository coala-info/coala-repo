cwlVersion: v1.2
class: CommandLineTool
baseCommand: ontime
label: ontime
doc: "Real-time monitoring of Nanopore sequencing. (Note: The provided text is an
  error log indicating a failure to build the container image due to lack of disk
  space and does not contain the tool's help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/mbhall88/ontime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ontime:0.3.1--hc1c3326_2
stdout: ontime.out
