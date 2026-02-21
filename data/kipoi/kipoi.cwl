cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi
label: kipoi
doc: "Kipoi: Model zoo for genomics (Note: The provided text is an error log and does
  not contain help information or argument definitions).\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi.out
