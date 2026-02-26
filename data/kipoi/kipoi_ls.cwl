cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi ls
label: kipoi_ls
doc: "Lists available models\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: group_filter
    type:
      - 'null'
      - string
    doc: A relative path to the model group used to subset the model list. Use 
      'all' to show all models
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: Model source to use (default=kipoi). Specified in ~/.kipoi/config.yaml 
      under model_sources. When 'dir' is used, use the local directory path when
      specifying the model/dataloader.
    default: kipoi
    inputBinding:
      position: 102
      prefix: --source
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Print the output in the tsv format.
    inputBinding:
      position: 102
      prefix: --tsv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_ls.out
