cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit label
label: cdskit_label
doc: "Label sequences in a file.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: clip_len
    type:
      - 'null'
      - int
    doc: Maximum length of sequence labels. Longer labels are truncated.
    default: 0
    inputBinding:
      position: 101
      prefix: --clip_len
  - id: inseqformat
    type:
      - 'null'
      - string
    doc: "Input sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    default: fasta
    inputBinding:
      position: 101
      prefix: --inseqformat
  - id: outseqformat
    type:
      - 'null'
      - string
    doc: "Output sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    default: fasta
    inputBinding:
      position: 101
      prefix: --outseqformat
  - id: replace_chars
    type:
      - 'null'
      - string
    doc: Replace sequence label characters. For example, "!@#$%^&*+=/?<>|--_" 
      replaces various characters with underbar ("_").
    default: ''
    inputBinding:
      position: 101
      prefix: --replace_chars
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --seqfile
  - id: unique
    type:
      - 'null'
      - string
    doc: Make sequence labels unique by adding suffix (_1, _2, ...).
    default: no
    inputBinding:
      position: 101
      prefix: --unique
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output sequence file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
