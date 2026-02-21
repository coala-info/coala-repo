cwlVersion: v1.2
class: CommandLineTool
baseCommand: domclust
label: domclust
doc: "DomClust is a tool for hierarchical clustering of orthologous groups. (Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments).\n\nTool homepage: http://mbgd.genome.ad.jp/domclust/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domclust:1.2.8--h503566f_0
stdout: domclust.out
