cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - patristic_distances
label: phykit_patristic_distances
doc: Calculate summary statistics among patristic distances in a phylogeny. 
  Patristic distances are all tip-to-tip distances in a phylogeny.
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
stdout: phykit_patristic_distances.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
