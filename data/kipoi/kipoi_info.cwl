cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi_info
label: kipoi_info
doc: "Prints dataloader keyword arguments.\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: model
    type: string
    doc: Model name.
    inputBinding:
      position: 1
  - id: dataloader
    type:
      - 'null'
      - string
    doc: "Dataloader name. If not specified, the model's\n                       \
      \ defaultDataLoader will be used"
    inputBinding:
      position: 102
      prefix: --dataloader
  - id: dataloader_source
    type:
      - 'null'
      - string
    doc: Dataloader source
    inputBinding:
      position: 102
      prefix: --dataloader_source
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_info.out
