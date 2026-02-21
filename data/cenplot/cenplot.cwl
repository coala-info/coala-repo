cwlVersion: v1.2
class: CommandLineTool
baseCommand: cenplot
label: cenplot
doc: "A tool for plotting centromeric regions (Note: The provided help text contains
  only container build error logs and no usage information).\n\nTool homepage: https://github.com/logsdon-lab/CenPlot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cenplot:0.1.5--pyhdfd78af_0
stdout: cenplot.out
