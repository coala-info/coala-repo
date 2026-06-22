cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - total_tree_length
label: phykit_total_tree_length
doc: Calculate total tree length, which is a sum of all branches.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_total_tree_length.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
