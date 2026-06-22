cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - column_score
label: phykit_column_score
doc: Calculates column score, an accuracy metric for a multiple alignment 
  relative to a reference alignment. It is calculated by summing the correctly 
  aligned columns over all columns in an alignment.
inputs:
  - id: fasta
    type: File
    doc: query fasta alignment file to be scored for accuracy
    inputBinding:
      position: 1
  - id: reference
    type:
      - 'null'
      - File
    doc: reference fasta alignment to compare query alignment to
    inputBinding:
      position: 102
      prefix: --reference
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
stdout: phykit_column_score.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
