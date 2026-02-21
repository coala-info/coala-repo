cwlVersion: v1.2
class: CommandLineTool
baseCommand: fade
label: fade
doc: "A tool for functional annotation of differential expression (Note: The provided
  help text contains only container runtime error messages and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/blachlylab/fade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
stdout: fade.out
