cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_new
label: fastafunk_new
doc: "Create a new FASTA file and metadata table by filtering and merging input files.\n\
  \nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: date_column
    type: string
    doc: Column in the metadata file containing date values to use for filtering
    inputBinding:
      position: 101
      prefix: --date-column
  - id: in_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more FASTA files of sequences (else reads from stdin)
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type:
      type: array
      items: File
    doc: One or more CSV or TSV tables of metadata
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type: string
    doc: Column in the metadata file to use to match to the sequence
    inputBinding:
      position: 101
      prefix: --index-column
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
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: A FASTA file (else writes to stdout)
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: out_metadata
    type:
      - 'null'
      - File
    doc: A metadata file
    outputBinding:
      glob: $(inputs.out_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
