cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster
label: machina_cluster
doc: "Cluster mutations based on their co-occurrence patterns.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: read_matrix
    type: string
    doc: Read matrix
    inputBinding:
      position: 1
  - id: clustering_confidence_interval
    type:
      - 'null'
      - float
    doc: Confidence interval used for clustering
    inputBinding:
      position: 102
      prefix: -a
  - id: clustering_filename
    type:
      - 'null'
      - string
    doc: Clustering input filename
    inputBinding:
      position: 102
      prefix: -C
  - id: family_wise_error_rate
    type:
      - 'null'
      - float
    doc: Family-wise error rate
    inputBinding:
      position: 102
      prefix: -FWR
  - id: min_variant_reads
    type:
      - 'null'
      - int
    doc: Minimum number of variant reads
    inputBinding:
      position: 102
      prefix: -varLB
  - id: output_ancestree
    type:
      - 'null'
      - boolean
    doc: Output AncesTree input file
    inputBinding:
      position: 102
      prefix: -A
  - id: pooled_frequency_confidence_interval
    type:
      - 'null'
      - float
    doc: Confidence interval used for pooled frequency matrix
    inputBinding:
      position: 102
      prefix: -b
  - id: relabel_clusters
    type:
      - 'null'
      - boolean
    doc: Relabel mutation clusters
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_cluster.out
