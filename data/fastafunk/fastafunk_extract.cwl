cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_extract
label: fastafunk_extract
doc: "Extracts sequences from FASTA files based on metadata and tree information.\n\
  \nTool homepage: https://github.com/cov-ert/fastafunk"
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
      - 'null'
      - type: array
        items: File
    doc: One or more CSV or TSV tables of metadata
    inputBinding:
      position: 2
  - id: in_tree
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more tree files in either nexus or newick format
    inputBinding:
      position: 3
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 104
      prefix: --log-file
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Extracts tip labels from trees using text wrangling instead of dendropy
    inputBinding:
      position: 104
      prefix: --low-memory
outputs:
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: A FASTA file (else writes to stdout)
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: reject_fasta
    type:
      - 'null'
      - File
    doc: A FASTA file to write the omitted sequences
    outputBinding:
      glob: $(inputs.reject_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
