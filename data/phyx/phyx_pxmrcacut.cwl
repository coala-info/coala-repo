cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxmrcacut]
label: phyx_pxmrcacut
doc: |-
  Extract subclade(s) from tree(s).
  This will take a newick- or nexus-formatted tree from a file or STDIN,
  and an MRCA file with format:
  MRCANAME = tip1 tip2 ...
  If multiple MRCAs are provided, multiple subtrees are returned

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
    doc: "extracted subtrees (newick)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
