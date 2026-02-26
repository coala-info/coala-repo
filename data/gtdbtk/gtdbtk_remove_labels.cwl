cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtdbtk
  - remove_labels
label: gtdbtk_remove_labels
doc: "Removes labels from a GTDB-Tk tree.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_tree
    type: File
    doc: path to the unrooted tree in Newick format
    inputBinding:
      position: 101
      prefix: --input_tree
outputs:
  - id: output_tree
    type: File
    doc: path to output the tree
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
