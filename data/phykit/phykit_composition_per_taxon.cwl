cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - composition_per_taxon
label: phykit_composition_per_taxon
doc: Calculate sequence composition per taxon in an alignment. Composition is 
  reported as symbol:frequency values for each taxon, where frequencies are 
  calculated from valid (non-gap/non-ambiguous) characters.
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
stdout: phykit_composition_per_taxon.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
