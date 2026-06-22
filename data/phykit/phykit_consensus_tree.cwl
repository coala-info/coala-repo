cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - consensus_tree
label: phykit_consensus_tree
doc: 'Infer a consensus tree from a collection of trees. Input can be either: 1) a
  file with one Newick tree per line, or 2) a file with one tree-file path per line.'
inputs:
  - id: trees
    type: File
    doc: file containing trees or tree paths
    inputBinding:
      position: 101
      prefix: --trees
  - id: method
    type:
      - 'null'
      - string
    doc: consensus method to infer (strict or majority)
    inputBinding:
      position: 101
      prefix: --method
  - id: missing_taxa
    type:
      - 'null'
      - string
    doc: 'how to handle mismatched taxa across trees: error or shared'
    inputBinding:
      position: 101
      prefix: --missing-taxa
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_consensus_tree.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
