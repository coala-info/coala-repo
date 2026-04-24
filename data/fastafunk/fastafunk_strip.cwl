cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk_strip
label: fastafunk_strip
doc: "Strip sequences from FASTA files.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: ambiguity
    type:
      - 'null'
      - boolean
    doc: Remove ambiguous sites from sequences ("N")
    inputBinding:
      position: 101
      prefix: --ambiguity
  - id: back
    type:
      - 'null'
      - boolean
    doc: Remove only from the back of the sequence
    inputBinding:
      position: 101
      prefix: --back
  - id: front
    type:
      - 'null'
      - boolean
    doc: Remove only from the front of the sequence
    inputBinding:
      position: 101
      prefix: --front
  - id: gap
    type:
      - 'null'
      - boolean
    doc: Remove gaps from sequences
    inputBinding:
      position: 101
      prefix: --gap
  - id: in_fasta
    type:
      type: array
      items: File
    doc: One or more FASTA files of sequences (else reads from stdin)
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: keep_alignment
    type:
      - 'null'
      - boolean
    doc: Remove gaps shared by all sequences at the same site
    inputBinding:
      position: 101
      prefix: --keep-alignment
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
  - id: missing
    type:
      - 'null'
      - boolean
    doc: Remove missing sites from sequences ("?")
    inputBinding:
      position: 101
      prefix: --missing
outputs:
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
