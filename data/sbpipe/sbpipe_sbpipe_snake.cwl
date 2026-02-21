cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbpipe_sbpipe_snake
label: sbpipe_sbpipe_snake
doc: "A tool for Systems Biology pipeline simulation and analysis (Note: The provided
  help text contains only system logs and error messages, no argument information
  was available).\n\nTool homepage: http://sbpipe.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbpipe:4.21.0--py_0
stdout: sbpipe_sbpipe_snake.out
