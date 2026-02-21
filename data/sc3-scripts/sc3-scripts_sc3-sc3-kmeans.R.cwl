cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3-kmeans.R
label: sc3-scripts_sc3-sc3-kmeans.R
doc: "Perform k-means clustering as part of the SC3 (Single-Cell Consensus Clustering)
  pipeline.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
stdout: sc3-scripts_sc3-sc3-kmeans.R.out
