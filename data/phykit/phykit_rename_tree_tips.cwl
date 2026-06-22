cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - rename_tree_tips
label: phykit_rename_tree_tips
doc: Renames tips in a phylogeny based on a tab-delimited identifier map.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: idmap
    type:
      - 'null'
      - File
    doc: identifier map of current tip names (col1) and desired tip names (col2)
    inputBinding:
      position: 102
      prefix: --idmap
  - id: output
    type: string
    doc: optional argument to write the renamed tree files to. Default output 
      will have the same name as the input file but with the suffix ".renamed"
    inputBinding:
      position: 102
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: optional argument to write the renamed tree files to. Default output 
      will have the same name as the input file but with the suffix ".renamed"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
