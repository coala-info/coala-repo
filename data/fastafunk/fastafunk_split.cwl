cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_split
label: fastafunk_split
doc: "Split a FASTA file into multiple FASTA files based on metadata.\n\nTool homepage:
  https://github.com/cov-ert/fastafunk"
inputs:
  - id: aliases
    type:
      - 'null'
      - string
    doc: JSON with aliases for lettered lineages.
    inputBinding:
      position: 101
      prefix: --aliases
  - id: in_fasta
    type: File
    doc: One FASTA files of sequences (else reads from stdin)
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type: File
    doc: One CSV of metadata
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type:
      - 'null'
      - string
    doc: Column(s) in the metadata file to use to match to the sequence
    inputBinding:
      position: 101
      prefix: --index-column
  - id: index_field
    type:
      - 'null'
      - string
    doc: Field(s) in the fasta header to match the metadata (else matches column
      names)
    inputBinding:
      position: 101
      prefix: --index-field
  - id: lineage
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific list of lineages to split by with others collpasing to nearest
      lineage.
    inputBinding:
      position: 101
      prefix: --lineage
  - id: lineage_csv
    type:
      - 'null'
      - File
    doc: CSV with lineage and outgroup columns defining the lineages to split 
      by.
    inputBinding:
      position: 101
      prefix: --lineage-csv
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: A directory for output FASTA files
    inputBinding:
      position: 101
      prefix: --out-folder
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
stdout: fastafunk_split.out
