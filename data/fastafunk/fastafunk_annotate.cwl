cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_annotate
label: fastafunk_annotate
doc: "Annotates FASTA sequences with metadata based on matching IDs.\n\nTool homepage:
  https://github.com/cov-ert/fastafunk"
inputs:
  - id: index_column
    type: string
    doc: Column in the metadata file to use to match to the sequence
    inputBinding:
      position: 1
  - id: add_cov_id
    type:
      - 'null'
      - boolean
    doc: Parses header for COG or GISAID unique id and stores
    inputBinding:
      position: 102
      prefix: --add-cov-id
  - id: header_delimiter
    type:
      - 'null'
      - string
    doc: Header delimiter
    inputBinding:
      position: 102
      prefix: --header-delimiter
  - id: in_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more FASTA files of sequences (else reads from stdin)
    inputBinding:
      position: 102
      prefix: --in-fasta
  - id: in_metadata
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more CSV or TSV tables of metadata
    inputBinding:
      position: 102
      prefix: --in-metadata
  - id: index_field
    type:
      - 'null'
      - type: array
        items: string
    doc: Field(s) in the fasta header to match the metadata (else matches column
      names)
    inputBinding:
      position: 102
      prefix: --index-field
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 102
      prefix: --log-file
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Assumes no duplicate sequences within a FASTA so can use SeqIO index
    inputBinding:
      position: 102
      prefix: --low-memory
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
