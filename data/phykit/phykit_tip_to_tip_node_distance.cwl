cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - tip_to_tip_node_distance
label: phykit_tip_to_tip_node_distance
doc: Calculate distance between two tips (or leaves) in a phylogeny. Distance is
  measured by the number of nodes between one tip and another.
inputs:
  - id: tree_file
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: tip_1
    type: string
    doc: second argument after function name should be one of the tip names
    inputBinding:
      position: 2
  - id: tip_2
    type: string
    doc: third argument after function name should be the second tip name
    inputBinding:
      position: 3
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 104
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_tip_to_tip_node_distance.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
