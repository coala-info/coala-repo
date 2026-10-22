cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tadtool
  - subset
label: tadtool_subset
doc: "Reduce a matrix to a smaller region.\n\nTool homepage: https://github.com/vaquerizaslab/tadtool"
inputs:
  - id: matrix
    type: File
    doc: "Square Hi-C Matrix as tab-delimited or .npy file (created\n            \
      \      with numpy.save) or sparse matrix format (each line: <row\n         \
      \         region index> <column region index> <matrix value>)"
    inputBinding:
      position: 1
  - id: regions
    type: File
    doc: "BED file (no header) with regions corresponding to the\n               \
      \   number of rows in the provided matrix. Fourth column, if\n             \
      \     present, denotes name field, which is used as an identifier\n        \
      \          in sparse matrix notation."
    inputBinding:
      position: 2
  - id: sub_region
    type: string
    doc: "Region of the Hi-C matrix to display in plot. Format:\n                \
      \  <chromosome>:<start>-<end>, e.g. chr12:31000000-33000000"
    inputBinding:
      position: 3
  - id: output_matrix_path
    type: string
    doc: Output matrix file.
    inputBinding:
      position: 4
  - id: output_regions_path
    type: string
    doc: Output regions file.
    inputBinding:
      position: 5
outputs:
  - id: output_matrix
    type: File
    doc: Output matrix file.
    outputBinding:
      glob: $(inputs.output_matrix_path)
  - id: output_regions
    type: File
    doc: Output regions file.
    outputBinding:
      glob: $(inputs.output_regions_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadtool:0.84--pyh7cba7a3_0
