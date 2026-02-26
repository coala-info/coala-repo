cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi_init
label: kipoi_init
doc: "Initializing a new Kipoi model\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: model_name
    type:
      - 'null'
      - string
    doc: Name of the new Kipoi model
    default: my_model
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_init.out
