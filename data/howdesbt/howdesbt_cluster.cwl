cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - cluster
label: howdesbt_cluster
doc: "determine a tree topology by clustering bloom filters\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: list_file
    type: File
    doc: "file containing a list of bloom filters to cluster; only filters with uncompressed bit vectors are allowed"
    inputBinding:
      position: 101
      prefix: "--list="
      separate: false
  - id: filters
    type:
      type: array
      items: File
    doc: "the bloom filter files named in the list file (staged in the working directory)"
  - id: out
    type: string
    doc: "name for tree topology file (by default this is derived from the list filename)"
    inputBinding:
      position: 102
      prefix: "--out="
      separate: false
  - id: nodename
    type:
      - 'null'
      - string
    doc: "filename template for internal tree nodes; this must contain the substring {number}"
    inputBinding:
      position: 103
      prefix: "--nodename="
      separate: false
  - id: bit_interval
    type:
      - 'null'
      - string
    doc: "interval of bits to use from each filter, as <start>..<end>; the clustering algorithm only considers this subset of each filter's bits (by default the first 100000 bits)"
    inputBinding:
      position: 104
  - id: bits
    type:
      - 'null'
      - int
    doc: "number of bits to use from each filter; same as 0..<N>"
    inputBinding:
      position: 105
      prefix: "--bits="
      separate: false
  - id: cull
    type:
      - 'null'
      - string
    doc: "remove nodes from the binary tree: <Z>sd removes nodes whose saturation of determined is more than Z standard deviations below the mean; <S> (such as 0.20 or 20%) removes nodes whose saturation of determined is less than S"
    inputBinding:
      position: 106
      prefix: "--cull="
      separate: false
  - id: keepallnodes
    type:
      - 'null'
      - boolean
    doc: "keep all nodes of the binary tree"
    inputBinding:
      position: 107
      prefix: "--keepallnodes"
  - id: nocull
    type:
      - 'null'
      - boolean
    doc: "same as --keepallnodes"
    inputBinding:
      position: 108
      prefix: "--nocull"
  - id: nobuild
    type:
      - 'null'
      - boolean
    doc: "perform the clustering but don't build the tree's nodes (this is the default)"
    inputBinding:
      position: 109
      prefix: "--nobuild"
  - id: build
    type:
      - 'null'
      - boolean
    doc: "perform clustering, then build the uncompressed nodes"
    inputBinding:
      position: 110
      prefix: "--build"
outputs:
  - id: tree_file
    type: File
    doc: "tree topology file"
    outputBinding:
      glob: $(inputs.out)
  - id: node_files
    type:
      type: array
      items: File
    doc: "internal node bloom filters (written with --build)"
    outputBinding:
      glob: "*.bf"
      outputEval: '$(self.filter(function(f) { return !inputs.filters.some(function(i) { return i.basename == f.basename; }); }))'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.filters)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
