cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxtcol]
label: phyx_pxtcol
doc: |-
  Add information to a tree so that you can color the edges.
  This will take nexus and newick inputs from a file or STDIN.
  Results are written in nexus format so that it can be read by figtree.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: mrca_file
    type: ['null', File]
    doc: "file with mrcas and annotations, tab separated (accepted but ignored by phyx 1.1)"
    inputBinding:
      prefix: -m
  - id: nodeid_file
    type: ['null', File]
    doc: "file with nodeids (labels) and annotations, tab separated"
    inputBinding:
      prefix: -d
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "annotated tree (Nexus)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
