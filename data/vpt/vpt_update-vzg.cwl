cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - update-vzg
label: vpt_update-vzg
doc: "Updates an existing .vzg file with new segmentation boundaries and the\ncorresponding
  expression matrix. NOTE: This functionality requires enough disk\nspace to unpack
  the existing .vzg file.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_boundaries
    type: File
    doc: Path to a micron-space parquet boundary file.
    inputBinding:
      position: 101
      prefix: --input-boundaries
  - id: input_entity_by_gene
    type: File
    doc: Path to the Entity by gene csv file.
    inputBinding:
      position: 101
      prefix: --input-entity-by-gene
  - id: input_entity_type
    type:
      - 'null'
      - string
    doc: "Entity type name for detections in input boundaries\nfile."
    inputBinding:
      position: 101
      prefix: --input-entity-type
  - id: input_metadata
    type:
      - 'null'
      - File
    doc: Path to an existing entity metadata file.
    inputBinding:
      position: 101
      prefix: --input-metadata
  - id: input_vzg
    type: File
    doc: Path to an existing vzg file.
    inputBinding:
      position: 101
      prefix: --input-vzg
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Set flag if you want to use non empty directory and\nagree that files can
      be over-written."
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: temp_path
    type:
      - 'null'
      - Directory
    doc: Path for temporary folder for unzipping vzg file.
    inputBinding:
      position: 101
      prefix: --temp-path
outputs:
  - id: output_vzg
    type: File
    doc: Path where the updated vzg should be saved.
    outputBinding:
      glob: $(inputs.output_vzg)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
