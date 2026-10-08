cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep3
  - cluster-haplogroups
label: haplogrep3_cluster-haplogroups
doc: "Cluster the haplogroups of a phylotree.\n\nTool homepage: https://github.com/genepi/haplogrep3"
inputs:
  - id: output
    type: string
    doc: "output haplogrpups (txt)"
    inputBinding:
      position: 101
      prefix: --output
  - id: tree
    type: string
    doc: "tree name"
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: clusters
    type: File
    doc: "Haplogroup clusters"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
