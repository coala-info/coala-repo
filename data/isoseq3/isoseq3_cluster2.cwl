cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq3
  - cluster2
label: isoseq3_cluster2
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image due to lack of disk
  space.\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
stdout: isoseq3_cluster2.out
