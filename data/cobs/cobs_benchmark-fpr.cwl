cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cobs
  - benchmark-fpr
label: cobs_benchmark-fpr
doc: "Calculate false positive distribution for COBS\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: in_file
    type: File
    doc: path to the input file
    inputBinding:
      position: 1
  - id: calculate_fpr_distribution
    type:
      - 'null'
      - boolean
    doc: calculate false positive distribution
    inputBinding:
      position: 102
      prefix: --dist
  - id: num_kmers
    type:
      - 'null'
      - int
    doc: number of kmers of each query
    default: 1000
    inputBinding:
      position: 102
      prefix: --num-kmers
  - id: queries
    type:
      - 'null'
      - int
    doc: number of random queries to run
    default: 10000
    inputBinding:
      position: 102
      prefix: --queries
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: warmup
    type:
      - 'null'
      - int
    doc: number of random warmup queries to run
    default: 100
    inputBinding:
      position: 102
      prefix: --warmup
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
stdout: cobs_benchmark-fpr.out
