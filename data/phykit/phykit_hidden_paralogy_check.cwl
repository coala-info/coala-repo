cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - hidden_paralogy_check
label: phykit_hidden_paralogy_check
doc: Scan tree for evidence of hidden paralogy. This analysis examines if a set 
  of well known monophyletic taxa are, in fact, monophyletic. If they are not, 
  the evolutionary history of the gene may be subject to hidden paralogy.
inputs:
  - id: tree
    type: File
    doc: First argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: clade
    type:
      - 'null'
      - File
    doc: Clade file that specifies what monophyletic clades to expect
    inputBinding:
      position: 102
      prefix: --clade
  - id: json
    type:
      - 'null'
      - boolean
    doc: Optional argument to output results as JSON
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
stdout: phykit_hidden_paralogy_check.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
