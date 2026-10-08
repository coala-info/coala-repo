cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - fetch
label: fastafunk_fetch
doc: "Fetches sequences within fasta files which have a corresponding metadata entry, keeping the last where there are duplicates\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type: ['null', {type: array, items: File}]
    doc: "One or more FASTA files of sequences (else reads from stdin)"
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type: File
    doc: "CSV or TSV of metadata with same naming convention as fasta file"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type: string
    doc: "Column in the metadata file to use to match to the sequence"
    inputBinding:
      position: 101
      prefix: --index-column
  - id: filter_column
    type: ['null', {type: array, items: string}]
    doc: "Metadata column name(s) to keep"
    inputBinding:
      position: 101
      prefix: --filter-column
  - id: where_column
    type: ['null', {type: array, items: string}]
    doc: "Additional matches to columns e.g. if want to rename, as <column>=<regex>"
    inputBinding:
      position: 101
      prefix: --where-column
  - id: restrict
    type: ['null', boolean]
    doc: "Only outputs metadata rows with a corresponding fasta entry"
    inputBinding:
      position: 101
      prefix: --restrict
  - id: keep_omit_rows
    type: ['null', boolean]
    doc: "Allows rows with with metadata saying omit to be kept"
    inputBinding:
      position: 101
      prefix: --keep-omit-rows
  - id: low_memory
    type: ['null', boolean]
    doc: "Assumes no duplicate sequences within a FASTA so can use SeqIO index"
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: out_fasta_path
    type: ['null', string]
    doc: "A FASTA file (else writes to stdout)"
    inputBinding:
      position: 101
      prefix: --out-fasta
  - id: out_metadata_path
    type: ['null', string]
    doc: "A metadata file"
    inputBinding:
      position: 101
      prefix: --out-metadata
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
  - id: out_metadata
    type: ['null', File]
    doc: "A metadata file"
    outputBinding:
      glob: $(inputs.out_metadata_path)
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_fetch.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
