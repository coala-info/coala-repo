cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggplot
label: ggplot
doc: "A tool for plotting data (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/tidyverse/ggplot2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggplot:0.6.8--py36_0
stdout: ggplot.out
