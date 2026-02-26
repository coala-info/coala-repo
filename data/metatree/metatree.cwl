cwlVersion: v1.2
class: CommandLineTool
baseCommand: metatree
label: metatree
doc: "Visualisation of polyphyletic groups between phylogenetic trees to a reference
  tree.\n\nTool homepage: https://github.com/aaronmussig/metatree"
inputs:
  - id: batchfile
    type: string
    doc: "First tree must be the reference tree, format:\nid<tab>path_to_tree"
    inputBinding:
      position: 1
  - id: out_dir
    type: Directory
    doc: path to the output directory
    inputBinding:
      position: 2
  - id: taxonomy_file
    type: File
    doc: 'path to taxonomy file, format: gid<tab>taxonomy'
    inputBinding:
      position: 3
  - id: outgroup
    type: string
    doc: outgroup for rooting
    inputBinding:
      position: 4
  - id: cpus
    type: int
    doc: number of CPUs to use
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metatree:0.0.1--py_0
stdout: metatree.out
