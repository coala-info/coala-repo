cwlVersion: v1.2
class: CommandLineTool
baseCommand: kc-align
label: kcalign_kc-align
doc: "Align a sequence against multiple others in a codon-aware fashion.\n\nTool homepage:
  https://github.com/davebx/kc-align"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress identical sequences
    inputBinding:
      position: 101
      prefix: --compress
  - id: dist
    type:
      - 'null'
      - string
    doc: 'For genome/mixed mode, determines the max distance a homologous sequence
      can be before it is discarded from the alignment (default = none). Distance
      limits: none < very-close < close < semi-close < less-close'
    default: none
    inputBinding:
      position: 101
      prefix: --dist
  - id: end
    type:
      - 'null'
      - int
    doc: 1-based end position (required in genome mode)
    inputBinding:
      position: 101
      prefix: --end
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep translated pre-alignment sequences file named pre_align.fasta, 
      otherwise will delete
    inputBinding:
      position: 101
      prefix: --keep
  - id: mode
    type: string
    doc: Alignment mode (genome, gene, or mixed) (required)
    inputBinding:
      position: 101
      prefix: --mode
  - id: reference
    type: string
    doc: Reference sequence
    inputBinding:
      position: 101
      prefix: --reference
  - id: sequences
    type: string
    doc: Other sequences to align
    inputBinding:
      position: 101
      prefix: --sequences
  - id: start
    type:
      - 'null'
      - int
    doc: 1-based start position (required in genome mode)
    inputBinding:
      position: 101
      prefix: --start
  - id: table
    type:
      - 'null'
      - string
    doc: Choose alternative translation table (See 
      https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi for values)
    inputBinding:
      position: 101
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of simultaneous threads to use (must be a multiple of 3)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcalign:1.0.2--py_0
stdout: kcalign_kc-align.out
