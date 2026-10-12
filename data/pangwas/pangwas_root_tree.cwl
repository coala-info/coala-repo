cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - root_tree
label: pangwas_root_tree
doc: "Root tree on outgroup taxa.\n\nTakes as input a path to a phylogenetic tree and outgroup taxa. This is\na utility script that is meant to fix IQ-TREE's creation of a multifurcated\nroot node. It will position the root node along the midpoint of the branch\nbetween the outgroup taxa and all other samples. If no outgroup is selected,\nthe tree will be rooted using the first taxa. Outputs a new tree in the specified\ntree format.\n\nNote: This functionality is already included in the tree subcommand.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: tree
    type:
      - 'null'
      - File
    doc: "Path to phylogenetic tree."
    inputBinding:
      position: 101
      prefix: --tree
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "Outgroup taxa as CSV string. If not specified, roots on first taxon."
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Tree format. (default: newick)"
    inputBinding:
      position: 101
      prefix: --tree-format
outputs:
  - id: rooted_tree
    type: File
    doc: "Rooted tree in the requested tree format"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'rooted.newick')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
