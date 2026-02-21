cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrpipe_diagnostic
label: pyrpipe_pyrpipe_diagnostic
doc: "A diagnostic tool for pyrpipe. Note: The provided help text contains only system
  logs and error messages regarding a failed container build and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/urmi-21/pyrpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrpipe:0.0.5--py_0
stdout: pyrpipe_pyrpipe_diagnostic.out
