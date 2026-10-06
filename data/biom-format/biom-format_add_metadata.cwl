cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - add-metadata
label: biom-format_add_metadata
doc: "Add sample and/or observation metadata to BIOM-formatted files.\n\nTool homepage: http://www.biom-format.org"
inputs:
  - id: input_fp
    type: File
    doc: The input BIOM table
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: output_fp
    type: string
    doc: The output BIOM table
    inputBinding:
      position: 101
      prefix: --output-fp
  - id: sample_metadata_fp
    type:
      - 'null'
      - File
    doc: The sample metadata mapping file (will add sample metadata to the input BIOM table,
      if provided).
    inputBinding:
      position: 101
      prefix: --sample-metadata-fp
  - id: observation_metadata_fp
    type:
      - 'null'
      - File
    doc: The observation metadata mapping file (will add observation metadata to the input
      BIOM table, if provided).
    inputBinding:
      position: 101
      prefix: --observation-metadata-fp
  - id: sc_separated
    type:
      - 'null'
      - string
    doc: Comma-separated list of the metadata fields to split on semicolons.
    inputBinding:
      position: 101
      prefix: --sc-separated
  - id: sc_pipe_separated
    type:
      - 'null'
      - string
    doc: Comma-separated list of the metadata fields to split on semicolons and pipes ("|").
    inputBinding:
      position: 101
      prefix: --sc-pipe-separated
  - id: int_fields
    type:
      - 'null'
      - string
    doc: Comma-separated list of the metadata fields to cast to integers.
    inputBinding:
      position: 101
      prefix: --int-fields
  - id: float_fields
    type:
      - 'null'
      - string
    doc: Comma-separated list of the metadata fields to cast to floating point numbers.
    inputBinding:
      position: 101
      prefix: --float-fields
  - id: sample_header
    type:
      - 'null'
      - string
    doc: Comma-separated list of the sample metadata field names.
    inputBinding:
      position: 101
      prefix: --sample-header
  - id: observation_header
    type:
      - 'null'
      - string
    doc: Comma-separated list of the observation metadata field names.
    inputBinding:
      position: 101
      prefix: --observation-header
  - id: output_as_json
    type:
      - 'null'
      - boolean
    doc: Write the output file in JSON format.
    inputBinding:
      position: 101
      prefix: --output-as-json
outputs:
  - id: output_table
    type: File
    doc: The output BIOM table
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
