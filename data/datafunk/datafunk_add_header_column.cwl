cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - add_header_column
label: datafunk_add_header_column
doc: "Add header column to metadata table corresponding to fasta record ids\n\nTool
  homepage: https://github.com/cov-ert/datafunk"
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
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of columns in metadata to parse for string\n                      \
      \  matching with fasta header"
    inputBinding:
      position: 101
      prefix: --columns
  - id: gisaid
    type:
      - 'null'
      - boolean
    doc: Input data is from GISAID
    inputBinding:
      position: 101
      prefix: --gisaid
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
  - id: output_metadata
    type: File
    doc: Output CSV
    outputBinding:
      glob: $(inputs.output_metadata)
  - id: output_fasta
    type: File
    doc: Output FASTA
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
