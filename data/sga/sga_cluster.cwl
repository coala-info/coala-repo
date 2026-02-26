cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - cluster
label: sga_cluster
doc: "Extract clusters of reads belonging to the same connected components.\n\nTool
  homepage: https://github.com/jts/sga"
inputs:
  - id: reads
    type: string
    doc: Reads to process
    inputBinding:
      position: 1
  - id: error_rate
    type:
      - 'null'
      - string
    doc: the maximum error rate allowed to consider two sequences aligned
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: extend
    type:
      - 'null'
      - File
    doc: extend previously existing clusters in FILE
    inputBinding:
      position: 102
      prefix: --extend
  - id: iterations
    type:
      - 'null'
      - int
    doc: limit cluster extension to NUM iterations
    inputBinding:
      position: 102
      prefix: --iterations
  - id: limit
    type:
      - 'null'
      - File
    doc: do not extend through the sequences in FILE
    inputBinding:
      position: 102
      prefix: --limit
  - id: max_cluster_size
    type:
      - 'null'
      - int
    doc: abort the search if the cluster size exceeds N
    inputBinding:
      position: 102
      prefix: --max-cluster-size
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: only write clusters with at least N reads
    default: 2
    inputBinding:
      position: 102
      prefix: --min-cluster-size
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: require an overlap of at least N bases between reads
    default: 45
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM worker threads to compute the overlaps
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: write the clusters to FILE
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
