cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - treeness_over_rcv
label: phykit_treeness_over_rcv
doc: Calculate treeness/RCV for a given alignment and tree. Higher treeness/RCV 
  values are thought to be desirable because they harbor a high signal-to-noise 
  ratio and are least susceptible to composition bias.
inputs:
  - id: alignment
    type: File
    doc: an alignment file
    inputBinding:
      position: 101
      prefix: --alignment
  - id: tree
    type:
      - 'null'
      - File
    doc: a tree file
    inputBinding:
      position: 101
      prefix: --tree
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
stdout: phykit_treeness_over_rcv.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
