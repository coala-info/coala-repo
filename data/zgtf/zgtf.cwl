cwlVersion: v1.2
class: CommandLineTool
baseCommand: zgtf
label: zgtf
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be an error log from a container build process.\n\nTool homepage:
  The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zgtf:0.1.2--pyh5e36f6f_0
stdout: zgtf.out
