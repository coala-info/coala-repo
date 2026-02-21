cwlVersion: v1.2
class: CommandLineTool
baseCommand: ococo
label: ococo
doc: "OCOCO is a program for online consensus calling from genomic alignments (SAM/BAM/CRAM).
  It uses a fast, memory-efficient algorithm to update consensus sequences as new
  data arrives.\n\nTool homepage: http://github.com/karel-brinda/ococo"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input SAM/BAM/CRAM file
    default: '-'
    inputBinding:
      position: 101
      prefix: -i
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: minimum base quality
    default: 20
    inputBinding:
      position: 101
      prefix: -Q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 20
    inputBinding:
      position: 101
      prefix: -q
  - id: mode
    type:
      - 'null'
      - string
    doc: consensus mode (majority/stochastic/gapless)
    default: majority
    inputBinding:
      position: 101
      prefix: -m
  - id: reference
    type:
      - 'null'
      - File
    doc: reference FASTA file
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ococo:0.1.2.7--h077b44d_10
