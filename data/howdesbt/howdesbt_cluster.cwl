cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster
label: howdesbt_cluster
doc: "determine a tree topology by clustering bloom filters\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: same as --list=<filename>
    inputBinding:
      position: 1
  - id: bit_interval
    type:
      - 'null'
      - string
    doc: "interval of bits to use from each filter; the clustering\n             \
      \       algorithm only considers this subset of each filter's bits\n       \
      \             (by default we use the first 100000 bits)"
    inputBinding:
      position: 2
  - id: build
    type:
      - 'null'
      - boolean
    doc: perform clustering, then build the uncompressed nodes
    inputBinding:
      position: 103
      prefix: --build
  - id: cull_default
    type:
      - 'null'
      - boolean
    doc: "remove nodes from the binary tree; remove those for which\n            \
      \        saturation of determined is more than 2 standard deviations\n     \
      \               below the mean\n                    (this is the default)"
    default: true
    inputBinding:
      position: 103
      prefix: --cull
  - id: cull_sd
    type:
      - 'null'
      - float
    doc: "remove nodes for which saturation of determined is more\n              \
      \      than <Z> standard deviations below the mean"
    inputBinding:
      position: 103
      prefix: --cull
  - id: cull_value
    type:
      - 'null'
      - float
    doc: "remove nodes for which saturation of determined is less\n              \
      \      than <S>; e.g. <S> can be \"0.20\" or \"20%\""
    inputBinding:
      position: 103
      prefix: --cull
  - id: keep_all_nodes
    type:
      - 'null'
      - boolean
    doc: keep all nodes of the binary tree
    inputBinding:
      position: 103
      prefix: --keepallnodes
  - id: list_file
    type:
      - 'null'
      - File
    doc: file containing a list of bloom filters to cluster; only filters with 
      uncompressed bit vectors are allowed
    inputBinding:
      position: 103
      prefix: --list
  - id: no_build
    type:
      - 'null'
      - boolean
    doc: "perform the clustering but don't build the tree's nodes\n              \
      \      (this is the default)"
    default: true
    inputBinding:
      position: 103
      prefix: --nobuild
  - id: no_cull
    type:
      - 'null'
      - boolean
    doc: (same as --keepallnodes)
    inputBinding:
      position: 103
      prefix: --nocull
  - id: nodename_template
    type:
      - 'null'
      - string
    doc: "filename template for internal tree nodes\n                    this must
      contain the substring {number}\n                    (by default this is derived
      from the list filename)"
    inputBinding:
      position: 103
      prefix: --nodename
  - id: num_bits
    type:
      - 'null'
      - int
    doc: number of bits to use from each filter; same as 0..<N>
    inputBinding:
      position: 103
      prefix: --bits
outputs:
  - id: output_tree_file
    type:
      - 'null'
      - File
    doc: "name for tree toplogy file\n                    (by default this is derived
      from the list filename)"
    outputBinding:
      glob: $(inputs.output_tree_file)
  - id: tree_file
    type:
      - 'null'
      - File
    doc: same as --out=<filename>
    outputBinding:
      glob: $(inputs.tree_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
