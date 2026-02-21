cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisad_create
label: pisad_create
doc: "Phylogenetic Inference from Single-cell ATAC-seq Data (Note: The provided text
  is a container build log and does not contain command-line argument definitions).\n
  \nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
stdout: pisad_create.out
