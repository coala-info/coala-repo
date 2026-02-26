cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophex
  - klcp
label: prophex_klcp
doc: "Construct k-LCP array\n\nTool homepage: https://github.com/prophyle/prophex"
inputs:
  - id: idxbase
    type: string
    doc: Index base name
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of k-mer
    inputBinding:
      position: 102
      prefix: -k
  - id: parallel_construction
    type:
      - 'null'
      - boolean
    doc: construct k-LCP and SA in parallel
    inputBinding:
      position: 102
      prefix: -s
  - id: sampling_distance
    type:
      - 'null'
      - int
    doc: sampling distance for SA
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
stdout: prophex_klcp.out
