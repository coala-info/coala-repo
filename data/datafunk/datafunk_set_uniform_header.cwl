cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - set_uniform_header
label: datafunk_set_uniform_header
doc: "Set uniform headers for FASTA and metadata files.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: cog_uk
    type:
      - 'null'
      - boolean
    doc: Input data is from COG-UK
    inputBinding:
      position: 101
      prefix: --cog-uk
  - id: column_name
    type:
      - 'null'
      - string
    doc: "Name of column in metadata corresponding to fasta\n                    \
      \    header"
    inputBinding:
      position: 101
      prefix: --column-name
  - id: extended
    type:
      - 'null'
      - boolean
    doc: Longer fasta name
    inputBinding:
      position: 101
      prefix: --extended
  - id: gisaid
    type:
      - 'null'
      - boolean
    doc: Input data is from GISAID
    inputBinding:
      position: 101
      prefix: --gisaid
  - id: index_column
    type:
      - 'null'
      - string
    doc: "Name of column in metadata to parse for string\n                       \
      \ matching with fasta header"
    inputBinding:
      position: 101
      prefix: --index-column
  - id: input_fasta
    type: File
    doc: Input FASTA
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: input_metadata
    type: File
    doc: Input CSV or TSV
    inputBinding:
      position: 101
      prefix: --input-metadata
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout)
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: output_fasta
    type: File
    doc: Input FASTA
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_metadata
    type: File
    doc: Input CSV or TSV
    outputBinding:
      glob: $(inputs.output_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
