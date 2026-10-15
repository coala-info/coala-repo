cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxmrca]
label: phyx_pxmrca
doc: |-
  Get the number of descendant tips of internal nodes specified by mrca statements.
  This will take a newick- or nexus-formatted tree from a file or STDIN,
  and an MRCA file with format:
  MRCANAME = tip1 tip2 ...

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input newick tree file"
    inputBinding:
      prefix: -t
  - id: mrca_file
    type: File
    doc: "file containing MRCA declarations"
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
    doc: "number of descendant tips per MRCA"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
