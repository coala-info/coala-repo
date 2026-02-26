cwlVersion: v1.2
class: CommandLineTool
baseCommand: quicktree
label: quicktree
doc: "Constructs a phylogenetic tree from a distance matrix or an alignment.\n\nTool
  homepage: https://github.com/khowe/quicktree"
inputs:
  - id: inputfile
    type: File
    doc: Input file (distance matrix or alignment)
    inputBinding:
      position: 1
  - id: boot
    type:
      - 'null'
      - int
    doc: Calcuate bootstrap values with n iterations (ignored for distance 
      matrix outputs)
    inputBinding:
      position: 102
      prefix: -boot
  - id: input_format
    type:
      - 'null'
      - string
    doc: input file is a distance matrix in phylip format (m) or an alignment in
      stockholm format* (a, default)
    default: a
    inputBinding:
      position: 102
      prefix: -in
  - id: kimura
    type:
      - 'null'
      - boolean
    doc: Use the kimura translation for pairwise distances (ignored for distance
      matrix inputs)
    inputBinding:
      position: 102
      prefix: -kimura
  - id: output_format
    type:
      - 'null'
      - string
    doc: output is a distance matrix in phylip format (m) or a tree in New 
      Hampshire format
    inputBinding:
      position: 102
      prefix: -out
  - id: upgma
    type:
      - 'null'
      - boolean
    doc: Use the UPGMA method to construct the tree (ignored for distance matrix
      outputs)
    inputBinding:
      position: 102
      prefix: -upgma
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quicktree:2.5--h7b50bb2_9
stdout: quicktree.out
