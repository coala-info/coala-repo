cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxcolt]
label: phyx_pxcolt
doc: |-
  Collapse edges with support below some threshold.
  If annotated Nexus, may require passing in the support identifier (-s).
  This will take a newick- or nexus-formatted tree from a file or STDIN.
  Output is written in newick format.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: limit
    type: ['null', float]
    doc: "minimum support threshold as proportion (default = 0.5)"
    inputBinding:
      prefix: -l
  - id: sup
    type: ['null', string]
    doc: "string identifying support values (if default fails)"
    inputBinding:
      prefix: -s
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "collapsed tree (newick)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
