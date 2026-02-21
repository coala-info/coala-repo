cwlVersion: v1.2
class: CommandLineTool
baseCommand: treecluster_score_clusters.py
label: treecluster_score_clusters.py
doc: "The provided text does not contain help information for the tool; it contains
  system error logs related to a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/niemasd/TreeCluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treecluster:1.0.5--pyh7e72e81_0
stdout: treecluster_score_clusters.py.out
