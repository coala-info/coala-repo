cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suppa.py
  - clusterEvents
label: suppa_clusterEvents
doc: "Cluster events with similar inclusion patterns across conditions.\n\nTool homepage: https://github.com/comprna/SUPPA"
inputs:
  - id: dpsi
    type: File
    doc: Input file of delta-PSI values (.dpsi format); staged writable because the tool writes its results next to this file
    inputBinding:
      position: 1
      prefix: --dpsi
      valueFrom: $(self.basename)
  - id: psivec
    type: File
    doc: Input file with PSI values (.psivec format)
    inputBinding:
      position: 1
      prefix: --psivec
      valueFrom: $(self.basename)
  - id: groups
    type: string
    doc: "Ranges of column numbers specifying the replicates per condition, continuous, for example 1-3,4-6"
    inputBinding:
      position: 1
      prefix: --groups
  - id: sig_threshold
    type:
      - 'null'
      - float
    doc: P-value cut-off for significant events. (default 0.05)
    inputBinding:
      position: 1
      prefix: --sig-threshold
  - id: dpsi_threshold
    type:
      - 'null'
      - float
    doc: Lower-bound for the absolute delta PSI value to cluster. (default 0.05)
    inputBinding:
      position: 1
      prefix: --dpsi-threshold
  - id: eps
    type:
      - 'null'
      - float
    doc: Maximum (Euclidean) distance (between 0 and 1) to consider two events as members of the same cluster. (default 0.05)
    inputBinding:
      position: 1
      prefix: --eps
  - id: separation
    type:
      - 'null'
      - float
    doc: Minimum separation for considering two points in different clusters. (default 0)
    inputBinding:
      position: 1
      prefix: --separation
  - id: min_pts
    type:
      - 'null'
      - int
    doc: Minimum number of events required per cluster. (default 20)
    inputBinding:
      position: 1
      prefix: --min-pts
  - id: metric
    type:
      - 'null'
      - string
    doc: "Distance function: euclidean (default), manhattan or cosine."
    inputBinding:
      position: 1
      prefix: --metric
  - id: clustering
    type:
      - 'null'
      - string
    doc: "Clustering method: OPTICS or DBSCAN (default)."
    inputBinding:
      position: 1
      prefix: --clustering
  - id: output
    type: string
    doc: Name of the output file.
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: cluster_files
    type:
      type: array
      items: File
    doc: Clustering results
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dpsi)
        writable: true
      - entry: $(inputs.psivec)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
