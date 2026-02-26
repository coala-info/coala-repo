cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_merge
label: fastafunk_merge
doc: "Merge FASTA files and associated metadata.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_metadata
    type:
      type: array
      items: File
    doc: One or more CSV or TSV tables of metadata
    inputBinding:
      position: 1
  - id: index_column
    type: string
    doc: Column in the metadata file to use to match to the sequence
    inputBinding:
      position: 2
  - id: in_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more FASTA files of sequences (else reads from stdin)
    inputBinding:
      position: 103
      prefix: --in-fasta
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 103
      prefix: --log-file
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Assumes no duplicate sequences within a FASTA so can use SeqIO index
    inputBinding:
      position: 103
      prefix: --low-memory
outputs:
  - id: out_metadata
    type: File
    doc: A CSV file (else writes to stdout)
    outputBinding:
      glob: '*.out'
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
