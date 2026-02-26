cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_gapjust
label: cdskit_gapjust
doc: "Adjusts gap lengths in sequences.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: gap_just_max
    type:
      - 'null'
      - int
    doc: "Maximum gap length to be adjusted. Ns\n                        will be shortened
      if the gap length is equal to or\n                        smaller than this
      value."
    default: None
    inputBinding:
      position: 101
      prefix: --gap_just_max
  - id: gap_just_min
    type:
      - 'null'
      - int
    doc: "Minimum gap length to be adjusted. Ns\n                        will be extended
      if the gap length is equal to or\n                        greater than this
      value."
    default: None
    inputBinding:
      position: 101
      prefix: --gap_just_min
  - id: gap_len
    type:
      - 'null'
      - int
    doc: "Gap length. Ns will be added or removed\n                        to make
      the gap length fixed."
    default: 100
    inputBinding:
      position: 101
      prefix: --gap_len
  - id: ingff
    type:
      - 'null'
      - File
    doc: Input gff file.
    default: None
    inputBinding:
      position: 101
      prefix: --ingff
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
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --seqfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output sequence file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
  - id: outgff
    type:
      - 'null'
      - File
    doc: Output gff file.
    outputBinding:
      glob: $(inputs.outgff)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
