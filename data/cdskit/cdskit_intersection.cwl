cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit intersection
label: cdskit_intersection
doc: "Performs intersection operations on CDS sequences.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: fix_outrange_gff_records
    type:
      - 'null'
      - string
    doc: Fix gff records that have coordinates out of the sequence range.
    default: yes
    inputBinding:
      position: 101
      prefix: --fix_outrange_gff_records
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
  - id: inseqformat2
    type:
      - 'null'
      - string
    doc: Input sequence format for --seqfile2.
    default: fasta
    inputBinding:
      position: 101
      prefix: --inseqformat2
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
  - id: outseqformat2
    type:
      - 'null'
      - string
    doc: Output sequence format for --outfile2.
    default: fasta
    inputBinding:
      position: 101
      prefix: --outseqformat2
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --seqfile
  - id: seqfile2
    type:
      - 'null'
      - File
    doc: Input sequence file 2.
    default: None
    inputBinding:
      position: 101
      prefix: --seqfile2
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
  - id: outfile2
    type:
      - 'null'
      - File
    doc: Output sequence file 2.
    outputBinding:
      glob: $(inputs.outfile2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
