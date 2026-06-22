cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - alignment_length
label: phykit_alignment_length
doc: Length of an input alignment is calculated using this function. Longer 
  alignments are associated with strong phylogenetic signal.
inputs:
  - id: alignment
    type: File
    doc: alignment file
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
stdout: phykit_alignment_length.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
