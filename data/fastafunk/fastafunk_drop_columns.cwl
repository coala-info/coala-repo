cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk drop_columns
label: fastafunk_drop_columns
doc: "Drop columns from a metadata table.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Column(s) in the metadata to drop
    inputBinding:
      position: 101
      prefix: --columns
  - id: in_metadata
    type: File
    doc: ONE CSV table of metadata
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_metadata
    type: File
    doc: A metadata file to write
    outputBinding:
      glob: $(inputs.out_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
