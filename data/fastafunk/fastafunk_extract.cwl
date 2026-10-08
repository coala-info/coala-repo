cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - extract
label: fastafunk_extract
doc: "Extracts sequences based on matches to the metadata/tree\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type: {type: array, items: File}
    doc: "One or more FASTA files of sequences (else reads from stdin)"
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type: ['null', {type: array, items: File}]
    doc: "One or more CSV or TSV tables of metadata"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: in_tree
    type: ['null', {type: array, items: File}]
    doc: "One or more tree files in either nexus or newick format"
    inputBinding:
      position: 101
      prefix: --in-tree
  - id: out_fasta_path
    type: ['null', string]
    doc: "A FASTA file (else writes to stdout)"
    inputBinding:
      position: 101
      prefix: --out-fasta
  - id: reject_fasta_path
    type: ['null', string]
    doc: "A FASTA file to write the omitted sequences"
    inputBinding:
      position: 101
      prefix: --reject-fasta
  - id: low_memory
    type: ['null', boolean]
    doc: "Extracts tip labels from trees using text wrangling instead of dendropy"
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
  - id: out_fasta
    type: ['null', File]
    doc: "A FASTA file (else writes to stdout)"
    outputBinding:
      glob: $(inputs.out_fasta_path)
  - id: reject_fasta
    type: ['null', File]
    doc: "A FASTA file to write the omitted sequences"
    outputBinding:
      glob: $(inputs.reject_fasta_path)
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_extract.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
