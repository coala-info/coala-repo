cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribocutter
label: ribocutter
doc: "ribocutter\n\nTool homepage: https://github.com/Delayed-Gitification/ribocutter.git"
inputs:
  - id: a3
    type:
      - 'null'
      - string
    doc: "Include an adaptor sequence for the 3' end containing\n                \
      \        a PAM motif (i.e. 5'-NGG-3'). This must be less than\n            \
      \            20 nt, and ideally should be less than 10 nt"
    inputBinding:
      position: 101
      prefix: --a3
  - id: a5
    type:
      - 'null'
      - string
    doc: "Include an adaptor sequence for the 5' end containing\n                \
      \        a PAM motif (in reverse complement, i.e. 5'-CCN-3').\n            \
      \            This must be less than 20 nt, and ideally should be\n         \
      \               less than 10 nt"
    inputBinding:
      position: 101
      prefix: --a5
  - id: background
    type:
      - 'null'
      - File
    doc: "A fasta file of background sequences that you do not\n                 \
      \       wish to target"
    inputBinding:
      position: 101
      prefix: --background
  - id: input
    type:
      type: array
      items: File
    doc: Input fastq(s)
    inputBinding:
      position: 101
      prefix: --input
  - id: max_guides
    type:
      - 'null'
      - int
    doc: The number of guides to design
    inputBinding:
      position: 101
      prefix: --max_guides
  - id: max_read_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max_read_length
  - id: max_reads
    type:
      - 'null'
      - int
    doc: max reads to examine
    inputBinding:
      position: 101
      prefix: --max_reads
  - id: min_read_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min_read_length
  - id: overlap
    type:
      - 'null'
      - int
    doc: The overlap, compatible with EnGen NEB kit
    inputBinding:
      position: 101
      prefix: --overlap
  - id: save_stats
    type:
      - 'null'
      - boolean
    doc: "Save a CSV of copy numbers for the most abundant\n                     \
      \   sequences"
    inputBinding:
      position: 101
      prefix: --save_stats
  - id: stats_frac
    type:
      - 'null'
      - float
    doc: "When using save_stats mode, this is the minimum\n                      \
      \  fractional abundance of a sequence for it to be\n                       \
      \ recorded in the csv. Default = 0.0001 (0.01percent)"
    default: '0.0001'
    inputBinding:
      position: 101
      prefix: --stats_frac
  - id: t7
    type:
      - 'null'
      - string
    doc: T7 promoter sequence
    inputBinding:
      position: 101
      prefix: --t7
outputs:
  - id: output
    type: File
    doc: output filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocutter:0.1.1--pyh5e36f6f_0
