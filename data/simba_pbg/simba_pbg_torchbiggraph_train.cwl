cwlVersion: v1.2
class: CommandLineTool
baseCommand: torchbiggraph_train
label: simba_pbg_torchbiggraph_train
doc: "Train a graph embedding model with PyTorch-BigGraph. The result is a checkpoint directory with the embeddings.\n\nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs:
  - id: config
    type: File
    doc: 'Path to config file (a Python file defining get_torchbiggraph_config)'
    inputBinding:
      position: 1
  - id: rank
    type:
      - 'null'
      - int
    doc: "For multi-machine, this machine's rank"
    inputBinding:
      position: 2
      prefix: --rank
  - id: data_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Input directories (for example the entity and edge data from the import step). They are staged under their own names, so relative paths in the config file resolve.
  - id: param
    type:
      - 'null'
      - type: array
        items: string
    doc: Config parameter overrides, each as name=value. They replace the values set in the config file.
    inputBinding:
      position: 90
      prefix: --param
  - id: output_directories
    type:
      type: array
      items: string
    doc: Names of the directories the tool writes, as set in the config file (for example entity_path, edge_paths or checkpoint_path).
outputs:
  - id: results
    type:
      type: array
      items: Directory
    doc: Directories written by the tool
    outputBinding:
      glob: $(inputs.output_directories)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.data_directories)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba:1.2--pyh7cba7a3_0
stdout: simba_pbg_torchbiggraph_train.out
