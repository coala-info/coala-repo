cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mergestatetrees
label: decifer_mergestatetrees
doc: "Merge several DeCiFer state tree files into one state tree file (written to
  stdout).\n\nTool homepage: https://github.com/raphael-group/decifer"
inputs:
  - id: state_tree_files
    type:
      type: array
      items: File
    doc: State tree files to merge (state_tree_file_1 ... state_tree_file_n)
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the merged state tree file
    default: merged_state_trees.txt
outputs:
  - id: merged_state_trees
    type: stdout
    doc: Merged state tree file
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decifer:2.1.4--py312hf731ba3_4
stdout: $(inputs.output_name)
