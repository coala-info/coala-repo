cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - convert-geometry
label: vpt_convert-geometry
doc: "Converts entity boundaries produced by a different tool into a vpt compatible
  parquet file. In the process, each of the input entities is checked for geometric
  validity, overlap with other geometries, and assigned a globally-unique EntityID
  to facilitate other processing steps.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: convert_to_3d
    type:
      - 'null'
      - boolean
    doc: Pass if segmentation should be converted from 2D to 3D by replication. 
      Only possible for geojson and parquet input formats.
    inputBinding:
      position: 101
      prefix: --convert-to-3d
  - id: entity_fusion_strategy
    type:
      - 'null'
      - string
    doc: 'String with entity fusion strategy name. One from list: harmonize, union,
      larger.'
    default: harmonize
    inputBinding:
      position: 101
      prefix: --entity-fusion-strategy
  - id: id_mapping_file
    type:
      - 'null'
      - File
    doc: Path to csv file where map from source segmentation entity id to 
      EntityID in result will be saved.
    inputBinding:
      position: 101
      prefix: --id-mapping-file
  - id: input_boundaries
    type: string
    doc: Regular expression that matches all input segmentation files (geojson 
      or hdf5) that will be processed.
    inputBinding:
      position: 101
      prefix: --input-boundaries
  - id: input_micron_to_mosaic
    type:
      - 'null'
      - File
    doc: Path to the transformation matrix.
    inputBinding:
      position: 101
      prefix: --input-micron-to-mosaic
  - id: max_row_group_size
    type:
      - 'null'
      - int
    doc: Maximum number of rows in row groups inside output parquet files. 
      Cannot be less than 1000
    inputBinding:
      position: 101
      prefix: --max-row-group-size
  - id: number_z_planes
    type:
      - 'null'
      - int
    doc: The number of z planes that should be produced during the conversion 
      from 2D to 3D. Should be specified only if the "--convert-to-3D" argument 
      is passed
    inputBinding:
      position: 101
      prefix: --number-z-planes
  - id: output_entity_type
    type:
      - 'null'
      - string
    doc: 'String with entity type name. For example: cell, nuclei.'
    default: cell
    inputBinding:
      position: 101
      prefix: --output-entity-type
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set flag if you want to use non empty directory and agree that files 
      can be over-written.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: spacing_z_planes
    type:
      - 'null'
      - float
    doc: Step size between z-planes, assuming that z-index 0 is 1 “step” above 
      zero. Should be specified only if the "--convert-to-3D" argument is passed
    inputBinding:
      position: 101
      prefix: --spacing-z-planes
outputs:
  - id: output_boundaries
    type: File
    doc: The path to the parquet file where segmentation compatible with vpt 
      will be saved.
    outputBinding:
      glob: $(inputs.output_boundaries)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
