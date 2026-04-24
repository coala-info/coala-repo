cwlVersion: v1.2
class: CommandLineTool
baseCommand: MS-make-ref
label: dms_MS-make-ref
doc: "Make customized reference for dynamic-meta-storms\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs:
  - id: input_taxonomy_annotation_file
    type: File
    doc: Input taxonomy annotation file (tabular format)
    inputBinding:
      position: 101
      prefix: -r
  - id: input_tree_file
    type: File
    doc: Input tree file (newick format)
    inputBinding:
      position: 101
      prefix: -i
  - id: output_reference_name
    type:
      - 'null'
      - string
    doc: Output reference name
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_MS-make-ref.out
