cwlVersion: v1.2
class: CommandLineTool
baseCommand: torchbiggraph_export_to_tsv
label: simba_pbg_torchbiggraph_export_to_tsv
doc: "Export the entity embeddings and relation type parameters of a trained PyTorch-BigGraph model to TSV files.\n\nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs:
  - id: config
    type: File
    doc: 'Path to config file (a Python file defining get_torchbiggraph_config)'
    inputBinding:
      position: 1
  - id: entities_output
    type: string
    doc: Output file for the entity embeddings (TSV)
    inputBinding:
      position: 2
      prefix: --entities-output
  - id: relation_types_output
    type: string
    doc: Output file for the relation type parameters (TSV)
    inputBinding:
      position: 2
      prefix: --relation-types-output
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
outputs:
  - id: entities_tsv
    type: File
    doc: Entity embeddings
    outputBinding:
      glob: $(inputs.entities_output)
  - id: relation_types_tsv
    type: File
    doc: Relation type parameters
    outputBinding:
      glob: $(inputs.relation_types_output)
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
stdout: simba_pbg_torchbiggraph_export_to_tsv.out
