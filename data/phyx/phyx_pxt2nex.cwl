cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxt2nex]
label: phyx_pxt2nex
doc: |-
  This will convert a tree file to vanilla Nexus format.
  This will take a newick- or nexus-formatted tree from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: out_file_path
    type: string
    doc: "output tree file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "tree in Nexus format"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
