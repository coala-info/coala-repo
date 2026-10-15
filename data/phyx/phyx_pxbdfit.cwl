cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxbdfit]
label: phyx_pxbdfit
doc: |-
  Fit a lineage diversification model to a tree.
  This will take a newick- or nexus-formatted tree from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file (newick or nexus)"
    inputBinding:
      prefix: -t
  - id: model
    type: ['null', string]
    doc: "diversification model; either 'yule', 'bd' (default), or 'best'"
    inputBinding:
      prefix: -m
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "model fit results"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
