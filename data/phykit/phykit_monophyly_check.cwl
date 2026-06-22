cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - monophyly_check
label: phykit_monophyly_check
doc: Check for monophyly of a lineage. This analysis can be used to determine if
  a set of taxa are monophyletic. Requires a taxa file, which specifies which 
  tip names are expected to be monophyletic. The output will have six columns 
  including monophyly status, bipartition support values, and additional 
  monophyletic taxa.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: list_of_taxa
    type:
      - 'null'
      - File
    doc: single column file with list of tip names to examine the monophyly of
    inputBinding:
      position: 2
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 103
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_monophyly_check.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
