cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_count
label: fastafunk_count
doc: "Count sequences based on metadata groupings.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: group_column
    type:
      type: array
      items: string
    doc: Column(s) in the metadata file to define groupings
    inputBinding:
      position: 1
  - id: in_metadata
    type:
      type: array
      items: File
    doc: One or more CSV or TSV tables of metadata
    inputBinding:
      position: 2
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 103
      prefix: --log-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
stdout: fastafunk_count.out
