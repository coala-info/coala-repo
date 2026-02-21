cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnuplot
label: gnuplot
doc: "A command-line driven graphing utility (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/dkogan/feedgnuplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnuplot:5.2.3
stdout: gnuplot.out
