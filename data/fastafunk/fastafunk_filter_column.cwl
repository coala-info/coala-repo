cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk filter_column
label: fastafunk_filter_column
doc: "Filter metadata based on a column's value.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: column
    type: string
    doc: Column in the metadata to filter on
    inputBinding:
      position: 101
      prefix: --column
  - id: in_metadata
    type: File
    doc: ONE table of metadata
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: is_false
    type:
      - 'null'
      - boolean
    doc: filter if column is false
    inputBinding:
      position: 101
      prefix: --is_false
  - id: is_true
    type:
      - 'null'
      - boolean
    doc: filter if column is true
    inputBinding:
      position: 101
      prefix: --is_true
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
outputs:
  - id: out_metadata
    type: File
    doc: A metadata file to write
    outputBinding:
      glob: $(inputs.out_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
