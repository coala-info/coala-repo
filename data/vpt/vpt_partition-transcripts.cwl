cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - partition-transcripts
label: vpt_partition-transcripts
doc: "Uses the segmentation boundaries to determine which Entity, if any, contains
  each detected transcript. Outputs an Entity by gene matrix, and may optionally output
  a detected transcript csv with an additional column indicating the containing Entity.\n\
  \nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of transcript file lines to be loaded in memory at once.
    default: 10000000
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: input_boundaries
    type: File
    doc: Path to a micron-space parquet boundary file.
    inputBinding:
      position: 101
      prefix: --input-boundaries
  - id: input_transcripts
    type: File
    doc: Path to an existing transcripts csv or parquet file.
    inputBinding:
      position: 101
      prefix: --input-transcripts
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
  - id: output_entity_by_gene
    type: File
    doc: Path to output the Entity by gene matrix csv file.
    outputBinding:
      glob: $(inputs.output_entity_by_gene)
  - id: output_transcripts
    type:
      - 'null'
      - File
    doc: If a filename is provided, a copy of the detected transcripts file will
      be written with an additional column with the EntityID of the cell or 
      other Entity that contains each transcript (or -1 if the transcript is not
      contained by any Entity).
    outputBinding:
      glob: $(inputs.output_transcripts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
