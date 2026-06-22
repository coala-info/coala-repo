cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - robinson_foulds_distance
label: phykit_robinson_foulds_distance
doc: Calculate Robinson-Foulds (RF) distance between two trees. This function 
  prints out two values, the plain RF value and the normalized RF value, which 
  are separated by a tab. Prior to calculating an RF value, PhyKIT will first 
  determine the number of shared tips between the two input phylogenies and 
  prune them to a common set of tips.
inputs:
  - id: tree_file_zero
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: tree_file_one
    type:
      - 'null'
      - File
    doc: second argument after function name should be a tree file
    inputBinding:
      position: 2
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 103
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_robinson_foulds_distance.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
