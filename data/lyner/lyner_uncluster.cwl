cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - uncluster
label: lyner_uncluster
doc: "Uncluster sequences\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_sequences
    type: File
    doc: Input sequences (FASTA/FASTQ)
    inputBinding:
      position: 1
  - id: cluster_threshold
    type:
      - 'null'
      - float
    doc: Clustering threshold (e.g., 0.95 for 95% identity)
    inputBinding:
      position: 102
      prefix: --cluster-threshold
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum number of sequences in a cluster to be considered clustered
    inputBinding:
      position: 102
      prefix: --min-cluster-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_sequences
    type:
      - 'null'
      - File
    doc: Output sequences (FASTA/FASTQ)
    outputBinding:
      glob: $(inputs.output_sequences)
  - id: output_clusters
    type:
      - 'null'
      - File
    doc: Output clusters (TSV)
    outputBinding:
      glob: $(inputs.output_clusters)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
