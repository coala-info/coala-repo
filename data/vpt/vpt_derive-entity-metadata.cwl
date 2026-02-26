cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - derive-entity-metadata
label: vpt_derive-entity-metadata
doc: "Uses the segmentation boundaries to calculate the geometric attributes of each
  Entity. These attributes include the position, volume, and morphological features.\n\
  \nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_boundaries
    type: File
    doc: Path to a micron-space parquet boundary file.
    inputBinding:
      position: 101
      prefix: --input-boundaries
  - id: input_entity_by_gene
    type:
      - 'null'
      - File
    doc: Path to an existing entity by gene csv.
    inputBinding:
      position: 101
      prefix: --input-entity-by-gene
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set flag if you want to use non empty directory and agree that files 
      can be over-written.
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_metadata
    type: File
    doc: Path to the output csv file where the entity metadata will be stored.
    outputBinding:
      glob: $(inputs.output_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
