cwlVersion: v1.2
class: CommandLineTool
baseCommand: consplice
label: consplice
doc: "The provided text contains system error messages related to a Singularity container
  execution failure and does not contain the tool's help documentation. No arguments
  could be parsed.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
stdout: consplice.out
