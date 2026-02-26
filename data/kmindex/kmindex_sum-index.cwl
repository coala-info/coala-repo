cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex_sum-index
label: kmindex_sum-index
doc: "Make a lightweight summarized index, at query time, reports only the number
  samples containing each k-mer. (experimental)\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: estimate_correction
    type:
      - 'null'
      - boolean
    doc: Estimate the false positive rate correction factor.
    inputBinding:
      position: 101
      prefix: --estimate-correction
  - id: fp_correction
    type:
      - 'null'
      - float
    doc: False positive rate correction factor in [0.0,1.0].
    default: 0.0
    inputBinding:
      position: 101
      prefix: --fp-correction
  - id: global_index
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --global-index
  - id: name
    type: string
    doc: Index name.
    inputBinding:
      position: 101
      prefix: --name
  - id: nbk
    type:
      - 'null'
      - int
    doc: Number of k-mers to use for estimating the correction factor (only with
      -e).
    default: 10000
    inputBinding:
      position: 101
      prefix: --nbk
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level [debug|info|warning|error].
    default: info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
stdout: kmindex_sum-index.out
