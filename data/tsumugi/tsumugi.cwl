cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi
label: tsumugi
doc: "tsumugi is a tool for time-series unsupervised mutation grouping and identification
  (Note: The provided text is an error log and does not contain usage information
  or argument definitions).\n\nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsumugi:1.0.1--pyhdfd78af_0
stdout: tsumugi.out
