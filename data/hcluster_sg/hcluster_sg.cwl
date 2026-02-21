cwlVersion: v1.2
class: CommandLineTool
baseCommand: hcluster_sg
label: hcluster_sg
doc: 'Hierarchical clustering software for sparse graphs (Note: The provided help
  text contains only container runtime error messages and no usage information).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hcluster_sg:0.5.1--h9948957_9
stdout: hcluster_sg.out
