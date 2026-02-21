cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq3
  - cluster
label: isoseq3_cluster
doc: "The provided text does not contain help information for isoseq3_cluster; it
  is a system error message regarding a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
stdout: isoseq3_cluster.out
