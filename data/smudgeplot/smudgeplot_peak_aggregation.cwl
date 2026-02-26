cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot peak_aggregation
label: smudgeplot_peak_aggregation
doc: "Aggregates smudges using local aggregation algorithm.\n\nTool homepage: https://github.com/KamilSJaron/smudgeplot"
inputs:
  - id: infile
    type: File
    doc: Name of the input smu file with covarages and frequencies.
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - int
    doc: Manthattan distance of k-mer pairs that are considered neighbouring for
      the local aggregation purposes.
    inputBinding:
      position: 102
      prefix: -distance
  - id: mask_errors
    type:
      - 'null'
      - boolean
    doc: All k-mer pairs belonging to smudges with the peak distant less than -d
      from the error line will be labeled as -1 (errors).
    inputBinding:
      position: 102
      prefix: --mask_errors
  - id: noise_filter
    type:
      - 'null'
      - int
    doc: k-mer pairs with frequencies lower than this value will not be 
      aggregated into smudges.
    inputBinding:
      position: 102
      prefix: -noise_filter
  - id: title
    type:
      - 'null'
      - string
    doc: name printed at the top of the smudgeplot
    default: infile prefix
    inputBinding:
      position: 102
      prefix: -title
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_peak_aggregation.out
