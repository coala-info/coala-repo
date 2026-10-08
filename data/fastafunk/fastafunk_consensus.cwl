cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - consensus
label: fastafunk_consensus
doc: "Collapses sequences into consensus sequences based on grouping by index column or index field\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type: ['null', File]
    doc: "One FASTA files of sequences (else reads from stdin)"
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type: File
    doc: "CSV of metadata with same naming convention as fasta file"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_field
    type: string
    doc: "Field(s) in the fasta header to match the metadata (else matches column names)"
    inputBinding:
      position: 101
      prefix: --index-field
  - id: index_column
    type: ['null', string]
    doc: "Column(s) in the metadata file to use to match to the sequence"
    inputBinding:
      position: 101
      prefix: --index-column
  - id: lineage
    type: ['null', {type: array, items: string}]
    doc: "Specific list of lineages to split by with others collpasing to nearest lineage."
    inputBinding:
      position: 101
      prefix: --lineage
  - id: out_fasta_path
    type: ['null', string]
    doc: "A FASTA file (else writes to stdout)"
    inputBinding:
      position: 101
      prefix: --out-fasta
  - id: log_file_path
    type: ['null', string]
    doc: "Log file to use (otherwise uses stdout, or stderr if out-fasta to stdout)"
    inputBinding:
      position: 101
      prefix: --log-file
  - id: verbose
    type: ['null', boolean]
    doc: "Run with high verbosity (debug level logging)"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout_output
    type: stdout
    doc: Standard output (FASTA or table when no output file is given, and log messages).
  - id: out_fasta
    type: ['null', File]
    doc: "A FASTA file (else writes to stdout)"
    outputBinding:
      glob: $(inputs.out_fasta_path)
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_consensus.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
