cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_printseq
label: cdskit_printseq
doc: "Print sequences from a sequence file.\n\nTool homepage: https://github.com/kfuku52/cdskit"
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
    doc: Name of the sequence to print. Regex is supported.
    default: ''
    inputBinding:
      position: 101
      prefix: --seqname
  - id: show_seqname
    type:
      - 'null'
      - string
    doc: Whether to show sequence name starting with ">". "no" prints sequences 
      only.
    default: yes
    inputBinding:
      position: 101
      prefix: --show_seqname
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
stdout: cdskit_printseq.out
