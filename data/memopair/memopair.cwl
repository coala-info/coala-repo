cwlVersion: v1.2
class: CommandLineTool
baseCommand: memopair
label: memopair
doc: "Methylation Motif Pairs\n\nTool homepage: https://github.com/SorenHeidelbach/memopair"
inputs:
  - id: reference
    type: File
    doc: File path to the fasta file with references
    inputBinding:
      position: 1
  - id: pileup
    type: File
    doc: File path to the pileup file with methylation data
    inputBinding:
      position: 2
  - id: motifs
    type:
      - 'null'
      - type: array
        items: string
    doc: "Comeplement motif pairs in the format: 'MOTIF_TYPE1_POS1_TYPE2_POS2', e.g.
      'ACGT_a_0_m_3' or 'CCWGG_4mC_0_5mC_3'"
    inputBinding:
      position: 3
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of contigs to load and process at once
    default: 100
    inputBinding:
      position: 104
      prefix: --batch-size
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage required to consider a position
    default: 5
    inputBinding:
      position: 104
      prefix: --min-cov
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 5
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Verbosity level
    default: normal
    inputBinding:
      position: 104
      prefix: --verbosity
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memopair:0.1.6--h4349ce8_0
