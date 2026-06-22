cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - dfoil
label: phykit_dfoil
doc: Compute DFOIL statistics (Pease & Hahn 2015) for detecting and polarizing 
  introgression in a 5-taxon symmetric phylogeny.
inputs:
  - id: alignment
    type: File
    doc: FASTA alignment file
    inputBinding:
      position: 101
      prefix: --alignment
  - id: p1
    type: string
    doc: taxon name for P1 (sister to P2)
    inputBinding:
      position: 101
      prefix: --p1
  - id: p2
    type: string
    doc: taxon name for P2 (sister to P1)
    inputBinding:
      position: 101
      prefix: --p2
  - id: p3
    type: string
    doc: taxon name for P3 (sister to P4)
    inputBinding:
      position: 101
      prefix: --p3
  - id: p4
    type: string
    doc: taxon name for P4 (sister to P3)
    inputBinding:
      position: 101
      prefix: --p4
  - id: outgroup
    type: string
    doc: outgroup taxon name
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: json
    type:
      - 'null'
      - boolean
    doc: output results as JSON
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
stdout: phykit_dfoil.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
