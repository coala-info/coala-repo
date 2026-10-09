cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - build
label: howdesbt_build
doc: "build a sequence bloom tree from a topology file and leaves\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: tree_topology
    type: File
    doc: "name of the tree topology file"
    inputBinding:
      position: 101
  - id: filters
    type:
      type: array
      items: File
    doc: "the leaf bloom filter files named in the topology file (staged in the working directory)"
  - id: outtree
    type:
      - 'null'
      - string
    doc: "name of topology file to write tree consisting of the filters built"
    inputBinding:
      position: 102
      prefix: "--outtree="
      separate: false
  - id: simple
    type:
      - 'null'
      - boolean
    doc: "create tree nodes as simple bloom filters (this is the default)"
    inputBinding:
      position: 103
      prefix: "--simple"
  - id: howde
    type:
      - 'null'
      - boolean
    doc: "equivalent to --determined,brief --rrr"
    inputBinding:
      position: 104
      prefix: "--howde"
  - id: allsome
    type:
      - 'null'
      - boolean
    doc: "create tree nodes as all/some bloom filters"
    inputBinding:
      position: 105
      prefix: "--allsome"
  - id: determined
    type:
      - 'null'
      - boolean
    doc: "create tree nodes as determined/how bloom filters"
    inputBinding:
      position: 106
      prefix: "--determined"
  - id: determined_brief
    type:
      - 'null'
      - boolean
    doc: "create tree nodes as determined/how, but only store active bits"
    inputBinding:
      position: 107
      prefix: "--determined,brief"
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: "create the nodes as uncompressed bit vector(s) (this is the default)"
    inputBinding:
      position: 108
      prefix: "--uncompressed"
  - id: rrr
    type:
      - 'null'
      - boolean
    doc: "create the nodes as rrr-compressed bit vector(s)"
    inputBinding:
      position: 109
      prefix: "--rrr"
  - id: roar
    type:
      - 'null'
      - boolean
    doc: "create the nodes as roar-compressed bit vector(s)"
    inputBinding:
      position: 110
      prefix: "--roar"
outputs:
  - id: node_files
    type:
      type: array
      items: File
    doc: "bloom filter files of the tree nodes built"
    outputBinding:
      glob: "*.bf"
      outputEval: '$(self.filter(function(f) { return !inputs.filters.some(function(i) { return i.basename == f.basename; }); }))'
  - id: topology_files
    type:
      type: array
      items: File
    doc: "tree topology files written by the build"
    outputBinding:
      glob: "*.sbt"
      outputEval: '$(self.filter(function(f) { return f.basename != inputs.tree_topology.basename; }))'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.filters)
      - $(inputs.tree_topology)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
