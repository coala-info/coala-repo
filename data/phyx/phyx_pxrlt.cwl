cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxrlt]
label: phyx_pxrlt
doc: |-
  Taxon relabelling for trees.
  Two ordered lists of taxa, -c (current) and -n (new) must be provided.
  This will take a newick- or nexus-formatted tree from a file or STDIN.
  Output is written in newick format.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: cnames
    type: File
    doc: "file containing current taxon labels (one per line)"
    inputBinding:
      prefix: -c
  - id: nnames
    type: File
    doc: "file containing new taxon labels (one per line)"
    inputBinding:
      prefix: -n
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
  - id: verbose
    type: ['null', boolean]
    doc: "make the output more verbose"
    inputBinding:
      prefix: -v
outputs:
  - id: out_file
    type: File
    doc: "relabelled tree (newick)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
