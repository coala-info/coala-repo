cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - add_columns
label: fastafunk_add_columns
doc: "Add columns from one CSV table to another based on matching columns.\n\nTool
  homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite even if new data is blank/None
    inputBinding:
      position: 101
      prefix: --force-overwrite
  - id: in_data
    type: File
    doc: One CSV table of additional data. Must have --index-column in common 
      with metadata
    inputBinding:
      position: 101
      prefix: --in-data
  - id: in_metadata
    type: File
    doc: ONE CSV table of metadata
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type: string
    doc: Column in the metadata files used to match rows
    inputBinding:
      position: 101
      prefix: --index-column
  - id: join_on
    type: string
    doc: Column in the data file used to match rows
    inputBinding:
      position: 101
      prefix: --join-on
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
  - id: new_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Column(s) in the in_data file to add to the metadata, if not provided, 
      all columns added
    inputBinding:
      position: 101
      prefix: --new-columns
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: where_column
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional matches to columns e.g. if want to rename
    inputBinding:
      position: 101
      prefix: --where-column
outputs:
  - id: out_metadata
    type: File
    doc: A metadata file to write
    outputBinding:
      glob: $(inputs.out_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
