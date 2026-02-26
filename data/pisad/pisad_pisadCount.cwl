cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisadCount
label: pisad_pisadCount
doc: "Calculate variant sketch statistics\n\nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 2
  - id: information
    type:
      - 'null'
      - boolean
    doc: extra debug information.
    inputBinding:
      position: 103
      prefix: --information
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size used.
    default: 21
    inputBinding:
      position: 103
      prefix: --kmer
  - id: max_cov
    type:
      - 'null'
      - int
    doc: k-mer coverage threshold for early termination.
    default: inf
    inputBinding:
      position: 103
      prefix: --maxCov
  - id: snp
    type:
      type: array
      items: string
    doc: variant sketch (one or more)
    inputBinding:
      position: 103
      prefix: --snp
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run.
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Evaluation file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
