cwlVersion: v1.2
class: CommandLineTool
baseCommand: scglue
label: scglue
doc: "Graph-linked unified embedding for single-cell multi-omics data integration.\n\
  \nTool homepage: https://github.com/gao-lab/GLUE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scglue:0.4.0--pyhdfd78af_0
stdout: scglue.out
