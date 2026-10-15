cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxtscale]
label: phyx_pxtscale
doc: |-
  Tree rescaling by providing either scaling factor or root height.
  This will take a newick- or nexus-formatted tree from a file or STDIN.
  Output is written in newick format.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: scale
    type: ['null', float]
    doc: "edge length scaling factor"
    inputBinding:
      prefix: -s
  - id: rootheight
    type: ['null', float]
    doc: "height of root (tree must be ultrametric)"
    inputBinding:
      prefix: -r
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "rescaled tree (newick)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
