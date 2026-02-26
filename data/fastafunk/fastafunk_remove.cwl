cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_remove
label: fastafunk_remove
doc: "Removes sequences from FASTA files based on metadata.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type:
      type: array
      items: File
    doc: One or more FASTA files of sequences (else reads from stdin)
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
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: A FASTA file (else writes to stdout)
    outputBinding:
      glob: $(inputs.out_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
