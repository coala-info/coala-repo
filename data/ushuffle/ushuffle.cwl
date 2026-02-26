cwlVersion: v1.2
class: CommandLineTool
baseCommand: ushuffle
label: ushuffle
doc: "a useful tool for shuffling biological sequences while preserving the k-let
  counts\n\nTool homepage: http://digital.cs.usu.edu/~mjiang/ushuffle/"
inputs:
  - id: benchmark
    type:
      - 'null'
      - boolean
    doc: benchmark
    inputBinding:
      position: 101
      prefix: -b
  - id: kmer_size
    type: int
    doc: specifies the let size
    inputBinding:
      position: 101
      prefix: -k
  - id: num_sequences
    type: int
    doc: specifies the number of random sequences to generate
    inputBinding:
      position: 101
      prefix: -n
  - id: seed
    type:
      - 'null'
      - int
    doc: specifies the seed for random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: sequence
    type: string
    doc: specifies the sequence
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ushuffle:1.2.2--py312h0fa9677_10
stdout: ushuffle.out
