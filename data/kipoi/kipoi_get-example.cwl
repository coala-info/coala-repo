cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi_get-example
label: kipoi_get-example
doc: "Get example files\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: model
    type: string
    doc: Model name.
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: "Model source to use (default=kipoi). Specified in\n                    \
      \    ~/.kipoi/config.yaml under model_sources. When 'dir'\n                \
      \        is used, use the local directory path when specifying\n           \
      \             the model/dataloader."
    inputBinding:
      position: 102
      prefix: --source
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: "Output directory where to store the examples. Default:\n               \
      \         'example'"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
