cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - merge
label: fastafunk_merge
doc: "Merges two fasta files avoiding duplicates based on matches to metadata (takes the one in the first file)\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type: ['null', {type: array, items: File}]
    doc: "One or more FASTA files of sequences (else reads from stdin)"
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type: {type: array, items: File}
    doc: "One or more CSV or TSV tables of metadata"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type: string
    doc: "Column in the metadata file to use to match to the sequence"
    inputBinding:
      position: 101
      prefix: --index-column
  - id: out_metadata_path
    type: string
    doc: "A CSV file (else writes to stdout)"
    inputBinding:
      position: 101
      prefix: --out-metadata
  - id: out_fasta_path
    type: ['null', string]
    doc: "A FASTA file (else writes to stdout)"
    inputBinding:
      position: 101
      prefix: --out-fasta
  - id: low_memory
    type: ['null', boolean]
    doc: "Assumes no duplicate sequences within a FASTA so can use SeqIO index"
    inputBinding:
      position: 101
      prefix: --low-memory
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
  - id: out_metadata
    type: File
    doc: "A CSV file (else writes to stdout)"
    outputBinding:
      glob: $(inputs.out_metadata_path)
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
stdout: fastafunk_merge.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
