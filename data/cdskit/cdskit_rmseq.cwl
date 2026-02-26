cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cdskit
  - rmseq
label: cdskit_rmseq
doc: "Remove sequences based on name or problematic characters.\n\nTool homepage:
  https://github.com/kfuku52/cdskit"
inputs:
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
  - id: problematic_char
    type:
      - 'null'
      - string
    doc: Problematic characters considered by --problematic_percent. Without 
      separator.
    default: NX-?
    inputBinding:
      position: 101
      prefix: --problematic_char
  - id: problematic_percent
    type:
      - 'null'
      - float
    doc: Sequences containing >= this percentage of --problematic_char are 
      removed.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --problematic_percent
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --seqfile
  - id: seqname
    type:
      - 'null'
      - string
    doc: Names of sequences to remove. Regex is supported.
    default: ''
    inputBinding:
      position: 101
      prefix: --seqname
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
