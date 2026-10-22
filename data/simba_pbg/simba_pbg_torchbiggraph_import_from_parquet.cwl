cwlVersion: v1.2
class: CommandLineTool
baseCommand: torchbiggraph_import_from_parquet
label: simba_pbg_torchbiggraph_import_from_parquet
doc: "Import Parquet edge lists into the partitioned format used by PyTorch-BigGraph (entity counts, entity names and edge files).\n\nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs:
  - id: config
    type: File
    doc: 'Path to config file (a Python file defining get_torchbiggraph_config)'
    inputBinding:
      position: 1
  - id: edge_paths
    type:
      type: array
      items: File
    doc: Input file paths
    inputBinding:
      position: 2
  - id: lhs_col
    type: int
    doc: 'Column index for source entity'
    inputBinding:
      position: 3
      prefix: --lhs-col
  - id: rhs_col
    type: int
    doc: 'Column index for target entity'
    inputBinding:
      position: 3
      prefix: --rhs-col
  - id: rel_col
    type:
      - 'null'
      - int
    doc: 'Column index for relation entity'
    inputBinding:
      position: 3
      prefix: --rel-col
  - id: weight_col
    type:
      - 'null'
      - int
    doc: '(Optional) Column index for edge weight'
    inputBinding:
      position: 3
      prefix: --weight-col
  - id: relation_type_min_count
    type:
      - 'null'
      - int
    doc: 'Min count for relation types'
    inputBinding:
      position: 3
      prefix: --relation-type-min-count
  - id: entity_min_count
    type:
      - 'null'
      - int
    doc: 'Min count for entities'
    inputBinding:
      position: 3
      prefix: --entity-min-count
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba:1.2--pyh7cba7a3_0
stdout: simba_pbg_torchbiggraph_import_from_parquet.out
