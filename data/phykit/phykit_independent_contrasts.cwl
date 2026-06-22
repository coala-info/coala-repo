cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - independent_contrasts
label: phykit_independent_contrasts
doc: Compute Felsenstein's (1985) phylogenetically independent contrasts (PIC) 
  for a continuous trait on a phylogeny.
inputs:
  - id: tree
    type: File
    doc: tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: trait_data
    type:
      - 'null'
      - File
    doc: 'trait data file, two columns: taxon<tab>value'
    inputBinding:
      position: 101
      prefix: --trait_data
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
stdout: phykit_independent_contrasts.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
