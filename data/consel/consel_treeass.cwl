cwlVersion: v1.2
class: CommandLineTool
baseCommand: treeass
label: consel_treeass
doc: "Find the associations between candidate tree topologies (tpl file) and their edges; writes <output_base>.ass for edge tests with consel -a and prints the trees, leaves, edges and tree/edge tables.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: tpl_file
    type: File
    doc: "tree topologies in Newick format, starting with the number of trees (tpl file)"
    inputBinding:
      position: 2
  - id: output_base
    type:
      - 'null'
      - string
    doc: "base name of the association file (<output_base>.ass), without extension"
    default: "treeass_out"
    inputBinding:
      position: 3
  - id: outgroup
    type:
      - 'null'
      - int
    doc: "index of the outgroup leaf"
    inputBinding:
      position: 1
      prefix: --outgroup
  - id: vt_file
    type:
      - 'null'
      - File
    doc: "vt file listing the trees to select"
    inputBinding:
      position: 1
      prefix: -v
  - id: leaf_count
    type:
      - 'null'
      - boolean
    doc: "the tpl file starts with the number of leaves"
    inputBinding:
      position: 1
      prefix: -l
  - id: toggle_labels
    type:
      - 'null'
      - boolean
    doc: "toggle printing the leaf labels"
    inputBinding:
      position: 1
      prefix: -p
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: ass
    type: File
    doc: "associations between trees and edges (ass file)"
    outputBinding:
      glob: $(inputs.output_base).ass
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_treeass.log
