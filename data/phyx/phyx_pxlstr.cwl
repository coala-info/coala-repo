cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxlstr]
label: phyx_pxlstr
doc: |-
  Print tree summary.
  By default returns all properties. Alternatively choose 1 property.
  This will take a newick- or nexus-formatted tree from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: rooted
    type: ['null', boolean]
    doc: "return whether the tree is rooted"
    inputBinding:
      prefix: -r
  - id: age
    type: ['null', boolean]
    doc: "return the height of root (must be rooted and ultrametric)"
    inputBinding:
      prefix: -a
  - id: ntips
    type: ['null', boolean]
    doc: "return the number of terminals"
    inputBinding:
      prefix: -n
  - id: ultrametric
    type: ['null', boolean]
    doc: "return whether tree is ultrametric"
    inputBinding:
      prefix: -u
  - id: binary
    type: ['null', boolean]
    doc: "return whether tree is binary"
    inputBinding:
      prefix: -b
  - id: length
    type: ['null', boolean]
    doc: "return the length of the tree"
    inputBinding:
      prefix: -l
  - id: tiplabels
    type: ['null', boolean]
    doc: "return all tip labels (one per line)"
    inputBinding:
      prefix: -i
  - id: rtvar
    type: ['null', boolean]
    doc: "return root-to-tip variance"
    inputBinding:
      prefix: -v
  - id: out_file_path
    type: string
    doc: "output tree stats file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "tree summary"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
