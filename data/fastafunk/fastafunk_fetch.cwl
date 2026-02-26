cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_fetch
label: fastafunk_fetch
doc: "Fetches sequences and metadata based on specified criteria.\n\nTool homepage:
  https://github.com/cov-ert/fastafunk"
inputs:
  - id: filter_column
    type:
      - 'null'
      - type: array
        items: string
    doc: Metadata column name(s) to keep
    inputBinding:
      position: 101
      prefix: --filter-column
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
    type: File
    doc: CSV or TSV of metadata with same naming convention as fasta file
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type: string
    doc: Column in the metadata file to use to match to the sequence
    inputBinding:
      position: 101
      prefix: --index-column
  - id: keep_omit_rows
    type:
      - 'null'
      - boolean
    doc: Allows rows with with metadata saying omit to be kept
    inputBinding:
      position: 101
      prefix: --keep-omit-rows
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Assumes no duplicate sequences within a FASTA so can use SeqIO index
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: restrict
    type:
      - 'null'
      - boolean
    doc: Only outputs metadata rows with a corresponding fasta entry
    inputBinding:
      position: 101
      prefix: --restrict
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
