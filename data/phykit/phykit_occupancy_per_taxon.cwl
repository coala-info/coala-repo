cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - occupancy_per_taxon
label: phykit_occupancy_per_taxon
doc: Calculate occupancy per taxon in an alignment. Occupancy is the fraction of
  valid (non-gap/non-ambiguous) characters for each taxon.
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
stdout: phykit_occupancy_per_taxon.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
