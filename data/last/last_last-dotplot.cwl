cwlVersion: v1.2
class: CommandLineTool
baseCommand: last-dotplot
label: last_last-dotplot
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  lack of disk space.\n\nTool homepage: https://gitlab.com/mcfrith/last"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last_last-dotplot.out
