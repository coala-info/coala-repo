cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - strip
label: fastafunk_strip
doc: "Strip sites based on various options\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type: {type: array, items: File}
    doc: "One or more FASTA files of sequences (else reads from stdin)"
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: gap
    type: ['null', boolean]
    doc: "Remove gaps from sequences (Default:False)"
    inputBinding:
      position: 101
      prefix: --gap
  - id: ambiguity
    type: ['null', boolean]
    doc: "Remove ambiguous sites from sequences (\"N\") (Default:False)"
    inputBinding:
      position: 101
      prefix: --ambiguity
  - id: missing
    type: ['null', boolean]
    doc: "Remove missing sites from sequences (\"?\") (Default:False)"
    inputBinding:
      position: 101
      prefix: --missing
  - id: keep_alignment
    type: ['null', boolean]
    doc: "Remove gaps shared by all sequences at the same site (Default:False)"
    inputBinding:
      position: 101
      prefix: --keep-alignment
  - id: front
    type: ['null', boolean]
    doc: "Remove only from the front of the sequence (Default:False)"
    inputBinding:
      position: 101
      prefix: --front
  - id: back
    type: ['null', boolean]
    doc: "Remove only from the back of the sequence (Default:False)"
    inputBinding:
      position: 101
      prefix: --back
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
stdout: fastafunk_strip.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
