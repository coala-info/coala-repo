cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - parsimony_score
label: phykit_parsimony_score
doc: Compute the Fitch (1971) maximum parsimony score of a tree given an 
  alignment. The parsimony score is the minimum number of character state 
  changes required to explain the alignment on the given tree topology.
inputs:
  - id: tree
    type: File
    doc: tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: alignment
    type:
      - 'null'
      - File
    doc: alignment file in FASTA format
    inputBinding:
      position: 101
      prefix: --alignment
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
stdout: phykit_parsimony_score.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
