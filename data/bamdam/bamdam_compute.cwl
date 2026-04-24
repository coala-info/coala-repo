cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdam_compute
label: bamdam_compute
doc: "Compute statistics from BAM and LCA files.\n\nTool homepage: https://github.com/bdesanctis/bamdam"
inputs:
  - id: in_bam
    type: File
    doc: Path to the BAM file (required)
    inputBinding:
      position: 101
      prefix: --in_bam
  - id: in_lca
    type: File
    doc: Path to the LCA file (required)
    inputBinding:
      position: 101
      prefix: --in_lca
  - id: k
    type:
      - 'null'
      - int
    doc: 'Value of k for per-node counts of unique k-mers and duplicity (default:
      29)'
    inputBinding:
      position: 101
      prefix: --k
  - id: mode
    type:
      - 'null'
      - int
    doc: 'Mode to calculate stats. 1: use best alignment (recommended), 2: average
      over reads, 3: average over alignments (default: 1)'
    inputBinding:
      position: 101
      prefix: --mode
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
  - id: udg
    type:
      - 'null'
      - boolean
    doc: 'Split CpG and non CpG sites. Intended for UDG-treated library damage analysis.
      (default: not set)'
    inputBinding:
      position: 101
      prefix: --udg
  - id: upto
    type:
      - 'null'
      - string
    doc: 'Keep nodes up to and including this tax threshold; use root to disable (default:
      family)'
    inputBinding:
      position: 101
      prefix: --upto
outputs:
  - id: out_tsv
    type: File
    doc: Path to the output tsv file (required)
    outputBinding:
      glob: $(inputs.out_tsv)
  - id: out_subs
    type: File
    doc: Path to the output subs file (required)
    outputBinding:
      glob: $(inputs.out_subs)
  - id: plotdupdust
    type:
      - 'null'
      - File
    doc: 'Path to create a duplicity-dust plot, ending in .pdf or .png. (default:
      not set)'
    outputBinding:
      glob: $(inputs.plotdupdust)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
