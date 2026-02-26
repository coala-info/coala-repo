cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep_cluster
label: tadrep_cluster
doc: "Cluster plasmids based on sequence identity and length difference.\n\nTool homepage:
  https://github.com/oschwengers/tadrep"
inputs:
  - id: max_sequence_length_difference
    type:
      - 'null'
      - int
    doc: Maximal plasmid sequence length difference in basepairs (default = 
      1000)
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-sequence-length-difference
  - id: min_sequence_identity
    type:
      - 'null'
      - int
    doc: Minimal plasmid sequence identity (default = 90%)
    default: 90
    inputBinding:
      position: 101
      prefix: --min-sequence-identity
  - id: skip
    type:
      - 'null'
      - boolean
    doc: Skips clustering, one group for each plasmid
    inputBinding:
      position: 101
      prefix: --skip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_cluster.out
