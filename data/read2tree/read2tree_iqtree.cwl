cwlVersion: v1.2
class: CommandLineTool
baseCommand: read2tree
label: read2tree_iqtree
doc: "The provided text does not contain help information, but appears to be a container
  execution error log for the read2tree tool.\n\nTool homepage: https://github.com/DessimozLab/read2tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read2tree:2.0.1--pyhdfd78af_0
stdout: read2tree_iqtree.out
