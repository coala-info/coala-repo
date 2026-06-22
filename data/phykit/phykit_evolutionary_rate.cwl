cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - evolutionary_rate
label: phykit_evolutionary_rate
doc: Calculate a tree-based estimation of the evolutionary rate of a gene. 
  Evolutionary rate is the total tree length divided by the number of terminals.
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
stdout: phykit_evolutionary_rate.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
