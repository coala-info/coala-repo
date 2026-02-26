cwlVersion: v1.2
class: CommandLineTool
baseCommand: starcode
label: starcode
doc: "starcode-v1.4 2020-11-02\n\nTool homepage: https://github.com/gui11aume/starcode"
inputs:
  - id: cluster_ratio
    type:
      - 'null'
      - float
    doc: min size ratio for merging clusters in message passing
    default: 5.0
    inputBinding:
      position: 101
      prefix: --cluster-ratio
  - id: connected_comp
    type:
      - 'null'
      - boolean
    doc: cluster connected components
    inputBinding:
      position: 101
      prefix: --connected-comp
  - id: input
    type:
      - 'null'
      - File
    doc: input file
    inputBinding:
      position: 101
      prefix: --input
  - id: input1
    type:
      - 'null'
      - File
    doc: input file 1
    inputBinding:
      position: 101
      prefix: --input1
  - id: input2
    type:
      - 'null'
      - File
    doc: input file 2
    inputBinding:
      position: 101
      prefix: --input2
  - id: max_distance
    type:
      - 'null'
      - int
    doc: maximum Levenshtein distance
    inputBinding:
      position: 101
      prefix: --dist
  - id: non_redundant
    type:
      - 'null'
      - boolean
    doc: remove redundant sequences from input file(s)
    inputBinding:
      position: 101
      prefix: --non-redundant
  - id: print_clusters
    type:
      - 'null'
      - boolean
    doc: outputs cluster compositions
    inputBinding:
      position: 101
      prefix: --print-clusters
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seq_id
    type:
      - 'null'
      - boolean
    doc: print sequence id numbers (1-based)
    inputBinding:
      position: 101
      prefix: --seq-id
  - id: sphere
    type:
      - 'null'
      - boolean
    doc: use sphere clustering algorithm
    inputBinding:
      position: 101
      prefix: --sphere
  - id: threads
    type:
      - 'null'
      - int
    doc: number of concurrent threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
  - id: output1
    type:
      - 'null'
      - File
    doc: output file1
    outputBinding:
      glob: $(inputs.output1)
  - id: output2
    type:
      - 'null'
      - File
    doc: output file2
    outputBinding:
      glob: $(inputs.output2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starcode:1.4--h7b50bb2_6
