cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - spurious_sequence
label: phykit_spurious_sequence
doc: Determines potentially spurious homologs using branch lengths by 
  identifying long terminal branches defined as branches that are equal to or 20
  times (or a user-specified factor) the median length of all branches.
inputs:
  - id: tree_file
    type: File
    doc: First argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: factor
    type:
      - 'null'
      - float
    doc: factor to multiply median branch length by to calculate the threshold 
      of long branches.
    inputBinding:
      position: 102
      prefix: --factor
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
stdout: phykit_spurious_sequence.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
