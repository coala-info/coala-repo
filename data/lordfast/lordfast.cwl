cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordfast
label: lordfast
doc: "A tool for long read alignment (Note: The provided help text contains only system
  error messages regarding container execution and disk space, and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/vpc-ccg/lordfast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordfast:0.0.10--h5ca1c30_6
stdout: lordfast.out
