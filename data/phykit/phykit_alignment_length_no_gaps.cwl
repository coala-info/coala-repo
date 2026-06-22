cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - alignment_length_no_gaps
label: phykit_alignment_length_no_gaps
doc: 'Calculate alignment length excluding sites with gaps. PhyKIT reports three tab
  delimited values: number of sites without gaps, total number of sites, and percentage
  of sites without gaps.'
inputs:
  - id: alignment
    type: File
    doc: first argument after function name should be an alignment file
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
stdout: phykit_alignment_length_no_gaps.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
