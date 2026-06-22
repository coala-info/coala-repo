cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - long_branch_score
label: phykit_long_branch_score
doc: Calculate long branch (LB) scores in a phylogeny. LB score is the mean 
  pairwise patristic distance of taxon i compared to all other taxa over the 
  average pairwise patristic distance. PhyKIT reports summary statistics. To 
  obtain LB scores for each taxa, use the -v/--verbose option.
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
stdout: phykit_long_branch_score.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
