cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - snpclust
label: strainest_snpclust
doc: "Given a SNP matrix (in DGRP format) and a distance matrix, snpdist clusters
  the profiles returning a SNP matrix containing the representative profiles (SNPOUT)
  and a cluster file (CLUST).\n\nTool homepage: https://github.com/compmetagen/strainest"
inputs:
  - id: snp_matrix
    type: File
    doc: SNP matrix (in DGRP format)
    inputBinding:
      position: 1
  - id: distance_matrix
    type: File
    doc: Distance matrix
    inputBinding:
      position: 2
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: distance threshold
    inputBinding:
      position: 103
      prefix: --thr
outputs:
  - id: snp_out
    type: File
    doc: SNP matrix containing the representative profiles
    outputBinding:
      glob: '*.out'
  - id: clust
    type: File
    doc: Cluster file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py35_0
