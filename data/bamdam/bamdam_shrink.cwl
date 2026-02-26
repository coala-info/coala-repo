cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdam shrink
label: bamdam_shrink
doc: "Shrinks an LCA file and its corresponding BAM file by filtering nodes and alignments.\n\
  \nTool homepage: https://github.com/bdesanctis/bamdam"
inputs:
  - id: annotate_pmd
    type:
      - 'null'
      - boolean
    doc: 'Annotate output bam file with PMD tags (default: not set)'
    inputBinding:
      position: 101
      prefix: --annotate_pmd
  - id: dust_max
    type:
      - 'null'
      - int
    doc: 'Maximum DUST score threshold to keep a read (default: not set)'
    default: not set
    inputBinding:
      position: 101
      prefix: --dust_max
  - id: exclude_tax
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Numeric tax ID(s) to exclude when filtering (default: none)'
    default: none
    inputBinding:
      position: 101
      prefix: --exclude_tax
  - id: exclude_tax_file
    type:
      - 'null'
      - File
    doc: 'File of numeric tax ID(s) to exclude when filtering, one per line (default:
      none)'
    default: none
    inputBinding:
      position: 101
      prefix: --exclude_tax_file
  - id: in_bam
    type: File
    doc: Path to the input (read-sorted) BAM file (required)
    inputBinding:
      position: 101
      prefix: --in_bam
  - id: in_lca
    type: File
    doc: Path to the input LCA file (required)
    inputBinding:
      position: 101
      prefix: --in_lca
  - id: mincount
    type:
      - 'null'
      - int
    doc: 'Minimum read count to keep a node (default: 5)'
    default: 5
    inputBinding:
      position: 101
      prefix: --mincount
  - id: minsim
    type:
      - 'null'
      - float
    doc: 'Minimum similarity to reference to keep an alignment (default: 0.9)'
    default: 0.9
    inputBinding:
      position: 101
      prefix: --minsim
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: 'Print a progress bar (default: not set)'
    inputBinding:
      position: 101
      prefix: --show_progress
  - id: stranded
    type: string
    doc: Either ss for single stranded or ds for double stranded (required)
    inputBinding:
      position: 101
      prefix: --stranded
  - id: upto
    type:
      - 'null'
      - string
    doc: 'Keep nodes up to and including this tax threshold (default: family)'
    default: family
    inputBinding:
      position: 101
      prefix: --upto
outputs:
  - id: out_lca
    type: File
    doc: Path to the short output LCA file (required)
    outputBinding:
      glob: $(inputs.out_lca)
  - id: out_bam
    type: File
    doc: Path to the short output BAM file (required)
    outputBinding:
      glob: $(inputs.out_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
