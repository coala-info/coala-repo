cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster-picker
label: cluster-picker
doc: "A tool for identifying clusters in phylogenetic trees from Newick format files.\n\
  \nTool homepage: https://github.com/niemasd/ClusterPickerII"
inputs:
  - id: input_tree
    type: File
    doc: Newick format tree, with branch lengths and node support (should have 
      .nwk extension)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cluster-picker:1.2.3--0
stdout: cluster-picker.out
