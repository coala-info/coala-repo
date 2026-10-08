cwlVersion: v1.2
class: CommandLineTool
baseCommand: MS-make-ref
label: dms_MS-make-ref
doc: "Make customized reference for dynamic-meta-storms\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: PREFIX
        envValue: /usr/local
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
    doc: Output reference name (the tool writes <name>.dms), default is "tree"
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: reference_dir
    type: Directory
    doc: Customized reference folder (<name>.dms)
    outputBinding:
      glob: '$((inputs.output_reference_name ? inputs.output_reference_name : "tree")
        + ".dms")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_MS-make-ref.out
