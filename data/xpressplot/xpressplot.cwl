cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpressplot
label: xpressplot
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/XPRESSyourself/XPRESSplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpressplot:0.2.5--pyh4c3bd37_1
stdout: xpressplot.out
