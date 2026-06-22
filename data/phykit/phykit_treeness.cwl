cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - treeness
label: phykit_treeness
doc: Calculate treeness statistic for a phylogeny. Treeness describes the 
  proportion of the tree distance found on internal branches. Treeness can be 
  used as a measure of the signal-to-noise ratio in a phylogeny.
inputs:
  - id: tree
    type: File
    doc: tree file
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
stdout: phykit_treeness.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
