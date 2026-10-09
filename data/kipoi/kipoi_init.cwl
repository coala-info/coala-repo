cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - init
label: kipoi_init
doc: "Initializing a new Kipoi model\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_init.out
