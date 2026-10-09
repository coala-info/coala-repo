cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - get-example
label: kipoi_get-example
doc: "Get example files\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: model
    type:
      - string
      - Directory
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
  - id: output_path
    type: string
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: "Output directory where to store the examples. Default:\n               \
      \         'example'"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
